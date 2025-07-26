trigger EmployeeTrigger on Employee__c (before insert, before update) {

    if( Trigger.isBefore && ( Trigger.isInsert || Trigger.isUpdate)){
        EmployeeHelper.validadateRecordFields(Trigger.new);
    }

}