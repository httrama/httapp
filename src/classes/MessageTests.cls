/*
 *this class will test the message inbox
 *written by mfullmore 10/06/09
*/

public class MessageTests {
    
    public static String getLargeData(){
        String data = 'Test';
        
        for(Integer i = 0; i<30; i++){
            data += ' More Data ';
        }
        return data;
    }
    
    //use this method to return a user sobject
    public static User createUser(){
        Profile pr = [select id from profile where name='Standard User' limit 1]; 
        
        User u = new User(alias = 'standt', 
                          email='standarduser@testorg.com', 
                          emailencodingkey='UTF-8', 
                          lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', 
                          profileid = pr.Id, 
                          timezonesidkey='America/Los_Angeles', 
                          username='standard' + String.valueOf(System.now().getTime()) + '@testorg.com');
            
        return u;
    }
    
    public static User createPortalUser(){
        Profile pr = [select id from profile where UserType ='PowerCustomerSuccess' limit 1]; 
        
        User u = new User(alias = 'port', 
                          email='portalUser@testorg.com', 
                          emailencodingkey='UTF-8', 
                          lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', 
                          profileid = pr.Id, 
                          timezonesidkey='America/Los_Angeles', 
                          username='portal' + String.valueOf(System.now().getTime()) + '@testorg.com');
            
        return u;
    }
    
    public static User getAdminUser(){
      Profile pr = [select id from profile where name='System Administrator' limit 1]; 
      return [select Id from User where ProfileId = : pr.Id Limit 1];
    }
    
    public static Message__c createMessage(){
      return new Message__c(Name = 'Test Message',
                Body__c = 'This is a test');
    }
    
    //tests to test the MessageTests methods
    static testMethod void testMessageTests(){
      String largeData = MessageTests.getLargeData();
      System.assert(largeData.contains(' More Data '));
      
      User createUser = MessageTests.createUser();
      System.assertEquals(createUser.Alias, 'standt');
      
      try{
        User createPortalUser = MessageTests.createPortalUser();
        System.assertEquals(createPortalUser.Alias, 'port');
      }catch(QueryException e){
        System.debug('**** error ' + e.getMessage());
      }
      
      User adminUser = MessageTests.getAdminUser();
      System.assertNotEquals(adminUser.Id, null);
      
      Message__c testMsg = MessageTests.createMessage();
      System.assertNotEquals(null, testMsg.Name);
    }
    
    //MessageInboxController tests
    static testMethod void testMessageInboxController(){
      MessageInboxController mic;
      PageReference p;
      My_Message_Settings__c msgSet;
      User testUser = MessageTests.createUser();
      
      insert testUser;
      System.assertNotEquals(null, testUser.Id);
      
      p = Page.MessageInbox;
      Test.setCurrentPage(p);
      
      System.runAs(testUser){
        try{
          mic = new MessageInboxController();
          System.assert(mic.newMessage().getUrl().contains('apex'));
          System.assert(mic.newMessageforPortal().getUrl().contains('Portal'));
          System.assertNotEquals(null, mic.getShowInfoHeader());
          System.assertNotEquals(null, mic.getShowHideLink());
          mic.hideInfoHeader();
          msgSet = [select Show_Info_Header__c from My_Message_Settings__c where SetupOwnerId = : UserInfo.getUserId()];
          System.assertNotEquals(null, msgSet);
          System.assert(!msgSet.Show_Info_Header__c);
          mic.hideInfoHeader();
        }catch(Exception e){
          System.debug('**** message error ' + e.getMessage());
        }
      }
    }
    
