/*
 *controller for the data page that displays the jq grid
*/

public with sharing class JqGridDataController {

  private String jsonText;
  private String sidx;
  private String sobjectName;
  private String[] sobjectFields;
  private String queryString;
  private ApexPages.StandardSetController setController;
  private Schema.SobjectType objType;
  private Integer pageSize = 10; //default to 10
  private Integer pageNum = 1; //default to the first page
  private String orderedBy;
  private String order;
  private String searchFilter;
  private String idFilter;
    
  public static Map<String, Schema.SobjectType> globalObjMap = Schema.getGlobalDescribe();
  
  public String getSidx(){return this.sidx;}
  
  public String getJsonText(){
    String testJson = '{"page":"1","total":666,"records":"13","rows":[' +
              '{"id":"13","cell":["13","<span style=\'color:blue;\'>2007-10-06</span>","Client 13","1000.00","0.00","1000.00",null]},' +
              '{"id":"12","cell":["12","2007-10-06","Client 2","700.00","140.00","840.00",null]},' +
              '{"id":"11","cell":["11","2007-10-06","Client 1","600.00","120.00","720.00",null]},' +
              '{"id":"10","cell":["10","2007-10-06","Client 2","100.00","20.00","120.00",null]},' +
              '{"id":"9","cell":["9","2007-10-06","Client 1","200.00","40.00","240.00",null]},' +
              '{"id":"8","cell":["8","2007-10-06","Client 3","200.00","0.00","200.00",null]},' +
              '{"id":"7","cell":["7","2007-10-05","Client 2","120.00","12.00","134.00",null]},' +
              '{"id":"6","cell":["6","2007-10-05","Client 1","50.00","10.00","60.00",null]},' +
              '{"id":"5","cell":["5","2007-10-05","Client 3","100.00","0.00","100.00","no tax"]},' +
              '{"id":"4","cell":["4","2007-10-04","Client 3","150.00","0.00","150.00","no tax"]}],' +
              '"userdata":{"amount":3220,"tax":342,"total":3564,"name":"Totals:"}}';
      
    if(this.sobjectName != null){
      testJson = processRequest();  
    }
    return testJson;
  }
  
  public List<Sobject> getSetRecords(){
    return (List<Sobject>) this.setController.getRecords();
  }
  
  public String getQueryString(){return this.queryString;}
  
  public JqGridDataController(){
    this.sobjectName = ApexPages.currentPage().getParameters().get('sobject');
    this.objType = JqGridDataController.globalObjMap.get(this.sobjectName);
    if(ApexPages.currentPage().getParameters().get('cols') != null){  
      this.sobjectFields = ApexPages.currentPage().getParameters().get('cols').split(',');
    }
    if(ApexPages.currentPage().getParameters().get('rows') != null){
      this.pageSize = Integer.valueOf(ApexPages.currentPage().getParameters().get('rows'));
    }
    if(ApexPages.currentPage().getParameters().get('page') != null){
      this.pageNum = Integer.valueOf(ApexPages.currentPage().getParameters().get('page'));
    }
    this.orderedBy = ApexPages.currentPage().getParameters().get('sidx');
    this.order = ApexPages.currentPage().getParameters().get('sord');
    this.searchFilter = ApexPages.currentPage().getParameters().get('searchText');
    this.idFilter = ApexPages.currentPage().getParameters().get('idToFilterBy');
    
  }
  
  private String processRequest(){
    String jsonString;
    createQueryString();
    this.setController = this.setController = EhrUtil.createStandardSetController(this.queryString, this.pageSize);
    this.setController.setPageNumber(this.pageNum);
    jsonString = createJson();
    
    return jsonString;
  }
  
  private void createQueryString(){
    this.queryString = 'select ';
    for(String str : this.sobjectFields){
      this.queryString += str + ',';
    }
    //gets rid of the last comma
    if(!this.queryString.contains('id,') && !this.queryString.contains('Id,')){
      this.queryString += 'Id,';
    }
    this.queryString = this.queryString.substring(0, this.queryString.length() - 1);
    
    this.queryString += ' from ' + this.sobjectName;
    this.queryString = addWhereToQueryString(this.queryString);
    this.queryString = addOrderToQueryString(this.queryString);
  }
  
  private String createJson(){
    String jsonString;
    if (this.setController.getResultSize() !=0) {
       jsonString = '{"page":"'+ this.setController.getPageNumber() + '","total":' + getTotalPages() + ',"records":"' + String.valueOf(this.setController.getResultSize()) + '","rows":[';
      
      for(Sobject obj : getSetRecords()){
        jsonString += '{"id":"' + obj.get('Id') + '","cell":[';
        for(String str : this.sobjectFields){
          jsonString += parseCell(obj.get(str));
        }
        jsonString = jsonString.subString(0,jsonString.length() - 1);
        jsonString += ']},';
      }
      
      jsonString = jsonString.subString(0,jsonString.length() - 1);
      jsonString += '],"userdata":{"amount":3220,"tax":342,"total":3564,"name":"Totals:"}}';
    }
    else {
      //no records were retrieved
      jsonString = '{"page":"'+ this.setController.getPageNumber() + '","total":' + getTotalPages() + ',"records":"' + String.valueOf(this.setController.getResultSize()) + '","rows":[';
      jsonString += '],"userdata":{"amount":3220,"tax":342,"total":3564,"name":"Totals:"}}';
    }
    
    System.debug('#'+jsonString);
    return jsonString;
  }
  
  private String getTotalPages(){
        if(this.setController != null){
          Double doublePageNum = (Double)this.setController.getResultSize()/this.setController.getPageSize();
          Decimal numOfPages = Decimal.valueOf(doublePageNum).round(RoundingMode.CEILING);
          return numOfPages == 0 ? '1' : String.valueOf(numOfPages);
        }else{
          return '1';
        }
    }
    
    private String addOrderToQueryString(String pQueryString){
      String retString = '';
      
      if(this.orderedBy != null && this.order != null){
        retString = pQueryString +
              ' ORDER BY ' + 
                    this.orderedBy + 
                    ' ' + 
                    this.order + 
                    ' Limit 900'; 
      }else{
        retString = pQueryString +
              ' Limit 900';
      }
      return retString;
    }
    
    private String addWhereToQueryString(String pQueryString){ //todo fix this so it's more better :)
      if(this.searchFilter != null || this.idFilter != null){
        pQueryString += ' where ';
      }
      if(this.searchFilter != null && this.idFilter == null){
        pQueryString += parseSearchText(this.searchFilter);
      }
      else if(this.idFilter != null && this.searchFilter != null) {
        pQueryString += parseSearchText(this.searchFilter) + ' and ' + parseIdToFilterBy(this.idFilter);
      }
      else if(this.idFilter != null && this.searchFilter == null){
        pQueryString += parseIdToFilterBy(this.idFilter);
      }
      return pQueryString;
    }
    
    private String parseCell(Object pField) { 
    String ret = checkForDate(pField);
    if(ret == 'null'){
      ret = 'null,';
    }else{
      ret = ret.replaceAll('"','\\\'' ); // get content produces quote chars \"  
          ret = ret.replaceAll( '&','&amp;');// we need to escape these in the node value
        ret = ret.replaceAll('\n',' '); // must use ALL since many new line may get 
          ret = ret.replaceAll('\r',' '); // get these also!
          
          ret = '"' + ret + '",';
    }
    System.debug('This is RET:' +  ret); // dump
        return ret ; 
  }
  
  private String parseSearchText(String pSearchFilter){
    String retString = '';
    String[] valueList = pSearchFilter.split(',');
    retString += valueList[0] + ' like \'%' + valueList[1] + '%\'';
    
    return retString;
  }
  
  private String parseIdToFilterBy(String pFilterId){
    String retString = '';
    String[] valueList = pFilterId.split(',');
    retString += valueList[0] + ' = ' + '\'' + valueList[1] + '\'';
    
    return retString;
  }
  
  private String checkForDate(Object pField){
    String ret = '' + pField;
    Date tmpDate;
    DateTime tmpDateTime;
    
    try{
      tmpDate = Date.valueOf(ret);
      ret = tmpDate.format();
    }catch(TypeException eDate){
      try{
        tmpDateTime = DateTime.valueOf(ret);
        ret = tmpDateTime.format();
      }catch(TypeException eDateTime){
        //do nothing because ret is already a string.
      }
    }
    
    return ret;
  }
  
  //static testMethod void test() {
    //TODO add this test
  //}
}