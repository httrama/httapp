trigger PatientTrigger on Patient__c (before insert) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      PatientRank.startRanking(Trigger.new);
    }
  }
}