    //MessageNewMessageController tests
    static testMethod void testMessageNewMessageController(){
      MessageNewMessageController mnmc;
      PageReference p;
      Attachment att;
      Message__c msg;
      
      //portal test of new message
      p = Page.MessageNewMessage;
      p.getParameters().put('returnUrl', '/MessageInbox');
      Test.setCurrentPage(p);
      mnmc = new MessageNewMessageController();
      mnmc.startProcess();
      
      att = new Attachment(Body = Blob.valueOf('test'),
                 Name = 'test attachment');
    mnmc.setNewAttachment(att);
    System.assertEquals(mnmc.getNewAttachment().Name, 'test attachment');
    msg = mnmc.getNewMessage();
    msg.Name = 'Test Message Patient Inbox';
    msg.Body__c = 'Test Body';
    mnmc.setNewMessage(msg);
    mnmc.setSelectedSenderId(UserInfo.getUserId());
    System.assertEquals(mnmc.saveNewMessage().getUrl(), '/MessageInbox');
    System.assertNotEquals(null, msg.Id);
      System.assertEquals(mnmc.cancelBtn().getUrl(), '/MessageInbox');
      
      //native test of new message
      p = Page.MessageNewMessage;
      p.getParameters().put('returnUrl', '/apex/MessageInbox');
      Test.setCurrentPage(p);
      mnmc = new MessageNewMessageController();
      mnmc.startProcess();
      
      mnmc.setToField('Test No Name');
      p.getParameters().put('setSelectedSenderId', UserInfo.getUserId());
      p.getParameters().put('setToField', UserInfo.getName());
      mnmc.itemSelected();
      System.assertEquals(mnmc.getSelectedSenderId(), UserInfo.getUserId());
      System.assertNotEquals(mnmc.getToField(), 'Test No Name');
      
      mnmc.itemCleared();
      System.assertEquals(mnmc.getSelectedSenderId(), null);
      
      //negitive tests
      p = Page.MessageNewMessage;
      p.getParameters().put('returnUrl', '/apex/MessageNewMessages');
      Test.setCurrentPage(p);
      mnmc = new MessageNewMessageController();
      mnmc.startProcess();
      msg = mnmc.getNewMessage();
    msg.Name = 'Test Message Patient Inbox';
    msg.Body__c = 'Test Body';
    mnmc.setNewMessage(msg);
    mnmc.setSelectedSenderId(null);
    System.assertEquals(mnmc.getSelectedSenderId(), null);
    mnmc.saveNewMessage();
    
      p = Page.MessageNewMessage;
      p.getParameters().put('returnUrl', '/apex/MessageMessages');
      Test.setCurrentPage(p);
      mnmc = new MessageNewMessageController();
      mnmc.startProcess();
      msg = mnmc.getNewMessage();
    msg.Name = MessageTests.getLargeData();
    msg.Body__c = 'Test Body';
    mnmc.setSelectedSenderId(UserInfo.getUserId());
    mnmc.setNewMessage(msg);
    System.assertEquals(mnmc.saveNewMessage(), null);
    }
    
    //MessageReplyMessageController tests
    static testMethod void testMessageTestMessageController(){
      MessageReplyMessageController mrmc;
      PageReference p;
      Message__c testMsg;
      Attachment att;
      
      //reply test
      testMsg = new Message__c();
      testMsg.Name = 'This is a test Reply';
      testMsg.Body__c = 'This is the test Body';
      testMsg.To__c = UserInfo.getUserId();
      testMsg.From__c = UserInfo.getUserId();
      insert testMsg;
      System.assertNotEquals(null, testMsg.Id);
      
      p = Page.MessageReplyMessage;
      p.getParameters().put('messageId', testMsg.Id);
      p.getParameters().put('returnUrl', '/MessageInbox');
      Test.setCurrentPage(p);
      mrmc = new MessageReplyMessageController();
      mrmc.startProcess();
      System.assertEquals('This is a test Reply', mrmc.getMessage().Name);
      System.assertEquals('Re: This is a test Reply', mrmc.getNewMessage().Name);
      
      att = new Attachment(Body = Blob.valueOf('test'),
                 Name = 'test attachment');
    mrmc.setNewAttachment(att);
    System.assertEquals(mrmc.getNewAttachment().Name, 'test attachment');
    System.assert(mrmc.saveReply().getUrl().contains('MessageInbox'));
    
    //native reply test
    testMsg = [select Id, Name, Body__c, To__c, From__c from Message__c where Id = : testMsg.Id];
    p = Page.MessageReplyMessage;
    //commenting these parameters out to test negitive tests for the return URL and the message ID.
      //p.getParameters().put('messageId', testMsg.Id);
      //p.getParameters().put('returnUrl', '/PatientMessages?viewType=Portal');
      Test.setCurrentPage(p);
      mrmc = new MessageReplyMessageController();
      mrmc.startProcess();
      //nagitive test for the message id
      System.assertEquals(mrmc.getNewMessage(), null);
      System.assertNotEquals(mrmc.cancelBtn().getUrl(), null);
      mrmc.setNewMessage(testMsg);

    p = Page.MessageReplyMessage;
    p.getParameters().put('messageId', testMsg.Id);
      p.getParameters().put('returnUrl', '/MesageInboxPage');
      Test.setCurrentPage(p);
      mrmc = new MessageReplyMessageController();
      mrmc.startProcess();
      System.assertEquals(mrmc.getNewMessage().Name, 'Re: This is a test Reply');
      
      //negitive for saveReply
      p = Page.MessageReplyMessage;
    p.getParameters().put('messageId', testMsg.Id);
      p.getParameters().put('returnUrl', '/MesageInboxPage');
      Test.setCurrentPage(p);
      mrmc = new MessageReplyMessageController();
      mrmc.startProcess();
      testMsg.Name = MessageTests.getLargeData();
      mrmc.setNewMessage(testMsg);
      System.assertEquals(null, mrmc.saveReply());
      
      //negitive for populateMessage
      p = Page.MessageReplyMessage;
    p.getParameters().put('messageId', '123456789012345');
      p.getParameters().put('returnUrl', '/MesageInboxPage');
      Test.setCurrentPage(p);
      mrmc = new MessageReplyMessageController();
      mrmc.startProcess();
      System.assertEquals(null, mrmc.getMessage());
    }
    
