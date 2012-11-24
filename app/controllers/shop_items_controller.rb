class ShopItemsController < ApplicationController
  # GET /shop_items
  # GET /shop_items.json
  def index
    @shop_items = ShopItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shop_items }
    end
  end

  # GET /shop_items/1
  # GET /shop_items/1.json
  def show
    @shop_item = ShopItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shop_item }
    end
  end

  # GET /shop_items/new
  # GET /shop_items/new.json
  def new
    @shop_item = ShopItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop_item }
    end
  end

  # GET /shop_items/1/edit
  def edit
    @shop_item = ShopItem.find(params[:id])
  end

  # POST /shop_items
  # POST /shop_items.json
  def create
    @shop_item = ShopItem.new(params[:shop_item])

    respond_to do |format|
      if @shop_item.save
        format.html { redirect_to @shop_item, notice: 'Shop item was successfully created.' }
        format.json { render json: @shop_item, status: :created, location: @shop_item }
      else
        format.html { render action: "new" }
        format.json { render json: @shop_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shop_items/1
  # PUT /shop_items/1.json
  def update
    @shop_item = ShopItem.find(params[:id])

    respond_to do |format|
      if @shop_item.update_attributes(params[:shop_item])
        format.html { redirect_to @shop_item, notice: 'Shop item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @shop_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_items/1
  # DELETE /shop_items/1.json
  def destroy
    @shop_item = ShopItem.find(params[:id])
    @shop_item.destroy

    respond_to do |format|
      format.html { redirect_to shop_items_url }
      format.json { head :no_content }
    end
  end
end
