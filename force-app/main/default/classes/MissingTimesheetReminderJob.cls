public with sharing class MissingTimesheetReminderJob implements Queueable {

    public void execute(QueueableContext qc) {
        Set<Id> employeeIds = new Set<Id>();

        List<Attendance__c> attList = [
            SELECT Employee__c
            FROM Attendance__c
            WHERE CreatedDate = TODAY
              AND Punch_Out__c = null
        ];

        for (Attendance__c att : attList) {
            employeeIds.add(att.Employee__c);
        }

        List<AggregateResult> sheetList = [
            SELECT Employee__c, SUM(Hours__c) totalHours
            FROM Timesheet__c
            WHERE CreatedDate = TODAY AND Employee__c IN :employeeIds
            GROUP BY Employee__c
        ];

        Map<Id, Decimal> empIdWithWorkedHour = new Map<Id, Decimal>();
        for (AggregateResult agr : sheetList) {
            System.debug('Inside agr Loop ');
            Decimal totalHours = (Decimal)agr.get('totalHours');
            if (totalHours < 8) {
                empIdWithWorkedHour.put((Id)agr.get('Employee__c'), totalHours);
            }
        }

        List<Employee__c> empList = [
            SELECT Id, Name, Email__c
            FROM Employee__c
            WHERE Id IN :empIdWithWorkedHour.keySet()
            ];
            
            List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
            for (Employee__c emp : empList) {
                System.debug('Inside emp Loop ');
                
                Decimal loggedHours = empIdWithWorkedHour.get(emp.Id);
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { emp.Email__c });
                email.setSubject('Reminder: Timesheet Incomplete');
            email.setPlainTextBody('Dear ' + emp.Name + ',\n\nYou have logged only ' +
                (loggedHours != null ? loggedHours : 0) +
                ' hours today. Please complete your timesheet for ' + System.today().format() + '.\n\nThanks,\nAdmin');
            emails.add(email);

        }

        if (!emails.isEmpty()) {
            System.debug(' ===== > Hell');
            Messaging.sendEmail(emails);
        }
    }
}
