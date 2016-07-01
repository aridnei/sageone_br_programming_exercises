class Product < ActiveRecord::Base
  belongs_to :current_state

  before_save do
    self.code = self.code.upcase if ! self.code.nil?
    self.unity = self.unity.upcase if ! self.unity.nil?

    self.weight = to_float( self.weight )
    self.stock = to_float( self.stock )
    self.max_stock = to_float( self.max_stock )
    self.min_stock = to_float( self.max_stock )
    self.purchase_stock = to_float( self.purchase_stock )
    self.cost  = to_float( self.cost )
    self.sale_price  = to_float( self.sale_price )
    self.ipi  = to_float( self.ipi )

    self.current_state_id =  to_integer( self.current_state_id )
  end

  def to_float( number )
    begin
      number + 0.0
    rescue
      0.0
    end
  end

  def to_integer( string )
    p string
    begin
      string.to_i
    rescue
      0
    end
  end

end
