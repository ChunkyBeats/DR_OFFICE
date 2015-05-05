require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require("pg")
require('pry')

DB = PG.connect({:dbname => "dr_office"})

get("/") do
  erb(:index)
end

get("/doctors") do
  @doctors = Doctor.all
  erb(:doctors)
end

post("/doctors") do
  doctor_name = Doctor.new(doctor_name: params.fetch("doctor_name"))
  doctor_name.save
  @doctors = Doctor.all
  erb(:doctors)
end

get("/patients") do
  @patients = Patient.all
  erb(:patients)
end

post("/patients") do
  patient_name = Patient.new(patient_name: params.fetch("patient_name"), birthday: params.fetch("birthday"))
  patient_name.save
  @patients = Patient.all
  erb(:patients)
end

get("/patients/new") do
  erb(:patient_form)
end

get("/doctors/new") do
  erb(:doctor_form)
end

get("/clear_doctors") do
  Doctor.clear
  erb(:index)
end

get("/doctors/:id") do

end

get("/patients/:id") do

end

get("/clear_patients") do
  Patient.clear
  erb(:index)
end
