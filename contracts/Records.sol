pragma solidity ^0.5.0;


contract Records{
    struct Patient{
        address patient;
        string[] patRecords;
    }

    struct Doctor{
        address doctor;
        // address[] pat;
        mapping(address=>bool)pat;
    }
    
    mapping(address=>Patient) public patients;
    address[] public patientAcc;
    mapping(address=>bool)public oldpatients;
    mapping (address=>Doctor) public doctors;
    address[] public doctorAcc;
    mapping(address=>bool)public olddoctors;
    event PatientCreated(
        address patient
        // string name
        // string[] patRecords
    );
    event DoctorCreated(
        address doctor
    );
    event docPat(
      address pat,
      bool permission
    );


//patient database
function loginPatient(address patient) public {
  require(!oldpatients[patient],"old patient");
  patients[patient] = Patient(patient,new string[](0));
  emit PatientCreated(patient);
  patientAcc.push(patient);
  oldpatients[patient] = true;
}

//doctor database
function loginDoctor(address doctor) public{
 require(!olddoctors[doctor]," old Doctor");
  doctors[doctor] = Doctor(doctor);
  doctorAcc.push(doctor)-1;
  olddoctors[doctor] = true;
  emit DoctorCreated(doctor);
}

//give permission to doctor to access patient's address
function createPermission(address patient) public{
  require(!doctors[msg.sender].pat[patient],"permission not needed");
  doctors[msg.sender].pat[patient] = true;
  emit docPat(patient,true);
}

//add patient record
function patientRecord(address patient, string memory hash)public{
  patients[patient].patRecords.push(hash);
}


}