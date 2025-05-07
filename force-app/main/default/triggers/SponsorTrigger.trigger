trigger SponsorTrigger on CAMPX__Sponsor__c (After insert,before insert,before update,After update) {
    
    if(Trigger.isInsert){
        SponsorHandler.sponsorCreate(Trigger.new);  
        //SponsorHandler.sponsorContributionCreate(Trigger.new); 
        SponsorHandler.updaterGrossAfterCreation(Trigger.new);
    }else if(Trigger.isUpdate & Trigger.isBefore){
        SponsorHandler.sponsorUpdate(Trigger.new,Trigger.oldMap);
        //SponsorHandler.sponsorContributionUpdate(Trigger.new, Trigger.oldMap);
        SponsorHandler.updaterGrossAfterUpdate(Trigger.new, Trigger.oldMap);
    }
    
}