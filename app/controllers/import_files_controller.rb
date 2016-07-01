class ImportFilesController < ApplicationController
  require 'csv'

  # GET /imported_files
  def index
  end

  # Post /imported_files
  def create
    error = nil

    # Has file?
    if ! params.has_key?(:text_file)
      flash[:danger] = "A file was not informed."
      redirect_to :back
      return
    end
    uploaded_file = params[:text_file][:file_name]
    file_name = uploaded_file.tempfile.to_path.to_s

    begin
      file_content = File.read(
        file_name,
        { encoding: 'UTF-8' }
      )
    rescue
      flash[:danger] = "File open error."
      redirect_to :back
      return
    end

    # For CVS import
    if (uploaded_file.content_type == 'text/csv') or (file_name[-3..-1].upcase == 'CVS')
      products_count = 0

      # Parse the CSV text
      begin
        csv_content = CSV.new(  file_content,
                                :headers => true,
                                :header_converters => :symbol,
                                :col_sep => ';' )
      rescue
        flash[:danger] = "Isn't a valid CSV file."
        redirect_to :back
        return
      end

      # Process line by line
      csv_content.each do |product|

        begin
          product_hash = bluebill_fix( product.to_hash )
        rescue Exception => e
          error = e.message
          break
        end

        begin
          Product.create!(product_hash)
        rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
          error = "'Identificação' duplicated or invalid file content."
          break
        end

        products_count += 1

      end


    # For TXT import
    elsif (uploaded_file.content_type == 'text/plain') or (file_name[-3..-1].upcase == 'TXT')
      products_count = 0

      # Read file_content line by line
      file_content.each_line do |file_line|

        if file_line.first == "I"

          begin
            product_hash = youdoinvoice_fix( file_line )
          rescue Exception => e
            error = e.message
            break
          end

          begin
            Product.create!(product_hash)
          rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
            error = "'Identificação' duplicated or invalid file content."
            break
          end

          products_count += 1

        end

      end

    # Invalid file
    else
      error = "File type is invalid!"
    end

    if ! error.nil?
      flash[:danger] = "Import fail with message: " + error
      redirect_to :back
    else
      flash[:success] = "#{products_count} product(s) was successfully imported from file: #{uploaded_file.original_filename}"
      redirect_to :back
    end

  end
end


private

  # Fix BlueBill product columns
  def bluebill_fix( product )
    product_hash = { }
    # Columns map for BlueBill layout
    col_names = {
                    :categoria => :category,
                    :unidade => :unity,
                    :descrio => :description,
                    :identificao => :code,
                    :custo => :cost,
                    :preo_de_venda_1 => :sale_price,
                    :observaes => :observations,
                    :fornecedor => :supplier,
                    :estoque => :stock,
                    :cd_barra => :barcode,
                    :preo_de_venda_2 => :sale_price,
                    :preo_de_venda_3 => :sale_price,
                    :estoque_mnimo => :min_stock,
                    :estoque_mximo => :max_stock,
                    :estoque_compra => :purchase_stock,
                    :ncm => :ncm,
                    :marca => :brand,
                    :peso => :weight,
                    :tamanho => :size,
                    :inativo => :current_state_id,
                    :tipo => :product_type,
                    :composio => :composition,
                    :matria_prima => :raw_material,
                    :material_expediente => :office_supplies,
                    :para_venda => :for_sale,
                    :moeda => :currency,
                    :fator_unid_de_venda => :unity_factor
                  }

    product.keys.each do |k|
      # Remove if duplicated to import last value
      product_hash.delete( col_names[k] ) if product_hash.has_key?( col_names[k] )

      # Key is in col_names and value is not empty?
      if product.has_key?(k) and not product[k].empty?
        product_hash[ col_names[k] ] = product[k]
      end
    end
    product_hash
  end

  # Fix YouDoInvoice product columns
  def youdoinvoice_fix( product )
    product_hash = { }
    # Columns map for YouDoInvoice layout
    col_names = [ :code,
                  :description,
                  :barcode,
                  :ncm,
                  :ipi,
                  :gender,
                  :unity,
                  :value,
                  :barcode,
                  :unity,
                  :value,
                  :stock ]

    product = product[2..-2]
    product.split("|").each.with_index do |value, index|
      product_hash[ col_names[index] ] = value if not value.empty?
    end
    product_hash
  end
