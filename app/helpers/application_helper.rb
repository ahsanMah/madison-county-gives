module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || "alert-" + flash_type.to_s
  end

  def alert_banner msg_type, message
    concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_sym)}") do
            concat content_tag(:button, octicon('x'), class: "close", data: { dismiss: 'alert' })
            concat message
          end)
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      alert_banner msg_type, message
    end
    nil
  end

  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    file = assets.find_asset(filename).source.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    if options[:width].present?
      svg["width"] = options[:width]
    end
    if options[:height].present?
      svg["height"] = options[:height]
    end
    raw doc
  end


end
