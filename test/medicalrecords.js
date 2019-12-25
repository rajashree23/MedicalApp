const MedicalRecord = artifacts.require('./Records.sol')

require('chai')
    .use(require('chai-as-promised'))
    .should()


contract('Records', ([patient, doctor]) => {
    let medicalRecord;

    before(async () => {
        medicalRecord = await MedicalRecord.deployed()
    })

    // describe('patientDetails', async () => {
    //     let result;
    //     it('new patient added successfully', async () => {
    //         result = await medicalRecord.loginPatient({ from: patient })
    //         console.log(result)
    //     })

    // })
    describe('doctorDetails', async () => {
        it('new doctor added successfully', async () => {
            result = await medicalRecord.loginDoctor({ from: doctor })
            const event1 = result.logs[0].args;
            assert.equal(event1.doctor, doctor, "correct doctor")
            resultpat = await medicalRecord.createPermission(patient, { from: doctor })
            const event2 = resultpat.logs[0].args;
            assert.equal(event2.pat, patient, "correct patient");
            assert.equal(event2.permission, true, "correct");

        })
    })
})