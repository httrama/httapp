public with sharing class TreatmentUtility {

  private static Set<id> patientIds;
  private static Map<Id, Patient__c> patientMap;
  
  public static void beforeInsert (List<Treatment__c> pTreatments) {
    TreatmentUtility.patientIds = new Set<id>();
    
    for (Treatment__c treat : pTreatments) {
      TreatmentUtility.patientIds.add(treat.Patient__c);
    }
        
    if (TreatmentUtility.patientIds.size() > 0) {
      TreatmentUtility.patientMap =
        TreatmentUtility.populatePatientMap(patientIds);
        
      for (Treatment__c treat : pTreatments) {
        if (treat.Patient_Email__c == null &&
            TreatmentUtility.patientMap.containsKey(treat.Patient__c)) {
          treat.Patient_Email__c =
            TreatmentUtility.patientMap.get(treat.Patient__c).Email__c;
        }
      }
    }
  }
    
  public static void beforeUpdate(List<Treatment__c> pTreatments,
    Map<Id, Treatment__c> oldTreatmentMap) {
    
    TreatmentUtility.patientIds = new Set<id>();
    
    for (Treatment__c treat : pTreatments) {
      if (treat.Patient_Email__c !=
          oldTreatmentMap.get(treat.Id).Patient_Email__c) {
        TreatmentUtility.patientIds.add(treat.Patient__c);
      }
    }
    
    if (TreatmentUtility.patientIds.size() > 0) {
      for (Treatment__c treat : pTreatments) {
        if (TreatmentUtility.patientMap.containsKey(treat.Patient__c)) {
          treat.Patient_Email__c =
            TreatmentUtility.patientMap.get(treat.Patient__c).Email__c;
        }
      }
    }
  }
    
  private static Map<Id, Patient__c> populatePatientMap(Set<Id> pPatientIds) {
    if (pPatientIds != null && pPatientIds.size() > 0) {
      return new Map<Id, Patient__c>([select Time_Zone__c,
                                             Street__c,
                                             State__c,
                                             Salutation__c,
                                             Preferred_Language__c,
                                             Postal_Code__c,
                                             Phone__c,
                                             Patient_Stage__c,
                                             Mobile__c,
                                             Gender__c,
                                             Email__c,
                                             Date_of_Birth__c,
                                             Country__c,
                                             City__c,
                                             Alternate_Email__c,
                                             Advocate_Phone__c,
                                             Advocate_Name__c,
                                             Advocate_Email__c,
                                             SystemModstamp,
                                             OwnerId,
                                             Name,
                                             LastModifiedDate,
                                             LastModifiedById,
                                             LastActivityDate,
                                             IsDeleted,
                                             Id,
                                             CreatedDate,
                                             CreatedById
                                      from Patient__c
                                      where Id IN :pPatientIds]);
    } else {
      return null;
    }
  }
}