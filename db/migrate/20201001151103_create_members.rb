class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      
      t.belongs_to :project
      t.belongs_to :user

      t.timestamps
    end
  end
end
