class AddAssignIdAndReportIdToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :assign_id, :integer
    add_column :tasks, :report_id, :integer
  end
end
