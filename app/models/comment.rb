class Comment < ApplicationRecord
  include Entryable

  def title
    content
  end
end
