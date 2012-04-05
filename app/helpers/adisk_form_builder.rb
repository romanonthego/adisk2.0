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


  # Wraper for sortable list (nested models)
  def sortable_list_for_nested method, *args, &block
    options = {
      :id => "sortable"      
    }.merge(args.extract_options!)

    content = fields_for method, &block
    content_tag :div, content, :class => "row sortable", :data => {:sortable => true}, :id => options[:id]
  end

  # List element for sortble list
  def sortable_list_element span=8, &block
    if block_given?
      contents = if @template.respond_to?(:is_haml?) && @template.is_haml?
        @template.capture_haml(&block)
      else
        @template.capture(&block)
      end
    end
    contents = contents.join if contents.respond_to?(:join)

    content_tag :div, contents, :class => "span#{span} sortable-element"
  end


  # Simple rails input, but wrapped with custom wraper div and icon span
  # TODO: different type of inputs
  def prepended_for method, type=:text, *args
    options = {
      :placeholder => method.to_s,
      :span => 4,
      :icon => "pencil",
      :hint => method.to_s,
      :rows => 2,
      :resize => false
    }.merge(args.extract_options!)
    # options = args.extract_options!.merge(defaults)

    add_on_class = display_label ? "add-on-label" : "add-on" # keep top positioning right with and without labels

    prepended = content_tag(:div, :class => "input-custom") do
      case method
      when :text
        field = ready_text_field method, options
      when :password
        field = ready_password_field method, options
      when :select
        field = ready_select method, options
      when :textarea
        field = ready_select_field method, options
      else
        field = ready_text_field method, options
      end

      field += content_tag(:span, :class => add_on_class, :rel => "tooltip", :title => options[:hint]) do
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

  def ready_text_field method, options
    text_field method, :placeholder => options[:placeholder], :class => "span#{options[:span]}"
  end

  def ready_password_field method, options
    password_field method, :placeholder => options[:placeholder], :class => "span#{options[:span]}"
  end

  def ready_select method, options
    select @object.class.to_s.downcase, method, options[:collection], 
                            {:include_blank => options[:placeholder] }, 
                            {:class => "span#{options[:span]}", :data => {:validate => true}}
  end

  def ready_textarea method, options
    klass = "span#{options[:span]}"
    klass += " resizable" if options[:resize]

    text_area method, :placeholder => options[:placeholder], :class => klass,
                      :rows => options[:rows]
  end



  def form_actions
    actions = content_tag(:div, :class => "span8 actions") do
      submit_button + reset_button
    end
  end

  # Simple reset button for a form
  def submit_button
    submit(:class => "btn btn-primary")
  end

  def reset_button
    submit_tag("Start Over", { :name => 'reset',:class => "btn", :id => 'reset_button', :type => "reset" })
  end

  private
  def capture_block &block
    # refactor block capturing here
  end

end