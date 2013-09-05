class SyndicationController < ApplicationController
  def rets
    @listings = Listing.all.order("rand()").limit(5)
  end
end
