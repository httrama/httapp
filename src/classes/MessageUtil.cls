/*
 *this class will provide utilities for the message workflow.
*/

public class MessageUtil {

  public static PageReference getReturnPage(String pRetUrl){
    PageReference p;
    if(pRetUrl != null){
      p = new PageReference(pRetUrl);
    }else{
      p = Page.MessageInbox;
    }
    p.setRedirect(true);
    return p;
  }
  
  public static String buildMessageQueryString(){
        return 'Select Id, ' +
                 'Name, ' + 
                 'htt__Body__c, ' +
                 'htt__Truncated_Body__c, ' +
                 'htt__isRead__c, ' +
                 'htt__From__c, ' +
                 'htt__From__r.Name,' +
                 'CreatedDate, ' +
                 'OwnerId, ' + 
                 'LastModifiedBy.Name, ' +
                 'htt__To__c, ' +
                 'htt__To__r.Name, ' +
                 'htt__Reply__c, ' +
                 'LastModifiedDate, ' +
                 'htt__Has_Attachments__c, ' +
                 'htt__Sent__c, ' +
                 '(select Id, Name from Attachments)' +
               'from htt__Message__c ';
    }
}