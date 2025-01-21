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
private class WorkOrderController_Test {

    @TestSetup
    static void makeData(){
        WorkOrder wo = new WorkOrder(Subject = 'Testing');
        insert wo;
    }
    @isTest
    static void saveRecordPositive() {
        WorkOrderController controller = new WorkOrderController();
        controller.newWorkOrder.Subject = 'Testing2';
        controller.saveRecord();
        Assert.areEqual('Testing2', controller.wOrders[1].Subject);
    }

    @isTest
    static void deleteRecordPositive(){
        WorkOrderController controller = new WorkOrderController();
        WorkOrder wo = [SELECT Id FROM WorkOrder WHERE Subject = 'Testing'];
        controller.workOrderId = wo.Id;
        controller.deleteRecord();
        Assert.areEqual(0, controller.wOrders.size());
    }

    @isTest
    static void deleteRecordNegative(){
        WorkOrderController controller = new WorkOrderController();
        WorkOrder wo = new WorkOrder();
        controller.workOrderId = wo.Id;
        controller.deleteRecord();
        Assert.areEqual(1, controller.wOrders.size());
    }

    @isTest
    static void testPageNav(){
        WorkOrderController controller = new WorkOrderController();
        PageReference pageRef = Page.WorkOrder;
        PageReference opportunityPage = Page.Opportunities;
        PageReference orderPage = Page.Order;
        PageReference accountsPage = Page.AccountsAndLeads;
        PageReference workOrderPage = Page.WorkOrder;
        PageReference contactsPage = Page.Contacts;
        PageReference linksPage = Page.ExternalLinks;
        Test.setCurrentPage(pageRef);
        Test.setCurrentPage(controller.OrderPage());
        Assert.areEqual(orderPage.getUrl(), ApexPages.currentPage().getUrl());
        Test.setCurrentPage(controller.OpportunityPage());
        Assert.areEqual(opportunityPage.getUrl(), ApexPages.currentPage().getUrl());
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