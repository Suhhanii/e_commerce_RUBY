class Entry < ApplicationRecord
  delegated_type :entryable, types: %w[Message Coment], dependent: :destroy
  delegate :title, to: :entryable
end
