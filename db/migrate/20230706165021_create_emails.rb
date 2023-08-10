class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :sender
      t.string :date

      t.timestamps
    end
  end
end
