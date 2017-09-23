class FieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :street_number, :string
    add_column :users, :street, :string
    add_column :users, :zip, :integer
    add_column :users, :city, :string
    add_column :users, :situation, :string
    add_column :users, :technical_informations, :string
  end
end
