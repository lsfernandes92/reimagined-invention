class AddKindToContacts < ActiveRecord::Migration[7.1]
  def change
    add_reference :contacts, :kind, null: true, foreign_key: true
  end
end
