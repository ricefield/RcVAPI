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

# get a single range of verses
# ex: /vv/Gen/1/26/Gen/1/27
get '/vrange/:begbk/:bgch/:bgv/:endbk/:endch/:endv' do

end

# get a single range of verses within the same chapter
# ex: /vv/2Cor/3/16/18
get '/vrange/:book/:ch/:beg/:end' do

end

# OSIS calls
# these are API calls that accept the OSIS verse reference format
# more info: 

get '/osis/' do

end

def get_rcv(book, chapter, verse, endbook=nil, endchapter=nil, endverse=nil)

    content_type :json
    data = Hash.new

    if endbook.nil? or endchapter.nil? or endverse.nil?
        PAGE_URL = "http://online.recoveryversion.org/getScripture.asp?vinfo="+book+chapter+":"+verse
    else
        PAGE_URL = "http://online.recoveryversion.org/getScripture.asp?vinfo="+book+chapter+":"+verse+"-"+endbook+endchapter+":"+endverse
    end

    # start building json
    data['request'] = PAGE_URL[57..-1]  # requested verse reference(s)
    data['url'] = PAGE_URL
    data['verses'] = Hash.new
    
    page = Nokogiri::HTML(open(PAGE_URL))
    ref = [].push(book, chapter).join('.')  # beginning reference (minus verse)

    # error-check
    unless page.css("p.error").nil?
        data['error'] = "Your request was invalid"
        return data
    end

    for verse in page.css("p.verses") do

        # calculate the reference
        verse.css("b.versenum").text

        data['verses'][]
        # remove bolded verse number
        verse.css("b.versenum").remove
        # remove superscripts (footnotes+cross references)
        verse.css("sup").remove
        data['verses'][]


    # yields clean verse text
    data['text'] = page.css("div#content p.verses").text.strip

    return data.to_json
    
end





