trigger Criatura_Trigger on Criatura__c (after insert, after update, after delete) {
    //List<Criatura__c> crList = [SELECT id FROM Criatura__c WHERE id in : trigger.newMap.keyset()];
    // Identificar os bankers.
    Map<id,Bunker__c> bunkersUpdateMap = new Map<id,Bunker__c>();
    
    for(Criatura__c cr : trigger.new){
        //insert ou update
        
        if(cr.Bunker__c != trigger.oldMap.get(cr.id).Bunker__c){
            bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.Bunker__c));            
        }    
    }
    for(Criatura__c cr : trigger.old){
        if(trigger.isDelete && cr.Bunker__c != null){
            bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.Bunker__c));            
        }
    }
    system.debug(bunkersUpdateMap);
    
    // Totalizar todas as criaturas dos bunkers identificados
    List<Bunker__c> bkList = [SELECT id, (SELECT id FROM Criaturas__r) FROM bunker__c WHERE id in : bunkersUpdateMap.keySet()];
    for(Bunker__c bk : bkList){
        bunkersUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
    }
    
    // Atualizar os bunkers
    update bunkersUpdateMap.values(); 
}