public with sharing class ContactController {

    public List<Contact> customerContacts {get;set;}
    public List<Contact> techContacts {get;set;}
    public Contact newContact {get;set;}
    public String recordType {get;set;}
    public Boolean isVisible {get;set;}
    //public List<String> recordTypeList {get;set;}
    ApexPages.StandardSetController customerSsc {get{
        customerSsc = new ApexPages.StandardSetController([SELECT FirstName, LastName, Title, Phone, Email FROM Contact WHERE RecordTypeName__c = 'Customer']);
        customerSsc.setPageSize(50);
        return customerSsc;
    }
        set;}
        ApexPages.StandardSetController techSsc {get{
            techSsc = new ApexPages.StandardSetController([SELECT FirstName, LastName, Title, Phone, Email FROM Contact WHERE RecordTypeName__c = 'Service Technician']);
            techSsc.setPageSize(50);
            return techSsc;
        }
            set;}   
    public Id contactId {get;set;}

    public ContactController(){
        Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        if(profileName == 'HR Member' || profileName == 'System Administrator'){
            this.isVisible = True;
        }
        else{
            this.isVisible = False;
        }      
        this.newContact = new Contact();      
        fetchRecords();
    }
  
    public void saveRecord(){
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE sObjectType = 'Contact' AND name = :recordType];
        try{
            newContact.recordTypeId = rt.Id;
            Database.insert(newContact);
            fetchRecords();
            this.newContact = new Contact();
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }

    public void deleteRecord(){
        try{
            Database.delete(contactId);
            fetchRecords();
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }        
    }
    public void fetchRecords(){
        this.customerContacts = customerSsc.getRecords();
        this.techContacts = techSsc.getRecords();
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