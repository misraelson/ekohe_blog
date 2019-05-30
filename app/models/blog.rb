class Blog < ApplicationRecord
  # set default status to draft
  enum status: { draft: 0, published: 1 }
  # extend FriendlyId module to slugify blog titles
  extend FriendlyId
  friendly_id :title, use: :slugged
  # basic validations
  validates_presence_of :title, :body, :status
  # added User foreign key on blogs, inforces that relationship
  belongs_to :user
end
