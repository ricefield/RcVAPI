require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
# require 'sanitize'
require 'json'
require 'pp'
# require 'haml'
# require 'builder'
require 'set'



get '/' do
	"welcome to RcV (unofficial) API"
    
    # HAML ? documentation page
    
end

# get a single verse
get '/v/:book/:ch/:verse' do

end

# get a range of verses
# ex: /vv/Gen/1/26/Gen/1/27
get '/vv/:begbk/:bgch/:bgv/:endbk/:endch/:endv' do

end

# get a range of verses within the same chapter
# ex: /vv/2Cor/3/16/18
get '/vv/:book/:ch/:beg/:end' do

end

# OSIS calls
# these are API calls that accept the OSIS verse reference format
# more info: 

get '/osis/' do

end

def rcv

    content_type :json
    verse = Hash.new

    PAGE_URL = "http://online.recoveryversion.org/getScripture.asp?vinfo="+:book+:ch+":"+:verse

    # start building json
    verse['ref'] = :book + " " + :ch + ":" + :verse
    verse['url'] = PAGE_URL
    
    page = Nokogiri::HTML(open(PAGE_URL))

    # remove footnotes/crossreferences
    page.css("div#content p.verses sup").remove

    # remove 
    page.css("div#content p.verses b.versenum").remove

    # yields clean verse text
    verse['text'] = page.css("div#content p.verses").text.strip

    verse.to_json
    
end





