/*
 *this class will prepare the message for saving.
*/

public class MessageManagement {

	private static DateTime newDateTime = System.now();
	
	private static final String CREATED_BY_TEXT = 'On: ';
	
	
	public static void populateBody(Message__c[] pMessages){
		for(Message__c msg : pMessages){
			if(msg.Body_Rich_Text__c != null){
				msg.Body_Rich_Text__c =
				  MessageManagement.CREATED_BY_TEXT +
					MessageManagement.newDateTime.format() +
					' ' +
					UserInfo.getName() + 
					', wrote:<br/><br/>' +
					MessageManagement.returnCorrectBody(msg.Body_Rich_Text__c);
			}
		}
	}
	
	public static void appendToBody(Message__c[] pMessages){
		for(Message__c msg : pMessages){
			if(msg.Reply_Rich_Text__c != null){
				msg.Body_Rich_Text__c =
				  MessageManagement.CREATED_BY_TEXT +
					MessageManagement.newDateTime.format() +
					' ' +
					UserInfo.getName() + 
					', wrote:<br/><br/>' +
					msg.Reply_Rich_Text__c +
					'<br/><br/>' +
					MessageManagement.returnCorrectBody(msg.Body_Rich_Text__c);
				msg.Reply_Rich_Text__c = null;
			}
		}
	}
	
	public static void populateTruncatedBody(Message__c[] pMessages){
		String plainText;
		
		for(Message__c msg : pMessages){
			if(msg.Body_Rich_Text__c != null){
				plainText = 
				  msg.Body_Rich_Text__c.replaceAll('\\<.*?\\>', '').replace('  ', ' ').trim();
				if(msg.Body_Rich_Text__c.length() > 200){
					msg.Truncated_Body__c = plainText.substring(0,99) + ' ...';
				}else{
					msg.Truncated_Body__c = plainText;
				}
			}
		}
	}
	
	public static void populateSent(Message__c[] pMessagesOld,
	   Message__c[] pMessagesNew){
		for(Integer i = 0; i < pMessagesOld.size(); i++){
			if(pMessagesOld[i].To__c != null && pMessagesNew[i].To__c != null){	
				if(pMessagesOld[i].To__c != pMessagesNew[i].To__c){
					pMessagesNew[i].Sent__c = System.now();
				}
			}
		}
	}
	
	//call only in the after trigger, this needs to have the message Id to work.
	public static void addApexSharing(Message__c[] pMessages){
		List<Message__Share> msgShares = new List<Message__Share>();
		Message__Share msgShare;
		
		for(Message__c msg : pMessages){
			if(msg.From__c != null){
				msgShare = new Message__Share();
				msgShare.AccessLevel = 'Read';
				msgShare.UserOrGroupId = msg.From__c;
				msgShare.RowCause = 'Manual';
				msgShare.ParentId = msg.Id;
				msgShares.add(msgShare);
			}
		}
		if(msgShares.size() > 0 ){
			try{
				insert msgShares;
			}catch(DmlException e){
				
			}
		}
	}	
	
	public static void checkForAttachments(Message__c[] pMessages){
		Set<Id> msgIds = new Set<Id>();
		Map<Id, Attachment> msgAttchMap = new Map<Id, Attachment>();
		
		for(Message__c message : pMessages){
			if(message.Id != null){
				msgIds.add(message.Id);
			}
		}
		
		for(Attachment att : [select Id, 
		                             ParentId
		                      from Attachment
		                      where ParentId IN : msgIds]){
			msgAttchMap.put(att.ParentId, att);
		}
		
		for(Message__c message : pMessages){
			if(message.Id != null){
				if(msgAttchMap.containsKey(message.Id)){
					message.Has_Attachments__c = true;
				}else{
					message.Has_Attachments__c = false;
				}
			}
		}
	}
	
	private static String returnCorrectBody(String pBody){
		String rtString = ' ';
		
		if(pBody != null){
			rtString = pBody;
		}
		return rtString;
	}
}