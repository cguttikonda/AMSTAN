<%@ include file="../../Lib/PurchaseBean.jsp"%>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" 
scope="session">
</jsp:useBean>

<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" 
scope="session">
</jsp:useBean>
<%@page import="java.util.*" %>
<%
	String companyName = (String)session.getValue("Vendor");
     	String sysKey= (String)session.getValue("SYSKEY");
     	String soldTo = (String)session.getValue("SOLDTO");

     	String contactPerson = "";
     	String designation = "";
     	String email = "";
     	String address1 = "";
     	String address2 = "";
     	String city = "";
     	String state = "";
     	String country = "";
     	String zipcode = "";
     	String phone1 = "";
     	String phone2 = "";
     	String fax = "";

	ezc.client.EzcPurchaseUtilManager ezUtil = new
ezc.client.EzcPurchaseUtilManager(Session);
	ezUtil.setDefPayTo(soldTo);
	ezUtil.setDefOrdAddr(soldTo);

	String defPayTo = ezUtil.getUserDefPayTo();

	ReturnObjFromRetrieve listOfPayTos = (ReturnObjFromRetrieve)
ezUtil.getListOfPayTos(sysKey);

	if ( listOfPayTos != null && listOfPayTos.find("EC_PARTNER_NO",defPayTo) ){
		int rId = listOfPayTos.getRowId("EC_PARTNER_NO",defPayTo);

		address1 = listOfPayTos.getFieldValueString(rId,"ECA_ADDR_1").trim();
          	address1 = address1.equals("null") ? "":address1;

		address2 = listOfPayTos.getFieldValueString(rId,"ECA_ADDR_2").trim();
          	address2 = address2.equals("null") ? "":address2;

		city = listOfPayTos.getFieldValueString(rId,"ECA_CITY").trim();
          	city = city.equals("null") ? "":city;

		state  = listOfPayTos.getFieldValueString(rId,"ECA_STATE").trim();
          	state = state.equals("null") ? "":state;

		zipcode = listOfPayTos.getFieldValueString(rId,"ECA_PIN").trim();
          	zipcode = zipcode.equals("null") ? "":zipcode;

		country = 
listOfPayTos.getFieldValueString(rId,"ECA_COUNTRY").toUpperCase().trim();
          	country = country.equals("null") ? "":country;
	}

     String manAddress1Id = "";
     String manAddress2Id = "";
     String manAddress3Id = "";


     String salestax = "";
     String cexcise = "";
     String druglic = "";
     String dmfno = "";
     String prodCapacity = "";
     String turnOver = "";


     String man1address1 = "";
     String man1address2 = "";
     String man1city = "";
     String man1state = "";
     String man1country = "";
     String man1zipcode = "";
     String man1phone1 = "";
     String man1phone2 = "";
     String man1fax = "";

     String man2address1 = "";
     String man2address2 = "";
     String man2city = "";
     String man2state = "";
     String man2country = "";
     String man2zipcode = "";
     String man2phone1 = "";
     String man2phone2 = "";
     String man2fax = "";

     String man3address1 = "";
     String man3address2 = "";
     String man3city = "";
     String man3state = "";
     String man3country = "";
     String man3zipcode = "";
     String man3phone1 = "";
     String man3phone2 = "";
     String man3fax = "";

     String organogram = "";
     String companyDetails = "";
     String bankerDetails = "";
     String prodsOffered = "";
     String newDevelopments = "";


	String editPage="N";

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
   	ezc.ezvendorapp.params.EzVendorProfileStructure struct =  new 
ezc.ezvendorapp.params.EzVendorProfileStructure();
	struct.setSysKey(sysKey);
	struct.setSoldTo(soldTo);
	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
    	Session.prepareParams(mainParams);
    	ezc.ezparam.ReturnObjFromRetrieve ret= 
(ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetVendorProfile(mainParams);

	int count=ret.getRowCount();

	if(count>0)
	{
          editPage="Y";

 	  manAddress1Id = ret.getFieldValueString(0,"MFADDRESS1ID");
	  manAddress2Id = ret.getFieldValueString(0,"MFADDRESS2ID");
	  manAddress3Id = ret.getFieldValueString(0,"MFADDRESS3ID");

	  ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
   	  ezc.ezupload.params.EziAddressParams params =  new 
ezc.ezupload.params.EziAddressParams();

	  String no = manAddress1Id+","+manAddress2Id+","+manAddress3Id;
	  params.setNo(no);
	  eParams.setObject(params);
    	  Session.prepareParams(eParams);
    	  ezc.ezparam.ReturnObjFromRetrieve
retAddress=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getAddress(eParams);



    	  String isCompanyDetails = ret.getFieldValueString(0,"ISCOMPANYDETAILS");
    	  ezc.ezparam.ReturnObjFromRetrieve retOther=null;
		
    	  if(isCompanyDetails.equals("Y"))
    	  {

    	  	ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
   	  	ezc.ezupload.params.EziDocumentTextsTable table =  new
		ezc.ezupload.params.EziDocumentTextsTable();
   	  	ezc.ezupload.params.EziDocumentTextsTableRow tableRow=null;

	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
	    	tableRow.setDocType("VENDORPROFILE");
	    	tableRow.setDocNo(soldTo);
	    	tableRow.setSysKey(sysKey);
	    	tableRow.setKey("ORGANOGRAM");
	    	table.appendRow(tableRow);

	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		tableRow.setDocType("VENDORPROFILE");
		tableRow.setDocNo(soldTo);
		tableRow.setSysKey(sysKey);
		tableRow.setKey("COMPANYDETAILS");
	    	table.appendRow(tableRow);

	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		tableRow.setDocType("VENDORPROFILE");
		tableRow.setDocNo(soldTo);
		tableRow.setSysKey(sysKey);
		tableRow.setKey("BANKERDETAILS");
	    	table.appendRow(tableRow);


	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		tableRow.setDocType("VENDORPROFILE");
		tableRow.setDocNo(soldTo);
		tableRow.setSysKey(sysKey);
		tableRow.setKey("PRODSOFFERED");
	    	table.appendRow(tableRow);

	    	tableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		tableRow.setDocType("VENDORPROFILE");
		tableRow.setDocNo(soldTo);
		tableRow.setSysKey(sysKey);
		tableRow.setKey("NEWDEVELOPMENTS");
	    	table.appendRow(tableRow);

	  	oParams.setObject(table);
    	  	Session.prepareParams(oParams);

		retOther=(ezc.ezparam.ReturnObjFromRetrieve)UploadManager.getDocumentTextDetails(oParams);

    	  	//retOther
    	  	//ezc.ezcommon.EzLog4j.log("CHK RET OTHER"+retOther.toEzcString(),"I");
    	  	
    	  	organogram = retOther.getFieldValueString(0,"VALUE1");
    	  	organogram = organogram.equals("null") ? "":organogram;

		companyDetails = retOther.getFieldValueString(1,"VALUE1");
		companyDetails = companyDetails.equals("null") ? "":companyDetails;

		bankerDetails = retOther.getFieldValueString(2,"VALUE1");
		bankerDetails  = bankerDetails.equals("null") ? "":bankerDetails;

		prodsOffered = retOther.getFieldValueString(3,"VALUE1");
		prodsOffered  = prodsOffered.equals("null") ? "":prodsOffered;

		newDevelopments = retOther.getFieldValueString(4,"VALUE1");
		newDevelopments = newDevelopments.equals("null") ? "":newDevelopments;
		
		/*
		organogram = "";
		companyDetails = "";
		bankerDetails  = "";
		prodsOffered  = "";
		newDevelopments = "";
		*/
		
   	  }



	  contactPerson = ret.getFieldValueString(0,"CONTACTPERSON");
	  contactPerson = contactPerson.equals("null") ? "":contactPerson;


          designation = ret.getFieldValueString(0,"DESIGNATION");
          designation = designation.equals("null") ? "":designation;

          email = ret.getFieldValueString(0,"EMAIL");
          email = email.equals("null") ? "":email;



	  phone1 = ret.getFieldValueString(0,"PHONE1");
	  phone1 =phone1.equals("null") ? "":phone1;

     	  phone2 = ret.getFieldValueString(0,"PHONE2");
	  phone2 = phone2.equals("null") ? "":phone2;

     	  fax = ret.getFieldValueString(0,"FAX");
	  fax = fax.equals("null") ? "":fax;


	  salestax = ret.getFieldValueString(0,"SALESTAX");
          salestax = salestax.equals("null") ? "":salestax;

          cexcise = ret.getFieldValueString(0,"CEXCISE");
          cexcise = cexcise.equals("null") ? "":cexcise;

          druglic = ret.getFieldValueString(0,"DRUGLIC");
          druglic = druglic.equals("null") ? "":druglic;

          dmfno = ret.getFieldValueString(0,"DMFNO");
          dmfno = dmfno.equals("null") ? "":dmfno;

          prodCapacity = ret.getFieldValueString(0,"PRODCAPACITY");
          prodCapacity = prodCapacity.equals("null") ? "":prodCapacity;

          turnOver = ret.getFieldValueString(0,"TURNOVER");
          turnOver = turnOver.equals("null") ? "":turnOver;


          man1address1 = retAddress.getFieldValueString(0,"ADDRESS1");
          man1address1 = man1address1.equals("null") ? "":man1address1;

          man1address2 = retAddress.getFieldValueString(0,"ADDRESS2");
          man1address2 = man1address2.equals("null") ? "":man1address2;

          man1city = retAddress.getFieldValueString(0,"CITY");
          man1city = man1city.equals("null") ? "":man1city;

          man1state = retAddress.getFieldValueString(0,"STATE");
          man1state = man1state.equals("null") ? "":man1state;

          man1country = retAddress.getFieldValueString(0,"COUNTRY");
          man1country = man1country.equals("null") ? "":man1country;

          man1zipcode = retAddress.getFieldValueString(0,"ZIPCODE");
          man1zipcode = man1zipcode.equals("null") ? "":man1zipcode;

          man1phone1 = retAddress.getFieldValueString(0,"PHONE1");
          man1phone1 = man1phone1.equals("null") ? "":man1phone1;

          man1phone2 = retAddress.getFieldValueString(0,"PHONE2");
          man1phone2 = man1phone2.equals("null") ? "":man1phone2;

          man1fax = retAddress.getFieldValueString(0,"FAX");
          man1fax = man1fax.equals("null") ? "":man1fax;

          man2address1 = retAddress.getFieldValueString(1,"ADDRESS1");
          man2address1 = man2address1.equals("null") ? "":man2address1;

          man2address2 = retAddress.getFieldValueString(1,"ADDRESS2");
          man2address2 = man2address2.equals("null") ? "":man2address2;

          man2city = retAddress.getFieldValueString(1,"CITY");
          man2city = man2city.equals("null") ? "":man2city;

          man2state = retAddress.getFieldValueString(1,"STATE");
          man2state = man2state.equals("null") ? "":man2state;

          man2country = retAddress.getFieldValueString(1,"COUNTRY");
          man2country = man2country.equals("null") ? "":man2country;

          man2zipcode = retAddress.getFieldValueString(1,"ZIPCODE");
          man2zipcode = man2zipcode.equals("null") ? "":man2zipcode;

          man2phone1 = retAddress.getFieldValueString(1,"PHONE1");
          man2phone1 = man2phone1.equals("null") ? "":man2phone1;

          man2phone2 = retAddress.getFieldValueString(1,"PHONE2");
          man2phone2 = man2phone2.equals("null") ? "":man2phone2;

          man2fax = retAddress.getFieldValueString(1,"FAX");
          man2fax = man2fax.equals("null") ? "":man2fax;

          man3address1 = retAddress.getFieldValueString(2,"ADDRESS1");
          man3address1 = man3address1.equals("null") ? "":man3address1;

          man3address2 = retAddress.getFieldValueString(2,"ADDRESS2");
          man3address2 = man3address2.equals("null") ? "":man3address2;

          man3city = retAddress.getFieldValueString(2,"CITY");
          man3city = man3city.equals("null") ? "":man3city;

          man3state = retAddress.getFieldValueString(2,"STATE");
          man3state = man3state.equals("null") ? "":man3state;

          man3country = retAddress.getFieldValueString(2,"COUNTRY");
          man3country = man3country.equals("null") ? "":man3country;

          man3zipcode = retAddress.getFieldValueString(2,"ZIPCODE");
          man3zipcode = man3zipcode.equals("null") ? "":man3zipcode;

          man3phone1 = retAddress.getFieldValueString(2,"PHONE1");
          man3phone1 = man3phone1.equals("null") ? "":man3phone1;


          man3phone2 = retAddress.getFieldValueString(2,"PHONE2");
          man3phone2 = man3phone2.equals("null") ? "":man3phone2;

          man3fax = retAddress.getFieldValueString(2,"FAX");
          man3fax = man3fax.equals("null") ? "":man3fax;
 	}


	ReturnObjFromRetrieve retFiles = null;
	int filesCount=0;
	String serverFda="";
	String serverMfgLic="";
	String serverIso="";
	String serverWho="";
	String fileName="";
	String fileType="";
	String tempServerFile="";
	String tempFileName="";
	String newTempServerFile="";
System.out.println("**************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**************");
	if(count>0)
	{

		ezc.ezparam.EzcParams listMainParams = null;
		ezc.ezupload.params.EziUploadDocsParams listParams= null;

		listMainParams = new ezc.ezparam.EzcParams(false);
		listParams= new ezc.ezupload.params.EziUploadDocsParams();
		listParams.setObjectNo("'"+sysKey+"PROFILE"+soldTo+"'");
		listMainParams.setObject(listParams);
		Session.prepareParams(listMainParams);
		ReturnObjFromRetrieve retUpload =
(ReturnObjFromRetrieve)UploadManager.getUploadedDocs(listMainParams);

		if(retUpload.getRowCount()>0)
		{

			retFiles = (ReturnObjFromRetrieve)retUpload.getFieldValue(0,"FILES");
			filesCount = retFiles.getRowCount();
			Vector v = new Vector();
			v.addElement("MFGLIC");
			v.addElement("FDA");
			v.addElement("ISO");
			v.addElement("WHO");
System.out.println("**************$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$**************");
			boolean flag=false;
			for(int j=0;j<v.size();j++)
			{


				for(int i=0;i<filesCount;i++)
				{
					flag=false;
					fileType=retFiles.getFieldValueString(i,"TYPE");
					if(fileType.equals((String)v.elementAt(j)))
					{
					    flag=true;
					    tempFileName = retFiles.getFieldValueString(i,"CLIENTFILENAME");
					    newTempServerFile = retFiles.getFieldValueString(i,"SERVERFILENAME");
					    break;
					}

				 }

				if(flag)
				{
                                          tempServerFile =
tempServerFile+newTempServerFile+"#"+(String)v.elementAt(j)+"^";
				          fileName=fileName+tempFileName+"#"+(String)v.elementAt(j)+"^";
				 }
				 else
				 {
				          tempServerFile = tempServerFile+"-#"+(String)v.elementAt(j)+"^";
				          fileName=fileName+"-#"+(String)v.elementAt(j)+"^";
				}


			 }
			 fileName = fileName.substring(0,fileName.length()-1);
			 tempServerFile = tempServerFile.substring(0,tempServerFile.length()-1);

			 StringTokenizer str = new  StringTokenizer(tempServerFile,"^");
			while(str.hasMoreTokens())
			{
			 	String temp = str.nextToken();
				if(temp.indexOf("#MFGLIC")>0)
				{
				    serverMfgLic = temp.substring(0,temp.indexOf("#MFGLIC"));
				    serverMfgLic = serverMfgLic.equals("-")?"¥":serverMfgLic;
				}
				else if(temp.indexOf("#FDA")>0)
				{
				    serverFda = temp.substring(0,temp.indexOf("#FDA"));
				    serverFda = serverFda.equals("-")?"¥":serverFda;
				}
				else if(temp.indexOf("#ISO")>0)
				{
				    serverIso = temp.substring(0,temp.indexOf("#ISO"));
				    serverIso = serverIso.equals("-")?"¥":serverIso;
				}
				else if(temp.indexOf("#WHO")>0)
				{
				    serverWho = temp.substring(0,temp.indexOf("#WHO"));
				    serverWho = serverWho.equals("-")?"¥":serverWho;
				}
			}
		}

      }


%>
