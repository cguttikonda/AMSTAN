<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>

<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>

<%@ page import = "ezc.ezvendorapp.client.*" %>
<%@ page import = "ezc.ezvendorapp.params.*" %>

<%@ page import = "ezc.ezutil.FormatDate"%>

<%@ page import = "ezc.ezupload.client.*" %>
<%@ page import = "ezc.ezupload.params.*" %>

<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session" />

<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	String type=request.getParameter("type");

	String fileName=request.getParameter("fileName");
	String isAttachments="N";

	if(!fileName.equals(""))
	{
	   isAttachments="Y";
	}

	String materialDesc=request.getParameter("MaterialDesc");
	String addressId=request.getParameter("sites");
	String suppAddressId="0";

	if(type.equals("S"))
	{
		ezc.ezupload.params.EziAddressTable table = new ezc.ezupload.params.EziAddressTable();
    		ezc.ezupload.params.EziAddressTableRow tableRow = null;

    		tableRow = new ezc.ezupload.params.EziAddressTableRow();
		tableRow.setCompanyName("");
  		tableRow.setAddress1(request.getParameter("mfgaddress1"));
    		tableRow.setAddress2(request.getParameter("mfgaddress2"));
    		tableRow.setCity(request.getParameter("mfgcity"));
    		tableRow.setState(request.getParameter("mfgstate"));
    		tableRow.setCountry(request.getParameter("mfgcountry"));
    		tableRow.setZipCode(request.getParameter("mfgzip"));
    		tableRow.setPhone1(request.getParameter("mfgphone1"));
    		tableRow.setPhone2(request.getParameter("mfgphone2"));
    		tableRow.setFax(request.getParameter("mfgfax"));
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
		tableRow.setCompanyName(request.getParameter("suppcompanyName"));
  		tableRow.setAddress1(request.getParameter("suppaddress1"));
    		tableRow.setAddress2(request.getParameter("suppaddress2"));
    		tableRow.setCity(request.getParameter("suppcity"));
    		tableRow.setState(request.getParameter("suppstate"));
    		tableRow.setCountry(request.getParameter("suppcountry"));
    		tableRow.setZipCode(request.getParameter("suppzip"));
    		tableRow.setPhone1(request.getParameter("suppphone1"));
    		tableRow.setPhone2(request.getParameter("suppphone2"));
    		tableRow.setFax(request.getParameter("suppfax"));
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
		retAddress= (ezc.ezparam.ReturnObjFromRetrieve)EzUploadManager.addAddress(eParams);
      		addressId=retAddress.getFieldValueString(0,"ADDRNO");
      		suppAddressId=retAddress.getFieldValueString(1,"ADDRNO");
	}

	String materialSpec = request.getParameter("materialSpec");

	EzShipmentHeaderStructure inStructHeader=new EzShipmentHeaderStructure();
	EzcParams shipParams=new EzcParams(true);
	EzShipmentManager shipManager= new EzShipmentManager();

	String currSysKey = (String)session.getValue("SYSKEY");
	String defErpVendor =  (String)session.getValue("SOLDTO");

	inStructHeader.setStatus("Y");						//Y-Submitted
	String dcno=request.getParameter("DeliveryChallan");
	String ponum="Samples"; 									//PONUMBER is hard coded
	String invno=request.getParameter("InvoiceNo");
	String lrno = request.getParameter("LR");
	String cname=request.getParameter("CarrierName");
	String expTime=request.getParameter("ExpectedArivalTime");
	String podate="";											//PODATE is sent space;
	String dcdate=request.getParameter("DCDate");
	String fdate=(String)session.getValue("DATEFORMAT");
	dcdate=dateConvertion(dcdate,fdate);
	String invdate=request.getParameter("InvoiceDate");
	invdate=dateConvertion(invdate,fdate);
	String shipdate=request.getParameter("ShipDate");
	shipdate=dateConvertion(shipdate,fdate);
	String expecdate=request.getParameter("ExpectedArivalTime");
	expecdate=dateConvertion(expecdate,fdate);

	String bat[]=request.getParameterValues("Line");
	String uom[]=request.getParameterValues("UOM");
	String qty[]=request.getParameterValues("QTY");

	double totalqty =0;

	for(int i=0;i<bat.length;i++)
	{
	    if(!bat[i].equals(""))
	    {
		totalqty=totalqty+Double.parseDouble(qty[i]);
	    }
	}


	dcno =dcno.replace('\'','`') ;
	invno = invno.replace('\'','`');
	lrno=lrno.replace('\'','`');
	cname = cname.replace('\'','`');


	invno=invno.replace('\'','`');

	String today=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);

	inStructHeader.setPurchaseOrderNumber(ponum);
	inStructHeader.setType("M");						//Type is  hardcoded M-Samples
	inStructHeader.setPurchaseOrderDate(podate);
	inStructHeader.setDeliveryChallanNumber(dcno);
	inStructHeader.setDeliveryChallanDate(dcdate);
	inStructHeader.setPurchaseOrderRev("NO");
	inStructHeader.setInvoiceNumber(invno);
	inStructHeader.setInvoiceDate(invdate);
	inStructHeader.setCreatedBy(Session.getUserId());
	inStructHeader.setCreatedOn(today);
	inStructHeader.setLastModifiedOn(today);
	inStructHeader.setLr_rr_air_nr(lrno);
	inStructHeader.setShipmentDate(shipdate);
	inStructHeader.setCarrier(cname);
	inStructHeader.setExpectedArivalTime(expecdate);

	String generalInfo = request.getParameter("generalInfo");
	//generalInfo=generalInfo.replace('\'','`');

	inStructHeader.setText(generalInfo);
	inStructHeader.setDocsAttached("N");
	inStructHeader.setUploadId("0");
	inStructHeader.setSysKey(currSysKey);
	inStructHeader.setSoldTo(defErpVendor);
	inStructHeader.setExt1("");
	inStructHeader.setExt2("");
	inStructHeader.setExt3("");

	shipParams.setLocalStore("Y");

	EzShipmentLinesTable ezTable= new EzShipmentLinesTable();
	EzShipmentLinesTableRow linesRow =null;

	linesRow = new EzShipmentLinesTableRow();
	linesRow.setLineNumber("1");					//Hardcoded to 1
	linesRow.setMaterialNumber("");
	linesRow.setMaterialDesc(materialDesc);
	linesRow.setUomQuantity("");		//This field is not required in line level
	linesRow.setQuantityShipped(String.valueOf(totalqty));
	linesRow.setAttachments("N");			//hard coded presently this is for attachments
	linesRow.setUploadId("0");
	linesRow.setExt1("");
	linesRow.setExt2("");
	ezTable.insertRow(0,linesRow);


	EzShipmentSchedulesTable shTable= new EzShipmentSchedulesTable();
	EzShipmentSchedulesTableRow shTableRow =null;

	for(int i=0;i<bat.length;i++)
	{
	    if(!bat[i].equals(""))
	    {
		shTableRow = new EzShipmentSchedulesTableRow();
		shTableRow.setLineNumber("1");
		shTableRow.setScheduleLine(String.valueOf(i+1));
		shTableRow.setBatch(bat[i]);
		shTableRow.setBatchQty(qty[i]);
		shTableRow.setMfgDate("");
		shTableRow.setExpDate("");
		shTableRow.setAttachments("N");
		shTableRow.setUploadId("0");
		shTableRow.setExt1(uom[i]);			//This Ext1 is used to store UOM's of each Schedule
		shTableRow.setExt2("");
		shTable.insertRow(0,shTableRow);
	    }
	}


	shipParams.setObject(inStructHeader);
	shipParams.setObject(ezTable);
	shipParams.setObject(shTable);
	Session.prepareParams(shipParams);
	ReturnObjFromRetrieve shipid=(ReturnObjFromRetrieve)shipManager.ezAddShipmentInfo(shipParams);
	//out.println("*********SHIPID**********"+shipid);
	//out.println("*********SHIPID COUNT*********"+shipid.getRowCount());
	//out.println(shipid.toEzcString());



