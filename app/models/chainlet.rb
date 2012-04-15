class Chainlet < ActiveRecord::Base
	has_many :chainlet_links, :dependent => :destroy
	accepts_nested_attributes_for :chainlet_links

  def get_id
    id.to_s
  end

  def get_comment
    if respond_to? :description
      unless comment.blank?
        comment
      else
        "---"
      end
    else
      raise NoMethodError.new "You model have no comment at all to get."
    end
  end

end

# Since one link does not have specific controller and views - jst keep it here
class ChainletLink < ActiveRecord::Base
	belongs_to :chainlet
	validates :ordinal_number, :presence => true
end


