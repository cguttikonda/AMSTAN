<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" />
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />

<%
	
	String sysKey=(String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");


	EzVendorQuestionnaireStructure struct = new EzVendorQuestionnaireStructure();
	
	String materialId = request.getParameter("chk1");
	struct.setMaterialId(materialId);

	EzcParams ezcparams= new EzcParams(true);
	ezcparams.setLocalStore("Y");
	ezcparams.setObject(struct);
	Session.prepareParams(ezcparams);
	ReturnObjFromRetrieve ret=(ReturnObjFromRetrieve)AppManager.ezViewVendorQuestionnaire(ezcparams);

	ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
   	ezc.ezupload.params.EziAddressParams params =  new ezc.ezupload.params.EziAddressParams();	
	
	String CompanyAddressId = ret.getFieldValueString(0,"COMPANYADDRESSID");
	
	params.setNo(CompanyAddressId);

	eParams.setObject(params);	
    	Session.prepareParams(eParams);

    	ezc.ezparam.ReturnObjFromRetrieve retAddress=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getAddress(eParams);	


	String MaterialDesc = ret.getFieldValueString(0,"MATERIALDESC");
	
	String MktContactName = ret.getFieldValueString(0,"MKTCONTACTNAME");
	MktContactName = MktContactName.equals("null") ? "":MktContactName;	
	
	String MktContactDesignation = ret.getFieldValueString(0,"MKTCONTACTDESIGNATION");
	MktContactDesignation = MktContactDesignation .equals("null") ? "":MktContactDesignation;	
	
	String MktContactPhone1 = ret.getFieldValueString(0,"MKTCONTACTPHONE1");
	MktContactPhone1=MktContactPhone1.equals("null") ? "":MktContactPhone1;	
	
	String MktContactPhone2 = ret.getFieldValueString(0,"MKTCONTACTPHONE2");
	MktContactPhone2=MktContactPhone2.equals("null") ? "":MktContactPhone2;	
	
	String MktContactFax = ret.getFieldValueString(0,"MKTCONTACTFAX");
	MktContactFax=MktContactFax.equals("null") ? "":MktContactFax;	
	
	String MktContactEmail = ret.getFieldValueString(0,"MKTCONTACTEMAIL");
	MktContactEmail=MktContactEmail.equals("null") ? "":MktContactEmail;	
	
	String QaContactName = ret.getFieldValueString(0,"QACONTACTNAME");
	QaContactName=QaContactName.equals("null") ? "":QaContactName;	
	
	String QaContactDesig = ret.getFieldValueString(0,"QACONTACTDESIG");
	QaContactDesig=QaContactDesig.equals("null") ? "":QaContactDesig;	
	
	String QaContactPhone1 = ret.getFieldValueString(0,"QACONTACTPHONE1");
	QaContactPhone1=QaContactPhone1.equals("null") ? "":QaContactPhone1;		
	
	String QaContactPhone2 = ret.getFieldValueString(0,"QACONTACTPHONE2");
	QaContactPhone2=QaContactPhone2.equals("null") ? "":QaContactPhone2;			
	
	String QaContactFax = ret.getFieldValueString(0,"QACONTACTFAX");
	QaContactFax=QaContactFax.equals("null") ? "":QaContactFax;			
	
	String QaContactEmail = ret.getFieldValueString(0,"QACONTACTEMAIL");
	QaContactEmail=QaContactEmail.equals("null") ? "":QaContactEmail;
	
	String MfgCapacity = ret.getFieldValueString(0,"MFGCAPACITY");
	MfgCapacity=MfgCapacity.equals("null") ? "":MfgCapacity;
	
	String TotalCapacity = ret.getFieldValueString(0,"TOTALCAPACITY");
	TotalCapacity=TotalCapacity.equals("null") ? "":TotalCapacity;
	
	String PctgSupply = ret.getFieldValueString(0,"PCTGSUPPLY");
	PctgSupply=PctgSupply.equals("null") ? "":PctgSupply;
	
	String Other = ret.getFieldValueString(0,"OTHER");
	Other = Other.equals("null")? "":Other;
	
	String CompanyName = retAddress.getFieldValueString(0,"COMPANYNAME");
	CompanyName=CompanyName.equals("null") ? "":CompanyName;

	String Address1= retAddress.getFieldValueString(0,"ADDRESS1");
	Address1=Address1.equals("null") ? "":Address1;

	String Address2= retAddress.getFieldValueString(0,"ADDRESS2");
	Address2=Address2.equals("null") ? "":Address2;
	
	String City= retAddress.getFieldValueString(0,"CITY");
	City=City.equals("null") ? "":City;

	String State= retAddress.getFieldValueString(0,"STATE");
	State=State.equals("null") ? "":State;
	
	String Country= retAddress.getFieldValueString(0,"COUNTRY");
	Country=Country.equals("null") ? "":Country;

	String ZipCode= retAddress.getFieldValueString(0,"ZIPCODE");
	ZipCode=ZipCode.equals("null") ? "":ZipCode;


	String Phone1= retAddress.getFieldValueString(0,"PHONE1");
	Phone1=Phone1.equals("null") ? "":Phone1;

	String Phone2= retAddress.getFieldValueString(0,"PHONE2");
	Phone2=Phone2.equals("null") ? "":Phone2;

	String Fax= retAddress.getFieldValueString(0,"FAX");
	Fax=Fax.equals("null") ? "":Fax;

	String Url = retAddress.getFieldValueString(0,"URL");
	Url = Url.equals("null") ? "":Url;


        String IsOtherDetails = ret.getFieldValueString(0,"ISOTHERDETAILS");

	String prodsOffered="";
	String customers="";

        if(IsOtherDetails.equals("Y"))
    	{
    	  
		ezc.ezparam.ReturnObjFromRetrieve retOther = null;

    	 	ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
   	  	ezc.ezupload.params.EziDocumentTextsTable table =  new ezc.ezupload.params.EziDocumentTextsTable();
   	  	ezc.ezupload.params.EziDocumentTextsTableRow tableRow=null;
	    	
	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
	    	tableRow.setDocType("QUESTIONNAIRE");
	    	tableRow.setDocNo(materialId);
	    	tableRow.setSysKey(sysKey);
	    	tableRow.setKey("PRODSOFFERED");
	    	table.appendRow(tableRow);
	    	
	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		tableRow.setDocType("QUESTIONNAIRE");
		tableRow.setDocNo(materialId);
		tableRow.setSysKey(sysKey);
		tableRow.setKey("CUSTOMERS");
	    	table.appendRow(tableRow);
	    	
	  	oParams.setObject(table);	
    	  	Session.prepareParams(oParams);
    	  	retOther=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getDocumentTextDetails(oParams);
    	  	
    	  	prodsOffered = retOther.getFieldValueString(0,"VALUE1");
    	  	prodsOffered = prodsOffered.equals("null") ? "":prodsOffered;          
    	  	
		customers = retOther.getFieldValueString(1,"VALUE1");
		customers = customers.equals("null") ? "":customers;  

   	  }


          String CertUploadId = ret.getFieldValueString(0,"CERTUPLOADID");
  	  String IsCertified = ret.getFieldValueString(0,"ISCERTIFIED");
  	  
  	  String isoFile="";
  	  String whoFile="";
  	  String gmpFile="";
  	  String fdaFile="";
  	  String fileName="";
  	  
  	  String isoServerFile="";
  	  String whoServerFile="";
  	  String gmpServerFile="";
  	  String fdaServerFile="";
  	  String serverLou="";

  	  ReturnObjFromRetrieve retFiles=null;
  	  
  	  if(IsCertified.equals("Y"))
  	  {
  	  
  	  	ezc.ezparam.EzcParams listMainParams = null;
	  	ezc.ezupload.params.EziUploadDocsParams listParams= null;

                listMainParams = new ezc.ezparam.EzcParams(false);
	  	listParams= new ezc.ezupload.params.EziUploadDocsParams();
	  	listParams.setObjectNo("'"+sysKey+"VENDORQUES"+materialId+"'");
	  	listMainParams.setObject(listParams);
	  	Session.prepareParams(listMainParams);
	  	ReturnObjFromRetrieve retUpload = (ReturnObjFromRetrieve)UploadManager.getUploadedDocs(listMainParams);
 	    	
 	    	retFiles = (ReturnObjFromRetrieve)retUpload.getFieldValue(0,"FILES");
		int filesCount = retFiles.getRowCount();
		for(int i=0;i<filesCount;i++)
		{
		   /* if(retFiles.getFieldValueString(i,"TYPE").equals("ISO"))	
		    {	
			isoFile=retFiles.getFieldValueString(i,"CLIENTFILENAME");
			isoServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
                    }  

		    if(retFiles.getFieldValueString(i,"TYPE").equals("WHO"))	
		    {			
			whoFile=retFiles.getFieldValueString(i,"CLIENTFILENAME");
			whoServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
                    } */


		    if(retFiles.getFieldValueString(i,"TYPE").equals("GMP"))	
		    {			
			gmpFile=retFiles.getFieldValueString(i,"CLIENTFILENAME");
			gmpServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
		    }	

		  /*  if(retFiles.getFieldValueString(i,"TYPE").equals("FDA"))	
		    {			
			fdaFile=retFiles.getFieldValueString(i,"CLIENTFILENAME");
			fdaServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
		    }	*/
		    
		    if(retFiles.getFieldValueString(i,"TYPE").equals("LOU"))	
		    {			
		    	fileName=retFiles.getFieldValueString(i,"CLIENTFILENAME");
			if(fileName.equals("null"))
			  fileName="";	
		    	serverLou = retFiles.getFieldValueString(i,"SERVERFILENAME");
		    }
		}
 	  
  	  }
	  
%>