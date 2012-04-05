class AdiskFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Context #nested content tags works now

  # Form helper, returns form column, actualy span4 div
  # TODO: emplement class handler

  display_label = false
  attr_accessor :display_label

  def column span=4,  &block
    if block_given?
      contents = if @template.respond_to?(:is_haml?) && @template.is_haml?
        @template.capture_haml(&block)
      else
        @template.capture(&block)
      end
    end

    contents = contents.join if contents.respond_to?(:join)

    column = content_tag(:div, contents, :class => "span#{span}")
  end

  # Return form fieldset with given legend
  def fieldset name, &block
    if block_given?
      contents = if @template.respond_to?(:is_haml?) && @template.is_haml?
        @template.capture_haml(&block)
      else
        @template.capture(&block)
      end
    end
    
    contents = contents.join if contents.respond_to?(:join)

    fieldset = content_tag(:fieldset) do
      content_tag(:legend, name) + contents
    end
  end

  # Simple rails input, but wrapped with custom wraper div and icon span
  # TODO: different type of inputs
  def prepended_input_for method, type, *args
    options = args.extract_options!

    prepended = content_tag(:div, :class => "input-custom") do
      if type == :text
        field = text_field method, :placeholder => options[:placeholder], :class => "span4"
      elsif type == :password
        field = password_field method, :placeholder => options[:placeholder], :class => "span4"
      elsif type == :select
        field = select @object.class.to_s.downcase, method, options[:collection], {:include_blank => options[:placeholder] }, {:class => "span4", :data => {:validate => true}}
      end

      field += content_tag(:span, :class => "add-on", :rel => "tooltip", :title => "hello") do
        content_tag(:i, "", :class => "icon-#{options[:icon]}")
      end

      # Display label if set options
      if display_label
        label(@object, method) + field
      else
        field
      end
    end
  end

  def form_actions
    actions = content_tag(:div, :class => "span8 actions") do
      submit_button + reset_button

    end
  end

  # Simple reset button for a form
  private
  def submit_button
    submit(:class => "btn btn-primary")
  end

  def reset_button
    submit_tag("Start Over", { :name => 'reset',:class => "btn", :id => 'reset_button', :type => "reset" })
  end

end