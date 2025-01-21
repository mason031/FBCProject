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
private class OpportunitiesController_Test {

    @TestSetup
    static void makeData(){
        Opportunity opp = new Opportunity(Name = 'Test', CloseDate = Date.valueOf('2025-01-30'), StageName = 'Prospecting');
        insert opp;
    }

    @isTest
    static void saveRecordPositive() {
        OpportunitiesController controller = new OpportunitiesController();
        controller.newOpp.Name = 'test2';
        controller.newOpp.CloseDate = Date.valueOf('2025-01-30');
        controller.newOpp.StageName = 'Prospecting';
        controller.saveRecord();
        //List<Opportunity> opps = [SELECT ]
        Assert.areEqual('test2', controller.opps[1].Name);
        // TO DO: implement unit test
    }
    @isTest
    static void saveRecordNegative(){
        OpportunitiesController controller = new OpportunitiesController();
        controller.newOpp.Name = 'test2';
        controller.newOpp.CloseDate = Date.valueOf('2025-01-30');
        controller.saveRecord();
        Assert.areEqual(1, controller.opps.size());
    }

    @isTest
    static void deleteRecordPositive(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test'];
        OpportunitiesController controller = new OpportunitiesController();
        controller.oppId = opp.Id;
        controller.deleteRecord();
        Assert.areEqual(0, controller.opps.size());
    }

    @isTest
    static void deleteRecordNegative(){
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Test'];
        Opportunity opp2 = new Opportunity(Name ='New', StageName = 'Prospecting', CloseDate = Date.valueOf('2025-01-30'));
        OpportunitiesController controller = new OpportunitiesController();
        controller.oppId = opp2.Id;
        controller.deleteRecord();
        Assert.areEqual(1, controller.opps.size());
    }

    @isTest
    static void testPageNav(){
        OpportunitiesController controller = new OpportunitiesController();
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