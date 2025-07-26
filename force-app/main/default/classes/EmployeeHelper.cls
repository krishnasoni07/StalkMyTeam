public with sharing class EmployeeHelper {

    public static void validadateRecordFields( List<Employee__c> empList ){

        for( Employee__c emp : empList ){
            if( emp.Employee_Name__c == null ||
                emp.Employee_Name__c == '' ||
                !UtilityMethods.checkIfStringContainsAlphabetsOnly(emp.Employee_Name__c) ){
                
                emp.addError( 'Employe Name Should Contain Alphabets Only' );
            }
            
            if( emp.Email__c == null ){
                emp.addError( 'Employe Email Couldn\'t be empty' );
            }
            
            if( emp.Role__c == null ){
                emp.addError( 'Employe must have a Role Defined' );
            }

            if( emp.Techlead__c == null ){
                emp.addError('Employee must have a Techlead');
            }

            if( emp.Manager__c == null ){
                emp.addError('Employee must have a Manager');
            }

        }

    }

}