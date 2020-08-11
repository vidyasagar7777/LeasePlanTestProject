@isTest(SeeAllData=false)
public class CaseTriggerHandlerTest {
     @testSetup static void Setup() 
    { 
        Profile profAdmin = [SELECT Id FROM Profile WHERE Name='System Administrator' LIMIT 1]; 
        User usr = new User();
        usr.Alias = 'ATU';
        usr.Email = 'ApexTestUser@test.test';
        usr.EmailEncodingKey = 'UTF-8';
        usr.LastName = 'Apex Test User ';
        usr.LanguageLocaleKey = 'en_US';
        usr.LocaleSidKey = 'de_DE_EURO';
        usr.ProfileId = profAdmin.Id;
        usr.TimeZoneSidKey = 'Europe/Berlin';
        usr.UserName = 'ApexTestUser@test.test';
        insert usr;
    }
    
     //Method to test the case aggregation functionality
    static TestMethod void TestCaseAggregation()
    {      
        List<User> us = [SELECT id FROM User WHERE Name='Apex Test User'];
        
        System.runAs(us[0]){
            List<Case> caseList = new List<Case>();
            Account Acc = new Account ();
            acc.Name = 'Test Account';
            Insert acc;
            
            Case c = new Case ();
            c.Status= 'New';
            c.Origin = 'Phone' ;
            c.Subject ='Case No 1';
            c.AccountId = acc.id;
            insert c; 
            
            c.Rating__c = 3;
            update c;
            List<Account> acnt = [Select id,Case_Avg_Rating__c from Account where Name='Test Account'];
            System.assertEquals(acnt[0].Case_Avg_Rating__c, 3, 'Assertion is wrong');
            
            Case c1 = new Case();
            c1.Status= 'New';
            c1.Origin = 'Phone' ;
            c1.Subject ='Case No 2';
            c1.AccountId = acc.id;
            insert c1;
            c1.Rating__c = 5;
            update c1;
            List<Account> acnt1 = [Select id,Case_Avg_Rating__c from Account where Name='Test Account'];
            System.assertEquals(acnt1[0].Case_Avg_Rating__c, 4, 'Assertion is wrong');

            Case c2 = new Case();
            c2.Status= 'New';
            c2.Origin = 'Phone' ;
            c2.Subject ='Case No 3';
            c2.AccountId = acc.id;
            insert c2;
            c2.Rating__c = 4;
            update c2;
            List<Account> acnt2 = [Select id,Case_Avg_Rating__c from Account where Name='Test Account'];
            System.assertEquals(acnt2[0].Case_Avg_Rating__c, 4, 'Assertion is wrong');
            
     
        }
    }
}