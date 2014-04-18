<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<jsp:useBean id="Manager" class="ezc.ezpreprocurement.client.EzPreProcurementManager" />
<%@ page import="ezc.ezpreprocurement.params.*,java.util.*,ezc.ezparam.*;" %>
<%@include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp"%>
<%

	java.util.Vector rfqNos=new java.util.Vector(); 
	int count = myRet.getRowCount();
	for(int i=count-1;i>=0;i--)
	{
		rfqNos.add(myRet.getFieldValueString(i,"RFQ_NO"));
		if(!("R".equals(myRet.getFieldValueString(i,"RELEASE_INDICATOR").trim())))
			myRet.deleteRow(i);

	}
	
	String fromContract = request.getParameter("SOS");
	String docType	 = request.getParameter("docType");
	String valType	 = request.getParameter("valType");
	String confCtrl	 = request.getParameter("confCtrl");	
	String houseBnkId= request.getParameter("houseBnkId");	
	String delivDate = request.getParameter("delivDate");	
	String taxCode	 = request.getParameter("taxCode");
	String headerText= request.getParameter("headerText");
	String itemText  = request.getParameter("itemText");

	String vendors	= request.getParameter("vendors");
	
	java.util.Vector vendCode=new java.util.Vector();
	java.util.Vector vendQty=new java.util.Vector();
	if(vendors!=null){
		java.util.StringTokenizer venDetStr = new java.util.StringTokenizer(vendors,"§"); 
		while(venDetStr.hasMoreTokens())
		{
			String vendStr=(String)venDetStr.nextToken();
			java.util.StringTokenizer venDetStk = new java.util.StringTokenizer(vendStr,"¥"); 
			if(venDetStk.countTokens()>1){
				vendCode.add(venDetStk.nextToken());
				vendQty.add(venDetStk.nextToken());
			}
			
		}
	}	
	
