pragma solidity ^0.5.0;


contract Records{
    struct Patient{
        address patient;
        string[] patRecords;
        uint i; 
    }

    struct Doctor{
        address doctor;
        // address[] pat;
        mapping(address=>bool)pat;
    }
    Patient[] public patientDetails;
    uint public id =0;
    
    address[] public patientAcc;
    mapping(address=>bool)public oldpatients;
    mapping (address=>Doctor) public doctors;
    address[] public doctorAcc;
    mapping(address=>uint)public patientId;
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
// function loginPatient(address patient) public {
//   require(!oldpatients[patient],"old patient");
//   patients[patient] = Patient(patient,new string[](0));
//   emit PatientCreated(patient);
//   patientAcc.push(patient);
//   oldpatients[patient] = true;
// }

//doctor database
function loginDoctor(address doctor) public{
//  require(!olddoctors[doctor]," old Doctor");
  doctors[doctor] = Doctor(doctor);
  doctorAcc.push(doctor)-1;
  olddoctors[doctor] = true;
  emit DoctorCreated(doctor);
}

//give permission to doctor to access patient's address
function createPermission(address patient) public{
  doctors[msg.sender].pat[patient] = true;
  emit docPat(patient,true);

  // require(!oldpatients[patient],"old patient");
  // patients[patient] = Patient(patient,new string[](0),0);
  patientDetails.push(Patient(patient,new string[](0),0));
  patientId[patient] = id;
  id++;
  emit PatientCreated(patient);
  patientAcc.push(patient);
  oldpatients[patient] = true;

}

//add patient record
function patientRecord(string memory hash,address patient)public{
  Patient storage pat = patientDetails[patientId[patient]];
  pat.patRecords.push(hash);
  pat.i++;
}

//verify patient
function verify(address patient) public view returns(bool){
   return doctors[msg.sender].pat[patient];

}

//return patient's record
function returnRecord(uint i) public view returns (string memory){
       Patient storage pat = patientDetails[patientId[msg.sender]];
            return pat.patRecords[i];
}
//return old or not
function verifyPat(address patient) public view returns(bool){
    return  oldpatients[patient];

}


function recordCount() public view returns(uint ){
       Patient storage pat = patientDetails[patientId[msg.sender]];
            return pat.i;

     }


}