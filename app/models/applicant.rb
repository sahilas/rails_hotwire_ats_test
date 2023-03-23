class Applicant < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :text_search,
                  against: %i[first_name last_name email],
                  using: {
                    tsearch: {
                      any_word: true,
                      prefix: true
                    }
                  }

  belongs_to :offer
  has_one_attached :resume
  enum stage: {
    application: 'application',
    interview: 'interview',
    offer: 'offer',
    hired: 'hire'
  }

  enum status: {
    active: 'active',
    inactive: 'inactive'
  }

  validates_presence_of :first_name, :last_name, :email

  def name
    [first_name, last_name].join(' ')
  end
  FILTER_PARAMS = %i[query offer sort].freeze

  scope :for_offer, ->(offer_id) { offer_id.present? ? where(offer_id: offer_id) : all }
  scope :search, ->(query) { query.present? ? text_search(query) : all }
  scope :sorted, ->(selection) { selection.present? ? apply_sort(selection) : all }
  scope :for_profile, ->(account_id) { where(offers: { profile_id: profile_id }) }

  def self.apply_sort(selection)
    sort, direction = selection.split('-')
    order("applicants.#{sort} #{direction}")
  end

  def self.filter(filters)
    includes(:offer)
      .search(filters['query'])
      .for_offer(filters['offer'])
      .sorted(filters['sort'])
  end

  def name
    [first_name, last_name].join(' ')
  end

  def index
    @applicants = filter!(Applicant).for_profile(current_member.profile_id)
  end

end