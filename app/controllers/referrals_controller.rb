require 'amazon_product'

class ReferralsController < ApplicationController
  
  def index
      req = AmazonProduct["us"]
  
  searchTerm = 'coke'
  
  req.configure do |c|
    c.key     = 'AKIAJYMB5E3M5N7776NQ'
    c.secret  = '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'
    c.tag     = 'gifmon-20'
  end

  resp = req.search('All', 
  :keywords => searchTerm, 
  :response_group => 'Offers')
  
  hashedResp = resp.to_hash
  puts hashedResp

end

end