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

  next if i==0 || i==1
  #if i > 3
  # break
  #end
  interval = (rand(100)+10)/100.0
  puts "Interval #{interval}"
  url = "/for_sale/#{city},#{state}/#{i}_p"
  @spider.get_next_page url
  listings = @spider.parse
  #listings.each do |listing|
	  
  #end
  binding.pry
  #pp listings
  puts i
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
average = Listing.average(city)
pp average
pp  listings.count
