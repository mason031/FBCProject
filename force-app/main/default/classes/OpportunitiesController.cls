public with sharing class OpportunitiesController {

    public List<Opportunity> opps {get;set;}
    public Opportunity newOpp {get;set;}
    
    ApexPages.StandardSetController ssc {get{
        ssc = new ApexPages.StandardSetController([SELECT Name, AccountId, Amount, CloseDate, ExpectedRevenue, StageName, Probability FROM Opportunity]);
        ssc.setPageSize(50);
        return ssc;
    }
        set;}
    public Id oppId {get;set;}

    public OpportunitiesController(){       
        this.newOpp = new Opportunity();      
        fetchRecords();
        
    }
  
    public void saveRecord(){
        
        try{
            Database.insert(newOpp);
            fetchRecords();
            this.newOpp = new Opportunity();
            
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }

    public void deleteRecord(){
        try{
            Database.delete(oppId);
            fetchRecords();
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }        
    }
    public void fetchRecords(){
        this.opps = ssc.getRecords();
    }

    public PageReference WorkOrderPage(){
        PageReference workPage = Page.WorkOrder;
        return workPage;
    }
    public PageReference OpportunityPage(){
        PageReference oppPage = Page.Opportunities;
        return oppPage;
    }
    public PageReference AccountsAndLeadsPage(){
        PageReference accAndLeadPage = Page.AccountsAndLeads;
        return accAndLeadPage;
    }
    public PageReference ContactsPage(){
        PageReference contactsPage = Page.Contacts;
        return contactsPage;
    }
    public PageReference OrderPage(){
        PageReference orderPage = Page.Order;
        return orderPage;
    }   
    public PageReference LinksPage(){
        PageReference linksPage = Page.ExternalLinks;
        return linksPage;
    } 
}