#scrub Trulia search for Brooklyn for listings

require 'httparty'
require 'nokogiri'


class RealEstateSpider
  include HTTParty

  attr_accessor :num_pages
  attr_accessor :page
  attr_accessor :current_page

  base_uri 'www.trulia.com'

  def user_agent_header
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36'
  end

  def get_num_pages
        doc = current_page
        pagination_links = doc.css(".srpPagination_list a")
        #much assumption of not nil here
        num_pages = pagination_links.last.children.first.content.to_i

  end
  #lazy initialize in Ruby
  def num_pages
    if @num_pages == nil
      @num_pages = get_num_pages
    end
    @num_pages
  end

  def get_current_page
    result = self.class.get(page, :headers => {"User-Agent"=>user_agent_header})
    doc = Nokogiri::HTML.parse result
    doc
  end

  def current_page
    if @current_page == nil
      @current_page = get_current_page
    end
    @current_page
  end

  #nil the current doc and update the url, next request that uses current_page will get the new page
  def get_next_page (url)
    @current_page = nil
    @page = url
  end

  def parse
    doc = current_page
    listings = doc.css("li.property-data-elem")
    listing_results = Array.new
    listings.each do |listing|
      listing_result = parse_listing listing
      #begin
      #pp listing_result
        result = listing_result.save
        #pp "result of save #{result}"
      #rescue
         #pp listing_result
      #end
      #listing_results << listing_result
    end
   # listing_results
  end

  def parse_listing  listing
    listing_model = Listing.new

    #pp listing
    if listing.attributes['data-property-id'] != nil
      listing_model.realty_id = listing.attributes['data-property-id'].value
    end


    lat_node = listing.css('div[@itemprop="geo"]').css('meta[@itemprop="latitude"]')[0]

    if lat_node != nil
      listing_model.latitude = lat_node.attributes["content"].value
    end
    long_node = listing.css('div[@itemprop="geo"]').css('meta[@itemprop="longitude"]')[0]
    if long_node != nil
      listing_model.longitude = long_node.attributes["content"].value
    end
    image = listing.css('.mediaImg img')[0]
    if image != nil
      listing_model.thumb  = image.attributes["data-lazy-src"].value
      #don't like depending on images to get the address but it's the easiest to get the full address (missing zip that i am getting later)
      #listing_model["address"] = listing.css('img')[0].attributes["alt"].value
      listing_model.address = image.attributes["alt"].value
    end
    url = listing.css('.mediaImg a')[0]
    if url != nil
      listing_model.url  = url.attributes["href"].value
    end
    post_code = listing.css('span [@itemprop="postalCode"]')
    if(post_code != nil && post_code.children != nil && post_code.children[0] != nil)
      listing_model.zip = post_code.children[0].text
    end
    locality = listing.css('span [@itemprop="addressLocality"]')
    if(locality != nil && locality.children != nil && locality.children[0]!= nil)
      listing_model.locality = locality.children[0].text
    end
    price = listing.css('.listingPrice')

    if price != nil && price.children != nil && price.children[0]!= nil
      price_unformatted = price.children[0].text
      price_formatted = price_unformatted.gsub('$', '').gsub(',', '')
      price_i = price_formatted.to_i
      listing_model.price = price_i
    end
    #pick up some properties like nabe if they are present

    listing.css('strong').each do |property|
      if property.children[0] == nil
        next
      end
      if property.children[0].text == "Neighborhood"
        listing_model.neighborhood = property.parent.text.gsub("Neighborhood", "").strip
      end
      if property.children[0].text == "Listing Type"
        listing_model.listing_type = property.parent.text.gsub("Listing Type", "").strip
      end
      if property.children[0].text == "Description"
        listing_model.description = property.parent.text.gsub("Description", "").strip
      end
    end
    #hacky pants
    beds = listing.css('strong')[3]
    if beds != nil && beds.text.include?('beds')
      listing_model.beds = beds.text.gsub('beds', '').strip
    end
    baths = listing.css('strong')[3]
    while baths != nil do
      if baths.text != nil && baths.text.include?('baths')
        listing_model.baths = baths.text.gsub('baths', '').strip
        break
      end
      baths = baths.next

    end

    listing.css('.mvn .h7').each do |node|
        #pp node.text
        if node.text.include?('sqft')
            #puts 'node includes sqft'
            listing_model.sqft =  node.text.gsub('sqft', '').gsub(',', '').strip
            #puts 'the SQFT is'
            #puts listing_model.sqft
        end
    end


    listing_model
  end





end
