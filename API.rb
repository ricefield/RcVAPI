require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
# require 'sanitize'
require 'json'
require 'pp'
# require 'haml'
# require 'builder'

get '/' do
	"welcome to RcV (unofficial) API"
    
    # HAML ? documentation page
    
end

# get a single verse
get '/verse/:book/:ch/:verse' do

end

# get a range of verses
get '/verses/:book/:ch/:beg/:end' do

end 

# get footnotes
# only one verse at a time
get '/hymn/:id' do
    
end

# get 
get '/search/:string' do

end