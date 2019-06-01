class Blog < ApplicationRecord
  belongs_to :user
  # set default status to draft
  enum status: { draft: 0, published: 1 }
  # extend FriendlyId module to slugify blog titles
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates(:title, :status, presence: true)

  validates :body, length: {minimum: 5}

  def self.search(search_term)
    # where(["title ILIKE :term OR body ILIKE :term", {term: "%#{search_term}%"}])
    where(["title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%"])
  end
end
