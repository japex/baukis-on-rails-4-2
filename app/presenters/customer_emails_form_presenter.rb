class CustomerEmailsFormPresenter < FormPresenter

  delegate :hidden_field, to: :form_builder

  def emails_field_block
    markup(:li) do |m|
      m << hidden_field(:id)
      m << text_field(:email)
      m << error_messages_for(:email, :span)
    end
  end
end
