module FlatsHelper

	def find id, authenticate = false
	    if id == "m"
	      flat = current_user.flat
	    else
	      flat = Flat.find(id)
	    end

	    if authenticate and flat != current_user
	    	raise "This is not your flat and authentication is turned on"
	    end

	    return flat
	end

end
