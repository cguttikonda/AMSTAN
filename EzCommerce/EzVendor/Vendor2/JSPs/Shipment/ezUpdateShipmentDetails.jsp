<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import = "ezc.ezparam.*,java.util.*,java.text.*,java.io.*" %>
<%@ page import = "ezc.ezshipment.client.*" %>
<%@ page import = "ezc.ezshipment.params.*" %>
<%@ page import="java.util.*,ezc.ezutil.FormatDate.*" %>
<%@ page import="ezc.ezupload.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>

<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page import="com.sap.mw.jco.JCO"%>
<%@page import ="java.util.*,ezc.ezutil.*" %>
<%@page import = "ezc.ezparam.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@page import="ezc.ezworkflow.params.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session" />
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />

<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
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
	String showMsg = ""; 
	boolean isConfirmationKey = false;
	boolean isIbdSuccess = true;
	
	String mailCols[]= new String []{ "LINE","MATNO","MATDESC","UOM","QTY" };
	String mailHeadCols[]= new String [] {"PONO","DCNO","LRNO","INVNO","DCDATE","INVDATE","SHIPDATE","EXPDATE","CNAME","TEXT" };
	ReturnObjFromRetrieve retMail= new ReturnObjFromRetrieve(mailCols);
	ReturnObjFromRetrieve  retMailHeader= new ReturnObjFromRetrieve(mailHeadCols);
	
	String ponum = request.getParameter("baseValue");
	//System.out.println("******************************START******************");
	Hashtable batfiles=new Hashtable();

	Hashtable vserver=new Hashtable();				//For taking server filename of attachments

	String status = request.getParameter("status");
	String shipId = request.getParameter("shipId");
	String printCount = request.getParameter("printCount");
	if(printCount==null||"null".equals(printCount) || "".equals(printCount.trim()))
	printCount="0";

	String shipuploads=request.getParameter("shipuploads");	 //////shipment level attached files
	String shipserverfiles=request.getParameter("shipserverfiles"); ///shipment level shipment level attached severfiles


	String shipflag=request.getParameter("shipflag");		//flag for shipment level attachments Y=present N=not present
	String schdflag=request.getParameter("schdflag");		//flag for schedule level attachments Y=present N=not present

	String currSysKey = (String) session.getValue("SYSKEY");
	String defErpVendor = (String) session.getValue("SOLDTO");
	String today=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);


	EzShipmentManager shipManager= new EzShipmentManager();

	String dcno=request.getParameter("DeliveryChallan");
	String dcdate=request.getParameter("DCDate");
	String invno=request.getParameter("InvoiceNo");
	String invdate=request.getParameter("InvoiceDate");
	String lrno = request.getParameter("LR");
	String cname=request.getParameter("CarrierName");
	String expTime=request.getParameter("ExpectedArivalTime");
	String text = request.getParameter("Text");
	String shipdate=request.getParameter("ShipDate");
	String exciseNo =request.getParameter("exciseNo"); 
	String expecdate	= request.getParameter("ExpectedArivalTime");
	String orderBase = request.getParameter("orderBase");
	String msgNumber 	= "";
	//System.out.println(">"+dcno+">"+dcdate+">"+invno+">"+invdate+">"+lrno+">"+cname+">"+expTime+">"+text+">"+shipdate);

	String batches[]=request.getParameterValues("batches");
	String line[]=request.getParameterValues("Line");
	String serverfiles[]=request.getParameterValues("serverfiles");  ///////serverfiles of schedules level attachments
	String Material[]=request.getParameterValues("MaterialNr");
	String mdesc[]=request.getParameterValues("matdesc");
	String uom[]=request.getParameterValues("UOM");
	String qty[] = request.getParameterValues("Quantity");
	String Plants[]=request.getParameterValues("Plant");
	String[] confKey 	= request.getParameterValues("confKey");
	String mailLines 	= "<Table border=1><tr><Th>LineNo</Th><Th>Mat.No</Th><Th>Description</Th><Th>Uom</Th><Th>Qty</Th></Tr>";

	String fdate 	= "3";
	String sendMail=request.getParameter("sendMail");
	
	java.util.Date ibd_dcdate	= getDateFormat(dcdate);
	java.util.Date ibd_shipdate	= getDateFormat(shipdate);
	java.util.Date ibd_exdate	= getDateFormat(expecdate);
	
	dcdate		= dateConvertion(dcdate,fdate);
	invdate		= dateConvertion(invdate,fdate);
	shipdate 	= dateConvertion(shipdate,fdate);
	expTime		= dateConvertion(expTime,fdate);
	int  count=line.length;
	
	//FOR CHECKING CONFIRMATION KEY OF ALL ITEMS STARTS. 
	for(int i=0;i<count;i++){
		
		if(!("".equals(qty[i]) || "null".equals(qty[i]) || qty[i]==null))
		{
			
			if(!("".equals(confKey[i]) || "null".equals(confKey[i]) || confKey[i]==null)){
				isConfirmationKey = true;
				break;
			}
		}
	}
	//FOR CHECKING CONFIRMATION KEY OF ALL ITEMS ENDS. 
	
	

	dcno =dcno.replace('\'','`') ;
	invno = invno.replace('\'','`');
	lrno=lrno.replace('\'','`');
	cname = cname.replace('\'','`');
	text=text.replace('\'','`');

	String shipUpSuccess_L = "";

	if("Y".equals(status))
		shipUpSuccess_L="Shipment has been submitted successfully";
	EzShipmentHeaderStructure inStructHeader =new EzShipmentHeaderStructure();
	inStructHeader.setPurchaseOrderNumber(ponum);
	inStructHeader.setDeliveryChallanNumber(dcno);
       	inStructHeader.setDeliveryChallanDate(expTime);
       	inStructHeader.setInvoiceNumber(invno);
       	inStructHeader.setInvoiceDate(invdate);
	inStructHeader.setLastModifiedOn(today);
       	inStructHeader.setLr_rr_air_nr(lrno);
       	inStructHeader.setShipmentDate(shipdate);
       	inStructHeader.setCarrier(cname);
       	inStructHeader.setExpectedArivalTime(expTime);
       	inStructHeader.setStatus(status);
	inStructHeader.setText(text);
	inStructHeader.setDocsAttached(shipflag);
       	inStructHeader.setShipId(shipId);
       	inStructHeader.setExt1("");
       	inStructHeader.setCreatedBy(Session.getUserId());
       	inStructHeader.setSoldTo((String)session.getValue("SOLDTO"));
       	inStructHeader.setSapInvDate(invdate);
