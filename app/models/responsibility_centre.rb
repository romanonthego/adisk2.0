class ResponsibilityCentre < ActiveRecord::Base
	# Scopes 
	default_scope includes(:head)

	# References
	has_many :users
	belongs_to :head, :class_name => "User", :foreign_key => :head_id

	# Validations
	validates :head_id, :presence => true
	validates :title, :presence => true
	validates :description, :presence => true

	# Instance Methods
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

	def get_id
		id.to_s
	end

	def get_head
		head.email
	end
end
