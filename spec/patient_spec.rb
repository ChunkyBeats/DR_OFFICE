require 'spec_helper'

describe Patient do
  describe '#patient_name' do
    it 'returns the name of the patient' do
      test_patient = Patient.new(patient_name: "XOA")
      expect(test_patient.patient_name).to eq("XOA")
    end
  end

  describe'#assign_dr' do
    it('assigns a doctor to a patient') do
      test_patient = Patient.new(patient_name: "Sicky")
      test_patient.save
      test_doctor = Doctor.new(doctor_name: "Dr. Doolittle")
      test_patient.assign_dr(test_doctor)
      expect(test_patient.doctor_id).to eq(test_doctor.id)
    end
  end

  describe '.all' do
    it 'lists all patients' do
      test_patient = Patient.new(patient_name: "Healthy")
      test_patient.save
      expect(Patient.all).to eq([test_patient.patient_name])
    end
  end
end