EzSampleMaterialStructure inStructSample=new EzSampleMaterialStructure();
EzcParams sampleParams=new EzcParams(true);
EzVendorAppManager vendorManager= new EzVendorAppManager();

inStructSample.setMaterialId(materialDesc);
inStructSample.setSoldTo(defErpVendor);
inStructSample.setSysKey(currSysKey);
inStructSample.setPoNo("Samples");
inStructSample.setPoDate("");
//inStructSample.setMaterialName(materialDesc);

String isMatSpec="N";
if(!materialSpec.equals(""))
{
	isMatSpec="Y";
}

inStructSample.setIsMatsSpecs(isMatSpec);
inStructSample.setSubmissionDate(today);
inStructSample.setMsAddrId(addressId);
inStructSample.setSupplierAddrId(suppAddressId);
inStructSample.setShipmentId(shipid.getFieldValueString(0,"SH_ID"));
inStructSample.setAttachments(isAttachments);
inStructSample.setUploadId("0");
inStructSample.setExt1("");
inStructSample.setExt2("");
sampleParams.setLocalStore("Y");
sampleParams.setObject(inStructSample);
Session.prepareParams(sampleParams);
ReturnObjFromRetrieve retSample = (ReturnObjFromRetrieve)vendorManager.ezAddSampleMaterial(sampleParams);
String SampleId = retSample.getFieldValueString(0,"SAMPLEID");


