public with sharing class GetCurrentEmployee {
    public class OutputWrapper{
        @InvocableVariable
        public Id empId;
    }

    @InvocableMethod
    public static List<OutputWrapper> getEmpId(){

        List<Employee__c> empList = [ SELECT Id FROM Employee__c WHERE Email__c = :UserInfo.getUserEmail() LIMIT 1 ];

        OutputWrapper result = new OutputWrapper();
        result.empId = empList[0].Id;

        return new List<OutputWrapper>{result};
    }

}