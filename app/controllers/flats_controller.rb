class FlatsController < ApplicationController
  # GET /flats
  # GET /flats.json

  #before_filter :authenticate_user!

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
    @flat = Flat.includes(:users).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flat.to_json(:include => [:users]) }
    end
  end

  def m
    @flat = current_user.flat

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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
    @flat = Flat.find(params[:id])
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = Flat.new(params[:flat])

    respond_to do |format|
      if @flat.save
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
    @flat = Flat.find(params[:id])

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
    @flat = Flat.find(params[:id])
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
