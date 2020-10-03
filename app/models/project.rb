class Project < ApplicationRecord
  include Filterable
  has_many :tasks, dependent: :destroy
  belongs_to :user
  belongs_to :lead, class_name: "User", foreign_key: "lead_id"
  has_many_attached :files
  has_many :members

  validates :status, inclusion: { in: ['not-started', 'in-progress', 'complete']}
  STATUS_OPTIONS = [
    ['Not started', 'not-started'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]
  scope :filter_by_status, -> (status) { where status: status }

  
    def self.search(search)
      if search
        where(["name LIKE ?","%#{search}%"])
      else
          all
      end
    end
end
