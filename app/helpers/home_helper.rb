module HomeHelper
	def encode(id_amount)
    if not id_amount.nil?
      return id_amount.map{|id, amount| "#{id}:#{amount}"}.join(";")
    end
  end

  def decode(id_amount)
    if not id_amount.nil?
    	decoded = {}
      id_amount.split(";").each do |elem|
      	key_value = elem.split(":")
      	decoded[key_value[0].to_i] = key_value[1].to_f
      end
      return decoded
    end
  end
end
