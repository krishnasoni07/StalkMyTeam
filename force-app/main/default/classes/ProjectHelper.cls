public with sharing class ProjectHelper {

    public static void validadateRecordFields( List<Project__c> proList ){
        
        for( Project__c pro : proList ){
            if( pro.Name == null || String.isEmpty(pro.Name) ){
                pro.addError('Please Enter a Project Name');
            }
        }

    }

}