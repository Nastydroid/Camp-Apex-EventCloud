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
    
}