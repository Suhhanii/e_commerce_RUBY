class Example < ApplicationRecord
  validates :terms_of_service, acceptance: {accept: ["done","check"]}

end