/******************************	For IBD*****/

	if("Y".equalsIgnoreCase(status) && isConfirmationKey)
	{
%>
		<%@include  file="../../../Includes/JSPs/Shipment/iPostGRDetails.jsp"%>
<%
		if("S".equalsIgnoreCase(ibdStatus) && "Y".equalsIgnoreCase(status))
		{
			
			inStructHeader.setExt1(ibdNo);
			showMsg =" with IBD Number: "+ibdNo+" <BR>against Purchase Order "+ponum;
		}else if( "E".equalsIgnoreCase(ibdStatus) && "Y".equalsIgnoreCase(status)){
			showMsg ="<font color=red>ERROR:</font> "+ibdNo;
			isIbdSuccess = false;
			sendMail = "No";
		}
	}
	

/****************************/ 	
       	
       	
       	String RqstType 	= request.getParameter("RqstType");
	String noDataStatement 	= "Shipment ";
	if(!isConfirmationKey && "SUBMIT".equals(RqstType))
	{
		isIbdSuccess = false;
		sendMail = "No";
		status = "Y";
		noDataStatement = "This PO does not require Shipping Advice Notice. <BR>SAP inbound delivery is NOT created";
		RqstType = "NO_RQST";
	}
       	
       	
       	ezc.ezcommon.EzLog4j.log("For IBD*****For IBD*****For IBD*****For IBD*****","I");
       	
       	EzShipmentLinesTable ezTable= new EzShipmentLinesTable();
	EzShipmentLinesTableRow linesRow =null;

	EzShipmentSchedulesTable shTable = new EzShipmentSchedulesTable();
	EzShipmentSchedulesTableRow shTableRow = null;

	StringTokenizer st=null;
	StringTokenizer serverst=null;
	String shLines="";
	String matMsg="";
	isIbdSuccess = true;
	if(isIbdSuccess){
		for(int i=0;i<count;i++)
		{
			if(batches[i] != null && !"null".equals(batches[i]) && !"".equals(batches[i]))
			{
				shLines=shLines+line[i]+",";
				st=new StringTokenizer(batches[i],"µ");	//Batch1§MfgDate1§ExpDate1§Qty1µBatch2§MfgDate2§ExpDate2§Qty2

				serverst=new StringTokenizer(serverfiles[i],"µ");
				int batchCount=st.countTokens();
				for(int k=0;k<batchCount;k++)
				{
					StringTokenizer st1=new StringTokenizer(st.nextToken(),"§");	//Batch§MfgDate§ExpDate§Qty
					String bat=st1.nextToken();
					bat=(bat.equals("NA"))?"":(bat);
					String mfg=st1.nextToken();
					mfg=(mfg.equals("NA"))?"":(mfg);

					String exp=st1.nextToken();
					exp=(exp.equals("NA"))?"":(exp);
					if(!"".equals(mfg))
						mfg = dateConvertion(mfg,fdate);
					if(!"".equals(exp))
						exp = dateConvertion(exp,fdate);

					String qtys=st1.nextToken();


					String filename=st1.nextToken();
					String sfile=serverst.nextToken();

					String noOfPacks="";
					String qtyPerPack="";


					if(st1.hasMoreTokens())
					noOfPacks=st1.nextToken();

					if(st1.hasMoreTokens())
					qtyPerPack=st1.nextToken();

					if(batfiles.get(line[i])!=null)
					{

						String files=(String)batfiles.get(line[i]);
						files+=","+filename;
						batfiles.put(line[i],files);

						String serfiles=(String)vserver.get(line[i]);
						serfiles+=","+sfile;
						vserver.put(line[i],serfiles);
					}
					else
					{

						batfiles.put(line[i],filename);
						vserver.put(line[i],sfile);
					}


					shTableRow = new EzShipmentSchedulesTableRow();
					shTableRow.setShipId(shipId);
					shTableRow.setLineNumber(line[i]);
					shTableRow.setScheduleLine(String.valueOf(k+1));
					shTableRow.setBatch(bat);
					shTableRow.setBatchQty(qtys);
					shTableRow.setMfgDate(mfg);
					shTableRow.setExpDate(exp);
					shTableRow.setAttachments(schdflag);

					shTableRow.setExt1(noOfPacks);
					shTableRow.setExt2(qtyPerPack);

					shTable.insertRow(k,shTableRow);
				}
			}
			////ezc.ezcommon.EzLog4j.log("CHECKINGGGGGGGGG!@#CHECKINGGGGGGGG:---->"+qty.length+":::"+qty[i].trim()+"<------"+qty[i].trim().length(),"I");
			if(!"".equals(qty[i].trim()))
			{
				linesRow = new EzShipmentLinesTableRow();
				linesRow.setShipId(shipId);
				linesRow.setLineNumber(line[i]);
				linesRow.setMaterialNumber(Material[i]);
				linesRow.setMaterialDesc(mdesc[i]);
				linesRow.setUomQuantity(uom[i]);
				linesRow.setQuantityShipped(qty[i]);
				linesRow.setAttachments("N");		//hard coded presently this is for attachments
				linesRow.setUploadId("0");
				linesRow.setExt1("");
				linesRow.setExt2("");
				linesRow.setPlant(Plants[i]);
				ezTable.insertRow(0,linesRow);
			}


			retMail.setFieldValue("LINE",line[i]);
			retMail.setFieldValue("MATNO",Material[i]);
			retMail.setFieldValue("MATDESC",mdesc[i]);
			retMail.setFieldValue("UOM",uom[i]);
			retMail.setFieldValue("QTY",qty[i]);
			retMail.addRow();

			mailLines = mailLines+"<tr><Td>"+line[i]+"</Td><Td>"+Material[i]+"</Td><Td>"+mdesc[i]+"</Td><Td>"+uom[i]+"</Td><Td>"+qty[i]+"</Td></tr></Table><br>";
		}


		// First deleting all Shipment Schedules then inserting all when user Updates the Shipment Info

		EziShipmentInfoParams inParams = new EziShipmentInfoParams();
		inParams.setShipId(shipId);
		inParams.setLineNumber(shLines.substring(0,shLines.length()-1));
		inParams.setSelection("S");	//To Delete All Schedules
		EzcParams shipParams=new EzcParams(true);
		shipParams.setLocalStore("Y");
		shipParams.setObject(inParams);
		Session.prepareParams(shipParams);
		shipManager.ezDeleteShipmentInfo(shipParams);

		inParams = new EziShipmentInfoParams();
		inParams.setShipId(shipId);
		inParams.setLineNumber(shLines.substring(0,shLines.length()-1));
		inParams.setSelection("L");	//To Delete All Schedules
		shipParams=new EzcParams(true);
		shipParams.setLocalStore("Y");
		shipParams.setObject(inParams);
		Session.prepareParams(shipParams);
		shipManager.ezDeleteShipmentInfo(shipParams);

		EzcParams shipParams1=new EzcParams(true);
		shipParams1.setLocalStore("Y");
		inStructHeader.setSelection("L");	//To insert only Delivery Schedules
		shipParams1.setObject(inStructHeader);
		shipParams1.setObject(ezTable);
		shipParams1.setObject(shTable);
		Session.prepareParams(shipParams1);
		System.out.println("check this code============<<<<<<<<<<<<<");
		shipManager.ezAddShipmentInfo(shipParams1);
		System.out.println("check this code============<<<<<<<<<<<<<");



		/*shipParams1=new EzcParams(true);
		shipParams1.setLocalStore("Y");
		inStructHeader.setSelection("S");	//To insert only Delivery Schedules
		shipParams1.setObject(inStructHeader);
		shipParams1.setObject(shTable);
		Session.prepareParams(shipParams1);

		shipManager.ezAddShipmentInfo(shipParams1);*/



		EzShipmentSchedulesTable linesTable =new EzShipmentSchedulesTable();
		EzcParams shipParams2=new EzcParams(true);
		shipParams2.setLocalStore("Y");
		shipParams2.setObject(inStructHeader);
		shipParams2.setObject(linesTable);
		Session.prepareParams(shipParams2);
		shipManager.ezUpdateShipmentInfo(shipParams2);


		ezc.ezparam.EzcParams addMainParams = null;
		ezc.ezupload.params.EziUploadDocsParams addParams= null;

		ezc.ezupload.params.EziUploadDocFilesTable tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
		ezc.ezupload.params.EziUploadDocFilesTableRow rowParams= null;


		///////// updating of  batches uploads



		if(schdflag.equals("Y"))
		{
			Enumeration enum=batfiles.keys();
			while(enum.hasMoreElements())
			{
				addMainParams = new ezc.ezparam.EzcParams(false);
				String lineno=(String)enum.nextElement();
				String totfiles=(String)batfiles.get(lineno);
				String stotfiles=(String)vserver.get(lineno);
				addParams= new ezc.ezupload.params.EziUploadDocsParams();
				addParams.setSysKey(currSysKey);
				addParams.setObjectType("SHIPSCHD");		//For schedule level attachments
				String objno=shipId+lineno;				//shipment no and line number
				addParams.setObjectNo(objno);
				addParams.setStatus("");
				addParams.setCreatedOn(today);
				addParams.setCreatedBy(Session.getUserId());
				addParams.setUploadDirectory(uploadTempDir+session.getId());	//temperary storage path for attached files
				addMainParams.setObject(addParams);

				StringTokenizer stk=new StringTokenizer(totfiles,",");
				StringTokenizer sfiles=new StringTokenizer(stotfiles,",");
				int i=1;												//Index for Files which are attached
				while(stk.hasMoreElements())
				{
					String finalfile=(String)stk.nextToken();
					String sf=(String)sfiles.nextToken();
					if(!finalfile.equals("NA"))
					{
						rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();


						rowParams.setType(String.valueOf(i));
						rowParams.setClientFileName(finalfile);
						if(sf.equals("NA"))
						{
							rowParams.setServerFileName("¥");  ///if new files are attached while updating
						}
						else
						{
							rowParams.setServerFileName(sf);
						}
						tabParams.appendRow(rowParams);
					}
					i++;
				}
				addMainParams.setObject(tabParams);
				Session.prepareParams(addMainParams);
				EzUploadManager.updateDoc(addMainParams);
			}
		}

		////updation of Shipment level uploads
		tabParams= new ezc.ezupload.params.EziUploadDocFilesTable();
		Vector v= new Vector();
		v.addElement("DCDOC");
		v.addElement("LRDOC");
		v.addElement("PACKAGEDOC");
		v.addElement("INVOICEDOC");

		if(shipflag.equals("Y"))
		{
			addMainParams = new ezc.ezparam.EzcParams(false);

			addParams= new ezc.ezupload.params.EziUploadDocsParams();
			addParams.setSysKey(currSysKey);
			addParams.setObjectType("SHIPMENT");

			addParams.setObjectNo(shipId);
			addParams.setStatus("");
			addParams.setCreatedOn(today);
			addParams.setCreatedBy(Session.getUserId());
			addParams.setUploadDirectory(uploadTempDir+session.getId());	//temperary storage path for attached files
			addMainParams.setObject(addParams);

			StringTokenizer shipstk=new StringTokenizer(shipserverfiles,"µ");
			StringTokenizer shipclient=new StringTokenizer(shipuploads,"§");
			int i=1;											//Index for Files which are attached
			while(shipstk.hasMoreElements())
			{
				String sf=(String)shipstk.nextToken();
				String finalfile=(String)shipclient.nextToken();
				if(!finalfile.equals("NA"))
				{
					rowParams= new ezc.ezupload.params.EziUploadDocFilesTableRow();
					rowParams.setType(String.valueOf(v.elementAt(i-1)));
					rowParams.setClientFileName(finalfile);

					if(sf.equals("NA"))
					{
						rowParams.setServerFileName("¥");		///if new files are attached while updating
					}
					else
					{
						rowParams.setServerFileName(sf);
					}
					tabParams.appendRow(rowParams);
				}
				i++;
			}
			addMainParams.setObject(tabParams);
			Session.prepareParams(addMainParams);
			EzUploadManager.updateDoc(addMainParams);
		}
	}	

	if("Yes".equalsIgnoreCase(sendMail))
	{
		String msgText="";
		String msgSubject="";
		String sendToUser="";
		String spaceCon 	="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		

		try{
			ponum=String.valueOf(Long.parseLong(ponum));
		  }
		catch(Exception e){ }

		retMailHeader.setFieldValue("PONO",ponum);
		retMailHeader.setFieldValue("DCNO",dcno);
		retMailHeader.setFieldValue("INVNO",invno);
		retMailHeader.setFieldValue("LRNO",lrno);
		retMailHeader.setFieldValue("EXPDATE",expTime);
		retMailHeader.setFieldValue("CNAME",cname);
		retMailHeader.setFieldValue("INVDATE",invdate);
		retMailHeader.setFieldValue("DCDATE",dcdate);
		retMailHeader.setFieldValue("SHIPDATE",shipdate);
		retMailHeader.setFieldValue("TEXT",text);
		retMailHeader.addRow();

		
		msgSubject="Shipment info posted for "  +  ponum;
		msgText="<br>Dear Sir,<br><br>";
		msgText	=msgText+spaceCon+"We have posted  new  shipment info for  "  +  ponum + " as follows\n<br>";
		msgText =msgText+spaceCon+"Invoice No: "+invno;
		msgText = msgText +"<br>"+spaceCon+"DC No: "+dcno;
		msgText = msgText +"<br>"+spaceCon+"Expected Arrival Date: "+expTime;
		msgText = msgText +"<br>"+spaceCon+"Carrier Name: "+cname;
		msgText=  msgText +"<br>"+matMsg;
		//msgText=  msgText +mailLines +"";
		msgText = msgText + "<br><br>Regards, \n<br><b>" + session.getValue("Vendor") + "(" + Session.getUserId()+").</b><br>";
		msgText = msgText + "<br><b>*</b>This is electronically generated mail/document.Hence signature is not required.";
		///out.println("msgText"+msgText.length());

		//To GET SBU Contacts given at partner level

		ReturnObjFromRetrieve retUser = null;
		String template=(String)session.getValue("TEMPLATE");
		String participant=(String)session.getValue("USERGROUP");

		
		//vector added by nagesh to send mail to superior
		
		//String desiredStep="-1";

		ArrayList desiredSteps=new ArrayList();

		desiredSteps.add("-1");
		desiredSteps.add("-2");
		desiredSteps.add("-3");


		String userType = (String)session.getValue("UserType");

		ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
		ReturnObjFromRetrieve retcatarea = (ReturnObjFromRetrieve)PurManager.getUserPurAreas();

		String catArea ="";
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
		if(retUser!=null)
		{
			if (retUser.getRowCount() > 0)
			{
				for(int i=0;i<retUser.getRowCount();i++)
				{
			     		sendToUser=sendToUser+retUser.getFieldValueString(i,"EU_ID")+",";
				}
			}
		}
		if(!"".equals(sendToUser))
			sendToUser=sendToUser.substring(0,sendToUser.length()-1);
		///System.out.println("************sendToUser*******"+sendToUser);

		String wareHouseIds="";
		try{
			ResourceBundle wbundle=ResourceBundle.getBundle("WAREHOUSEIDS");

			if (Plants != null)
			{
				for( int i=0; i < Plants.length ; i++)
				{
					String tempW=null;
					try{
						tempW = wbundle.getString(Plants[i]);
					}
					catch(Exception e)
					{
						tempW="";
					}
					if(tempW!=null && !"".equals (tempW) && !"null".equals(tempW) )
						wareHouseIds=wareHouseIds+","+tempW;
				}
			}
		}
		catch(Exception e)
		{
		}

		sendToUser=sendToUser+"," + wareHouseIds;
%>
	<%@ include file="../Inbox/ezSendAlert.jsp" %>
<%
	}
	
	
		
	if("SAVE".equals(RqstType))
		noDataStatement += " updated successfully";
	else if("SUBMIT".equals(RqstType)){
		noDataStatement += "has been submitted successfully ";
		noDataStatement = noDataStatement+showMsg;
		if("E".equalsIgnoreCase(ibdStatus))
			noDataStatement = showMsg;
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
</script>
</head>
<body scroll=no>
<%@ include file="../Misc/ezDisplayNoData.jsp"%>
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
<Div id="MenuSol"></Div>
</body>
</html>



