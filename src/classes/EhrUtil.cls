/*
 *this class can be used for all the different public utilities that ehr will use.
 *written by mfullmore 01/12/10
*/

public class EhrUtil {

  public static ApexPages.StandardSetController createStandardSetController(String pQueryString){
    ApexPages.StandardSetController returnSet;
    if(pQueryString != null){
      returnSet = new ApexPages.StandardSetController(Database.getQueryLocator(pQueryString));
    }
    return returnSet;
  }
  
  public static ApexPages.StandardSetController createStandardSetController(String pQueryString, Integer pPageSize){
    ApexPages.StandardSetController returnSet;
    System.debug('#query: '+pQueryString);
    System.debug('#pageSize: '+pPageSize);
    if(pQueryString != null && pPageSize != null){
      System.debug('#create standar controller (if)');
      returnSet = new ApexPages.StandardSetController(Database.getQueryLocator(pQueryString));
      System.debug('#after queryLocator');
      // we need this due to a bug in Visualforce : see 
            // http://community.salesforce.com/sforce/board/message?board.id=Visualforce&message.id=17035 
            if (returnSet.getResultSize() > 0) {
                returnSet.setPageSize(pPageSize);
            }
    }
    return returnSet;
  }
  
  public static testMethod void testEhrUtil(){
    ApexPages.StandardSetController sc;
    
    sc = EhrUtil.createStandardSetController(MessageUtil.buildMessageQueryString() + 
                         'where To__c = \'' + 
                         UserInfo.getUserId() + 
                         '\'');
    System.assertNotEquals(null, sc);
    
    sc = EhrUtil.createStandardSetController(MessageUtil.buildMessageQueryString() + 
                         'where To__c = \'' + 
                         UserInfo.getUserId() + 
                         '\'', 6);
    System.assertNotEquals(null, sc);
  }
}