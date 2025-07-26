public with sharing class UserHelper {

    @future
    public static void createEmployeeAsync(Set<Id> userIds) {
        List<User> usersWithRole = [ SELECT Id, FirstName, LastName, Email, UserRole.Name FROM User WHERE Id IN :userIds ];

        List<Employee__c> empList = new List<Employee__c>();
        for (User user : usersWithRole) {
            if (user.UserRole != null && (
                user.UserRole.Name == 'Employee' || 
                user.UserRole.Name == 'Manager' || 
                user.UserRole.Name == 'Techlead'
            )) {
                Employee__c emp = new Employee__c(
                    Employee_Name__c = user.FirstName + ' ' + user.LastName,
                    Email__c = user.Email,
                    Techlead__c = '005dM00000Kh1QLQAZ',
                    Manager__c = '005dM00000Kh0a2QAB',
                    Role__c = user.UserRole.Name,
                    User__c = user.Id
                );
                empList.add(emp);
            }
        }

        if (!empList.isEmpty()) {
            insert empList;
        }
    }

    public static void createEmployee(List<User> userList) {
        Set<Id> userIds = new Set<Id>();
        for (User u : userList) {
            userIds.add(u.Id);
        }
        createEmployeeAsync(userIds);
    }

    @future
    public static void updateEmployeeAsync(Set<Id> userIds) {
        Map<Id, User> usersWithRoleMap = new Map<Id, User>(
            [SELECT Id, FirstName, LastName, Email, UserRole.Name FROM User WHERE Id IN :userIds]
        );

        List<Employee__c> empList = [ SELECT Id, Employee_Name__c, Role__c, Email__c, User__c FROM Employee__c WHERE User__c IN :userIds ];

        for (Employee__c emp : empList) {
            User user = usersWithRoleMap.get(emp.User__c);
            if (user != null && user.UserRole != null) {
                emp.Employee_Name__c = user.FirstName + ' ' + user.LastName;
                emp.Email__c = user.Email;
                emp.Role__c = user.UserRole.Name;
            }
        }

        if (!empList.isEmpty()) {
            update empList;
        }
    }

    public static void updateEmployee(Map<Id, User> usersMap) {
        updateEmployeeAsync(usersMap.keySet());
    }
}
