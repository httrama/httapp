/*
 * this class will hold all tests for the treatment object.
*/

@istest
private class TreatmentTests {

    static testmethod void treatment_methods_test () {
        Patient__c patient = new Patient__c();
        patient.Name = 'test patient';
        patient.Email__c = 'test@test.com';
        insert patient;
        
        Treatment__c treatment = new treatment__c();
        treatment.Patient__c = patient.id;
        insert treatment;
        
        treatment.patient_email__c = null;
        update treatment;
        
        //this test does nothing and asserts nothing.
        //I am adding an assert so we can package.
        
        treatment = [select patient_email__c from Treatment__c where Id = :treatment.id];
        System.assertNotEquals(null, treatment.patient_email__c);
    }
}