ezc.ezparam.EzcParams coaParams = new ezc.ezparam.EzcParams(true);
coaParams.setLocalStore("Y");
ezc.ezshipment.params.EzCOATable coaTable =  new ezc.ezshipment.params.EzCOATable();
ezc.ezshipment.params.EzCOATableRow coaTableRow =  null;

String[] coaData = request.getParameterValues("coaData");
StringTokenizer coaDataSt = null;
String mainFieldValue="";
for(int i=0;i<coaData.length;i++)
{
  if(!bat[i].equals("")) 	
  {	
	System.out.println(">>>>>>>>Sudhir"+coaData[i]);
    if(!coaData[i].equals(""))
    {

          coaDataSt = new StringTokenizer(coaData[i],"§");
          coaTableRow =  new ezc.ezshipment.params.EzCOATableRow();

          coaTableRow.setDocumentNo(SampleId);
	  coaTableRow.setItemNumber("1");				//	Item hardcoded bcoz there will only one item all the time.
	  coaTableRow.setLineNumber(String.valueOf(i+1));

  	  mainFieldValue = coaDataSt.nextToken();
  	  mainFieldValue = mainFieldValue.equals("-") ? "":mainFieldValue;
          coaTableRow.setArNumber(mainFieldValue);

          mainFieldValue = coaDataSt.nextToken();
  	  mainFieldValue = mainFieldValue.equals("-") ? "":dateConvertion(mainFieldValue,fdate);
	  coaTableRow.setDateOfAnalysis(mainFieldValue);

	  mainFieldValue = coaDataSt.nextToken();
  	  mainFieldValue = mainFieldValue.equals("-") ? "":dateConvertion(mainFieldValue,fdate);
	  coaTableRow.setDateOfMfg(mainFieldValue);

	  mainFieldValue = coaDataSt.nextToken();
  	  mainFieldValue = mainFieldValue.equals("-") ? "":mainFieldValue;
  	  coaTableRow.setBoxes(mainFieldValue);

  	  mainFieldValue = coaDataSt.nextToken();
	  mainFieldValue = mainFieldValue.equals("-") ? "":mainFieldValue;
  	  coaTableRow.setSpecNumber(mainFieldValue);

  	  coaTableRow.setExt1("");
  	  coaTableRow.setExt2("");
	  coaTable.appendRow(coaTableRow);

     }
   }
 }

 coaParams.setObject(coaTable);
 Session.prepareParams(coaParams);
 shipManager.ezAddCOA(coaParams);

 ezc.ezparam.EzcParams oParams = new ezc.ezparam.EzcParams(true);
 oParams.setLocalStore("Y");
 ezc.ezupload.params.EziDocumentTextsTable docTable =  new ezc.ezupload.params.EziDocumentTextsTable();
 ezc.ezupload.params.EziDocumentTextsTableRow docTableRow =  null;

 if(isMatSpec.equals("Y"))
 {

 	docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
 	docTableRow.setDocType("SAMPLES");
 	docTableRow.setDocNo(SampleId);
 	docTableRow.setSysKey(currSysKey);
 	docTableRow.setKey("MATERIALSPEC");
 	docTableRow.setValue(materialSpec);
 	docTable.appendRow(docTableRow);
 }

 String[] coaFields = new String[9];
 coaFields[0] = "DESCRIPTION";
 coaFields[1] = "DIMLENGTH";
 coaFields[2] = "DIMWIDTH";
 coaFields[3] = "DIMHEIGHT";
 coaFields[4] = "GRAMMAGE";
 coaFields[5] = "FLAPCUTTING";
 coaFields[6] = "PRINTING";
 coaFields[7] = "SHADE";
 coaFields[8] = "AQLDEFECTS";
 String[] coaValues = request.getParameterValues("coaLong");
 StringTokenizer coaSt = null;
 String fieldValue="";
 for(int i=0;i<coaValues.length;i++)
 {
   if(!bat[i].equals("")) 	
   {	
    if(!coaValues[i].equals(""))
    {
          coaSt = new StringTokenizer(coaValues[i],"§");
          for(int j=0;j<coaFields.length;j++)
          {
    		 fieldValue = coaSt.nextToken();
        	 if(!fieldValue.equals("-"))
        	 {
		     docTableRow =  new ezc.ezupload.params.EziDocumentTextsTableRow();
		     docTableRow.setDocType("SAMPLES");
		     docTableRow.setDocNo(SampleId+"COA"+String.valueOf(i+1));
		     docTableRow.setSysKey(currSysKey);
		     docTableRow.setKey(coaFields[j]);
		     docTableRow.setValue(fieldValue);
		     docTable.appendRow(docTableRow);
		 }
	   }
     }
  }

 }

 oParams.setObject(docTable);
 Session.prepareParams(oParams);
 EzUploadManager.addDocumentText(oParams);


