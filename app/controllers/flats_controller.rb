class FlatsController < ApplicationController
  # GET /flats
  # GET /flats.json

  before_filter :authenticate_user!, :except => :search
  before_filter :me, :only => [:show,:edit,:update,:destroy]

  def me
    if params[:id] == "m"
      @flat_id = current_user.flat_id
    else
      @flat_id = params[:id]
    end
    
    @flat = Flat.includes(:users,:shop_items).find(@flat_id)
  end

  def index
    @flats = Flat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flats }
    end
  end

  # GET /flats/1
  # GET /flats/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flat.to_json(:include => [:users,:shop_items]) }
    end
  end

  # GET /flats/new
  # GET /flats/new.json
  def new
    @flat = Flat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flat }
    end
  end

  # GET /flats/1/edit
  def edit
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = Flat.new(params[:flat])
    
    # Approve yourself when you create a flat!
    @result = @flat.save
    if user_logged_in
      current_user.flat_approved = true
      current_user.flat_id = @result.id
      current_user.save
    end

    respond_to do |format|
      if @result
        format.html { redirect_to @flat, notice: 'Flat was successfully created.' }
        format.json { render json: @flat, status: :created, location: @flat }
      else
        format.html { render action: "new" }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flats/1
  # PUT /flats/1.json
  def update

    respond_to do |format|
      if @flat.update_attributes(params[:flat])
        format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1
  # DELETE /flats/1.json
  def destroy
    @flat.destroy

    respond_to do |format|
      format.html { redirect_to flats_url }
      format.json { head :no_content }
    end
  end

  def search
    @search = params[:search].gsub(/[^0-9a-z]/i, '').upcase
    @nickname = params[:nickname]
    if @nickname.nil?
      @flats = Flat.includes(:users).where("postcode LIKE '%#{@search}%'").limit(10)
    else
      @flats = Flat.includes(:users).where("postcode LIKE '%#{@search}%' AND nickname LIKE '%#{@nickname}%'").limit(10)
    end
    respond_to do |format|
      format.json { render json: @flats.to_json(:include => [:users]) }
    end
  end

end
