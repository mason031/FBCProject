public with sharing class WorkOrderController {

        public List<WorkOrder> wOrders {get;set;}
        public WorkOrder newWorkOrder {get;set;}
        ApexPages.StandardSetController ssc {get{
            ssc = new ApexPages.StandardSetController([SELECT WorkOrderNumber, Subject, ContactId, AccountId, Status, Priority FROM WorkOrder]);
            return ssc;
        }
            set;}
        public Id workOrderId {get;set;}
    
        public WorkOrderController(){       
            this.newWorkOrder = new WorkOrder();      
            fetchRecords();
        }
      
        public void saveRecord(){
            try{
                Database.insert(newWorkOrder);
                fetchRecords();
            }
            catch(Exception e){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
                ApexPages.addMessage(msg);
            }      
        }
    
        public void deleteRecord(){
            try{
                Database.delete(workOrderId);
                fetchRecords();
            }catch(Exception e){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
                ApexPages.addMessage(msg);
            }        
        }
        public void fetchRecords(){
            this.wOrders = ssc.getRecords();
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