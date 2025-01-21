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
private class AccountsAndLeadsController_Test {

    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Testing');
        insert acc;
        Lead lead = new Lead(LastName = 'Test', Company = 'TestCo', Status = 'Open - Not Contacted');
        insert lead;
    }

    @isTest
    static void saveRecordPositive() {
        AccountsAndLeadsController controller = new AccountsAndLeadsController();
        controller.newAcc.Name = 'Testing2';
        controller.newLead.LastName = 'Doe';
        controller.newLead.Company = 'TestCo';
        controller.newLead.Status = 'Open - Not Contacted';
        controller.saveAccount();
        controller.saveLead();
        //List<Opportunity> opps = [SELECT ]
        Assert.areEqual('Testing2', controller.accs[1].Name);
        Assert.areEqual('Doe', controller.leads[1].LastName);
        // TO DO: implement unit test
    }
    @isTest
    static void saveRecordNegative(){
        AccountsAndLeadsController controller = new AccountsAndLeadsController();
        controller.newLead.LastName = 'Doe';
        //controller.newOpp.CloseDate = Date.valueOf('2025-01-30');
        controller.saveAccount();
        controller.saveLead();
        Assert.areEqual(1, controller.accs.size());
        Assert.areEqual(1, controller.leads.size());
    }

    @isTest
    static void deleteRecordPositive(){
        Account acc = [SELECT Id FROM Account WHERE Name = 'Testing'];
        AccountsAndLeadsController controller = new AccountsAndLeadsController();
        controller.deleteId = acc.Id;
        controller.deleteRecord();
        Assert.areEqual(0, controller.accs.size());
    }

    @isTest
    static void deleteRecordNegative(){
        
        Account acc = new Account(Name = 'Testing2');
        AccountsAndLeadsController controller = new AccountsAndLeadsController();
        controller.deleteId = acc.Id;
        controller.deleteRecord();
        Assert.areEqual(1, controller.accs.size());
    }

    @isTest
    static void testPageNav(){
        AccountsAndLeadsController controller = new AccountsAndLeadsController();
        PageReference pageRef = Page.Opportunities;
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