public class Zumbificacao 
{
    @InvocableMethod (label='Transforma Zumbi')
    public static void zumbificar(List<id> ids)
    {
        List<Criatura__c> criList = [SELECT id, bunker__r.name, bunker__c, (SELECT id from Recursos_da_Criatura__r) FROM Criatura__c WHERE id in :ids];
        List<Recurso_da_Criatura__c> rcDeleteList = new List<Recurso_da_Criatura__c>();
        
        for(Criatura__c cr : criList){
            String tipo_Zumbi = '';
            integer rand = Math.mod(Integer.valueof(Math.random()*100000),100);
            if(rand < 50)
            {
                tipo_Zumbi = 'Lento';
            }
            else if (rand < 80){
                tipo_Zumbi = 'Rápido';
            }
            else
            {
                tipo_Zumbi = 'Gordo';
            }
            cr.tipo_de_Zumbi__c = tipo_Zumbi;
            rcDeleteList.addAll(cr.Recursos_da_Criatura__r);
        }
        update criList;
        delete rcDeleteList;
    }

}