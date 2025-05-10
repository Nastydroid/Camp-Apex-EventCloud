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
        
        Set<Id> events = new Set<Id>();
        
        for (CAMPX__Sponsor__c sponsor : newSponsor) {
            CAMPX__Sponsor__c oldRec = oldSponsor.get(sponsor.Id);
            
            
            if (
                sponsor.CAMPX__Status__c != oldRec.CAMPX__Status__c &&
                sponsor.CAMPX__Status__c == 'Accepted' &&
                sponsor.CAMPX__ContributionAmount__c != null &&
                sponsor.CAMPX__Event__c != null
            ) {
                events.add(sponsor.CAMPX__Event__c);
                
            }
        }
        System.debug('Updated sponsor to update, event count: ' + events.size());
        
        Map<Id,Decimal> eventIdAndContributionAmount = new Map<Id,Decimal>();
        for(AggregateResult total :[SELECT CAMPX__Event__c,SUM(CAMPX__ContributionAmount__c)total 
                        FROM CAMPX__Sponsor__c
                        WHERE CAMPX__Status__c ='Accepted' 
                        AND CAMPX__ContributionAmount__c !=null 
                         GROUP BY CAMPX__Event__c]){
            
            eventIdAndContributionAmount.put((Id)total.get('CAMPX__Event__c'),(Decimal)total.get('total'));
            
        }
        
        List<CAMPX__Event__c> eventToUpdate = new List<CAMPX__Event__c>();
        
        for(Id evt : events){
            CAMPX__Event__c eventUp = new CAMPX__Event__c();
            eventUp.Id = evt;
            eventUp.CAMPX__GrossRevenue__c = eventIdAndContributionAmount.ContainsKey(evt)? eventIdAndContributionAmount.get(evt) : 0;
            eventToUpdate.add(eventUp);
            
            
        }
        
        update eventToUpdate;
        
        
        
    }
    
    
    
    
    public static void updaterGrossAfterCreation(List<CAMPX__Sponsor__c> newsponsor){
        Set<Id> eventId = new Set<Id>();
        for(CAMPX__Sponsor__c sponsors : newsponsor){
            if(sponsors.CAMPX__Status__c == 'Accepted' && sponsors.CAMPX__ContributionAmount__c !=null && sponsors.CAMPX__Event__c != null){
                eventId.add(sponsors.CAMPX__Event__c);
                
                
            }
        }
        
        System.debug('created sponsors event to work with  ' + eventId.size());
        Map<Id,Decimal> eventIdAndContributionAmount = new Map<Id,Decimal>();
        for(AggregateResult total :[SELECT CAMPX__Event__c,SUM(CAMPX__ContributionAmount__c)total 
                        FROM CAMPX__Sponsor__c
                        WHERE CAMPX__Status__c ='Accepted' 
                        AND CAMPX__ContributionAmount__c !=null 
                         GROUP BY CAMPX__Event__c]){
            
            eventIdAndContributionAmount.put((Id)total.get('CAMPX__Event__c'),(Decimal)total.get('total'));
            
        }
        
        List<CAMPX__Event__c> eventToUpdate = new List<CAMPX__Event__c>();
        
        for(Id evt : eventId){
            CAMPX__Event__c eventUp = new CAMPX__Event__c();
            eventUp.Id = evt;
            eventUp.CAMPX__GrossRevenue__c = eventIdAndContributionAmount.ContainsKey(evt)? eventIdAndContributionAmount.get(evt) : 0;
            eventToUpdate.add(eventUp);
            
            
        }
        
        update eventToUpdate;
        
        
        
    }
    
    
    public static void updaterGrossAfterUpdate(List<CAMPX__Sponsor__c> newsponsor,Map<Id,CAMPX__Sponsor__c> oldSponsor){
        Set<Id> eventId = new Set<Id>();
        for(CAMPX__Sponsor__c sponsors : newsponsor){
            if(sponsors.CAMPX__Status__c == 'Accepted' && sponsors.CAMPX__ContributionAmount__c !=null && sponsors.CAMPX__Event__c != null && sponsors.CAMPX__Status__c != oldSponsor.get(sponsors.Id).CAMPX__Status__c){
                eventId.add(sponsors.CAMPX__Event__c);
                
                
            }
        }
        
        System.debug('created sponsors event to work with  ' + eventId.size());
        Map<Id,Decimal> eventIdAndContributionAmount = new Map<Id,Decimal>();
        for(AggregateResult total :[SELECT CAMPX__Event__c,SUM(CAMPX__ContributionAmount__c)total 
                        FROM CAMPX__Sponsor__c
                        WHERE CAMPX__Status__c ='Accepted' 
                        AND CAMPX__ContributionAmount__c !=null 
                         GROUP BY CAMPX__Event__c]){
            
            eventIdAndContributionAmount.put((Id)total.get('CAMPX__Event__c'),(Decimal)total.get('total'));
            
        }
        
        List<CAMPX__Event__c> eventToUpdate = new List<CAMPX__Event__c>();
        
        for(Id evt : eventId){
            CAMPX__Event__c eventUp = new CAMPX__Event__c();
            eventUp.Id = evt;
            eventUp.CAMPX__GrossRevenue__c = eventIdAndContributionAmount.ContainsKey(evt)? eventIdAndContributionAmount.get(evt) : 0;
            eventToUpdate.add(eventUp);
            
            
        }
        
        update eventToUpdate;
        
        
        
    }
    
    public static void sponsorStatusUpdateRevertAmount(List<CAMPX__Sponsor__c> newSponsor, Map<Id,CAMPX__Sponsor__c> oldSponsor){
        Set<Id> sponsorsToUpdate = new Set<Id>();
        for(CAMPX__Sponsor__c allSponsor : newSponsor){
            if((allSponsor.CAMPX__Status__c == 'Pending' || allSponsor.CAMPX__Status__c == 'Rejected') && allSponsor.CAMPX__Status__c != oldSponsor.get(allSponsor.Id).CAMPX__Status__c){
                sponsorsToUpdate.add(allSponsor.Id);
            }
        }
        
        List<CAMPX__Event__c> allEvents =[SELECT Id,CAMPX__GrossRevenue__c,(SELECT Id,CAMPX__ContributionAmount__c FROM CAMPX__Sponsors__r WHERE Id IN :sponsorsToUpdate) FROM CAMPX__Event__c];
        // List<CAMPX__Sponsor__c> spons =[SELECT Id,CAMPX__Event__c,CAMPX__Event__r.CAMPX__GrossRevenue__c FROM CAMPX__Sponsor__c WHERE Id IN :sponsorsToUpdate];
        for(CAMPX__Event__c ev : allEvents){
            Decimal grossREvenue = ev.CAMPX__GrossRevenue__c != null ? ev.CAMPX__GrossRevenue__c: 0; //this will avoid nullPointer exception
            Decimal contributedAmount = 0;
            for(CAMPX__Sponsor__c spons: ev.CAMPX__Sponsors__r){
                Decimal SponsorscontributedAmount = spons.CAMPX__ContributionAmount__c != null ? spons.CAMPX__ContributionAmount__c : 0;
                contributedAmount += SponsorscontributedAmount;
                
            }
            
            ev.CAMPX__GrossRevenue__c = grossREvenue - contributedAmount;
                
            
        }

        if(!allEvents.isEmpty()){
            update allEvents;
        }
        
        
    }
    
}


// When the CAMPX__Event__c lookup of a CAMPX__Sponsor__c changes,
// the previously associated CAMPX__Event__c's CAMPX__GrossRevenue__c field
// should no longer reflect the sponsor's CAMPX__ContributedAmount__c