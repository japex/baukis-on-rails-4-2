class Email < ActiveRecord::Base
  include EmailHolder

  belongs_to :customer
end
