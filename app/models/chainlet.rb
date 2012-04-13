class Chainlet < ActiveRecord::Base
	has_many :chainlet_links, :dependent => :destroy
	accepts_nested_attributes_for :chainlet_links
end

# Since one link does not have specific controller and views - jst keep it here
class ChainletLink < ActiveRecord::Base
	belongs_to :chainlet
	validates :ordinal_number, :presence => true
end
