require "active_record"

env = ENV['WIMDU_ENV']
db = if env
       "#{env}.db"
     else
       "wimdu.db"
     end

ActiveRecord::Base.logger = Logger.new(File.open(File.expand_path('../../log/database.log', __FILE__), 'w'))
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.expand_path("../../data/#{db}", __FILE__)
)
ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'properties'
    create_table :properties do |table|
      table.column :title,     :string
      table.column :property_type, :string
      table.column :address, :string
      table.column :nightly_rate, :float
      table.column :max_guests, :integer
      table.column :email, :string
      table.column :phone_number, :string
    end
  end
end


