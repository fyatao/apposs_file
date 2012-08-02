class CreateDirectiveTemplates < ActiveRecord::Migration
  def change
    create_table :directive_templates do |t|
      t.string :name
      t.string :alias
      t.integer :owner_id
      t.integer :directive_group_id
      t.timestamps
    end
  end
end
