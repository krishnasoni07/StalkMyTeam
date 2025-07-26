trigger UserTrigger on User (after insert, after update) {

    if( Trigger.isAfter && Trigger.isInsert  ){
        UserHelper.createEmployee(Trigger.new);
    }

    if( Trigger.isAfter && Trigger.isUpdate  ){
        UserHelper.updateEmployee(Trigger.newMap);
    }

}