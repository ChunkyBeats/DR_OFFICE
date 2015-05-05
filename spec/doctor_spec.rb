require 'spec_helper'


describe Doctor do
  describe '#doctor_name' do
    it('returns the name of the doctor') do
      test_doctor = Doctor.new(doctor_name: "Dr. Seuss")
      expect(test_doctor.doctor_name).to eq("Dr. Seuss")
    end
  end

  describe '.all' do
    it('returns a list of all doctors') do
      test_doctor = Doctor.new(doctor_name: "Dr. Mann", doctor_id: nil)
      test_doctor.save
      expect(Doctor.all).to(eq([test_doctor]))
    end
  end

  describe '#save' do
    it('stores a doctor') do
      test_doctor = Doctor.new(doctor_name: "Dr. Hammond")
      test_doctor.save
      expect(test_doctor.doctor_name).to(eq("Dr. Hammond"))
    end
  end

  describe '#==' do
    it('checks equality of doctor name between two doctors') do
      test_doctor1 = Doctor.new(doctor_name: "Dr. Hammond")
      test_doctor1.save
      test_doctor2 = Doctor.new(doctor_name: "Dr. Hammond")
      test_doctor2.save
      expect(test_doctor1.==(test_doctor2)).to eq(true)
    end
  end

  describe '#specialty' do
    it('returns the specialty of the doctor') do
      test_doctor = Doctor.new(doctor_name: "Dr. Octopus", specialty: "Meta-physics")
      test_doctor.save
      expect(test_doctor.specialty).to(eq("Meta-physics"))
    end
  end

  describe '#patients' do
    it 'returns the list of patients assigned to the doctor id' do
      test_patient = Patient.new(patient_name: "Healthy")
      test_patient.save
      test_doctor = Doctor.new(doctor_name: "Dr. Dre", specialty: "Hip Hop")
      test_doctor.save
      test_patient.assign_dr(test_doctor)
      expect(test_doctor.patients).to eq([test_patient.patient_name])
    end
  end
end
