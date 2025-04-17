public with sharing class EventHandler {
    public static void eventCreate(List<CAMPX__Event__c> newEvent){
        for(CAMPX__Event__c events : newEvent){
            if(events.CAMPX__GrossRevenue__c == null || events.CAMPX__TotalExpenses__c ==null){
                events.CAMPX__NetRevenue__c = null;
            }else{
                events.CAMPX__NetRevenue__c = events.CAMPX__GrossRevenue__c - events.CAMPX__TotalExpenses__c;
            } 

        }

    }

    public static void eventUpdate(List<CAMPX__Event__c> newEvent,Map<Id,CAMPX__Event__c> oldmap){
        for(CAMPX__Event__c event : newEvent){
            if(event.CAMPX__GrossRevenue__c != oldmap.get(event.Id).CAMPX__GrossRevenue__c || event.CAMPX__TotalExpenses__c != oldmap.get(event.Id).CAMPX__TotalExpenses__c){
                if(event.CAMPX__GrossRevenue__c == null || event.CAMPX__TotalExpenses__c == null){
                    event.CAMPX__NetRevenue__c = null;
                }else{
                    event.CAMPX__NetRevenue__c = event.CAMPX__GrossRevenue__c - event.CAMPX__TotalExpenses__c;
                }
            }
        }

    }
    
}



/**
 * The CAMPX__NetRevenue__c of an CAMPX__Event__c record should always 
 * reflect the formula: CAMPX__GrossRevenue__c - CAMPX__TotalExpenses__c
If either 
CAMPX__GrossRevenue__c or CAMPX__TotalExpenses__c are blank, the CAMPX__NetRevenue__c should be blank
 */