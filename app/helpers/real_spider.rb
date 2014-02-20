#http://www.trulia.com/CA/Los_Angeles,7209,Silver_Lake/
#this is sample code that uses the RealEstateSpider (it's in the /lib folder)
#this should be a part of a job
require_relative '../../config/environment'
@spider = RealEstateSpider.new.tap do |r|
  #r.page = '/CA/Los_Angeles,7209,Silver_Lake/'
  r.page = "/NY/Brooklyn/"
end

@spider.parse

sleep(0.5)
@spider.num_pages.times do |i|
  r = rand(100)+10
  interval = r / 100.0
  puts "Interval #{interval}"
  if i==0 || i==1
    next
  end
  #if i > 3
    #break
  #end
  #Silver Lake next page url url = "/for_sale/7209_nh/#{i}_p"
  url =  "/NY/Brooklyn/#{i}_p"
  puts url
  @spider.get_next_page url
  listings = @spider.parse
  pp i, listings

  sleep(interval)
end