module OrdersHelper
  def listing_order_error_messages!

    html = ''

    return html if @order.errors.empty? 

    messages = @order.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved", 
                      count: @order.errors.count, 
                      resource: @order.class.model_name.human.downcase)

    html = <<-HTML 
           <div class="alert alert-warning alert-dismissible" role="alert"> 
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button> 
              <h4>#{sentence}</h4> 
              #{messages} 
           </div> 
           HTML

    html.html_safe
  end

end
