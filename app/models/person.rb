class Person < ApplicationRecord

  class EmailBlankException < StandardError; end

  before_validation do
   puts "email and email-confirmation should be same "
  end

  after_commit ShowName

  validates :email,confirmation: true,presence: {strict: EmailBlankException }
  validates :email_confirmation, presence: true,
  unless: Proc.new { |a| a.email.blank?}

  validates :email, format: {with: /\A[a-zA-Z]+\z/}


end
