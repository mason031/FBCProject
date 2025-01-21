public with sharing class ExternalLinksController {

    public List<ExternalLink__c> links {get;set;}
    public ExternalLink__c newLink {get;set;}

    ApexPages.StandardSetController ssc{
        get{
            ssc = new ApexPages.StandardSetController([SELECT Name, Description__c, WebsiteLink__c FROM ExternalLink__c]);
            ssc.setPageSize(50);
            return ssc;
        }
        set;
    }
    public ExternalLinksController() {
        this.newLink = new ExternalLink__c();
        this.links = [SELECT Name, Description__c, WebsiteLink__c FROM ExternalLink__c];
        
        //fetchRecords();
    }
    public void saveRecord(){
        
        try{
            Database.insert(newLink);
            fetchRecords();
            this.newLink = new ExternalLink__c();
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }
    

    public void fetchRecords(){
        this.links = ssc.getRecords();
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