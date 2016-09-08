class CustomerPresenter < ModelPresenter

  def email
    if object.emails.size <= 1
      object.emails.first.try(:email)
    else
      markup(:ul, style: 'margin: 0px') do |m|
        object.emails.each do |email|
          m.li email.email
        end
      end
    end
  end

  def full_name
    object.family_name + ' ' + object.given_name
  end

  def full_name_kana
    object.family_name_kana + ' ' + object.given_name_kana
  end

  def birthday
    return '' if object.birthday.blank?
    object.birthday.strftime('%Y/%m/%d')
  end

  def gender
    case object.gender
    when 'male'
      '男性'
    when 'female'
      '女性'
    else
      ''
    end
  end

  def personal_phones
    object.personal_phones.map(&:number)
  end
end
