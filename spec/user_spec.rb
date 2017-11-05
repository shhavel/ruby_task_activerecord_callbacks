require "sqlite3"
require "active_record"

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
    end
  end
end

class User < ActiveRecord::Base
  # define callback here
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
CreateUsers.new.change

describe "ActiveRecord callbacks" do
  it "assigns full_name before saving record" do
    user = User.create(first_name: "Dougal", last_name: "McGuire")
    expect(user.full_name).to eq("Dougal McGuire")
  end
end
