public class JSONParser {
	
    //Contact JSON fields
	public class Contacts {
		public String first_name;
		public String last_name;
		public String email;
	}

	public List<Accounts> accounts;
	
    //Account JSON fields
	public class Accounts {
		public String uuid;
		public String company_name;
		public Integer annual_revenue;
		public Integer number_employees;
		public List<Contacts> contacts;
	}

	//Method to read the JSON and store the account and contact fields
	public static JSONParser parse (String json) {
		return (JSONParser) System.JSON.deserialize(json, JSONParser.class);
	}
    
    //Upsert the accounts and the contacts stored in the JSON file
    public static void upsertAccounts (JSONParser obj) {
        
        //Stores the external ids of the accounts
        Set<Id> sAccountExternalId;
        for(Accounts acc : obj.accounts) sAccountExternalId.add(acc.uuid);
        
        //Objects to insert and update
        List<Account> lAccountToUpsert;
        List<Contact> lContactsToUpsert;
        
        //Get all accounts and contacts to upsert
        for(Accounts acc : obj.accounts) {
            Account newAccount = new Account( ExternalId__c = acc.uuid,
                							  CompanyName__c = acc.company_name,
                                        	  AnnualRevenue = acc.annual_revenue,
                                        	  NumberEmployees__c = acc.number_employees
            						  		); 
            lAccountToUpsert.add(newAccount);
            
            for(Contacts cont : acc.contacts){
                Contact newContact = new Contact( AccountExternalId__c = acc.uuid,
                							  	  FirstName = cont.first_name,
                                        	      LastName = cont.last_name,
                                        	      Email = cont.email
            						  		    );
                lContactsToUpsert.add(newContact);
            }
        }
        
        //Upsert based on the external account id
        upsert lAccountToUpsert ExternalId__c;
        upsert lContactsToUpsert AccountExternalId__c;
        
    }
}