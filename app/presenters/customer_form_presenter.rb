class CustomerFormPresenter < UserFormPresenter
  def birthday_field_block(name, label_text, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      if options[:class].kind_of?(String)
        classes = options[:class].strip.split + [ 'birthday-picker' ]
        options[:class] = classes.uniq.join(' ')
      else
        options[:class] = 'birthday-picker'
      end
      m << text_field(name, options)
      m << error_messages_for(name)
    end
  end

  def gender_field_block
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(:gender, '性別')
      m << radio_button(:gender, 'male')
      m << label(:gender_male, '男性')
      m << radio_button(:gender, 'female')
      m << label(:gender_female, '女性')
    end
  end

  def emails_field_block(label_text, options = {})
    v = view_context
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(:emails, label_text, options)
      m << v.content_tag(:ol, type: 1) do
        form_builder.fields_for :emails do |e|
          v.concat v.content_tag(:li, e.text_field(:email, options))
        end
      end
    end
  end
end
