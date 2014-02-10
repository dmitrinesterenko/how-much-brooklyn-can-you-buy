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
    #nabe = 'Williamsburg'
    #nabe = nil
    if nabe != nil && nabe != ''
      listings = Listing.find_by(neighborhood: nabe)
    else
      listings = Listing.take(100)
    end
    #render :json => listings
    #return
    total_price = 0
    listing_results = Array.new
    listings.each do |listing|
      total_price = total_price + listing.price

      if total_price >= money
        break
      end
      listing_results << listing
    end
    render :json => listing_results

  end

  def neighborhoods
    nabes = Listing.select(:neighborhood).uniq
    render :json => nabes
  end
end
