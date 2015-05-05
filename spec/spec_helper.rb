require 'doctor'
require 'patient'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'dr_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patients *;")
  end
end
