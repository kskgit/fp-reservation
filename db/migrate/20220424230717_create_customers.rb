class CreateCustomer < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|

      t.timestamps
    end
  end
end