if(!fileName.equals(""))
{

  //String today=FormatDate.getStringFromDate(new java.util.Date(),".",FormatDate.DDMMYYYY);
  java.util.StringTokenizer st = new java.util.StringTokenizer(fileName,"^");

  ezc.ezparam.EzcParams addDocMainParams = null;
  ezc.ezupload.params.EziUploadDocsParams addParams= null;

  ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
  ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;

  addDocMainParams = new ezc.ezparam.EzcParams(false);
  addParams= new ezc.ezupload.params.EziUploadDocsParams();
  addParams.setSysKey(currSysKey);
  addParams.setObjectType("SAMPLES");
  addParams.setObjectNo(SampleId);
  addParams.setStatus("");
  addParams.setCreatedOn(today);
  addParams.setCreatedBy(Session.getUserId());
  addParams.setUploadDirectory(uploadTempDir+session.getId());
  addDocMainParams.setObject(addParams);

       String pfd = st.nextToken();
       if(!pfd.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
		rowParams.setType("PFD");
		rowParams.setClientFileName(pfd);
		tabParams.appendRow(rowParams);
       }

       String reactmech = st.nextToken();
       if(!reactmech.equals("-"))
       {
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("REACTMECH");
	 	rowParams.setClientFileName(reactmech);
	 	tabParams.appendRow(rowParams);

       }

       String spec= st.nextToken();
       if(!spec.equals("-"))
       {
 		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("SPEC");
 		rowParams.setClientFileName(spec);
 		tabParams.appendRow(rowParams);
       }

       String procdesc = st.nextToken();
       if(!procdesc.equals("-"))
       {

 		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("PROCDESC");
 		rowParams.setClientFileName(procdesc);
 		tabParams.appendRow(rowParams);
 	}

       String metofanal = st.nextToken();
       if(!metofanal.equals("-"))
       {

	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("METOFANAL");
	 	rowParams.setClientFileName(metofanal);
	 	tabParams.appendRow(rowParams);
        }

       String matsafety = st.nextToken();
       if(!matsafety.equals("-"))
       {
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("MATSAFETY");
	 	rowParams.setClientFileName(matsafety);
	 	tabParams.appendRow(rowParams);
	}


       String stabilityData = st.nextToken();
       if(!stabilityData.equals("-"))
       {
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("STABLEDATA");
	 	rowParams.setClientFileName(stabilityData);
	 	tabParams.appendRow(rowParams);
	}

       String dcdoc= st.nextToken();
       if(!dcdoc.equals("-"))
       {
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("DCDOC");
	 	rowParams.setClientFileName(dcdoc);
	 	tabParams.appendRow(rowParams);
        }


       String lrdoc= st.nextToken();
       if(!lrdoc.equals("-"))
       {

		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("LRDOC");
	 	rowParams.setClientFileName(lrdoc);
	 	tabParams.appendRow(rowParams);
       }

       String packdoc= st.nextToken();
       if(!packdoc.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	  	rowParams.setType("PACKDOC");
	  	rowParams.setClientFileName(packdoc);
	  	tabParams.appendRow(rowParams);
       }

       String invdoc= st.nextToken();
       if(!invdoc.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("INVDOC");
 		rowParams.setClientFileName(invdoc);
 		tabParams.appendRow(rowParams);
       }

       String impProfile= st.nextToken();
       if(!impProfile.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("IMPPROFILE");
 		rowParams.setClientFileName(impProfile);
 		tabParams.appendRow(rowParams);
       }

       String solventList= st.nextToken();
       if(!solventList.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("SOLVENT");
 		rowParams.setClientFileName(solventList);
 		tabParams.appendRow(rowParams);
       }

       String chromotogram= st.nextToken();
       if(!chromotogram.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("CHROMOTOGRAM");
 		rowParams.setClientFileName(chromotogram);
 		tabParams.appendRow(rowParams);
       }




       String coadoc1= st.nextToken();
       if(!coadoc1.equals("-"))
       {
	 	rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
	 	rowParams.setType("COADOC1");
	 	rowParams.setClientFileName(coadoc1);
	 	tabParams.appendRow(rowParams);
       }

       String coadoc2= st.nextToken();
       if(!coadoc2.equals("-"))
       {
		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
 		rowParams.setType("COADOC2");
 		rowParams.setClientFileName(coadoc2);
 		tabParams.appendRow(rowParams);
       }

       String coadoc3= st.nextToken();
       if(!coadoc3.equals("-"))
       {

 		rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
  		rowParams.setType("COADOC3");
  		rowParams.setClientFileName(coadoc3);
  		tabParams.appendRow(rowParams);
  	}

 addDocMainParams.setObject(tabParams);
 Session.prepareParams(addDocMainParams);
 EzUploadManager.uploadDoc(addDocMainParams);

}
	String msgSubject="Sample Submitted to NewCo Pharmaceuticals";
	String msgText="Material Sample has been Submitted to NewCo Pharmaceuticals";
	String sendToUser = request.getParameter("toUser");

%>
<%@include file="../Purorder/ezSendAckMail.jsp" %>

<%
	response.sendRedirect ("../Shipment/ezMessage.jsp?Msg=Thank you for submitting Material Sample to NewCo Pharmaceuticals");
%>
<Div id="MenuSol"></Div>
