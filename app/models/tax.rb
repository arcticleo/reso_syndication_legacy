class Tax < ActiveRecord::Base

  belongs_to :listing

  validates :year,        :length => { :maximum => 4, },
                          :numericality => true,
                          :presence => true

  validates :amount,      :numericality => true,
                          :presence => true

  validates :description, :length => { :maximum => 255 },
                          :presence => true

end
