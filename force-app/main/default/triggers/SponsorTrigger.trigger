trigger SponsorTrigger on CAMPX__Sponsor__c (before insert,before update) {

    if(Trigger.isInsert){
        SponsorHandler.sponsorCreate(Trigger.new);
        SponsorHandler.sponsorContributionCreate(Trigger.new);
    }else if(Trigger.isUpdate){
        SponsorHandler.sponsorUpdate(Trigger.new,Trigger.oldMap);
        SponsorHandler.sponsorContributionUpdate(Trigger.new, Trigger.oldMap);
    }

}