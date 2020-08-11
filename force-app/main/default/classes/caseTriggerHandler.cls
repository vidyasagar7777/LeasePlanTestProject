public class caseTriggerHandler {
    
    public void calculateAvgAcnt (List<Case> newCase, Map<Id,Case> oldMap){   
        Set<Id> acntIdSet = new Set<Id>();
        Map<Id,Double> avgRatingMap= new Map<Id,Double>();
        List<Account> updateAccList = new List<Account>();
        for (Case c :newCase){
            if (c.Rating__c != oldMap.get(c.id).Rating__c){
                acntIdSet.add(c.AccountId);   
            }   
        }
        
        if (!acntIdSet.isEmpty()){
            for (AggregateResult results : [SELECT AccountId acc,Avg(Rating__c) rating FROM Case WHERE AccountId IN :acntIdSet GROUP BY AccountId]){   
                avgRatingMap.put((ID)results.get('acc'),(double)results.get('rating'));              
            }
            if (!avgRatingMap.isEmpty()){
                for (Account acc : [select id from Account where id IN: avgRatingMap.keyset()]){
                    Double s  = avgRatingMap.get(acc.id); 
                    acc.Case_Avg_Rating__c =s;
                    updateAccList.add(acc);
                }
                try {
                    Database.update(updateAccList);
                } 
                catch(DmlException e) {
                    System.debug('The following exception has occurred: ' + e.getMessage());
                }
                
            }
            
        }
        
    }
    
}