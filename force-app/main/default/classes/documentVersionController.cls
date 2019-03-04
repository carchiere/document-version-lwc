public with sharing class documentVersionController {
        @AuraEnabled(Cacheable=true)
        public static List <versionWrapper> getDocVersions(Id docId){
        //public static List <ContentVersion> getDocVersions(Id docId){
          system.debug(docId);
          List<versionWrapper> versionList = new List<versionWrapper>();
          List<ContentVersion> versions= [SELECT Id, ContentDocumentId,CreatedBy.Name
          ,Owner.Name, LastModifiedBy.Name, Title,VersionNumber 
          FROM ContentVersion where ContentDocumentId= :docId ORDER BY VersionNumber LIMIT 50];
          for (ContentVersion c : versions) {
              versionWrapper ver = new versionWrapper(c);
              system.debug(ver.OwnerName);
              versionList.add(ver);
          }
          system.debug(versionList.size());
          return versionList;
          //return versions;
    }
   
    public class versionWrapper{
        @AuraEnabled public Id Id {get;set;}
        @AuraEnabled public String VersionNumber {get;set;}
        @AuraEnabled public String Title {get;set;}
        @AuraEnabled public String OwnerName {get;set;}
        @AuraEnabled public String CreatedByName {get;set;}
        @AuraEnabled public String LastModifiedByName {get;set;}
        
        
        public versionWrapper(ContentVersion version){
              this.Id = version.Id;
              this.VersionNumber = version.VersionNumber;
              this.Title = version.Title;
              this.OwnerName = version.Owner.Name;
              this.CreatedByName = version.CreatedBy.Name;
              this.LastModifiedByName = version.LastModifiedBy.Name;  
        }


    }
}
