require 'amazon_product'

class ReferralsController < ApplicationController
  
  def index
# replace search_term with your variable from hunch
 #search_term = 'asdfjadfhg43'
    req = AmazonProduct["us"]
    
    is_this_good = true
  
    
    req.configure do |c|
      c.key     = 'AKIAJYMB5E3M5N7776NQ'
      c.secret  = '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'
      c.tag     = 'gifmon-20'
    end
  
    resp = req.search('All', 
    :keywords => params[:search], 
    :response_group => 'Offers')
    
    response = Hash.new
    
    begin
#    if !resp.valid? then is_this_good = false end
    
    initial_resp = resp.to_hash
    product_asin = initial_resp["Items"]["Item"][0]["ASIN"]
    product_url = initial_resp["Items"]["Item"][0]["Offers"]["MoreOffersUrl"]
    product_price = initial_resp["Items"]["Item"][0]["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]
    
    image_req = req.find(product_asin, :response_group => 'Images')
    
#    if !image_req.valid? then is_this_good = false end
    
    image_resp = image_req.to_hash
    image_medium_url = image_resp["Items"]["Item"]["MediumImage"]["URL"]
    image_medium_x = image_resp["Items"]["Item"]["MediumImage"]["Width"]["__content__"]
    image_medium_y = image_resp["Items"]["Item"]["MediumImage"]["Height"]["__content__"]
    image_large_url = image_resp["Items"]["Item"]["LargeImage"]["URL"]
    image_large_x = image_resp["Items"]["Item"]["LargeImage"]["Width"]["__content__"]
    image_large_y = image_resp["Items"]["Item"]["LargeImage"]["Height"]["__content__"]
    
    title_req = req.find(product_asin, :response_group => 'ItemAttributes')
#    if !title_req.valid? then is_this_good = false end
      
    title_resp = title_req.to_hash
    product_title = title_resp["Items"]["Item"]["ItemAttributes"]["Title"]
    
#    if is_this_good == true then
        response["URL"] = product_url
        response["Price"] = product_price
        response["Title"] = product_title
        response["MediumImageURL"] = image_medium_url
        response["MediumImageX"] = image_medium_x
        response["MediumImageY"] = image_medium_y
        response["LargeImageURL"] = image_large_url
        response["LargeImageX"] = image_large_x
        response["LargeImageY"] = image_large_y
#    else
     rescue
        response["Error"] = "true"
#    end

    end
    
    #render :json => params[:search]
    render :json => response
    
    #render :text => "Title: "+ product_title + ", ASIN: " + product_asin + ", URL: " + product_url + " , Price: " + product_price + ", Medium URL: " + image_medium_url + " , X: " + image_medium_x + ", Y: " + image_medium_y + ", Large URL: " + image_large_url + " , X: " + image_large_x + ", Y: " + image_large_y

end

end