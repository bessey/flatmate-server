class ApplicationController < ActionController::Base
  protect_from_forgery


  def find_flat
    @flat = FlatsHelper.find(params[:flat_id])

    if @flat.id != current_user.flat_id and request.format == :json
	    respond_to do |format|
	       format.json { render json: "Error: This is not your flat! Your flat is #{current_user.flat_id}" }
    end
	end
	 
  end

  
  def index 
  	render :blank
  end

end
