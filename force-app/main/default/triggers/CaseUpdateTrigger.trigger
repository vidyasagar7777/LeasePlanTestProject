trigger CaseUpdateTrigger on Case (after update) {

    CaseTriggerHandler controller = new CaseTriggerHandler();
    if (Trigger.isUpdate){
        controller.calculateAvgAcnt(Trigger.new,Trigger.oldMap);
    }
}