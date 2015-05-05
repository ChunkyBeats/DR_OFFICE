class Patient
attr_reader(:id, :patient_name, :birthday, :doctor_id)

  def initialize(attributes)
    @patient_name = attributes[:patient_name]
    @birthday = attributes[:birthday]
    @id = attributes[:id]
    @doctor_id = attributes[:doctor_id]
  end

  def save
    patients = DB.exec("INSERT INTO patients (patient_name) VALUES ('#{@patient_name}') RETURNING id;")
    @id = patients.first["id"].to_i
  end

  # def assign_dr(doctor)
  #   dr_name = doctor.doctor_name
  #   temp_id = DB.exec("SELECT id FROM doctor WHERE doctor_name = ('#{dr_name}');")
  #   blah = temp_id.first.fetch('id').to_i
  #   DB.exec("UPDATE patients SET doctor_id = ('#{blah}') WHERE patient_name = ('#{self.patient_name}')")
  # end

  def assign_dr(doctor)
    dr_name = doctor.doctor_name
    returned_results = DB.exec("SELECT id FROM doctor WHERE doctor_name = ('#{dr_name}');")
    dr_ids = []
    returned_results.each() do |id|
      whatweneed = id.fetch("id")
      dr_ids.push(whatweneed)
    end
    id_of_doctor = dr_ids.first.to_i
    DB.exec("UPDATE patients SET doctor_id = ('#{id_of_doctor}') WHERE patient_name = ('#{self.patient_name}')")
  end

  def self.all
    returned_patients = []
    patients = DB.exec("SELECT patient_name FROM patients;")
    patients.each do |patient|
      patient_name = patient["patient_name"]
      returned_patients.push(Patient.new(patient_name: patient_name))
    end
    returned_patients
  end

  def self.clear
    DB.exec("DELETE FROM patients *;")
  end

  # def find
  #   patient_info = DB.exec("SELECT patient_name, birthday, doctor_name FROM patient INNER JOIN doctor ON patient.doctor_id = doctor.id")
  #   info_array = []
  #   patient_info.each do |element|
  #     p_name = element["patient_name"]
  #     p_bd = element["birthday"]
  #     p_doctor = element["doctor_name"]
  #     info_array.push(Patient.new(patient_name: p_name, birthday: p_bd, ))
  # end

end
