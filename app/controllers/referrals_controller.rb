require 'amazon_product'

class ReferralsController < ApplicationController
  
  def index
 search_term = 'eric reis'
    req = AmazonProduct["us"]
  
    
    req.configure do |c|
      c.key     = 'AKIAJYMB5E3M5N7776NQ'
      c.secret  = '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'
      c.tag     = 'gifmon-20'
    end
  
    resp = req.search('All', 
    :keywords => search_term, 
    :response_group => 'Offers')
    
    hashed_resp = resp.to_hash
    #puts hashed_resp
    render :text => hashed_resp["Items"]["Item"][0]["OfferSummary"]["LowestNewPrice"]["FormattedPrice"]
    #render :text => hashed_resp["Items"]["Item"][0]["Offers"]["MoreOffersUrl"]


end

end