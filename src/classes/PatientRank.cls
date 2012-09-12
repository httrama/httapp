/*
 * class to support the Patient ranker on insert a small app that ranks the quality of
 * a patient.
*/

public class PatientRank {

  private static Map<String, String> rankMap;
  private static String HIGH = 'High';
      
  //call only from Patient trigger
  public static void startRanking(List<Patient__c> pPatients) {
   
    PatientRank.populateRankMap();
    
    for(Patient__c patient : pPatients) {
      PatientRank.rankPatient(patient);
    }
  }
  
  private static void populateRankMap() {
    PatientRank.rankMap = new Map<String, String>();
    String[] keyValue;
    
    for (String s : Label.Patient_Ranking_Values.split(',')) {
      keyValue = s.split('=');
      PatientRank.rankMap.put(keyValue[0], keyValue[1]);
    }
  }
  
  private static void rankPatient(Patient__c pPatient) {
    Integer ranking = 0;
    
    ranking += (pPatient.Name != null) ? 1 : 0;
    ranking += (pPatient.Email__c != null) ? 1 : 0;
    ranking += (pPatient.Phone__c != null) ? 1 : 0;
    ranking += (pPatient.Mobile__c != null) ? 1 : 0;
    ranking += PatientRank.qualifyEmail(pPatient.Email__c);
    
    pPatient.Original_Number_Rank__c = Decimal.valueOf(ranking);
    
    if (PatientRank.rankMap.containsKey(String.valueOf(ranking))) {
      pPatient.Patient_Quality__c =
        PatientRank.rankMap.get(String.valueOf(ranking));
    } else {
      pPatient.Patient_Quality__c = PatientRank.HIGH;
    }
  }
  
  private static Integer qualifyEmail(String pEmail) {
    Integer returnValue = 0;
    
    if (pEmail != null) {
      returnValue += (!pEmail.contains('test')) ? 1 : 0;
    }
    return returnValue;
  }
}