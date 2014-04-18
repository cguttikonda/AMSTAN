<%@ include file="../../Library/Globals/errorPagePath.jsp"%>  
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iAddSaveShipmentDetails_Labels.jsp"%>  
<%@ page import="java.util.*" %>
<%@ page import = "ezc.ezparam.*,ezc.ezutil.FormatDate.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%@ page import="ezc.ezupload.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import="ezc.ezworkflow.params.*" %>

<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session" />
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<%!
	public java.util.Date getDateFormat(String fromDate){
	
		ezc.ezutil.FormatDate formatDate=new ezc.ezutil.FormatDate();
		int dateArray[] = formatDate.getMMDDYYYY(fromDate, true);
				
		dateArray[0]=dateArray[0]-1;
		Date FromDate=new java.sql.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
		
		return FromDate; 
	
	}

%>
<%
	String ibdStatus="";
	String ibdNo="";
	boolean isConfirmationKey = false;
	boolean isIbdSuccess = true;
	
	ReturnObjFromRetrieve retMail		= new ReturnObjFromRetrieve(new String []{ "LINE","MATNO","MATDESC","UOM","QTY"});
	ReturnObjFromRetrieve retMailHeader	= new ReturnObjFromRetrieve(new String [] {"PONO","DCNO","LRNO","INVNO","DCDATE","INVDATE","SHIPDATE","EXPDATE","CNAME","TEXT" });
	ReturnObjFromRetrieve retship = null;

	Hashtable batfiles	= new Hashtable();
	Vector shipno		= new Vector();
	Vector batno		= new Vector();
	Vector ackPO		= (java.util.Vector) session.getValue("toShipPos");
	String linktopodat	="";//"¤"

	String batches[]	= request.getParameterValues("batches");
	String line[]		= request.getParameterValues("Line");
	String Material[]	= request.getParameterValues("MaterialNr");
	String mdesc[]		= request.getParameterValues("Description");
	String uom[]		= request.getParameterValues("UOM");
	String qty[] 		= request.getParameterValues("Quantity");
	String Plants[]		= request.getParameterValues("Plant");
	String[] coaData 	= request.getParameterValues("coaData");
	String[] coaLong 	= request.getParameterValues("coaLong");
	String[] confKey 	= request.getParameterValues("confKey"); 
	
	String matMsg		= "";
	String mailLines 	= "<Table border=1><tr><Th>LineNo</Th><Th>Mat.No</Th><Th>Description</Th><Th>Uom</Th><Th>Qty</Th></Tr>";
	int  count		= Integer.parseInt(request.getParameter("count"));			//no of lines count
	String shipupload	= request.getParameter("shipupload");
	String shipflag		= request.getParameter("shipflag");	//This shipflag="Y" OR "N" for shipment level attachments
	String schdflag		= request.getParameter("schdflag");	//This schdflag="Y" OR "N" for schedule batches attachments
	String status 		= request.getParameter("status");
	String Type		= request.getParameter("Type"); 
	String dcno		= request.getParameter("DeliveryChallan");
	String ponum		= request.getParameter("ponum");
	String orderBase 	= request.getParameter("orderBase");
	
	String invno		= request.getParameter("InvoiceNo");
	String lrno 		= request.getParameter("LR");
	String cname		= request.getParameter("CarrierName");
	String expTime		= request.getParameter("ExpectedArivalTime");
	String text 		= request.getParameter("Text");
	String podate		= request.getParameter("PODate");
	String dcdate		= request.getParameter("DCDate");
	String invdate		= request.getParameter("InvoiceDate");
	String shipdate		= request.getParameter("ShipDate"); 
	String expecdate	= request.getParameter("ExpectedArivalTime");
	String sendMail		= request.getParameter("sendMail");	
	String today		= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);

	String currSysKey 	= (String) session.getValue("SYSKEY");
	String defErpVendor 	= (String) session.getValue("SOLDTO");
	String fdate		= (String) session.getValue("DATEFORMAT");
	String template		= (String) session.getValue("TEMPLATE");
	String participant	= (String) session.getValue("USERGROUP");
	String userType 	= (String) session.getValue("UserType");
	String msgNumber 	= "";
	
	//java.util.Date ibd_dcdate	= getDateFormat(dcdate);
	java.util.Date ibd_shipdate	= getDateFormat(shipdate);
	java.util.Date ibd_exdate	= getDateFormat(expecdate);
	
	//out.println("ibd_shipdateibd_shipdateibd_shipdate	"+ibd_shipdate);
	
	//out.println("ibd_exdateibd_exdateibd_exdate		"+ibd_exdate);
	
	linktopodat = dcno+"¤"+dcdate+"¤"+invno+"¤"+invdate+"¤"+lrno+"¤"+shipdate+"¤"+cname+"¤"+expecdate+"¤"+text;
	
	podate		= dateConvertion(podate,fdate);
	dcdate		= dateConvertion(dcdate,fdate);
	invdate 	= dateConvertion(invdate,fdate);
	shipdate	= dateConvertion(shipdate,fdate);
	expecdate	= dateConvertion(expecdate,fdate);
	
	dcno 	= dcno.replace('\'','`') ;
	invno 	= invno.replace('\'','`');
	lrno	= lrno.replace('\'','`');
	cname 	= cname.replace('\'','`');
	text	= text.replace('\'','`');
	
	//FOR CHECKING CONFIRMATION KEY OF ALL ITEMS STARTS. 
	
	for(int i=0;i<line.length;i++)
	{
		//out.println("qty[i]::"+qty[i]);
		if(!("".equals(qty[i]) || "null".equals(qty[i]) || qty[i]==null)){
			
			if(!("".equals(confKey[i]) || "null".equals(confKey[i]) || confKey[i]==null))
			{
				isConfirmationKey = true;
				break;
			}
		}
	}
	//FOR CHECKING CONFIRMATION KEY OF ALL ITEMS ENDS.  
	
	EzShipmentManager shipManager= new EzShipmentManager();
	EzcParams shipParams=new EzcParams(true);
	EzShipmentHeaderStructure inStructHeader=new EzShipmentHeaderStructure();
	if(status.equals("N"))
		inStructHeader.setStatus("N");			//for saving the shipment
	else
		inStructHeader.setStatus("Y");			//for submitting the shipment
	inStructHeader.setPurchaseOrderNumber(ponum);
	inStructHeader.setType(Type);						//Type p-PurchaseOrder S-SheduleAgreement
	inStructHeader.setPurchaseOrderDate(podate);		//Ssrver Date
	inStructHeader.setDeliveryChallanNumber(dcno);
	inStructHeader.setDeliveryChallanDate(dcdate);
	inStructHeader.setPurchaseOrderRev("NO");			//hardcoded
	inStructHeader.setInvoiceNumber(invno);
	inStructHeader.setInvoiceDate(invdate);
	inStructHeader.setCreatedBy(Session.getUserId());
	inStructHeader.setCreatedOn(today);
	inStructHeader.setLastModifiedOn(today);
	inStructHeader.setLr_rr_air_nr(lrno);
	inStructHeader.setShipmentDate(shipdate);
	inStructHeader.setCarrier(cname);
	inStructHeader.setExpectedArivalTime(expecdate);
	inStructHeader.setText(text);
	inStructHeader.setDocsAttached(shipflag);	// This is for file attachments
	inStructHeader.setUploadId("0");		// hardcoded not necessary
	inStructHeader.setSysKey(currSysKey);
	inStructHeader.setSoldTo(defErpVendor);
	inStructHeader.setExt1("");
	inStructHeader.setExt2("");
	inStructHeader.setExt3("");
	
	
