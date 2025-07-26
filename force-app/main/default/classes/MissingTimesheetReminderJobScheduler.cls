public with sharing class MissingTimesheetReminderJobScheduler {
    public MissingTimesheetReminderJobScheduler() {
        System.enqueueJob(new MissingTimesheetReminderJob() );
    }
}