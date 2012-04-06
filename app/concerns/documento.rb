module Documento
	extend ActiveSupport::Concern

	# Evaluating included code for scopes, variables, methods definitions.
	included do
		# scope :awesome, where(:favorite_language => 'ruby')
		belongs_to :author, :class_name => "User"
		before_save :assign_author
	end

	module ClassMethods
		def cl
			return "class method invoked!"
		end
	end

	def inst
		return "inst method invoked!"
	end

	private
	def assign_author
		
	end

end
