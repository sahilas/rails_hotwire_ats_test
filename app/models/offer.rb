class Offer < ApplicationRecord
  belongs_to :profile
  has_rich_text :description
  has_many :applicants, dependent: :destroy
  validates_presence_of :title, :status, :offer_type, :location

  has_many :applicants, dependent: :destroy

  enum status: {
    draft: 'draft',
    open: 'open',
    closed: 'closed'
  }

  enum offer_type: {
    full_time: 'full_time',
    part_time: 'part_time'
  }
end
