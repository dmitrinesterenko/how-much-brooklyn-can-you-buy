class ApiController < ActionController::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  def index
    listings = Listing.find_by(neighborhood: "Williamsburg")
    render :json => listings
  end

  def ihave
    money = params[:money].to_i
    nabe = params[:nabes]
    listing_results = Listing.find_for_price money, nabe
    render :json => listing_results

  end

  def neighborhoods
    nabes = Listing.neighborhoods
    render :json => nabes
  end
end
