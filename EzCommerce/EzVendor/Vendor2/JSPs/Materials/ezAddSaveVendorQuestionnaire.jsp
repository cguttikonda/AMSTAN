<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import = "ezc.ezparam.*"%>
<%@ page import = "ezc.ezutil.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<jsp:useBean id="UploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session"></jsp:useBean>

<%

   String[] files = request.getParameterValues("n1");	

   String sysKey= (String) session.getValue("SYSKEY");
   String soldTo =  (String) session.getValue("SOLDTO");

   String prods = request.getParameter("prodsManufactured"); 
   String customers = request.getParameter("majorCustomers"); 

   ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
    mainParams.setLocalStore("Y");	    
    ezc.ezvendorapp.params.EzVendorQuestionnaireStructure struct =  new ezc.ezvendorapp.params.EzVendorQuestionnaireStructure();
       
   struct.setSoldTo(soldTo.trim());
   struct.setSysKey(sysKey);
   struct.setMaterialDesc(request.getParameter("materialDesc"));
   struct.setCompanyAddressId("0");
   struct.setMktContactName(request.getParameter("mktName"));
   struct.setMktContactDesignation(request.getParameter("mktDesig"));
   struct.setMktContactPhone1(request.getParameter("mktPhone1"));
   struct.setMktContactPhone2(request.getParameter("mktPhone2"));
   struct.setMktContactFax(request.getParameter("mktFax"));
   struct.setMktContactEmail(request.getParameter("mktEmail"));
   struct.setQaContactName(request.getParameter("qaName"));
   struct.setQaContactDesig(request.getParameter("qaDesig"));
   struct.setQaContactPhone1(request.getParameter("qaPhone1"));
   struct.setQaContactPhone2(request.getParameter("qaPhone2"));
   struct.setQaContactFax(request.getParameter("qaFax"));
   struct.setQaContactEmail(request.getParameter("qaEmail"));
   struct.setMfgCapacity(request.getParameter("mfgCapacity"));
   struct.setTotalCapacity(request.getParameter("totCapacity"));
   struct.setPctgSupply(request.getParameter("perSupply"));
   struct.setIsPrimeMfr(request.getParameter("chk1"));
    
   String otherFlag="Y";
   if(prods.trim().equals("") && customers.trim().equals(""))
   {
       otherFlag="N";
   }  	
   
   struct.setIsOtherDetails(otherFlag);
   
   String isCertified="N";
   for(int i=0;i<files.length;i++)
   {
	if(!files[i].equals(""))
	{
   	   isCertified="Y";
   	   break;
   	}
   }	
   
   String fileName=request.getParameter("fileName");
   if(!fileName.equals(""))
   {
   	isCertified="Y";
   }
   
   struct.setIsCertified(isCertified);
   struct.setCertUploadId("0");
   
   String iso = request.getParameter("chk21");
   String who = request.getParameter("chk22");
   String gmp = request.getParameter("chk23");
   String fda = request.getParameter("chk24");
   
   struct.setIso(iso);
   struct.setWho(who);
   struct.setGmp(gmp);
   struct.setFda(fda);
   struct.setOther(request.getParameter("Other"));
   struct.setEmpTraining(request.getParameter("chk31"));
   struct.setHouseKeeping(request.getParameter("chk32"));
   struct.setEqDedicated(request.getParameter("chk33"));
   struct.setEqMultiPur(request.getParameter("chk34"));
   struct.setEqWpMaint(request.getParameter("chk35"));
   struct.setEqWpClean(request.getParameter("chk36"));
   struct.setEqWpCallib(request.getParameter("chk37"));
   struct.setEqAbvDoc(request.getParameter("chk38"));
   struct.setMfrTseCert(request.getParameter("chk41"));
   struct.setMfrIsPencillins(request.getParameter("chk42"));
   struct.setMfrIsStOpProc(request.getParameter("chk43"));
   struct.setMfrIsAbnormal(request.getParameter("chk44"));
   struct.setQcTestProc(request.getParameter("chk45"));
   struct.setQcSpecs(request.getParameter("chk46"));
   struct.setQcStatMethods(request.getParameter("chk47"));
   struct.setSheIsoAdapted(request.getParameter("chk51"));
   struct.setSheWaterAct(request.getParameter("chk52"));
   struct.setSheAirAct(request.getParameter("chk53"));
   struct.setSheWasteMgmt(request.getParameter("chk54"));
   struct.setMiscTest(request.getParameter("chk55"));
   struct.setMiscCert(request.getParameter("chk56"));
   struct.setMiscSop(request.getParameter("chk57"));
   struct.setExt1("");
   struct.setExt2("");
       
   mainParams.setObject(struct);	
   Session.prepareParams(mainParams);

   ezc.ezparam.ReturnObjFromRetrieve ret=null;
   ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezAddVendorQuestionnaire(mainParams);
  String materialId = ret.getFieldValueString(0,"MATERIALID");

	   ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
	   oParams.setLocalStore("Y");	    
	   ezc.ezupload.params.EziDocumentTextsTable docTable =  new ezc.ezupload.params.EziDocumentTextsTable();
	   ezc.ezupload.params.EziDocumentTextsTableRow docTableRow =  null;
      
	   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
	   docTableRow.setDocType("QUESTIONNAIRE");
	   docTableRow.setDocNo(materialId);
	   docTableRow.setSysKey(sysKey);
	   docTableRow.setKey("PRODSOFFERED");
	   docTableRow.setValue(prods);
	   docTable.appendRow(docTableRow);
   
   	   docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
	   docTableRow.setDocType("QUESTIONNAIRE");
	   docTableRow.setDocNo(materialId);
	   docTableRow.setSysKey(sysKey);
	   docTableRow.setKey("CUSTOMERS");
	   docTableRow.setValue(customers);
	   docTable.appendRow(docTableRow);

	   oParams.setObject(docTable);	
	   Session.prepareParams(oParams);
	   UploadManager.addDocumentText(oParams);


        
	String today=FormatDate.getStringFromDate(new java.util.Date(),".",FormatDate.DDMMYYYY);	

	ezc.ezparam.EzcParams addMainParams = null;
	ezc.ezupload.params.EziUploadDocsParams addParams= null;

	ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
	ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;

        addMainParams = new ezc.ezparam.EzcParams(false);
	addParams= new ezc.ezupload.params.EziUploadDocsParams();
	addParams.setSysKey(sysKey);
	addParams.setObjectType("VENDORQUES");
	addParams.setObjectNo(materialId);
	addParams.setStatus("");
	addParams.setCreatedOn(today);
	addParams.setCreatedBy(Session.getUserId());
	addParams.setUploadDirectory(uploadTempDir+session.getId());
	addMainParams.setObject(addParams);



	 /* String isoFile = files[0]; 	
	    if(!isoFile.equals(""))	
	    {	
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("ISO");
		rowParams.setClientFileName(isoFile);
		tabParams.appendRow(rowParams);
            }

	    String whoFile = files[1]; 	
	    if(!whoFile.equals(""))	
	    {	

		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("WHO");
		rowParams.setClientFileName(whoFile);
		tabParams.appendRow(rowParams);
            } */

	    String gmpFile = files[0]; 	
	    if(!gmpFile.equals(""))	
	    {	
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("GMP");
		rowParams.setClientFileName(gmpFile);
		tabParams.appendRow(rowParams);
            } 

	  /* String fdaFile = files[3]; 	
	    if(!fdaFile.equals(""))	
	    {	
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("FDA");
		rowParams.setClientFileName(fdaFile);
		tabParams.appendRow(rowParams);
            } */
            
	    if(!fileName.equals("") || !fileName.equals("-"))	
	    {	
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("LOU");
		rowParams.setClientFileName(fileName);
		tabParams.appendRow(rowParams);
            } 
            

	addMainParams.setObject(tabParams);
	Session.prepareParams(addMainParams);
	UploadManager.uploadDoc(addMainParams);

	String msgSubject="VendorQuestionnaire Added";
	String msgText="This mail is to inform that new VendorQuestionnaire has been posted";

%>

<%@include file="../Materials/ezSendMail.jsp"%>

<%
        response.sendRedirect("ezListVendorQuestionnaire.jsp");

%>
<Div id="MenuSol"></Div>
