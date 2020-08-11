trigger CaseUpdateTrigger on Case (after update) {
    caseTriggerHandler controller = new caseTriggerHandler();
    if (Trigger.isUpdate){
        controller.calculateAvgAcnt(Trigger.new,Trigger.oldMap);
    }
}