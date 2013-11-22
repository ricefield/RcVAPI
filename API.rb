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
        url = "http://online.recoveryversion.org/getScripture.asp?vinfo="+book+chapter+":"+verse
    else
        url = "http://online.recoveryversion.org/getScripture.asp?vinfo="+book+chapter+":"+verse+"-"+endbook+endchapter+":"+endverse
    end

    # start building json
    data['request'] = url[57..-1]  # requested verse reference(s)
    data['url'] = url
    data['verses'] = Hash.new
    
    page = Nokogiri::HTML(open(url))

    # error-check
    unless page.css("p.error").nil?
        data['error'] = "Your request was invalid"
        return data
    end

    # helpful for calculating references
    ref = [].push(book, chapter, verse)  # beginning reference (minus verse)
    prev = []

    for verse in page.css("p.verses")

        # calculate the reference <ref>
        prev = ref
        vnum = verse.css("b.versenum").text
        # checks if this is a new chapter (as opposed to the beginning of the sequence)
        if vnum == '1' and prev[2].to_i > vnum.to_i
            # and if so, increment the chapter number
            ref[1] = ref[1].to_i++
        # update the verse number
        ref[2] = vnum
        ref = ref.join('.')

        # remove bolded verse number
        verse.css("b.versenum").remove
        # remove superscripts (footnotes+cross references)
        verse.css("sup").remove

        # put text in struct
        data['verses'][ref] = verse.css("div#content p.verses").text.strip

    end

    return data.to_json
    
end





