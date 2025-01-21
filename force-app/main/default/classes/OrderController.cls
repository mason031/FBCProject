public with sharing class OrderController {

    public List<Order> orders {get;set;}
    public Order newOrder {get;set;}
    public List <OrderItem> orderProducts {get;set;}
    public OrderItem newOrderProduct{get;set;}
    public List<SelectOption> options {get;set;}
    public List<PricebookEntry> pbEntries {get;set;}
    public PricebookEntry newEntry {get;set;}
    ApexPages.StandardSetController ssc {get{
        ssc = new ApexPages.StandardSetController([SELECT AccountId, ContractId, EffectiveDate, TotalAmount, Status FROM Order]);
        ssc.setPageSize(50);
        return ssc;
    }
        set;}
    public Id orderId {get;set;}
    public Id orderProductId {get;set;}

    public OrderController(){       
        this.newOrder = new Order();      
        this.newOrderProduct = new OrderItem();
        
        fetchRecords();
    }
  
    public void saveRecord(){
        
        try{
            //PricebookEntry = new PricebookEntry(OrderI)
            Database.insert(newOrder);
            fetchRecords();
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }      
    }

    public void saveOrderProduct(){
        newOrderProduct.OrderId = orderId;
        //newOrderProduct.PricebookEntryId = newEntry.Id;
        try{
            Database.insert(newOrderProduct);
            this.orderProducts = [SELECT OrderId, Product2Id, Product2.Name, Quantity, TotalPrice, ServiceDate FROM OrderItem WHERE OrderId = :orderId];
        }
        catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }  
    }

    public void deleteRecord(){
        try{
            Database.delete(orderId);
            fetchRecords();
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }        
    }

    public void deleteOrderProductRecord(){
        try{
            Database.delete(orderProductId);
            this.orderProducts = [SELECT OrderId, Product2Id, Product2.Name, Quantity, TotalPrice, ServiceDate FROM OrderItem WHERE OrderId = :orderId];
        }catch(Exception e){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(msg);
        }        
    }

    public void fetchRecords(){
        this.orders = ssc.getRecords();
    }

    public PageReference WorkOrderPage(){
        PageReference workPage = Page.WorkOrder;
        return workPage;
    }
    public PageReference OpportunitiesPage(){
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
        //this.orderLists = [SELECT OrderId, Product2Id, Quantity, TotalPrice, ServiceDate FROM OrderItem WHERE OrderId = :orderId];
        return orderPage;
    }
    public PageReference OrderRelatedListPage(){
        //PageReference orderListPage = new PageReference('/apex/OrderRelatedList?Id=' + orderId);
        PageReference orderListPage = Page.OrderProducts;
        this.options = new List<SelectOption>();
        this.orderProducts = [SELECT OrderId, Product2Id, Product2.Name, Quantity, TotalPrice, ServiceDate FROM OrderItem WHERE OrderId = :orderId];
        Order newOrder2 = [SELECT AccountId, Pricebook2Id, ContractId, EffectiveDate, TotalAmount, Status FROM Order WHERE Id = :orderId];
        this.pbEntries = [SELECT Id, Product2.Name FROM PricebookEntry WHERE Pricebook2Id = :newOrder2.Pricebook2Id];
        System.debug(this.pbEntries);
        for(PricebookEntry e: this.pbEntries){
            SelectOption option = new SelectOption(e.Id, e.Product2.Name);
            options.add(option);
        }

        //this.newOrderProduct.PricebookEntryId = 
        return orderListPage;
    }
    public PageReference LinksPage(){
        PageReference linksPage = Page.ExternalLinks;
        return linksPage;
    } 
}