module CustomerParamsHelper
  include StringNormalizer

  # Remove {id: "", email: ""} which causes invalid creation of Email with blank email.
  def prune_emails(customer_params)
    customer_params.tap { |_customer_params|
      _customer_params[:emails_attributes].delete_if { |key, value|
        value[:id].blank? && value[:email].blank?
      }

      email_values = _customer_params[:emails_attributes].values
      if email_values.size > 2
        raise NotImplementedError, "Cannot handle emails size of > 2 (#{email_values.size} given)"
      end
      if email_in_db_and_email_literal_eql?(*email_values)
        email_values[0][:id], email_values[1][:id] = email_values[1][:id], email_values[0][:id]
      end
    }
  end

    def email_in_db_and_email_literal_eql?(value0, value1)
      [[value0, value1], [value1, value0]].any? { |v0, v1|
        normalize_as_email(v0[:email]).downcase == Email.find(v1[:id]).email_for_index
      }
    end
    private :email_in_db_and_email_literal_eql?

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
