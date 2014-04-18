<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	String sysKey = (String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");

	String companyAddressId = "";
	
	String isAddressAvailable = "N";

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
	ezc.ezvendorapp.params.EzVendorProfileStructure profileStruct =  new ezc.ezvendorapp.params.EzVendorProfileStructure();	

	profileStruct.setSysKey(sysKey);
	profileStruct.setSoldTo(soldTo);

	mainParams.setObject(profileStruct);	
	mainParams.setLocalStore("Y");	
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve retProfile= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetVendorProfile(mainParams);	
	int profileCount=retProfile.getRowCount();
	
	ezc.ezparam.ReturnObjFromRetrieve retAddress=null;
	int addressCount = 0;
	

String CompanyName="";
String Address1="";
String Address2="";
String City="";
String State="";
String Country="";
String ZipCode="";
String Phone1="";
String Phone2="";
String Fax="";
String Email="";
String Url="";


	if(profileCount>0)
	{
	    isAddressAvailable="Y";	
            companyAddressId = retProfile.getFieldValueString(0,"COMPANYADDRESSID");

	    ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
	    ezc.ezupload.params.EziAddressParams params =  new ezc.ezupload.params.EziAddressParams();	
            String no = companyAddressId;
            params.setNo(no);
	    eParams.setObject(params);	
	    Session.prepareParams(eParams);
    	    retAddress=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getAddress(eParams);	
    	    addressCount = retAddress.getRowCount();
    	    
	    CompanyName = retAddress.getFieldValueString(0,"COMPANYNAME");
	    CompanyName=CompanyName.equals("null") ? "":CompanyName;

	    Address1= retAddress.getFieldValueString(0,"ADDRESS1");
	    Address1=Address1.equals("null") ? "":Address1;

  	    Address2= retAddress.getFieldValueString(0,"ADDRESS2");
 	    Address2=Address2.equals("null") ? "":Address2;
	
	    City= retAddress.getFieldValueString(0,"CITY");
	    City=City.equals("null") ? "":City;

  	    State= retAddress.getFieldValueString(0,"STATE");
	    State=State.equals("null") ? "":State;
	
	    Country= retAddress.getFieldValueString(0,"COUNTRY");
	    Country=Country.equals("null") ? "":Country;

	    ZipCode= retAddress.getFieldValueString(0,"ZIPCODE");
	    ZipCode=ZipCode.equals("null") ? "":ZipCode;


  	    Phone1= retAddress.getFieldValueString(0,"PHONE1");
	    Phone1=Phone1.equals("null") ? "":Phone1;

  	    Phone2= retAddress.getFieldValueString(0,"PHONE2");
	    Phone2=Phone2.equals("null") ? "":Phone2;

 	    Fax= retAddress.getFieldValueString(0,"FAX");
	    Fax=Fax.equals("null") ? "":Fax;

	    Email= retAddress.getFieldValueString(0,"EMAIL");
	    Email=Email.equals("null") ? "":Email;		

	    Url= retAddress.getFieldValueString(0,"URL");
	    Url=Url.equals("null") ? "":Url;		


	}
	
	
	
	
	





%>