/*
	String docType	 = "ZRMI";
	String taxCode	 = "AA";
	String valType	 = "OGL FOR RM";
	String confCtrl	 = "0001";	
	String houseBnkId= "ABNDB";
	vendor 	   	 = "1100000887";
	material    	 = "000000000004000060";
	uom 	   	 = "05K";
*/	
	ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"OBJ","VENDOR"});
	String material="",uom="",plant="",price="",vendor="",quantity="";
	int myRetCount  = myRet.getRowCount();
	for(int i=0;i<myRetCount;i++)	
	{
		vendor   = (String)vendCode.get(i);
		quantity = (String)vendQty.get(i);		
		
		material = myRet.getFieldValueString(i,"MATERIAL");
		uom	 = myRet.getFieldValueString(i,"UOM");	
		plant	 = myRet.getFieldValueString(i,"PLANT");
		price	 = myRet.getFieldValueString(i,"PRICE");

		//vendor 	 = "1100000132";
		//material    	 = "000000000004000060";
		//uom 	   	 = "05K";

		EziPOHeaderParams 	headerParams		= new EziPOHeaderParams();
		EziPOItemTable		itemTable		= new EziPOItemTable();	
		EziPOItemTableRow 	itemRow			= null;
		EziPOSchedTable 	schTable		= new EziPOSchedTable();
		EziPOSchedTableRow 	schRow			= null;
		EziPOCondTable 		condTable		= new EziPOCondTable();
		EziPOCondTableRow 	condRow			= null;
		EziPOHeaderTextTable 	headerTextTable 	= new EziPOHeaderTextTable();
		EziPOHeaderTextTableRow	hTextRow		= null;
		EziPOItemTextTable   	itemTextTable   	= new EziPOItemTextTable();
		EziPOItemTextTableRow	iTextRow		= null; 



		headerParams.setCreatedOn(new Date());	
		headerParams.setCreatedBy(Session.getUserId());
		headerParams.setVendor(vendor);			//"1100000887"
		headerParams.setDocType(docType);		//"ZRMI"
		headerParams.setHouseBankId(houseBnkId);	//"ABNDB"

	
		itemRow = new EziPOItemTableRow();
		itemRow.setMaterial(material);			//"4000060"
		itemRow.setPlant(plant);			//"1000"
		itemRow.setQuantity(quantity);			//"50.000"
		itemRow.setUOM(uom);				//"KG"
		itemRow.setPrice(price);			//"10"
		itemRow.setTaxCode(taxCode);			//"AA"
		itemRow.setConfCtrl(confCtrl);			//"0001"
		//if(valType!=null && !"null".equals(valType))
		//	itemRow.setValType(valType);		//"OGL FOR RM"
		itemTable.appendRow(itemRow);
	
		schRow = new EziPOSchedTableRow();
		schRow.setMaterial(material);
		schRow.setQuantity(quantity);			//"50.000"
		schRow.setDelivDate(delivDate);			//"04/12/2005"
		schTable.appendRow(schRow);

		hTextRow = new EziPOHeaderTextTableRow();
		hTextRow.setTextId("F01");
		hTextRow.setTextForm("EN");
		hTextRow.setTextLine(headerText);		//"Header Text Testing"
		headerTextTable.appendRow(hTextRow);

		iTextRow = new EziPOItemTextTableRow();
		iTextRow.setTextId("F01");
		iTextRow.setTextForm("EN");
		iTextRow.setTextLine(itemText);			//"Item Text Testing"
		itemTextTable.appendRow(iTextRow);

		EzcParams mainParams = new EzcParams(true);
		mainParams.setObject(headerParams);
		mainParams.setObject(itemTable);
		mainParams.setObject(schTable);
		mainParams.setObject(condTable);
		mainParams.setObject(headerTextTable);
		mainParams.setObject(itemTextTable);
		
		Session.prepareParams(mainParams);
		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve)Manager.ezCreatePO(mainParams);
		
		finalRet.setFieldValue("OBJ",ret);
		finalRet.setFieldValue("VENDOR",vendor);
		finalRet.addRow();
	}
	
	String retMessage ="";
	boolean closing=false;
	for(int x=0;x<finalRet.getRowCount();x++)
	{
		
		String vend = finalRet.getFieldValueString(x,"VENDOR");		
		boolean flag =false;
		int cnt =1;

		ReturnObjFromRetrieve ret = (ReturnObjFromRetrieve )finalRet.getFieldValue(x,"OBJ");	

		retMessage += "Vendor: " +vend +"<br>";	
		for(int pc=0;pc<ret.getRowCount();pc++)
		{
			String errorType = ret.getFieldValueString(pc,"TYPE");
			if("E".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage+cnt+"."+ret.getFieldValueString(pc,"MESSAGE")+"<br>";
				cnt++;
				flag = false;
			}
			else if("S".equalsIgnoreCase(errorType))
			{
				retMessage = retMessage + ret.getFieldValueString(pc,"MESSAGE");
				retMessage = retMessage + " Successfully"+"<br>";
				flag = true;
				closing=true;
			}
			
			
		}
		if(flag && fromContract==null)
		{
			ezc.ezupload.client.EzUploadManager ezUploadManager = new ezc.ezupload.client.EzUploadManager();
			EzcParams docMainParams = new EzcParams(true);
			ezc.ezupload.params.EziDocumentTextsTable ezidocumenttextstable = new ezc.ezupload.params.EziDocumentTextsTable();
			ezc.ezupload.params.EziDocumentTextsTableRow ezidocumenttextstablerow = new ezc.ezupload.params.EziDocumentTextsTableRow();
			ezidocumenttextstablerow.setDocType("QCFPO"+((new java.util.Date()).getTime()));
			ezidocumenttextstablerow.setDocNo(vend);
			ezidocumenttextstablerow.setSysKey("QCF_PO");
			ezidocumenttextstablerow.setKey("QCF_PO");
			ezidocumenttextstablerow.setValue(ret.getFieldValueString(0,"PO_NUM"));
			ezidocumenttextstable.appendRow(ezidocumenttextstablerow);
			docMainParams.setObject(ezidocumenttextstable);
			Session.prepareParams(docMainParams);
			ezUploadManager.addDocumentText(docMainParams);
					
		}
	}
	
	if(closing){
%>	
	<%//@include file="../../../Includes/JSPs/Rfq/iCloseQCF.jsp"%>			
<%		
	}
	response.sendRedirect("../Shipment/ezMessage.jsp?Msg="+retMessage);
%>