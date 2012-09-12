trigger TreatmentTrigger on Treatment__c (before insert, before update) {
    
  if (trigger.isBefore && trigger.isInsert) {
    TreatmentUtility.beforeInsert(Trigger.new);
  }
    
  if (trigger.isBefore && trigger.isupdate){
    TreatmentUtility.beforeUpdate(Trigger.new, Trigger.oldMap);
  }
}