/******************************	For IBD*****/

	if("Y".equalsIgnoreCase(status) && isConfirmationKey)  
	{
%>
		<%@include  file="../../../Includes/JSPs/Shipment/iPostGRDetails.jsp"%>
<%
		if("S".equalsIgnoreCase(ibdStatus) && "Y".equalsIgnoreCase(status))
		{
			shipSuccess_L +=" with IBD Number: "+ibdNo+" <BR>against Purchase Order "+ponum;
			inStructHeader.setExt1(ibdNo);
			shipSuccess_L = shipSuccess_L.replace('.',' ');
		}				
		else if( "E".equalsIgnoreCase(ibdStatus) && "Y".equalsIgnoreCase(status)){
		
		
			shipSuccess_L ="<font color=red>ERROR:</font> "+ibdNo;
			isIbdSuccess = false;
			sendMail = "No";
		}
	}

	
		

/****************************/
	
	if(!isConfirmationKey && "Y".equals(status))
	{
		isIbdSuccess = false;
		sendMail = "No";
		status = "Y";
		
		shipSuccess_L = "This PO does not require Shipping Advice Notice. <BR>SAP inbound delivery is NOT created";
		if("M".equals(Type))	
		shipSuccess_L = "This Schedule Agreement does not require Shipping Advice Notice. <BR>SAP inbound delivery is NOT created";
		
		
		
		
	}
	
	
	retMailHeader.setFieldValue("PONO",ponum);
	retMailHeader.setFieldValue("DCNO",dcno);
	retMailHeader.setFieldValue("INVNO",invno);
	retMailHeader.setFieldValue("LRNO",lrno);
	retMailHeader.setFieldValue("EXPDATE",expecdate);
	retMailHeader.setFieldValue("CNAME",cname);
	retMailHeader.setFieldValue("INVDATE",invdate);
	retMailHeader.setFieldValue("DCDATE",dcdate);
	retMailHeader.setFieldValue("SHIPDATE",shipdate);
	retMailHeader.setFieldValue("TEXT",text);
	retMailHeader.addRow();
	
	shipParams.setLocalStore("Y");
	
	EzShipmentLinesTable ezTable	 = new EzShipmentLinesTable();
	EzShipmentLinesTableRow linesRow = null;
	
	ezc.ezcommon.EzLog4j.log(status+"::::::::isIbdSuccess:::::::::"+isIbdSuccess,"I");
	
	isIbdSuccess = true;
	if(isIbdSuccess){
		for(int i=0;i<count;i++)				//for no of lines
		{
			mdesc[i]=mdesc[i].replace('\'','`');
			if(batches[i]!=null && !"null".equals(batches[i]) && !"".equals(batches[i]))
			{
				linesRow = new EzShipmentLinesTableRow();
				linesRow.setLineNumber(line[i]);
				linesRow.setMaterialNumber(Material[i]);
				linesRow.setMaterialDesc(mdesc[i]);
				linesRow.setUomQuantity(uom[i]);
				linesRow.setQuantityShipped(qty[i]);
				linesRow.setAttachments("N");		//hard coded presently this is for attachments
				linesRow.setUploadId("0");
				linesRow.setExt1("");
				linesRow.setExt2("");
				ezTable.insertRow(0,linesRow);

				if(!"0".equals(qty[i]))
				{
					retMail.setFieldValue("LINE",line[i]);
					retMail.setFieldValue("MATNO",Material[i]);
					retMail.setFieldValue("MATDESC",mdesc[i]);
					retMail.setFieldValue("UOM",uom[i]);
					retMail.setFieldValue("QTY",qty[i]);
					retMail.addRow();

					mailLines = mailLines+"<tr><Td>"+line[i]+"</Td><Td>"+Material[i]+"</Td><Td>"+mdesc[i]+"</Td><Td>"+uom[i]+"</Td><Td>"+qty[i]+"</Td></tr></Table><br>";
				}

			}
			
		}
		StringTokenizer st=null;
		EzShipmentSchedulesTable shTable 	= new EzShipmentSchedulesTable();
		EzShipmentSchedulesTableRow shTableRow  = null;
		for(int i=0;i<count;i++)			//For lines
		{
			if(batches[i]!=null && !"null".equals(batches[i]) && !"".equals(batches[i]))
			{
				int j=0;
				st=new StringTokenizer(batches[i],"µ");
				String sbatches[]=new String[st.countTokens()];
				while(st.hasMoreTokens())
				{
					sbatches[j]=st.nextToken();
					j++;
				}
				for(int k=0;k<sbatches.length;k++) //for no of batches in each line
				{
					shTableRow = new EzShipmentSchedulesTableRow();
					st=new StringTokenizer(sbatches[k],"§");
					String bat=st.nextToken();
					bat=(bat.equals("NA"))?"":(bat);
					String mfg= st.nextToken();
					mfg=(mfg.equals("NA"))?"":(dateConvertion(mfg,fdate));
					String exp=st.nextToken();
					exp=(exp.equals("NA"))?"":(dateConvertion(exp,fdate));
					String qtys=st.nextToken();

					String filename=st.nextToken();
					///System.out.println("*****************filename****"+filename);
					if(batfiles.get(line[i])!=null)
					{
						String files=(String) batfiles.get(line[i]);
						files+=","+filename;
						batfiles.put(line[i],files);
					}
					else
					{
						batfiles.put(line[i],filename);
					}
					batno.addElement(String.valueOf(k+1));

					shTableRow.setLineNumber(line[i]);
					shTableRow.setScheduleLine(String.valueOf(k+1));
					shTableRow.setBatch(bat.replace('\'','~'));
					shTableRow.setBatchQty(qtys);
					shTableRow.setMfgDate(mfg);
					shTableRow.setExpDate(exp);
					shTableRow.setAttachments(schdflag);
					shTableRow.setUploadId("0");
					shTableRow.setExt1("");
					shTableRow.setExt2("");
					shTable.insertRow(0,shTableRow);
				}
			}
		}
		shipParams.setObject(inStructHeader);
		shipParams.setObject(ezTable);
		shipParams.setObject(shTable);
		Session.prepareParams(shipParams);
		
		/******************Added if statement to insert into DB iff. IBD created in SAP*****************/
		if("311".equals(msgNumber) && "S".equalsIgnoreCase(ibdStatus))
		{
			retship=(ReturnObjFromRetrieve)shipManager.ezAddShipmentInfo(shipParams);
		}
		
		if("N".equals(status))
		retship=(ReturnObjFromRetrieve)shipManager.ezAddShipmentInfo(shipParams);

		ezc.ezparam.EzcParams addMainParams = null;
		ezc.ezupload.params.EziUploadDocsParams addParams= null;

		ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
		ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;

		if(schdflag.equals("Y"))				//if schedule level attatchments are present
		{
			Enumeration enum1=batfiles.keys();
			while(enum1.hasMoreElements())
			{
				addMainParams = new ezc.ezparam.EzcParams(false);
				String lineno=(String)enum1.nextElement();
				String totfiles=(String)batfiles.get(lineno);

				addParams= new ezc.ezupload.params.EziUploadDocsParams();
				addParams.setSysKey(currSysKey);
				addParams.setObjectType("SHIPSCHD");					// This key is added for identification of Schedules attachments
				String objno=retship.getFieldValueString(0,"SH_ID")+lineno;
				addParams.setObjectNo(objno);
				addParams.setStatus("");
				addParams.setCreatedOn(today);
				addParams.setCreatedBy(Session.getUserId());
				addParams.setUploadDirectory(uploadTempDir+session.getId());
				addMainParams.setObject(addParams);
				StringTokenizer stk=new StringTokenizer(totfiles,",");
				int i=1;
				while(stk.hasMoreElements())
				{
					String finalfile=(String)stk.nextToken();
					if(!finalfile.equals("NA"))
					{
						rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
						rowParams.setType(String.valueOf(i));
						rowParams.setClientFileName(finalfile);
						tabParams.appendRow(rowParams);
					}
					i++;
				}
				addMainParams.setObject(tabParams);
				Session.prepareParams(addMainParams);
				EzUploadManager.uploadDoc(addMainParams);
			}
		}

		//////Shipment Level Uploads
		tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
		if(shipflag.equals("Y"))
		{
			addMainParams = new ezc.ezparam.EzcParams(false);
			addParams= new ezc.ezupload.params.EziUploadDocsParams();
			addParams.setSysKey(currSysKey);
			addParams.setObjectType("SHIPMENT");			//This is for Shipment level attachments identifications
			String objno=retship.getFieldValueString(0,"SH_ID");
			addParams.setObjectNo(objno);
			addParams.setStatus("");
			addParams.setCreatedOn(today);
			addParams.setCreatedBy(Session.getUserId());
			addParams.setUploadDirectory(uploadTempDir+session.getId());
			addMainParams.setObject(addParams);

			StringTokenizer stkfile=new StringTokenizer(shipupload,"§");
			String dcdoc=(String)stkfile.nextToken();
			if(!dcdoc.equals("NA"))
			{
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType("DCDOC");				//This hardcoded for attachment type
				rowParams.setClientFileName(dcdoc);
				tabParams.appendRow(rowParams);
			}

			String lrdoc=(String)stkfile.nextToken();
			if(!lrdoc.equals("NA"))
			{
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType("LRDOC");				//This hardcoded for attachment type
				rowParams.setClientFileName(lrdoc);
				tabParams.appendRow(rowParams);
			}
			String packagedoc=(String)stkfile.nextToken();
			if(!packagedoc.equals("NA"))
			{
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType("PACKAGEDOC");		//This hardcoded for attachment type
				rowParams.setClientFileName(packagedoc);
				tabParams.appendRow(rowParams);
			}
			String invoicedoc=(String)stkfile.nextToken();
			if(!invoicedoc.equals("NA"))
			{
				rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
				rowParams.setType("INVOICEDOC");		//This hardcoded for attachment type
				rowParams.setClientFileName(invoicedoc);
				tabParams.appendRow(rowParams);
			}
			addMainParams.setObject(tabParams);
			Session.prepareParams(addMainParams);
			EzUploadManager.uploadDoc(addMainParams);
		}
	}

	//To send Mail after Shipment send
	if("Yes".equalsIgnoreCase(sendMail))
	{
		String msgText		="";
		String msgSubject	="";
		String sendToUser	="";
		String catArea 		="";
		String spaceCon 	="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		try
		{
			ponum=String.valueOf(Long.parseLong(ponum));
		}
		catch(Exception e){}

		msgSubject="Shipment info posted for "  +  ponum;
		msgText="<br>Dear Sir,<br><br>";
		msgText	=msgText+spaceCon+"We have posted  new  shipment info for  "  +  ponum + " as follows\n<br>";
		msgText =msgText+spaceCon+"Invoice No: "+invno;
		msgText = msgText +"<br>"+spaceCon+"DC No: "+dcno;
		msgText = msgText +"<br>"+spaceCon+"Expected Arrival Date: "+expTime;
		msgText = msgText +"<br>"+spaceCon+"Carrier Name: "+cname;
		msgText=  msgText +"<br>"+matMsg;
		//msgText=  msgText +mailLines +"";
		msgText = msgText + "<br>Regards, \n<br><b>" + session.getValue("Vendor") + "(" + Session.getUserId()+").</b><br>";
		msgText = msgText + "<br><b>*</b>This is electronically generated mail/document.Hence signature is not required.";
		////////out.println("Message Text for Shipment is "+msgText.length());

		//To GET SBU Contacts given at partner level
		//This is added by nagesh for sending mails to superiors.
		ReturnObjFromRetrieve retUser = null;
		ArrayList desiredSteps=new ArrayList();
		desiredSteps.add("-1");
		desiredSteps.add("-2");
		desiredSteps.add("-3");

		

		ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();
		
		for(int i=0;i<retcatarea.getRowCount();i++)
		{
			catArea = catArea+retcatarea.getFieldValue(i,"ESKD_SYS_KEY")+"','";
		}
		catArea= catArea.substring(0,catArea.length()-3);

		ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
		ezc.ezworkflow.params.EziWFParams params= new ezc.ezworkflow.params.EziWFParams();
		params.setTemplate(template);
		params.setSyskey(catArea);
		params.setParticipant(participant);
		params.setDesiredSteps(desiredSteps);
		mainParams.setObject(params);
		Session.prepareParams(mainParams);
		retUser=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParams);
		if (retUser.getRowCount() > 0)
		{
			for(int i=0;i<retUser.getRowCount();i++)
			{
				sendToUser=sendToUser+retUser.getFieldValueString(i,"EU_ID")+",";
			}
		}
		sendToUser=sendToUser.substring(0,sendToUser.length()-1);

		String wareHouseIds="";
		try
		{
			ResourceBundle wbundle=ResourceBundle.getBundle("WAREHOUSEIDS");
			if (Plants != null)
			{
				for( int i=0; i < Plants.length ; i++)
				{
					String tempW=null;
					try
					{
						tempW = wbundle.getString(Plants[i]);
					}
					catch(Exception e)
					{
						tempW="";
					}
					if(tempW!=null && !"".equals (tempW) && !"null".equals(tempW))
						wareHouseIds=wareHouseIds+","+tempW;
				}
			}
		}
		catch(Exception e){}
		sendToUser=sendToUser+"," + wareHouseIds;
