public with sharing class supplierController {
    
    @AuraEnabled
    public Static List<Supplier__c>  findSuppliers(String city){
        List<Supplier__c> supplierList = [SELECT id,Name,City__c,Latitude__c,Longitude__c FROM Supplier__c Where City__c =:city];
        return supplierList;
    }
}
