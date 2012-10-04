/**
* Name        : PatientExtension
* Description : To display Patient and Related data on Patient Tab
* CreatedBy   : Ramadevi Kanchadapu
*/ 
public class PatientExtension{
  public Patient__c patient{get;set;}
  public Treatment__c treatment{get;set;}    
  public Travel__c travel{get;set;}
  public List<Message__c> messages{get;set;}
  public List<Task> tasks{get;set;}  
  public Payment__c payment{get;set;}   
  public Medical_Profile__c medProfile{get;set;}
            
  public List<SelectOption> taskOptions{get;set;}
  public String selectedTaskOption{get;set;}
  public String firstName{get;set;}
  public String lastName{get;set;}
  public String phaseCount{get;set;}    
                    
  public Boolean inquiryFlag{get;set;}    
  public Boolean interactionFlag{get;set;}    
  public Boolean travelFlag{get;set;}
  public Boolean postopFlag{get;set;}
            
  public PatientExtension(ApexPages.StandardController sc){
    this.patient = (Patient__c)sc.getRecord();
    try{
      selectedTaskOption = 'All Open';
      taskOptions = new List<SelectOption>();
      taskOptions.add(new SelectOption('All Open', 'All Open'));
      taskOptions.add(new SelectOption('All Closed', 'All Closed'));
      taskOptions.add(new SelectOption('My Open', 'My Open'));
      taskOptions.add(new SelectOption('My Closed', 'My Closed'));
           
      String patientId = patient.id;
      inquiryFlag = true;
      interactionFlag = false;
      travelFlag = false;
      postopFlag = false;            

      if(patientId != null && patientId.trim().length() > 0){
        this.patient = [Select id, Name, CreatedBy.Name,LastModifiedBy.Name,Owner.Name,Advocate_Email__c,
                            Advocate_Name__c,Advocate_Phone__c,Alternate_Email__c,City__c,Country__c,
                            Date_of_Birth__c,Email__c,Gender__c,Mobile__c,Patient_Stage__c,Phone__c,
                            Postal_Code__c,Preferred_Language__c,Salutation__c,State__c,Street__c,Time_Zone__c From Patient__c where id =: patientId LIMIT 1];
                            
        if(patient != null){
          String fullName;
          fullName = patient.Name;
          List<String> nameParts = fullName.split(' ');
          firstName = nameParts[0];   
          lastName = nameParts[nameParts.size()-1]; 
                                                                                                 
          this.treatment = [Select id, Name,CreatedBy.Name,LastModifiedBy.Name,Additional_Amount__c,Amount__c,Best_Time_to_Contact__c, 
                                     Case_Manager_s_Feel__c,Close_Date__c,Decision_Timeframe__c,Deposit_Required__c,Financial_Reconciliation__c, 
                                     Financing_Reguired__c,Hospital_Destination__c,Inquiry_Quality__c,Inquiry_Source__c, 
                                      On_Site_Recovery_Period__c,Original_Number_Rank__c,Patient__c,Patient_Email__c,Payment_Type__c, 
                                      Phase__c,Post_Op_Follow_Up_Program__c,Preferred_Destination__c,Preferred_Form_of_Contact__c, 
                                      Preferred_Travel_Date_From__c,Preferred_Travel_Date_To__c,Primary_Provider__c,Procedure__c, 
                                      Procedure_Category__c,Procedure_Date__c,Procedure_Treatment_Type__c,Response_SLA__c, 
                                      Stage__c,Sub_Stage__c,Treatment_Date__c 
                             From Treatment__c 
                             where Patient__c =: patientId Limit 1];
         if  (treatment.Phase__c.contains( 'Post-Op' )) {phaseCount = '4';}   
         if  (treatment.Phase__c.contains( 'Inquiry' )) {phaseCount = '1';}  
         if (treatment.Phase__c.contains( 'Interaction' )) {phaseCount = '2';}  
         if  (treatment.Phase__c.contains( 'Travel' )) {phaseCount = '3';}   
         this.tasks= [Select id, Owner.Name,CallDurationInSeconds,CallObject,CallDisposition,CallType,
                             Description,CreatedBy.Name,ActivityDate,LastModifiedBy.Name,Who.Name,
                             Priority,What.Name,Status,Subject
                      From Task Where Status != 'Completed' Limit 5];                             
         this.messages = [Select id, Name,CreatedBy.Name,LastModifiedBy.Name,Owner.Name,
                                 Body_Rich_Text__c,Body__c,Truncated_Body__c,From_Name__c,
                                 From__c,Has_Attachments__c,Priority__c,IsRead__c,Reply_Rich_Text__c,
                                 Reply__c,Sent__c,Status__c,To_Name__c,To__c
                          From Message__c Limit 5];                                                                     
                                                     
         this.travel = [Select Id, Name, CreatedBy.Name,LastModifiedBy.Name,Owner.Name,Airfare_Coordination_Needed__c,
                                 Booking_Status__c,Companion__c,Date_Of_Birth__c,Extra_Local_Concier__c,Ground_Transportation_Needed__c,
                                 Hotel_Coordination_Needed__c,Itinerary_Summary__c,Number_of_Hospital_Nights__c,
                                 Opportunity__c,Passport_Status__c,Pre_Op__c,Pre_Op_Instructions__c,Procedure_Date__c,
                                 Special_Passport_Visa__c,Travel_Alert__c,Travel_End__c,Travel_Start__c,Visa_Status__c,Wheel_Chair_Bound__c                                                        
                        From Travel__c Limit 1];
         this.payment= [Select Id, Name, Benefit_Percentage__c, Claim_Address__c, Co_pay__c, CreatedBy.Name, CreatedDate, 
                               Deductible__c, IsDeleted, Dependent_Coverage__c, Effective_Date__c, 
                               Fax_Number_Medical_Reviews__c, Group__c, Insurance_Contact__c, LastModifiedBy.Name, 
                               LastModifiedDate, Name_of_Insurance__c, Patient__c,  Payment_Type__c, Policy_ID__c, 
                               SystemModstamp, Treatment__c, Verification_Date__c, Verification_Phone_Number__c 
                        From Payment__c 
                        Where Patient__c =: patientId Limit 1]; 
        this.medProfile= [Select Id, Name, CreatedBy.Name, CreatedDate, IsDeleted, LastModifiedBy.Name, 
                                   LastModifiedDate, Patient__c, SystemModstamp, Treatment__c         
                          From Medical_Profile__c 
                          Where Patient__c =: patientId Limit 1];                                                 
        }                                                   
      }          
    }catch(Exception e){
      ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, e.getMessage()));
    }
  }    
  public void displayInquiry(){
    inquiryFlag = true;
    interactionFlag = false;
    travelFlag = false;
    postopFlag = false;
  }    
  public void displayInteraction(){
    inquiryFlag = false;
    interactionFlag = true;
    travelFlag = false;
    postopFlag = false;
  }        
  public void displayTravel(){
    inquiryFlag = false;
    interactionFlag = false;
    travelFlag = true;
    postopFlag = false;
  }      
  public void displayPostOp(){
    inquiryFlag = false;
    interactionFlag = false;
    travelFlag = false;
    postopFlag = true;
  }     
  public void searchTask(){
    try{     
      system.debug('###selectedTaskOption : '+selectedTaskOption);
      Id myid =   UserInfo.getUserId();       
      if (selectedTaskOption == 'All Open') {
        tasks= [Select id, Owner.Name,CallDurationInSeconds,CallObject,CallDisposition,CallType,
                       Description,CreatedBy.Name,ActivityDate,LastModifiedBy.Name,Who.Name,
                       Priority,What.Name,Status,Subject
                From Task Where Status !='Completed' Limit 5];
      } 
      if (selectedTaskOption == 'My Open') {
        tasks= [Select id, Owner.Name,CallDurationInSeconds,CallObject,CallDisposition,CallType,
                                            Description,CreatedBy.Name,ActivityDate,LastModifiedBy.Name,Who.Name,
                                            Priority,What.Name,Status,Subject
                          From Task Where Status !='Completed' and Ownerid = :myid Limit 5];
      }     
      if (selectedTaskOption == 'All Closed') {
        tasks= [Select id, Owner.Name,CallDurationInSeconds,CallObject,CallDisposition,CallType,
                                            Description,CreatedBy.Name,ActivityDate,LastModifiedBy.Name,Who.Name,
                                            Priority,What.Name,Status,Subject
                           From Task Where Status ='Completed' Limit 5];
      }  
      if (selectedTaskOption == 'My Closed') {
        tasks= [Select id, Owner.Name,CallDurationInSeconds,CallObject,CallDisposition,CallType,
                                            Description,CreatedBy.Name,ActivityDate,LastModifiedBy.Name,Who.Name,
                                            Priority,What.Name,Status,Subject
                          From Task Where Status !='Completed' and Ownerid = :myid Limit 5];
      }                                                                 
    }catch(Exception e){
      ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Info, e.getMessage()));
    }
  }   
  static testMethod void testPatientExtension(){
    Patient__c pat = new Patient__c();
    pat.name = 'Test';
    insert pat;
        
    Treatment__c t = new Treatment__c();
    t.Patient__c = pat.id;
    insert t;
    Task task = new Task();
    task.subject ='Test';
    task.Status = 'Completed';
    insert task ;
    
    PatientExtension pe = new PatientExtension( new ApexPages.StandardController(pat));
    pe.displayInquiry();    
    pe.displayInteraction();
    pe.displayTravel();
    pe.displayPostOp();
    pe.selectedTaskOption = 'All Closed';
    pe.searchTask();    
  }        
}