class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: "User", foreign_key: "assign_id"
  belongs_to :reportee, class_name: "User", foreign_key: "report_id"

  validates :status, inclusion: { in: ['not-started', 'in-progress', 'complete']}
  STATUS_OPTIONS = [
    ['Not started', 'not-started'],
    ['In progress', 'in-progress'],
    ['Complete', 'complete']
  ]
end
