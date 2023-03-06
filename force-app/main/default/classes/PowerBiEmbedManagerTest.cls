@isTest
public with sharing class PowerBiEmbedManagerTest {

    static testmethod void powerBiToken(){
        
        Test.startTest();

        // Set Mock Request
        String strResponse = '{}';
        PowerBiEmbedMockRequest fakeResponse = new PowerBiEmbedMockRequest(200,'OK',strResponse,null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);

        String myToken = PowerBiEmbedManager.getPowerBiAccessToken();

        system.assertEquals('123T456O789K10E11N', myToken, 'Invalid Token');
        
        Test.stopTest();
        
    }

    static testmethod void powerBiReport() {

        Test.startTest();

        // Set Mock Request
        String strResponse = '{"@odata.context":"http://wabi-us-east-a-primary-redirect.analysis.windows.net/v1.0/myorg/groups/XXX3/$metadata#reports/$entity","id":"XXX4","reportType":"PowerBIReport","name":"Report1","webUrl":"https://app.powerbi.com/groups/XXX3/reports/XXX4","embedUrl":"https://app.powerbi.com/reportEmbed?reportId=XXX3&groupId=XXX4&w=2&config=XXX7","isFromPbix":true,"isOwnedByMe":true,"datasetId":"XXX9","datasetWorkspaceId":"XXX10","users":[ ],"subscriptions":[ ]}';
        PowerBiEmbedMockRequest fakeResponse = new PowerBiEmbedMockRequest(200,'OK',strResponse,null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);

        PowerBiEmbedManager.PowerBiReportData myReport = PowerBiEmbedManager.getEmbeddingDataForReport('123','456');

        system.assertEquals('Report1', myReport.name, 'Invalid Report Name');
        
        Test.stopTest();

    }

    static testmethod void powerBiReportError() {

        Test.startTest();

        // Set Mock Request
        String strResponse = '{}';
        PowerBiEmbedMockRequest fakeResponse = new PowerBiEmbedMockRequest(404,'Not Found',strResponse,null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);

        PowerBiEmbedManager.PowerBiReportData myReport = PowerBiEmbedManager.getEmbeddingDataForReport('123','456');

        system.assert(myReport.error.length() > 0, 'Missing Error');
        
        Test.stopTest();

    }

}
