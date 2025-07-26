trigger LeaveRequestTrigger on Leave_Request__c (before insert, before update, after update) {
    if( Trigger.isBefore && ( Trigger.isInsert || Trigger.isUpdate ) ){
        LeaveRequestHelper.validadateRecordFields(Trigger.new);
    }

    if( Trigger.isAfter && Trigger.isUpdate ){
        LeaveRequestHelper.handleApprovedLeave( Trigger.new, Trigger.oldMap );
    }
}