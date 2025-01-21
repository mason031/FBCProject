
public with sharing class AccountsAndLeadsController {

    public List<Account> accs {get;set;}
    public List<Lead> leads {get;set;}
    public Account newAcc {get;set;}
    public Lead newLead {get;set;}
    ApexPages.StandardSetController accountSsc {get{
        accountSsc = new ApexPages.StandardSetController([SELECT Name, Industry, AnnualRevenue, Rating, Phone, Website FROM Account]);
        accountSsc.setPageSize(100);
        return accountSsc;
    }
    set;}
    ApexPages.StandardSetController leadSsc {get{
        leadSsc = new ApexPages.StandardSetController([SELECT FirstName, LastName, Company, Title, Phone, Email, LeadSource, Status FROM Lead]);
        leadSsc.setPageSize(100);
        return leadSsc;
    }
    set;}
    //public Id accountId {get;set;}
    //public Id leadId {get;set;}
    public Id deleteId{get;set;}

    public AccountsAndLeadsController(){       
        this.newAcc = new Account();    
        this.newLead = new Lead();  
        fetchAccountRecords();
        fetchLeadRecords();
    }
  
    public void saveAccount(){
        try{
            Database.insert(newAcc);
            fetchAccountRecords();
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }
    public void saveLead(){
        try{
            Database.insert(newLead);
            fetchLeadRecords();
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }
    public void deleteRecord(){
        try{
            Database.delete(deleteId);
            fetchAccountRecords();
            fetchLeadRecords();
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }        
    }
    public void fetchAccountRecords(){
        this.accs = accountSsc.getRecords();
    }
    public void fetchLeadRecords(){
        this.leads = leadSsc.getRecords();
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