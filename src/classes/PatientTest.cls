/*
 * test class for patient use case
*/

@isTest
private class PatientTest {
  static testMethod void testPatient() {
    Patient__c patient;
    
    patient = populatePatient();
    insert patient;
    
    patient = [select Id, Original_Number_Rank__c
               from Patient__c
               where Id = :patient.Id];
               
    System.assert(patient.Original_Number_Rank__c != null);
  }
  
  static Patient__c populatePatient() {
    return new Patient__c(Name = 'Test Patient',
                          Email__c = 'patient@htt.com',
                          Phone__c = '1231231234');
  }
}