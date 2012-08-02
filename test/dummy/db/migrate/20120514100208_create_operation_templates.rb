class CreateOperationTemplates < ActiveRecord::Migration
  def change
    create_table :operation_templates do |t|
      t.integer :app_id
      t.string  :name
      t.string  :source_ids
      t.string  :begin_script
      t.timestamps
    end
  end
end
