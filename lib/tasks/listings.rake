namespace :listings do
	desc "Populate listings"
	task :populate => :environment do
                Listing.delete_all
		nabe = 'Staten_Island'
		page = "/NY/Brooklyn/" #"/FL/Naples"
		state = "NY" #"FL"
		city = "New_York" #"Naples"
		@spider = RealEstateSpider.new.tap do |r|
		  r.page = "/for_sale/#{city},#{state}/1_p"
		end
		@spider.parse
		sleep(0.5)
		start_time = Time.new
		index = 0
		@spider.num_pages.times do |i|

		  next if i==0 || i==1
		  #break if i>4
		  interval = (rand(100)+10)/100.0
		  puts "Interval #{interval}"
		  url = "/for_sale/#{city},#{state}/#{i}_p"
		  @spider.get_next_page url
		  listings = @spider.parse
		  puts i, url
		  sleep(interval)
		end
		end_time = Time.new

		puts "Time to parse #{end_time - start_time}"
		listings = Listing.all
		average = Listing.average(city)
		pp average
		pp  listings.count
	end
end
