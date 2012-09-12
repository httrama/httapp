trigger MessageTrigger on Message__c (before insert, 
		                                  before update, 
		                                  after insert, 
		                                  after update) {

  if(Trigger.isBefore) {
    if(Trigger.isInsert) {
      MessageManagement.populateBody(Trigger.new);
      MessageManagement.populateTruncatedBody(Trigger.new);
    }
    if(Trigger.isUpdate) {
      MessageManagement.appendToBody(Trigger.new);
      MessageManagement.populateTruncatedBody(Trigger.new);
      MessageManagement.populateSent(Trigger.old, Trigger.new);
      MessageManagement.checkForAttachments(Trigger.new);
    }
  }

  if(Trigger.isAfter) {
    if(Trigger.isInsert) {
      MessageManagement.addApexSharing(Trigger.new);
    }
    
    if(Trigger.isUpdate) {
      MessageManagement.addApexSharing(Trigger.new);
    }
  }
}
