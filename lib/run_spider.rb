require File.expand_path("../../config/environment", __FILE__)
nabe = 'Staten_Island'
page = "/FL/Naples/"
state = "FL"
city = "Naples"
@spider = RealEstateSpider.new.tap do |r|
  r.page = "/for_sale/#{city},#{state}/1_p"
  #/for_sale/Naples,FL/1_p
end
@spider.parse
#listings = Listing.all
#pp listings
sleep(0.5)
start_time = Time.new
index = 0
@spider.num_pages.times do |i|

  if i==0 || i==1
    next
  end
  #if i > 3
  #  break
  #end
  r = rand(100)+10
  interval = r / 100.0
  puts "Interval #{interval}"
  url = "/for_sale/#{city},#{state}/#{i}_p"
  @spider.get_next_page url
  listings = @spider.parse
  #pp listings
  index = index + 1
  puts index
  sleep(interval)
end
end_time = Time.new

puts "Time to parse #{end_time - start_time}"


#listings = Listing.all
#puts 'All listings after parse'
#
#expect(listings.count > 0)
#listings = Listing.find_by(neighborhood: "Cobble Hill")
#puts 'Cobble Hill'
#pp listings
#
listings = Listing.all
average = Listing.average('Naples')
pp average
pp  listings.count