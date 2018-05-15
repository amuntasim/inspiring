class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :parent, class_name: "Message", optional: true
  validates_presence_of :body, :user_id

  validates :messageable_id, presence: true

  def status
    read_at ? "read" : "unread"
  end

  def read!
    self.read_at = Time.now
    save
  end
end
