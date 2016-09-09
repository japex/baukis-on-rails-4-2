class ConfirmingCustomerEmailsFormPresenter < ConfirmingFormPresenter

  def emails_field_block
    markup(:li) do |m|
      m << hidden_field(:id)
      m << hidden_field(:email)
      m.div(object.email, class: 'field-value')
    end
  end
end
