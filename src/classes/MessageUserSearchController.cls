/*
 *this class will be the controller for the message user search feature in the Health Cloud App
 *This page looks for the name query string to search on the user records that have contact ids, and receive messages
 *written by mfullmore 01/05/10
*/

public with sharing class MessageUserSearchController {
    
    private String searchNameFilter;
    private List<User> toList;
    
    public String getJsonList(){
        populateToList();
        return createJsonString(this.toList);
    }
    
    public MessageUserSearchController(){
        this.searchNameFilter = ApexPages.currentPage().getParameters().get('name');
    }
    
    private void populateToList(){
        String searchFilter = '%' + this.searchNameFilter + '%';
        if(this.searchNameFilter != null){
            try{   
                this.toList = [select Id,
                                      FirstName,
                                      LastName,
                                      Email,
                                      ContactId,
                                      Profile.Name
                               from User
                               where Name like : searchFilter
                               and (Receive_Portal_Messages__c = true
                               or Receive_Staff_Messages__c = true
                               or ContactId != null)
                               and IsActive = true
                               order by Name asc
                               limit 200];
            }catch(QueryException e){
                ApexPages.addMessages(e);
            }
        }else{
            this.toList = new List<User>();
            this.toList.add(new User(FirstName='No',
                                     LastName='Results',
                                     Email='noresults@query.com'));
        }
    }
    
    private String createJsonString(List<User> pUsers){
        String jsonString = '[';
            
            if(pUsers != null && pUsers.size() > 0){
                for(User u : pUsers){
                    jsonString += '{id:\"' + u.Id + '\",' +
                                  addImage(u) +
                                  'text:\"' + u.FirstName + ' ' + u.LastName + '\",' +
                                  'href:\"/' + u.Id + '\",' +
                                  'extra:\"' + u.Profile.Name + '\"';
                                                      
                    jsonString += '},';
                }
                jsonString = jsonString.substring(0,jsonString.length() - 1);
            }
        
        jsonString += ']';
        return jsonString;
    }
    
    private String addImage(User pUser){
        String returnString = 'imageClass:\"currentProvider\",';
        if(pUser != null){
            if(pUser.ContactId != null){
                returnString = 'imageClass:\"currentPatient\",';
            }
        }
        return returnString;
    }
}