%>
		<%@ include file="../Inbox/ezSendAlert.jsp" %>
<%
	}

	///String shipId = retship.getFieldValueString(0,"SH_ID");
	if(ackPO.contains(ponum))
		ackPO.remove(ponum);
	if(!("Y".equalsIgnoreCase(status)))
		shipSuccess_L = "Shipment has been saved successfully.";
	String noDataStatement = shipSuccess_L;
	int size = ackPO.size();
	
	if("P".equals(Type))
		orderBase = "po";
	else if("M".equals(Type)){	
		orderBase = "con";
		wouldLinSh_L	= "Would you like to link this shipment data to another Schedule Agreement? ";
	}	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	function checkList()
	{
		
		location.href="ezViewShipmentHeader.jsp?showData=Y&ponum=<%=ponum%>&orderBase=<%=orderBase%>";
	}
	function submitIt1()
	{
			
			if (document.myForm.base.selectedIndex==0)
			{
				alert ("Please select Purchase Order Number");
				document.myForm.base.focus();
				return false;
			}
			else{
				document.myForm.ponum.value=document.myForm.base.options[document.myForm.base.selectedIndex].value
				document.myForm.action = "ezAddShipmentDetails.jsp";
				document.myForm.submit();
			}
	}
	
</script>
</head>
<body scroll=no onContextmenu="return false;">
<form name="myForm" method="post">
<%
	String shIdFw = "",shDetailsFw="";
	if(retship!=null)
		shIdFw = retship.getFieldValueString(0,"SH_ID");
	if("Y".equalsIgnoreCase(status))
		shDetailsFw = "ezViewShipmentDetails.jsp?ShipId="+shIdFw+"&Status=Y&ponum="+ponum+"&orderBase="+orderBase;		
	else
		shDetailsFw = "ezShipmentDetails.jsp?ShipId="+shIdFw+"&Status=Y&ponum="+ponum+"&orderBase="+orderBase;		
	if("S".equalsIgnoreCase(ibdStatus) && "Y".equalsIgnoreCase(status))	
		noDataStatement = noDataStatement + "<BR>" + "Click <a href="+shDetailsFw+">here</a> to view shipment details";
