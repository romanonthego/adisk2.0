module IndexTableHelper
	# include ActionView::Helpers::TagHelper
	# include ActionView::Context

	# Main helper, construct index table for given object and columns
	def index_table_for object, &block #objects, columns
		table = IndexTable.new object
		# gather all the column and controls
		yield table

		table.construct
	end

	def generate_path path
		lambda {|object| send path, object}
	end

	class IndexTable
		include ActionView::Helpers::TagHelper
		include ActionView::Context
		include ActionView::Helpers::UrlHelper
		include Rails.application.routes.url_helpers
		# include ActionView::Helpers
		include ActionDispatch::Routing
		# include Rails.application.routes.url_helpers

		def initialize objects
			@objects = objects
			@columns = []
			@controls = []
		end

		def add_column *args
			column = {
				:name => :name,
				:header => "Some name"
			}.merge(args.extract_options!)

			# Remember to pass something to return as value in table cell
			unless column[:method]
				raise ArgumentError.new "You have to pass :method => :some_thing"
			end

			@columns << column
		end

		def add_control *args
			control = {
				:type => :info,
				:icon => "star",
				:action => :show
			}.merge(args.extract_options!)

			@controls << control
		end

		# Constructing table
		def construct
			content_tag(:table, :class => "table") do
				# Construct table header
				header = index_table_header
				body = index_table_rows

				content = header + body
			end
		end


		private
		# Construct table header
		def index_table_header
			header = content_tag(:thead) do
				content_tag(:tr) do
					content = ActiveSupport::SafeBuffer.new
					@columns.each do |c|
						content += content_tag(:th, c[:header])
					end

					# Check if where is any controls given
					# If there is - display empty cell to match column with controls
					unless @controls.empty?
						content += content_tag(:th, "")
					end

					content
				end
			end
		end


		# Construct rows
		def index_table_rows
			tbody = content_tag(:tbody) do
				rows = ActiveSupport::SafeBuffer.new
				# each given obj in collection
				@objects.each do |obj|
					rows += content_tag(:tr) do
						# content_tag(:td, "hello") + content_tag(:td, "hello")
						row = fulfill_the_row obj

						# Add cell with controls if where any
						unless @controls.empty?
							row += fulfill_controls obj # add td with controls for specific object
						end

						row
					end
				end
				rows
			end	
		end

		# Display control links
		# TODO: implement checking for can?(:method) for each controll
		def fulfill_controls obj
			content = ActiveSupport::SafeBuffer.new
			@controls.each do |control|
				content += link_to control[:path].call(obj), :class => "control control-#{control[:type]}" do
					content_tag(:i, "", :class => "icon-#{control[:icon]} icon-large")
				end
			end
			content_tag(:td, content)
		end

		# TODO: check why is model respond to :id method but returns nothing
		def fulfill_the_row obj
			tdata = ActiveSupport::SafeBuffer.new
			@columns.each do |c|
				tdata += content_tag(:td) do
					if obj.respond_to? c[:method]
						obj.send(c[:method])
					else
						raise NoMethodError.new "Can't get that data inside the index table. Check the method your calling."
					end
				end
			end
			tdata
		end
	end

end