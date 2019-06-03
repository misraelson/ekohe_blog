class Blog < ApplicationRecord
  
  belongs_to :user
  
  enum status: { draft: 0, published: 1 }
  # extend FriendlyId module to slugify blog titles
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates(:title, presence: true, uniqueness: true)
  validates(:status, presence: true)

  validates :body, length: {minimum: 5}

  scope :published, -> { where(status: 1) }

  def self.search(search_term)
    where(["title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%"])
  end
end
