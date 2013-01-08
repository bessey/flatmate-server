class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  before_filter :authenticate_user!
  before_filter :find_flat, :only => [:review]

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
    if params[:id] == "m"
      @user = current_user
    else
      @user = User.find(params[:id])
  end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # Review whether a user can join a group or not
  def review
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


    if params[:user][:approve] == true
      @user.flat_approved = true
    else
      @user.flat_id = nil
    end

    @user.save

  end

  def m
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    @device = Gcm::Device.new(:registration_id => params[:gcm][:registration_id])
    @device.user_id =  @user.id
    @device.last_registered_at = Time.now

    respond_to do |format|
      if @user.save and @device.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: [@user.errors, @device.errors], status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        # Create a Device if the user doesn't have one
        if @user.gcm_device.nil?
          @device = Gcm::Device.new
          @device.user_id = params[:id]
        else
          @device = @user.gcm_device
        end

        @device.last_registered_at = Time.now

        if @device.update_attributes(params[:gcm])
          format.html { redirect_to @user, notice: 'User and GcmDevice were successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @device = Gcm::Device.where(:user_id => params[:id])
    
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
