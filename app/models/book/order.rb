
class Book::Order < ApplicationRecord
  validate :quantity_greater_than_zero
  belongs_to :book

  enum :statuss,{pending: "PENDING" , confirm: "CONFIRM"}#, validate: {presence: true}#, :shipped, :cancel], instance_methods: false , default: :pending

  after_find do |variable|
    puts "after find callback"
  end

  after_initialize do |variable|
   begin
    puts "after initialize trigger"
    # byebug
   rescue NotNullViolation
    puts "enum value is null"
   end
  end

  before_update :update_quantity #ordinary method

  after_update do
    puts "after update callback trigger"
  end

  before_validation do #block
    puts "before validation quantity is #{quantity} "
  end

  after_validation do #block
    puts "after validation quantity is #{quantity} "
  end

  # before_create -> { puts "before book order create" }
  #proc

  # around_create do |obj|
  #   puts "Before create #{quantity}"
  #   yield
  #   puts "After Create #{quantity}"
  # end

  before_create do |variable|
    puts "before create callback triggers"

  end


  after_touch do |variable|
    puts "After touch callback trigger"
  end

  after_create -> { puts "after book order create" }

  before_save do
    puts "before save callback trigger"
    # throw :abort
    # byebug
  end

  after_commit do |variable|
    # raise ActiveRecord::Errors
    puts "transaction commited ,,...after commit callback trigger"
  end

  after_rollback do |variable|
    puts "rollback due to some reason"
  end

  after_save do |obj|
    puts "after save callback trigger "
    # raise ActiveRecord::Rollback
    # byebug
    #  c = obj.count + 1
    #  byebug
    # # obj.save unless obj.persisted?
    # obj.update_column(:count, c)
    # # obj.save unless Book::Order.exists?(obj.id)
    # byebug
  end

  before_destroy do |variable|
    puts "before destroy call back ,,#{variable.id} id of destroy order"
  end

  after_destroy do |variable|
    puts "after destroy callback trigger"
  end


  private
  def quantity_greater_than_zero
   errors.add(:quantity, "Quantity Greater then 0") unless quantity.positive?
  end

  def update_quantity
    puts "update Callback"
    # byebug
    # quantity = 5
    # self.quantity = 5
    # byebug
  end
end

