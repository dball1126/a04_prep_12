class Link < ApplicationRecord
    validates :title, :url, :user_id, presence: true

    belongs_to :user
    has_many :comments

end