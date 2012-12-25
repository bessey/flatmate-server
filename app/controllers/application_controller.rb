class ApplicationController < ActionController::Base
  protect_from_forgery


  def find_flat
    @flat = Flat.find(params[:flat_id])
    if @flat.id != current_user.flat_id
	    respond_to do |format|
	       format.html # index.html.erb
	       format.json { render json: "Error: This is not your flat! Your flat is #{current_user.flat_id}" }
	    end
	end
	 
  end

  
  def index 
  	render :blank
  end

end
