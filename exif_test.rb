require 'rubygems'
require 'mini_exiftool'


home = Hash.new
restaurant = Hash.new

# puts photo.tags

R = 6371000

# Latitude example - "37 deg 35' 59.64\" N"
# longitude example - "127 deg 1' 18.61\" E"
module Math
	 def self.to_rad angle
    angle/180 * Math::PI
  end
end

def convertToDD degMinSec
	degree = degMinSec.split[0]
	min = degMinSec.split[2][0..-2]
	sec = degMinSec.split[3][0..-2]
	dd = degree.to_i + min.to_i/60.0 + sec.to_i/3600.0
end

def distance a, b
	#Haversine Formula
	dlat = Math.to_rad(b[:lat] - a[:lat])
	dlon = Math.to_rad(b[:lon] - a[:lon])
	a = Math.sin(dlat/2)**2 + Math.cos(Math.to_rad(a[:lat])) *
			Math.cos(Math.to_rad(a[:lat]))*(Math.sin(dlon/2)**2)
	c = 2 * Math.asin([1, Math.sqrt(a)].min)
	d = R * c
end

photo = MiniExiftool.new 'myroom.jpg'
home[:lat] = convertToDD photo.GPSLatitude
home[:lon] = convertToDD photo.GPSLongitude
home[:time] = photo.CreateDate

photo = MiniExiftool.new 'restaurant.jpg'
restaurant[:lat] = convertToDD photo.GPSLatitude
restaurant[:lon] = convertToDD photo.GPSLongitude
restaurant[:time] = photo.CreateDate

puts home.inspect
puts restaurant.inspect

puts distance home, restaurant
