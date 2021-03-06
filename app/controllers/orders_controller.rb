class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 

  respond_to :html

  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC") 
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
    respond_with(@order,:location => root_url)
  end

  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user 
    
    @order.buyer_id   = current_user.id
    @order.listing_id = @listing.id
    @order.seller_id  = @seller.id  

    @order.save
    respond_with(@order,:location => root_url)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
