public with sharing class SponsorHandler {
    
    public static void sponsorCreate(List<CAMPX__Sponsor__c> newSponsor){
        for(CAMPX__Sponsor__c sponsor : newSponsor){
            if(sponsor.CAMPX__Event__c == null && sponsor.CAMPX__Status__c =='Accepted'){
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
        
    }
    
    
    public static void sponsorUpdate(List<CAMPX__Sponsor__c> newSponsor,Map<Id,CAMPX__sponsor__c> oldMap){
        for(CAMPX__sponsor__c sponsor : newSponsor){
            if(sponsor.CAMPX__Status__c != oldMap.get(sponsor.Id).CAMPX__Status__c && sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__Event__c == null)
            {
                sponsor.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }
        
    }
    
    public static void sponsorContributionUpdate(List<CAMPX__Sponsor__c> newSponsor, Map<Id, CAMPX__Sponsor__c> oldSponsor) {
        List<CAMPX__Sponsor__c> sponsorId = new List<CAMPX__Sponsor__c>();
        Set<Id> events = new Set<Id>();
        
        
        for (CAMPX__Sponsor__c sponsor : newSponsor) {
            if(sponsor.CAMPX__Status__c != oldSponsor.get(sponsor.Id).CAMPX__Status__c && sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__ContributionAmount__c != null ){
                events.add(sponsor.CAMPX__Event__c);      
                
            }
            
        }


        List<CAMPX__Event__c> eventToUpdate =[SELECT Id,Name,CAMPX__GrossRevenue__c,(SELECT Id, CAMPX__ContributionAmount__c, CAMPX__Event__c FROM CAMPX__Sponsors__r WHERE CAMPX__Status__c = 'Accepted') FROM CAMPX__Event__c WHERE Id IN :events];
        System.debug('we have ' + eventToUpdate.size()+ ' sponsors');
        System.debug(eventToUpdate);
        for(CAMPX__Event__c evt : eventToUpdate){
            Decimal totalAmount = 0;
            for(CAMPX__Sponsor__c sponsors : evt.CAMPX__Sponsors__r){
                totalAmount = totalAmount  +  sponsors.CAMPX__ContributionAmount__c;
                System.debug('total ' + totalAmount);
                
            }
            evt.CAMPX__GrossRevenue__c =totalAmount;
            System.debug('Gross '+ evt.CAMPX__GrossRevenue__c);
        }

        update eventToUpdate;
    }


    public static void sponsorContributionCreate(List<CAMPX__Sponsor__c> newSponsor) {
        List<CAMPX__Sponsor__c> sponsorId = new List<CAMPX__Sponsor__c>();
        Set<Id> events = new Set<Id>();
        
        // Step 1: Collect Event IDs for sponsors that were just accepted
        for (CAMPX__Sponsor__c sponsor : newSponsor) {
            if(sponsor.CAMPX__Status__c == 'Accepted' && sponsor.CAMPX__ContributionAmount__c != null && sponsor.CAMPX__Event__c != null ){
                events.add(sponsor.CAMPX__Event__c);      
                
            }
            
        }

       


        List<CAMPX__Event__c> eventToUpdate =[SELECT Id,Name,CAMPX__GrossRevenue__c,(SELECT Id, CAMPX__ContributionAmount__c, CAMPX__Event__c FROM CAMPX__Sponsors__r WHERE CAMPX__Status__c = 'Accepted') FROM CAMPX__Event__c ];
        System.debug('we have ' + eventToUpdate.size()+ ' sponsors');
        System.debug(eventToUpdate);
        for(CAMPX__Event__c evt : eventToUpdate){
            Decimal totalAmount = 0;
            for(CAMPX__Sponsor__c sponsors : evt.CAMPX__Sponsors__r){
                totalAmount = totalAmount  +  sponsors.CAMPX__ContributionAmount__c;
                System.debug('total ' + totalAmount);
                
            }
            evt.CAMPX__GrossRevenue__c =totalAmount;
            System.debug('Gross '+ evt.CAMPX__GrossRevenue__c);
        }

        update eventToUpdate;
    }
    
}

/**
 * When a CAMPX__Sponsor__c record is updated to have an "Accepted" CAMPX__Status__c,
 * the system should account for
 * the sponsor's CAMPX__ContributedAmount__c in the CAMPX__Event__c's CAMPX__GrossRevenue__c field
 */