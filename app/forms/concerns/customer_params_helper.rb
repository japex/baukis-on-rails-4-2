module CustomerParamsHelper

  # Remove {id: "", email: ""} which causes invalid creation of Email with blank email.
  def prune_emails(customer_params)
    customer_params.tap { |_customer_params|
      _customer_params[:emails_attributes].delete_if { |key, value|
        value[:id].blank? && value[:email].blank?
      }
    }
  end

  def mark_emails_for_destruction(customer, customer_params)
    emails_params = customer_params[:emails_attributes]
    customer.emails.size.times do |index|
      attributes = emails_params[index.to_s]
      if attributes && attributes[:email].blank?
        customer.emails[index].mark_for_destruction
      end
    end
  end
end
