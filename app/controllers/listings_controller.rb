class ListingsController < ApplicationController
  # Could calls these the trigger before is run for the controller class
  before_action :set_listing,        only: [:show, :edit,   :update, :destroy]
  before_action :authenticate_user!, only: [:seller, :new,  :create, :edit,   :destroy]
  before_action :check_user,         only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  # These are my pages, and the data it will collect when requested - well not pages, but what actions need to be taken
  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end 

  def index
    @listings = Listing.all.order("created_at DESC")
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing         = Listing.new(listing_params)
    @listing.user_id = (user_signed_in? ? current_user.id : nil)  
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_user
    if @listing.user != current_user 
      redirect_to root_url, alert: "Sorry, this listing belongs to someone else"
    end 
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end
end
