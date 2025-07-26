public with sharing class PunchInHelper {
    
    public class OutputWrapper{
        @InvocableVariable
        public Boolean isRecordAvailable;
        @InvocableVariable
        public Id AttRecordId;
        @InvocableVariable
        public Id currentEmployeeId;
    }

    @InvocableMethod
    public static List<OutputWrapper> checkIfAttendanceRecordAlreadyExist(){
        List<OutputWrapper> results = new List<OutputWrapper>();
        List<Attendance__c> attList = [ SELECT Id FROM Attendance__c WHERE Employee__r.Email__c = :UserInfo.getUserEmail() AND CreatedDate = Today ];
        List<Employee__c> emp = [ SELECT Id FROM Employee__c WHERE Email__c = :UserInfo.getUserEmail() ];
        OutputWrapper temp = new OutputWrapper();


        temp.isRecordAvailable = !attList.isEmpty();
        temp.currentEmployeeId = emp[0].Id;
        if( !attList.isEmpty() ){
            temp.AttRecordId = attList[0].Id;
        }

        results.add(temp);
        return results;
    }


}