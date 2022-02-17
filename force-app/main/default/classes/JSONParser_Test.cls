@IsTest
public class JSONParser_Test {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"accounts\": [{'+
		'        \"uuid\": \"123456-123456\",'+
		'        \"company_name\": \"Acme Corp.\",'+
		'        \"annual_revenue\": 120000,'+
		'        \"number_employees\": 8,'+
		'        \"contacts\": [{'+
		'            \"first_name\": \"John\",'+
		'            \"last_name\": \"Smith\",'+
		'            \"email\": \"john@acme.com\"'+
		'        }, {'+
		'            \"first_name\": \"Maria\",'+
		'            \"last_name\": \"Doe\",'+
		'            \"email\": \"maria@acme.com\"'+
		'        }]'+
		'    }]'+
		'}';
		JSONParser obj = JSONParser.parse(json);
		System.assert(obj != null);
        system.debug('***Objeto: '+obj);
	}
    
    static testMethod void testUpsert() {
        String json = '{'+
		'    \"accounts\": [{'+
		'        \"uuid\": \"123456-123456\",'+
		'        \"company_name\": \"Acme Corp.\",'+
		'        \"annual_revenue\": 120000,'+
		'        \"number_employees\": 8,'+
		'        \"contacts\": [{'+
		'            \"first_name\": \"John\",'+
		'            \"last_name\": \"Smith\",'+
		'            \"email\": \"john@acme.com\"'+
		'        }, {'+
		'            \"first_name\": \"Maria\",'+
		'            \"last_name\": \"Doe\",'+
		'            \"email\": \"maria@acme.com\"'+
		'        }]'+
		'    }]'+
		'}';
        
        Test.startTest();
		JSONParser.upsertAccounts(JSONParser.parse(json));
        Test.stopTest();
    }
}