trigger ProjectTrigger on Project__c (before insert, before update) {

    if( Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate) ){
        ProjectHelper.validadateRecordFields(Trigger.new);
    }

}