
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session">
</jsp:useBean>

<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session">
</jsp:useBean>

<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>


<%

    String sysKey = request.getParameter("SysKey");
    String soldTo = request.getParameter("SoldTo");

    String organogram = request.getParameter("organogram");
    String companyDetails = request.getParameter("companyDetails");
    String bankerDetails = request.getParameter("BankerDetails");
    String products = request.getParameter("Products");
    String developments = request.getParameter("Developments");

    String manAddress1Id = request.getParameter("ManAddress1Id");
    String manAddress2Id = request.getParameter("ManAddress2Id");
    String manAddress3Id = request.getParameter("ManAddress3Id");

//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+manAddress1Id+">>>>>>>>>>>>>");
//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+manAddress2Id+">>>>>>>>>>>>>");
//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+manAddress3Id+">>>>>>>>>>>>>");

    String isEdit = request.getParameter("editPage");
    String isCompanyDetails = "Y";

    if(organogram.trim().equals("") && companyDetails.trim().equals("") && bankerDetails.trim().equals("") && products.trim().equals("") && developments.trim().equals(""))
    {
    	isCompanyDetails="N";
    }

    ezc.ezupload.params.EziAddressTable table = new ezc.ezupload.params.EziAddressTable();
    ezc.ezupload.params.EziAddressTableRow tableRow = null;

    tableRow = new ezc.ezupload.params.EziAddressTableRow();
    if(isEdit.equals("Y"))
    {
    	tableRow.setNo(manAddress1Id);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>> Address No"+tableRow.getNo()+">>>>>>>>>>>>>");
    }

    tableRow.setCompanyName("");
    tableRow.setAddress1(request.getParameter("man1add1"));
    tableRow.setAddress2(request.getParameter("man1add2"));
    tableRow.setCity(request.getParameter("man1city"));
    tableRow.setState(request.getParameter("man1state"));
    tableRow.setCountry(request.getParameter("man1country"));
    tableRow.setZipCode(request.getParameter("man1zip"));
    tableRow.setPhone1(request.getParameter("man1phone1"));
    tableRow.setPhone2(request.getParameter("man1phone2"));
    tableRow.setFax(request.getParameter("man1fax"));
    tableRow.setURL("");
    tableRow.setLang("EN");
    tableRow.setEMail("");
    tableRow.setDistrict("");
    tableRow.setMobile("");
    tableRow.setExt1("");
    tableRow.setExt2("");
    tableRow.setExt3("");
    table.appendRow(tableRow);


    tableRow = new ezc.ezupload.params.EziAddressTableRow();
    if(isEdit.equals("Y"))
    {
    	tableRow.setNo(manAddress2Id);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+tableRow.getNo()+">>>>>>>>>>>>>");
    }

    tableRow.setCompanyName("");
    tableRow.setAddress1(request.getParameter("man2add1"));
    tableRow.setAddress2(request.getParameter("man2add2"));
    tableRow.setCity(request.getParameter("man2city"));
    tableRow.setState(request.getParameter("man2state"));
    tableRow.setCountry(request.getParameter("man2country"));
    tableRow.setZipCode(request.getParameter("man2zip"));
    tableRow.setPhone1(request.getParameter("man2phone1"));
    tableRow.setPhone2(request.getParameter("man2phone2"));
    tableRow.setFax(request.getParameter("man2fax"));
    tableRow.setURL("");
    tableRow.setLang("EN");
    tableRow.setEMail("");
    tableRow.setDistrict("");
    tableRow.setMobile("");
    tableRow.setExt1("");
    tableRow.setExt2("");
    tableRow.setExt3("");
    table.appendRow(tableRow);


    tableRow = new ezc.ezupload.params.EziAddressTableRow();
    if(isEdit.equals("Y"))
    {
        tableRow.setNo(manAddress3Id);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+tableRow.getNo()+">>>>>>>>>>>>>");
    }

    tableRow.setCompanyName("");
    tableRow.setAddress1(request.getParameter("man3add1"));
    tableRow.setAddress2(request.getParameter("man3add2"));
    tableRow.setCity(request.getParameter("man3city"));
    tableRow.setState(request.getParameter("man3state"));
    tableRow.setCountry(request.getParameter("man3country"));
    tableRow.setZipCode(request.getParameter("man3zip"));
    tableRow.setPhone1(request.getParameter("man3phone1"));
    tableRow.setPhone2(request.getParameter("man3phone2"));
    tableRow.setFax(request.getParameter("man3fax"));
    tableRow.setURL("");
    tableRow.setLang("EN");
    tableRow.setEMail("");
    tableRow.setDistrict("");
    tableRow.setMobile("");
    tableRow.setExt1("");
    tableRow.setExt2("");
    tableRow.setExt3("");
    table.appendRow(tableRow);

    ezc.ezparam.EzcParams eParams = new ezc.ezparam.EzcParams(true);
    eParams.setLocalStore("Y");
    eParams.setObject(table);
    Session.prepareParams(eParams);

   ezc.ezparam.ReturnObjFromRetrieve retAddress=null;
   if(isEdit.equals("N"))
   {
      retAddress= (ezc.ezparam.ReturnObjFromRetrieve)UploadManager.addAddress(eParams);
      manAddress1Id=retAddress.getFieldValueString(0,"ADDRNO");
      manAddress2Id=retAddress.getFieldValueString(1,"ADDRNO");
      manAddress3Id=retAddress.getFieldValueString(2,"ADDRNO");
   }
   else
   {
     UploadManager.updateAddress(eParams);
   }



   ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
   oParams.setLocalStore("Y");
   ezc.ezupload.params.EziDocumentTextsTable docTable =  new ezc.ezupload.params.EziDocumentTextsTable();
   ezc.ezupload.params.EziDocumentTextsTableRow docTableRow =  null;

   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   docTableRow.setDocType("VENDORPROFILE");
   docTableRow.setDocNo(soldTo);
   docTableRow.setSysKey(sysKey);
   docTableRow.setKey("ORGANOGRAM");
   docTableRow.setValue(organogram);
   docTable.appendRow(docTableRow);

   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   docTableRow.setDocType("VENDORPROFILE");
   docTableRow.setDocNo(soldTo);
   docTableRow.setSysKey(sysKey);
   docTableRow.setKey("COMPANYDETAILS");
   docTableRow.setValue(companyDetails);
   docTable.appendRow(docTableRow);

   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   docTableRow.setDocType("VENDORPROFILE");
   docTableRow.setDocNo(soldTo);
   docTableRow.setSysKey(sysKey);
   docTableRow.setKey("BANKERDETAILS");
   docTableRow.setValue(bankerDetails);
   docTable.appendRow(docTableRow);


   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   docTableRow.setDocType("VENDORPROFILE");
   docTableRow.setDocNo(soldTo);
   docTableRow.setSysKey(sysKey);
   docTableRow.setKey("PRODSOFFERED");
   docTableRow.setValue(products);
   docTable.appendRow(docTableRow);


   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
   docTableRow.setDocType("VENDORPROFILE");
   docTableRow.setDocNo(soldTo);
   docTableRow.setSysKey(sysKey);
   docTableRow.setKey("NEWDEVELOPMENTS");
   docTableRow.setValue(developments);
   docTable.appendRow(docTableRow);

   oParams.setObject(docTable);
   Session.prepareParams(oParams);

   if(isEdit.equals("N"))
   {
      	UploadManager.addDocumentText(oParams);
   }
   else
   {
   	UploadManager.updateDocumentText(oParams);
   }


   ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(true);
   mainParams1.setLocalStore("Y");
   ezc.ezvendorapp.params.EzVendorProfileStructure struct =  new ezc.ezvendorapp.params.EzVendorProfileStructure();

   struct.setManAddress1Id(manAddress1Id);
   struct.setManAddress2Id(manAddress2Id);
   struct.setManAddress3Id(manAddress3Id);

   struct.setIsCompanyDetails(isCompanyDetails);

   struct.setContactPerson(request.getParameter("contperson"));
   struct.setDesignation(request.getParameter("desig"));
   struct.setPhone1(request.getParameter("phone1"));
   struct.setPhone2(request.getParameter("phone2"));
   struct.setFax(request.getParameter("fax"));
   struct.setEmail(request.getParameter("email"));

   struct.setSalesTax(request.getParameter("SalestaxNo"));
   struct.setCExcise(request.getParameter("CentralExciseNo"));
   struct.setDrugLic(request.getParameter("LicenseNo"));
   struct.setDmfNo(request.getParameter("DMFNo"));
   struct.setProdCapacity(request.getParameter("prodCapacity"));
   struct.setTurnOver(request.getParameter("TurnOver"));

   struct.setSysKey(sysKey);
   struct.setSoldTo(soldTo);

   mainParams1.setObject(struct);
   Session.prepareParams(mainParams1);

   ezc.ezparam.ReturnObjFromRetrieve ret=null;


   if(isEdit.equals("N"))
   {
      ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezAddVendorProfile(mainParams1);
   }
   else
   {
     ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezUpdateVendorProfile(mainParams1);
   }


   String fileName=request.getParameter("fileName");

   String serverFda = request.getParameter("serverFda");
   String serverMfgLic = request.getParameter("serverMfgLic");
   String serverIso = request.getParameter("serverIso");
   String serverWho = request.getParameter("serverWho");

   if(serverFda.equals(""))
	serverFda="¥";

  if(serverMfgLic.equals(""))
      serverMfgLic="¥";

  if(serverIso.equals(""))
      serverIso="¥";

  if(serverWho.equals(""))
      serverWho="¥";


   Date d=new Date();
   SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
   String SysDate=sdf.format(d);

   
   ezc.ezparam.EzcParams addDocMainParams = null;
   ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();

   java.util.StringTokenizer st = new java.util.StringTokenizer(fileName,"^");
   ezc.ezupload.params.EziUploadDocsParams addParams= null;
   ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;

   addDocMainParams = new ezc.ezparam.EzcParams(false);
   addParams= new ezc.ezupload.params.EziUploadDocsParams();
   addParams.setSysKey(sysKey);
   addParams.setObjectType("PROFILE");
   addParams.setObjectNo(soldTo);
   addParams.setStatus("");
   addParams.setCreatedOn(SysDate);
   addParams.setCreatedBy(Session.getUserId());
   addParams.setUploadDirectory(uploadTempDir+session.getId());
   addDocMainParams.setObject(addParams);

   if(!fileName.equals(""))
   {

 	String mfgLic = st.nextToken();
	mfgLic = mfgLic.substring(0,mfgLic.indexOf("#"));
        if(!mfgLic.equals("-"))
	{
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("MFGLIC");
		rowParams.setClientFileName(mfgLic);
	 	rowParams.setServerFileName(serverMfgLic);
		tabParams.appendRow(rowParams);
	}

	String fda = st.nextToken();
        fda = fda.substring(0,fda.indexOf("#"));
	if(!fda.equals("-"))
	{
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("FDA");
	 	rowParams.setClientFileName(fda);
	 	rowParams.setServerFileName(serverFda);
	 	tabParams.appendRow(rowParams);
        }

	String iso = st.nextToken();
        iso = iso.substring(0,iso.indexOf("#"));
	if(!iso.equals("-"))
	{
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("ISO");
	 	rowParams.setClientFileName(iso);
	 	rowParams.setServerFileName(serverIso);
	 	tabParams.appendRow(rowParams);
        }

	String who = st.nextToken();
        who = who.substring(0,who.indexOf("#"));
	if(!who.equals("-"))
	{
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("WHO");
	 	rowParams.setClientFileName(who);
	 	rowParams.setServerFileName(serverWho);
	 	tabParams.appendRow(rowParams);
        }


   }

   addDocMainParams.setObject(tabParams);
   Session.prepareParams(addDocMainParams);
   if(isEdit.equals("N"))
   {
	UploadManager.uploadDoc(addDocMainParams);
   }
   else
   {
	UploadManager.updateDoc(addDocMainParams);
   }
  
   
   Hashtable mailData = new Hashtable();
   String msgType = "CHGPROFILE";
   boolean sendToExt = true ;  
   boolean isVendor  = true;	
      		
   mailData.put((String)session.getValue("SOLDTO"),(String)session.getValue("Vendor"));
   
   response.sendRedirect("../Shipment/ezMessage.jsp?Msg=Thank you for entering Vendor Profile.");
                            
   
%>
<%@include file="../Purorder/ezSendMailCounter.jsp"%>
	
<Div id="MenuSol"></Div>