    /*
    //MessageListController tests
    static testMethod void testMessageListController(){
      MessageListController mlc;
      Message__c tempMsg;
      List<Message__c> msgList = new List<Message__c>();
      String queryString;
      
      for(Integer i = 0; i < 3; i++){
        tempMsg = new Message__c();
        tempMsg.Name = 'Test msg ' + i;
        tempMsg.Body__c = 'Test Body ' + i;
        tempMsg.To__c = UserInfo.getUserId();
        tempMsg.From__c = UserInfo.getUserId();
        msgList.add(tempMsg);
      }
      insert msgList;
      System.assertNotEquals(null, msgList[0].Id);
      
      mlc = new MessageListController();
      //test mlc.getReturnUrl first, because you can't pass in a null to a setter.
      
      mlc.setQueryString(MessageUtil.buildMessageQueryString() + 'where To__c = \'' + UserInfo.getUserId() + '\'');
      mlc.setOrderedBy(mlc.getOrderedBy());
      mlc.setOrdered(mlc.getOrdered());
      mlc.setPageSize('6');
      mlc.setIsInbox(true);
      mlc.setIsPortal(false);
      mlc.setReturnUrl('/apex/MessageInbox');
      System.assertEquals(MessageUtil.buildMessageQueryString() + 'where To__c = \'' + UserInfo.getUserId() + '\'', mlc.getQueryString());
      System.assertEquals('Sent__c', mlc.getOrderedBy());
      System.assertEquals('DESC', mlc.getOrdered());
      System.assertEquals('6', mlc.getPageSize());
      System.assertEquals('true', mlc.getIsInbox());
      System.assertEquals('false', mlc.getIsPortal());
      System.assertEquals('/apex/MessageInbox', mlc.getReturnUrl());
      
      //test all of the mlc.getReturnUrl() statements.
      mlc.setReturnUrl(null);
      System.assertEquals('/apex/MessageInbox', mlc.getReturnUrl());
      mlc.setIsPortal(true);
      System.assertEquals('/PatientMessages?viewType=Portal', mlc.getReturnUrl());
      
      //showMessage()
      System.assertNotEquals(null, mlc.getMessages().size());
      mlc.setMessageId(msgList[0].Id);
      System.assertEquals(msgList[0].Id, mlc.getMessageId());
      System.assertEquals(null, mlc.showMessage());
      System.assertEquals(true, mlc.getShowReplyBtn());
      
      //replyMessage()
      System.assert(mlc.replyBtn().getUrl().contains('PatientMessages'));
      mlc.setIsPortal(false);
      System.assert(mlc.replyBtn().getUrl().contains('MessageInbox'));
      mlc.backBtn();
      System.assert(!mlc.getShowMessage());
      mlc.orderList();
      System.assertEquals('ASC', mlc.getOrdered());
      mlc.orderList();
      System.assertEquals('DESC', mlc.getOrdered());
      mlc.setOrdered(null);
      mlc.orderList();
      System.assertEquals('ASC', mlc.getOrdered());
      mlc.previous();
      mlc.next();
      System.assertNotEquals('0', mlc.getTotalPages());
      System.assertNotEquals('0', mlc.getPageNum());
      System.assertNotEquals(null, mlc.getShowPrevious());
      System.assertNotEquals(null, mlc.getShowNext());
      
      //nagitive tests
      mlc.setQueryString('BAD QUERY');
      mlc.getMessages();
      System.assertEquals('1', mlc.getPageNum());
      System.assertEquals('1', mlc.getTotalPages());
      
      //after the dml on showMessage
      mlc.setIsInbox(false);
      mlc.showMessage();
      System.assert(!mlc.getShowReplyBtn());
      
    }
    */
    
