class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  before_filter :authenticate_user!, :except => [:create]
  before_filter :me, :only => [:show,:edit,:update,:destroy]

  def me
    if params[:id] == "m"
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def index
    if params[:flat_id]
      @users = Flat.find(params[:flat_id]).users
    else
      @users = User.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # Review whether a user can join a group or not
  def review
    @flat = current_user.flat
    @user = @flat.users.find(params[:id])
    if @user == current_user
      respond_to do |format|
        format.html { render text: "You can't approve yourself!"}
        format.json { render json: "You can't approve yourself!" }
      end
      return
    end

    if params[:user].nil? or params[:user][:approve].nil?
      respond_to do |format|
        format.html { render text: "Please send either user[approve] = true or false"}
        format.json { render json: "Please send either user[approve] = true or false" }
      end
      return
    end


    if params[:user][:approve] == true or params[:user][:approve] == "true"
      @user.flat_approved = true
      data = {
        :msg_type => "approved", 
        :approved_id => @user.id, 
        :approver_first_name => current_user.first_name
      }

    else
      @user.flat_id = nil
    end

    @user.save
    @flat.send_notification current_user, data

    respond_to do |format|
      format.json { render json: "User has been approved" }
    end

  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  #def create
  #  @user = User.new(params[:user])
  #  #@ret = true
  #
  #  #if params[:gcm] and params[:gcm][:registration_id]
  #  #  @device = Gcm::Device.new(:registration_id => params[:gcm][:registration_id])
  #  #  @device.user_id =  @user.id
  #  #  @device.last_registered_at = Time.now
  #  #  @ret = @device.save
  #  #end
  #
  #  if @user.save and @ret
  #    respond_to do |format|
  #      format.html { redirect_to @user, notice: 'User was successfully created.' }
  #      format.json { render json: @user, status: :created, location: @user }
  #    end
  #  else
  #    respond_to do |format|
  #      format.html { render action: "new" }
  #      format.json { render json: [@user.errors], status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PUT /users/1
  # PUT /users/1.json
  def update

    if @user.update_attributes(params[:user])
      # Create a Device if the user doesn't have one
      if params[:gcm] and params[:gcm][:registration_id]
        if @user.gcm_device.nil?
          @device = Gcm::Device.new
          @device.user_id = params[:id]
        else
          @device = @user.gcm_device
        end

        @device.last_registered_at = Time.now

        if @device.update_attributes(params[:gcm])
          respond_to do |format|
            format.html { redirect_to @user, notice: 'User and GcmDevice were successfully updated.' }
            format.json { head json: 'User and GcmDevice were successfully updated.' }
          end
          return
        else
          respond_to do |format|
            format.html { render action: "edit" }
            format.json { render json: @device.errors, status: :unprocessable_entity }
          end
          return
        end

      end

      respond_to do |format|
        format.html { redirect_to @user }
        format.json { render json: @user }
      end
      
    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @device = Gcm::Device.where(:user_id => @user.id)
    
    @user.destroy

    if !@device.empty?
      @device.destroy_all
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
