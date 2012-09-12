/*
 *this class will be the controller for the message reply in the Health Cloud App
 *written by mfullmore 01/10/10
*/

public with sharing class MessageReplyMessageController {
    
    private String returnUrl;
    private Message__c message;
    private Message__c newMessage;
    private String toName;
    private Id currentUserId = UserInfo.getUserId();
    private Attachment newAttachment = new Attachment();
    
    private final String RE = 'Re:';
    
    //getters and setters
    public Message__c getMessage(){return this.message;}
    public Message__c getNewMessage(){return this.newMessage;}
    public String getToName(){return this.toName;}
    public Attachment getNewAttachment(){return this.newAttachment;}
    
    public void setNewMessage(Message__c pMessage){this.newMessage = pMessage;}
    public void setNewAttachment(Attachment pAttachment){this.newAttachment = pAttachment;}
    
    public MessageReplyMessageController(){
        this.returnUrl = ApexPages.currentPage().getParameters().get('returnUrl');
        populateMessage(ApexPages.currentPage().getParameters().get('messageId'));
    }
    
    public void startProcess(){
        populateNewMessage();
    }

    public PageReference saveReply(){
        PageReference p;
        
        try{
            this.newMessage.OwnerId = this.newMessage.To__c;
            this.newMessage.IsRead__c = false;
            update this.newMessage;
            
            if(this.newAttachment.Name != null){  
                    this.newAttachment.ParentId = this.newMessage.Id;
                    insert this.newAttachment;
                    
                    update new Message__c(id = this.newMessage.Id,
                                               Has_Attachments__c = true);
            }
            p = MessageUtil.getReturnPage(this.returnUrl);
        }catch(DmlException e){
            ApexPages.addMessages(e);
        }
        return p;
    }
    
    public PageReference cancelBtn(){
        PageReference p = MessageUtil.getReturnPage(this.returnUrl);
        return p;
    }
    
    private void populateMessage(String pMessageId){
        if(pMessageId != null){
            try{
                this.message = [select Id,
                                       To__c,
                                       From__c,
                                       From__r.Name,
                                       Name,
                                       Body_Rich_Text__c,
                                       To__r.Name,
                                       Reply_Rich_Text__c
                                from Message__c
                                where Id = : pMessageId];
            }catch(QueryException e){
                ApexPages.addMessages(e);
            }
        }
    }
    
    private void populateNewMessage(){
      if(this.message != null){
          this.newMessage = new Message__c(Id = this.message.Id);
          this.newMessage.From__c = this.message.To__c;
          this.newMessage.To__c = this.message.From__c;
          this.toName = this.message.From__r.Name;
          this.newMessage.Body_Rich_Text__c = this.message.Body_Rich_Text__c;
          
          if(this.message.Name.contains(this.RE)){
              this.newMessage.Name = this.message.Name;
          }else{
              this.newMessage.Name = this.RE + ' ' + this.message.Name;
          }
      }
    }
}