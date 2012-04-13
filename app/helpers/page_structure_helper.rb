module PageStructureHelper
	# include ActionView::Helpers::RenderingHelper
	def page_header &block
		header = Header.new
		yield header
		# header.construct
		render :partial => 'layouts/page_header.haml', 
						 :locals => {:header => header}
	end

	class Header
		# include ActionView::Helpers::TagHelper
		# include ActionView::Context
		# include ActionView::Helpers::UrlHelper
		# include Rails.application.routes.url_helpers
		# include ActionView::Helpers
		# include ActionDispatch::Routing
		# include Rails.application.routes.url_helpers
		include ActionView::Helpers::RenderingHelper

		attr_accessor :back_path
		attr_accessor :headline
		attr_accessor :actions
		attr_accessor :crumbs


		def initialize
			@actions = []
			@crumbs = []
		end

		# def construct
		# 	render :partial => 'layouts/page_header.haml', 
		# 				 :locals => {:back_path => back_path, :headline => headline, :actions => @actions, :crumbs => @crumbs}
		# end

		def add_action text, path, *args
			action = {
				:text => text,
				:path => path,
				:type => "info",
				:icon => "star"
			}.merge(args.extract_options!)

			@actions << action
		end
		
		def add_crumb text, value, *args
			crumb = {
				:text => text,
				:value => value
			}.merge(args.extract_options!)

			@crumbs << crumb
		end
	end

end