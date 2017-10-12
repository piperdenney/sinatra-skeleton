class Entry < ApplicationRecord::Base
  validates :title, :body, :user_id, { presence: true }
  belongs_to :user

  def self.most_recent
    Entry.order(created_at: :desc).limit(5)
  end
end
