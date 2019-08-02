class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.text :name
      t.text :summary
      t.text :images_path

      t.timestamps
    end
  end
end
