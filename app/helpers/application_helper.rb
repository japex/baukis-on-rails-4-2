module ApplicationHelper
  include HtmlBuilder

  def document_title
    if @title.present?
      "#{@title} - Baukis"
    else
      'Baukis'
    end
  end

  def application_name
    AppSetting.application_name || 'BAUKIS'
  end
end
