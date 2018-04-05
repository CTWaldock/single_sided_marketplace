class CartsController < ApplicationController

  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  before_action :find_user

  # GET /carts
  # GET /carts.json
  def index
    @user.carts.each do |cart|
      cart[:name] = Product.find(cart.product_id).name
      cart[:price] = Product.find(cart.product_id).price

    # @products = []
    # product_hash ={}
    # @user.carts.each do |cart|
    #   product_hash[:qty] = cart.qty
    #   product_hash[:name] = Product.where(product_id: cart.product_id).name
      # product_hash[:price] = Product.where(product_id: cart.product_id).price
      # @products.push(product_hash)
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json

  # { controller: "carts", action: "create", id: product.id }, method: :post
  def create
    # render plain: params.inspect
    # render plain: @product.inspect
    # render plain: params[:id]
    @product = Product.find(params[:id])

    @cart = Cart.new
    @cart.product_id = @product.id
    @cart.qty = 1
    if @user.carts.find_by(product_id: @cart.product_id) == nil
      if @cart.save
        flash[:notice] = "Item added to cart"
        redirect_to(carts_path)
      else
        flash[:notice] = "Failed to add item to cart"
        redirect_to(new_cart_path)
      end
    else
      update_cart = @user.carts.find_by(product_id: @cart.product_id)
      update_cart.qty += @cart.qty
      update_cart.save
      @cart.destroy
      flash[:notice] = "Item added to cart"
      redirect_to(carts_path)
    end

    # respond_to do |format|
    #   if @cart.save
    #     format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
    #     format.json { render :show, status: :created, location: @cart }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @cart.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update

    @cart.update(cart_params)
    flash[:notice] = "Item added to cart"
    redirect_to(carts_path)
    # respond_to do |format|
    #   if @cart.update(cart_params)
    #     format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @cart }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @cart.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy

    @cart.destroy
    redirect_to(carts_path)
    # @cart.destroy
    # respond_to do |format|
    #   format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def find_user
    # @user = User.find(params[:user_id])
    @user = User.first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:qty, :user_id, :product_id)
    end
end
