require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Add a new doctor', {:type => :feature}) do
  it 'allows user to add a doctor' do
    visit('/')
    click_link('Add New Doctor')
    fill_in('doctor_name', :with => 'Dr. Banner')
    click_button('Add Doctor')
    expect(page).to have_content('Submission complete.')
  end
end

describe('Add a patient', {:type => :feature}) do
  it 'allows user to add a patient' do
    visit('/patient/new')
    fill_in('patient_name', :with => 'Patient X')
    click_button('Add. (At your own risk...)')
    expect(page).to have_content('Patient X')
  end
end
