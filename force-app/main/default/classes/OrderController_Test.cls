/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class OrderController_Test {
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Test');
        insert acc;
        Contract con = new contract(AccountId = acc.Id, Status = 'Draft', ContractTerm = 3, StartDate = Date.valueOf('2025-01-30'));
        insert con;
        Order ord = new Order(AccountId = acc.Id, ContractId = con.Id, Status = 'Draft', EffectiveDate = Date.valueOf('2025-01-30'));
        insert ord;
    }

    @isTest
    static void saveRecordPositive() {
        OrderController controller = new OrderController();
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test' LIMIT 1];
        Contract con = [SELECT Id FROM Contract LIMIT 1];
        controller.newOrder.AccountId = acc.Id;
        controller.newOrder.ContractId = con.Id;
        controller.newOrder.EffectiveDate = Date.valueOf('2025-02-02');
        controller.newOrder.Status = 'Draft';
        controller.saveRecord();
        Assert.areEqual(2, controller.orders.size());
        // TO DO: implement unit test
    }

    @isTest
    static void saveRecordNegative(){
        OrderController controller = new OrderController();
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test' LIMIT 1];
        Contract con = [SELECT Id FROM Contract LIMIT 1];
        controller.saveRecord();
        Assert.areEqual(1, controller.orders.size());
        
    }

    @isTest
    static void deleteRecordPositive(){
        OrderController controller = new OrderController();
        Order o = [SELECT Id FROM Order LIMIT 1];
        controller.orderId = o.Id;
        controller.deleteRecord();
        Assert.areEqual(0, controller.orders.size());
    }

    @isTest
    static void deleteRecordNegative(){
        OrderController controller = new OrderController();
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test' LIMIT 1];
        Contract con = [SELECT Id FROM Contract LIMIT 1];
        Order ord = new Order(AccountId = acc.Id, ContractId = con.Id, Status = 'Draft', EffectiveDate = Date.valueOf('2025-01-30'));
        controller.orderId = ord.Id;
        controller.deleteRecord();
        Assert.areEqual(1, controller.orders.size());
        
    }

    @isTest
    static void testPageNav(){
        OrderController controller = new OrderController();
        PageReference pageRef = Page.Order;
        PageReference opportunitiesPage = Page.Opportunities;
        PageReference orderPage = Page.Order;
        PageReference accountsPage = Page.AccountsAndLeads;
        PageReference workOrderPage = Page.WorkOrder;
        PageReference contactsPage = Page.Contacts;
        PageReference linksPage = Page.ExternalLinks;
        Test.setCurrentPage(pageRef);
        Test.setCurrentPage(controller.OrderPage());
        Assert.areEqual(orderPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.OpportunitiesPage());
        Assert.areEqual(opportunitiesPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.AccountsAndLeadsPage());
        Assert.areEqual(accountsPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.WorkOrderPage());
        Assert.areEqual(workOrderPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.ContactsPage());
        Assert.areEqual(contactsPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.LinksPage());
        Assert.areEqual(linksPage.getUrl(), ApexPages.currentPage().getUrl());

    }

   


}