%>

<%@ include file="../Misc/ezDisplayNoData.jsp" %>

<Div id='linkDiv' style='position:absolute;align:center;top:45%;width:100%;height:10%'>
	<Table width="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
			<Table border="0" align="center" valign=middle width="100%" cellpadding=1 cellspacing=1 class=welcomecell>
				<Tr>
					<Td colspan=2 style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='100%' align=center>
								<%=wouldLinSh_L%> 
					</Td>
				</Tr>
				<Tr>
					
					<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold' width='60%' align=right>
					<Select name="base" style="width:35%" id="ListBoxDiv1">
						<option value=''><%=sel_L%></option>
<%
						for(int i=0;i<size;i++)
						{
							
							
							out.println("<option value='"+(String)ackPO.get(i)+"' >"+(String)ackPO.get(i)+"</option>");
						}
%>
					</select>
					</Td>
					<Td style='background:#F3F3F3' width='40%' align=left>
						<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" style="cursor:hand" border="none" onClick="submitIt1()" onMouseover="window.status=' Add  the Shipment '; return true" onMouseout="window.status=' '; return true">
					</Td>
				</TR>
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</Div>







<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("checkList()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<input type='hidden' name='ponum' value='<%=ponum%>'  >
<input type='hidden' name='orderBase' value='<%=orderBase%>'  >
<input type='hidden' name='showData' value='Y'  >

<input type='hidden' name='linktopo' value='Y'  >
<input type='hidden' name='linktopodat' value='<%=linktopodat%>'  >

<Div id="MenuSol"></Div>
</form>
</body>
</html>

