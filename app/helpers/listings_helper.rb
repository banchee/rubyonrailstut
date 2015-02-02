module ListingsHelper
  def listing_error_messages!

    html = ''

    return html if @listing.errors.empty? 

    messages = @listing.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved", 
                      count: @listing.errors.count, 
                      resource: @listing.class.model_name.human.downcase)

    html = <<-HTML 
           <div class="alert alert-warning alert-dismissible" role="alert"> 
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button> 
              <h4>#{sentence}</h4> 
              #{messages} 
           </div> 
           HTML

    html.html_safe
  end

  def form_error_control!
  
    html = ''

    return html if @listing.errors.empty? 

    html = <<-HTML "has-error" 
            HTML

    html.html_safe
  end 


end