    //PatientDashboardMessagesController tests
    /*
    static testMethod void testPatientDashboardMessageController(){
      Patient__c testPatient = PatientTests.createPatientObject();
      PatientDashboardMessagesController pdmc;
      ApexPages.StandardController sc;
      String testString;
      User testPortalUser;
      Contact testContact;
      Id conId;
      Boolean portalUserTestSuccess;
      
      insert testPatient;
      System.assertNotEquals(null, testPatient.Id);
      
      //without portal user tests
      sc = new ApexPages.Standardcontroller(testPatient);
      pdmc = new PatientDashboardMessagesController(sc);
      System.assert(pdmc.getShowCreatePortalButton());
      testString = String.valueOf(testPatient.Id).substring(0,15);
      System.assertEquals('/apex/PatientDashboardMessages?id=' + testString, pdmc.getReturnUrl());
      System.assert(pdmc.createPortalUser().getUrl().contains('PatientDashboardMessages'));
      System.assertEquals(null, pdmc.getPageSize());
      
      try{
        testPatient = [select Id, Contact__c from Patient__c where Id = : testPatient.Id];
        testPortalUser = MessageTests.createPortalUser();
        testPortalUser.ContactId = testPatient.Contact__c;
        system.debug( testPortalUser );
        system.debug( testPatient.Contact__c );
        Contact c =  [select id, name, account.ownerid, account.id, account.name
          from Contact where id =:testPatient.Contact__c limit 1];
        system.debug (c);
        Account a = [ Select name, a.Owner.ProfileId, a.Owner.UserRoleId, a.Owner.Name, a.Owner.Id, a.OwnerId 
          From Account a where id = :c.account.id limit 1];
        system.debug('Account ' + a);
        system.debug('Owner ' + a.Owner );
        insert testPortalUser;
        System.assertNotEquals(null, testPortalUser.Id);
        portalUserTestSuccess = true;
      }catch(QueryException e){
        System.debug('**** error' + e.getMessage());
        portalUserTestSuccess = false;
      }
      
      //with portal user tests
      sc = new ApexPages.Standardcontroller(testPatient);
      pdmc = new PatientDashboardMessagesController(sc);
      pdmc.startProcess();
      if(portalUserTestSuccess){
        System.assert(!pdmc.getShowCreatePortalButton());
      }
      
      try { 
        system.debug( pdmc );
        System.assert(pdmc.getReceivedQueryString().contains('To__c'));
        System.assert(pdmc.getSentQueryString().contains('From__c'));
        System.assert(pdmc.sendPatientMessage().getUrl().contains('messagenewmessage'));
      
      } catch(System.DmlException e){
        System.assert(false,e.getMessage() + 
          '  you must create a role in your org for the user running the install');
      }
      
      //negitive tests for create alias
      testPatient = PatientTests.createPatientObject();
      testPatient.First_Name__c = 't';
      insert testPatient;
      System.assertNotEquals(null, testPatient.Id);
      sc = new ApexPages.Standardcontroller(testPatient);
      pdmc = new PatientDashboardMessagesController(sc);
      System.assert(pdmc.createPortalUser().getUrl().contains('Alias=Cole'));
      
      conId = [select Contact__c from Patient__c where Id = : testPatient.Id].Contact__c;
      testContact = [select Id, FirstName from Contact where Id = : conId];
      testContact.FirstName = null;
      update testContact;
      sc = new ApexPages.Standardcontroller(testPatient);
      pdmc = new PatientDashboardMessagesController(sc);
      System.assert(pdmc.createPortalUser().getUrl().contains('Alias=Colem'));
      
      testPatient = PatientTests.createPatientObject();
      testPatient.First_Name__c = 't';
      testPatient.Last_Name__c = 'te';
      insert testPatient;
      System.assertNotEquals(null, testPatient.Id);
      sc = new ApexPages.Standardcontroller(testPatient);
      pdmc = new PatientDashboardMessagesController(sc);
      System.assert(pdmc.createPortalUser().getUrl().contains('Alias=ais'));
    }*/
  
  public static testMethod void testMessageUtil(){
      //test for the getReturnPage method
      PageReference p;
    p = MessageUtil.getReturnPage('/apex/PatientMessages');
    System.assert(p.getUrl().contains('PatientMessages'));
    p = MessageUtil.getReturnPage(null);
       System.debug('**** what is the url ' + p.getUrl());
    System.assert(p.getUrl().contains('messageinbox'));
    
      String qs = MessageUtil.buildMessageQueryString();
      System.assert(qs.contains('To__r'));
    }
      
  static testMethod void testEhrUtilClass(){
    EhrUtil.testEhrUtil();
  }
  
  static testMethod void testMessageUserSearch(){
        User u = MessageTests.createUser();
        MessageUserSearchController mus;
        String jsonString;
        PageReference p;
        p = Page.MessageUserSearch;
        Test.setCurrentPage(p);
        
        mus = new MessageUserSearchController();
        jsonString = mus.getJsonList();
        System.assert(jsonString.contains('Results'));
        
        p.getParameters().put('name', 'test');
        Test.setCurrentPage(p);
        
        System.runAs(u) {
            mus = new MessageUserSearchController();
            jsonString = mus.getJsonList();
            System.assert(!jsonString.contains('Results'));
        }
    }
}