/*
 *this class will be the controller for the message inbox in the Health Cloud App
 *written by mfullmore 10/06/09
*/

public with sharing class MessageInboxController {

  private Boolean showInfoHeader;
  private Boolean showHideLink;
    
    public Boolean getShowInfoHeader(){return this.showInfoHeader;}
    public Boolean getShowHideLink(){return this.showHideLink;}
    
    public MessageInboxController(){
      if(My_Message_Settings__c.getInstance(UserInfo.getUserId()) != null){
        this.showInfoHeader = My_Message_Settings__c.getInstance(UserInfo.getUserId()).Show_Info_Header__c;
        this.showHideLink = true;
      }else{
        this.showInfoHeader = true;
        this.showHideLink = false;
      }
    }
    
    public PageReference newMessage(){
      PageReference p;
    p = new PageReference('/apex/MessageNewMessage');
    p.getParameters().put('returnUrl', '/apex/MessageInbox');
      p.setRedirect(true);
      return p;
    }
    
    public PageReference newMessageForPortal(){
      PageReference p;
    p = new PageReference('/PortalNewMessage');
    p.getParameters().put('returnUrl', '/PortalMessages');
      p.setRedirect(true);
      return p;
    }
    
    public void hideInfoHeader(){
      My_Message_Settings__c msgSetting;
      if(My_Message_Settings__c.getValues(UserInfo.getUserId()) != null){
        msgSetting = My_Message_Settings__c.getValues(UserInfo.getUserId());
        msgSetting.Show_Info_Header__c = false; 
        update msgSetting;
      }else{
        msgSetting = new My_Message_Settings__c(Show_Info_Header__c = false,
                              SetupOwnerId = UserInfo.getUserId(),
                              Name = UserInfo.getFirstName() +
                                ' ' +
                                UserInfo.getLastName() +
                                ' Message Settings');
        insert msgSetting;
      }
    }
}