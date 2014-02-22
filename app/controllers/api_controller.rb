class ApiController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  def index
    listings = Listing.find_by(neighborhood: "Williamsburg")
    render :json => listings
  end

  def spend
    money = params[:money].to_i
    nabe = params[:neighborhood]
    #money = amount.to_i
    #nabe = neighborhood
    listing_results = Listing.find_for_price money, nabe
    render :json => listing_results

  end

  def neighborhoods
    nabes = Listing.neighborhoods
    render :json => nabes
  end

  def autocomplete
    input = params[:term]
    areas = Listing.autocomplete input
    #respond_to do |format|
    #  format.json {render :json => areas}
    #  format.xml { render :xml => areas }
    #end
    render :json => areas
  end
end
