public without sharing class LeaveRequestHelper {

    public static void validadateRecordFields( List<Leave_Request__c> requestList ){
        List<User> userList = [ SELECT Email FROM User WHERE Id =: UserInfo.getUserId() ];
        List<Employee__c> emp = [ SELECT Id FROM Employee__c WHERE Email__c =: userList[0].Email ];
        
        for( Leave_Request__c request : requestList ){

            if( request.Start_Date__c != null && request.End_Date__c != null ){
                if( request.Start_Date__c <= System.today() ){
                    request.addError('Please Enter a Valid Start Date');
                }
    
                if( request.End_Date__c < request.Start_Date__c ){
                    request.addError('Please Enter a Valid End Date');
                }
            }
            else{
                request.addError('Please make sure both start and end Dates are Filled');
            }

            if( String.isEmpty(request.Reason__c) || String.isBlank(request.Reason__c) ){
                request.addError('Please Enter a Reason for Leave');
            }

            if( !emp.isEmpty() ){
                request.Employee__c = emp[0].Id;
            }
        }

    }

    public static void handleApprovedLeave( List<Leave_Request__c> requestList, Map<Id, Leave_Request__c> oldMap ){
        List<Timesheet__c> timesheetList = new List<Timesheet__c>();

        for( Leave_Request__c request : requestList ){
            Leave_Request__c temp = oldMap.get( request.Id );
            // System.debug( temp.Status__c + ' => ' + request.Status__c );

            if( temp.Status__c == 'Pending' && request.Status__c == 'Approved' ){
                // System.debug('Inside If Block');
                Integer days = request.Start_Date__c.daysBetween(request.End_Date__c) + 1 ;

                for( Integer i = 0; i < days; i++ ){
                    Timesheet__c timesheet = new Timesheet__c(
                            Project__c = 'a01dM00002qDyDtQAK',
                            Hours__c = 0.00,
                            Description__c = 'On Approved Leave',
                            Date__c = request.Start_Date__c + i,
                            Employee__c = request.Employee__c
                    );
                    timesheetList.add( timesheet );

                    // System.debug(timesheet);
                }
            }
        }

        // System.debug(timesheetList);
        if( !timesheetList.isEmpty() ){
            insert timesheetList;
        }
    }
}