class Doctor
  attr_reader(:id, :doctor_name, :specialty)

  def initialize(attributes)
    @doctor_name = attributes[:doctor_name]
    @id = attributes[:id]
    @specialty = attributes[:specialty]
  end

  def self.all
    returned_doctors = []
    results = DB.exec('SELECT * FROM doctor;')
    results.each do |result|
      doctor_name = result['doctor_name']
      doctor_id = result['id']
      speciality = result['specialty']
      returned_doctors.push(Doctor.new(doctor_name: doctor_name, id: doctor_id, specialty: speciality))
    end
    returned_doctors
  end

  def save
    results = DB.exec("INSERT INTO doctor (doctor_name) VALUES ('#{@doctor_name}') RETURNING id;")
    @id = results.first["id"].to_i
  end

  def ==(another_doctor)
    self.doctor_name == another_doctor.doctor_name
  end

  def patients
    results = DB.exec("SELECT patient_name FROM patients WHERE doctor_id = ('#{self.id}');")
    list_patients = []
    results.each() do |patient|
      patient_name = patient['patient_name']
      list_patients.push(patient_name)
    end
    list_patients
  end

  def self.clear
    DB.exec("DELETE FROM doctor *;")
  end
end
