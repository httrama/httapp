/*
 * class to control the procedure line process
 *
*/

public class ProcedureLineExtension {

  public Procedure_Line_Item__c line { get; set; }
  public Treatment__c treatment { get; private set; }
  public Boolean showLine { get; private set; }
  public Procedure_Catalog__c procedure { get; set; }
  
  public String testURL {get;set;} //delete for prod.
  
  public ProcedureLineExtension(ApexPages.StandardSetController sc) {
    
    this.line = (Procedure_Line_Item__c) sc.getRecord();
    /*this.treatment = [select Id
                      from Treatment__c
                      where Id =
                        :ApexPages.currentPage().getParameters().get('id')];*/
                        
                        
  }
  
  public void populateLine() {
    try {  

      this.procedure = [select Id,
                               Name,
                               Procedure_Code__c,
                               Procedure_Description__c,
                               Facility__r.Name,
                               (select Id,
                                       List_Price__c,
                                       Sale_Price__c
                               from Procedure_Catalogs__r)
                        from Procedure_Catalog__c
                        where Id = :this.line.Procedure__c
                        and Active__c = true];
      
      this.line.List_Price__c = this.procedure.Procedure_Catalogs__r[0].List_Price__c;
      this.line.Sale_Price__c = this.procedure.Procedure_Catalogs__r[0].Sale_Price__c;
                   
      this.showLine = true;
            
    } catch(QueryException e) {
      ApexPages.addMessages(e);
    }
  }
  
  public PageReference saveLine() {
    PageReference p;
    try {
      upsert this.line;
      
      p = new PageReference('/' + this.treatment.Id);
      
    } catch(Exception e) {
      ApexPages.addMessages(e);
    }
    return p;
  }
  
  static testMethod void testProcedureLineController() {
    Procedure_Line_Item__c line;
    List<Procedure_Line_Item__c> lines =
      new List<Procedure_Line_Item__c>();
    ProcedureLineExtension ple;
    
    line = new Procedure_Line_Item__c();
    lines.add(line);
    
    ple = new ProcedureLineExtension(
      new ApexPages.StandardSetController(lines)
    );
    
    ple.populateLine();
    ple.saveLine();
    
    System.assertEquals(ple.procedure, null);
    
  }
}