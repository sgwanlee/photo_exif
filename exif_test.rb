require 'rubygems'
require 'mini_exiftool'


photo = MiniExiftool.new 'myroom.jpg'

# puts photo.tags

puts photo.GPSposition

puts photo.CreateDate