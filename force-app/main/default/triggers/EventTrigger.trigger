trigger EventTrigger on CAMPX__Event__c (before insert,before update) {
    if(Trigger.isInsert){
        EventHandler.eventCreate(Trigger.new);
    }else if(Trigger.isUpdate){
        EventHandler.eventUpdate(Trigger.new, Trigger.oldMap);

    }
    
    }

