/*
 *this class will be the controller for the new message page in the Health Cloud App
 *written by mfullmore 10/06/09
*/
public with sharing class MessageNewMessageController {

    private String returnUrl;
    private Message__c newMessage;
    private String selectedSenderId;
    private String toField;
    private Id currentUserId = UserInfo.getUserId();
    private Attachment newAttachment = new Attachment();
    
    private final String PICK_A_PERSON_EXCEPTION = Label.MessagePickPersonException;
    
    //getters and setters
    public Message__c getNewMessage(){return this.newMessage;}
    public String getSelectedSenderId(){return this.selectedSenderId;}
    public String getToField(){return this.toField;}
    public Attachment getNewAttachment(){return this.newAttachment;}
    
    public void setNewMessage(Message__c pNewMessage){this.newMessage = pNewMessage;}
    public void setNewAttachment(Attachment pAttachment){this.newAttachment = pAttachment;}
    public void setSelectedSenderId(String pSelected){this.selectedSenderId = pSelected;}
    public void setToField(String pToField){this.toField = pToField;}
    
    public MessageNewMessageController(){
        this.returnUrl = ApexPages.currentPage().getParameters().get('returnUrl');
        this.newMessage = new Message__c();
        this.selectedSenderId = System.currentPageReference().getParameters().get('setSelectedSenderId');
        this.toField = System.currentPageReference().getParameters().get('setToField');
    }
    
    public void startProcess(){
    }
    
    public PageReference itemSelected(){
        this.selectedSenderId = System.currentPageReference().getParameters().get('setSelectedSenderId');
        this.toField = System.currentPageReference().getParameters().get('setToField');
        return null;
    }
    
    public void itemCleared(){
        this.selectedSenderId = null;
        this.toField = null;
    }
    
    public PageReference saveNewMessage(){
        PageReference p;
        
        if(checkMessage()){
            try{
                this.newMessage.OwnerId = this.selectedSenderId;
                this.newMessage.To__c = this.selectedSenderId;
                this.newMessage.From__c = this.currentUserId;
                insert this.newMessage;
                
                if(this.newAttachment.Name != null){  
                    this.newAttachment.ParentId = this.newMessage.Id;
                    insert this.newAttachment;
                    
                    update new Message__c(id = this.newMessage.Id,
                                               Has_Attachments__c = true);
                }
                p = MessageUtil.getReturnPage(this.returnUrl);
                
            }catch(DmlException e){
              p = null;
                ApexPages.addMessages(e);
            }
        }
        return p;
    }
    
    public PageReference cancelBtn(){
        PageReference p = MessageUtil.getReturnPage(this.returnUrl);
        return p;
    }
    
    private Boolean checkMessage(){
        Boolean success = true;
        if(this.selectedSenderId == null){
            success = false;
            ApexPages.addMessages(new EhrException(this.PICK_A_PERSON_EXCEPTION));
        }
        
        return success;
    }
}