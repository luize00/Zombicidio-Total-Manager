global class ContagionSchedulable implements Schedulable {
    
    global void execute(SchedulableContext SC){
        this.contagiar();
    }
    
    private void contagiar() {
        List<Criatura__c> humanList = [SELECT id, RecordTypeId, bunker__r.defesa_do_bunker__c, bunker__c, (SELECT id, acrescimo_de_defesa__c FROM Recursos_da_Criatura__r)  FROM Criatura__c WHERE recordtypeId = '0125e000000a6oaAAA'];
        List<Criatura__c> zombieList = [SELECT id FROM Criatura__c WHERE recordtypeId = '0125e000000a6opAAA'];
        
        for(Criatura__c zb : zombieList) {
            if(humanList.size() == 0) break;
            Criatura__c hmn1 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000), humanList.size() ));
            
            Decimal defesa = 0;
                      
            if(hmn1.recordtypeId != '0125e000000a6opAAA'){
               
                if(hmn1.Bunker__c != null){
                    defesa += hmn1.bunker__r.defesa_do_bunker__c;
                }
                if(hmn1.Recursos_da_criatura__r != null){
                    for(Recurso_da_criatura__c recCri : hmn1.Recursos_da_Criatura__r){
                        defesa += recCri.acrescimo_de_defesa__c;
                    }
                }
            }
            Integer DiceRoll = Math.mod(Integer.valueOf(Math.random()*100000),100)+1;
               if(DiceRoll > defesa)
            {
                hmn1.recordtypeId  = '0125e000000a6opAAA';
                hmn1.DataZumbificacao__c = Date.today();
            }
            defesa = 0;
            Criatura__c hmn2 = humanList.get(Math.mod(Integer.valueof(Math.random()*1000),humanList.size()));
            if(hmn2.recordtypeId  != '0125e000000a6opAAA')
            {
                if(hmn2.bunker__c != null)
                {
                    defesa += hmn2.bunker__r.defesa_do_Bunker__c;
                }
                if(hmn2.Recursos_da_Criatura__r != null)
                {
                    for(recurso_da_Criatura__c recCri : hmn2.Recursos_da_Criatura__r)
                    {
                        defesa += recCri.acrescimo_de_Defesa__c;
                    }
                }
            }
            Integer DiceRoll2 = Math.mod(Integer.valueof(Math.random()*100000),100)+1;
            if(DiceRoll2 > defesa)
            {
                hmn2.recordtypeId  = '0125e000000a6opAAA';
                hmn2.DataZumbificacao__c = Date.today();
            }
        }            	
        update humanList;
    } 
}