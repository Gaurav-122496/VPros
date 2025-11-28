

public class AccountDomain {
 
    //The Map is Private so that We can set this only from This class and prevent it for Use in other classes
    private static Map<String, Schema.RecordTypeInfo> recordTypeInfosMap = new Map<String, Schema.RecordTypeInfo>();

    public static Map<Decimal, Account> getPincodeAccountMap(List<Supplier_Pincode_Mapping__c> supplierPincodeMappings){
        Map<Decimal, Account> pincodeAccountMap = new Map<Decimal, Account>(); // pincodeAccountMap
        for(Supplier_Pincode_Mapping__c pincodeMapping : supplierPincodeMappings){
            Account accountObj = new Account(Id = pincodeMapping.Account__c, ProductType__c = pincodeMapping.Account__r.ProductType__c);
            pincodeAccountMap.put(pincodeMapping.Pincode__c, accountObj);
        }
        return pincodeAccountMap;
    }


    public static string getRecordTypeIdbyDeveloperName(String recordTypeDeveloperName){
		if(recordTypeInfosMap.containsKey(recordTypeDeveloperName)){
			return recordTypeInfosMap.get(recordTypeDeveloperName).getRecordTypeId();

		}
	   recordTypeInfosMap = Account.sobjectType.getDescribe(SObjectDescribeOptions.DEFERRED).getRecordTypeInfosByDeveloperName();

	   return recordTypeInfosMap.get(recordTypeDeveloperName).getRecordTypeId();
    }
    


    public static Map<String , String> getRecordTypeIdsbyDeveloperNameSet(Set<String> recordTypeDeveloperNameSet){

        Map<String , String> recordTypeDeveloperNamevsIdMap = new Map<String , String>();
        recordTypeInfosMap = Account.sobjectType.getDescribe(SObjectDescribeOptions.DEFERRED).getRecordTypeInfosByDeveloperName();
        for(String recordTypeDeveloperName : recordTypeDeveloperNameSet){
            if(recordTypeInfosMap.containsKey(recordTypeDeveloperName)){
                recordTypeDeveloperNamevsIdMap.put(recordTypeDeveloperName , 
                recordTypeInfosMap.get(recordTypeDeveloperName).getRecordTypeId());
            }
        }
 
        return recordTypeDeveloperNamevsIdMap;
     }


    

}