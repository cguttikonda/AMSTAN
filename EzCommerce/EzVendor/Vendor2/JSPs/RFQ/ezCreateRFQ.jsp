<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezpreprocurement.params.*,ezc.ezparam.*" %>
<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />


<%
	String selectedPRs[] = request.getParameterValues("purchReq");	
	String clubbedPRsStr = "";
	int selectedPRsCnt = 0;
	
	if(selectedPRs!=null)
		selectedPRsCnt = selectedPRs.length;
	for(int p=0;p<selectedPRsCnt;p++)
	{
		ezc.ezbasicutil.EzStringTokenizer EzToken = new ezc.ezbasicutil.EzStringTokenizer(selectedPRs[p],"$$");
		java.util.Vector Tokens = EzToken.getTokens();

		try
		{
			String prNo	= (String)Tokens.elementAt(6);	
			String matNo	= (String)Tokens.elementAt(0);	
			String prItem	= (String)Tokens.elementAt(7);	
			String plant 	= (String)Tokens.elementAt(1);	
			String qty	= (String)Tokens.elementAt(3);		
			
			if(p==0)
			{
				clubbedPRsStr = prNo+"¥"+prItem+"¥"+matNo+"¥"+plant+"¥"+qty;
			}
			else
			{
				clubbedPRsStr = clubbedPRsStr+"$"+prNo+"¥"+prItem+"¥"+matNo+"¥"+plant+"¥"+qty;
			}
			
		}
		catch(Exception e)
		{
		}	
	}		
	

	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	
	String collNo		= request.getParameter("collNo");
	String currSysKey 	= (String)session.getValue("SYSKEY");
	String qtnEndDate 	= request.getParameter("qtnEndDate");
	String material 	= request.getParameter("material");
	String delivDate 	= request.getParameter("delivDate");
	String matDesc 		= request.getParameter("matDesc");
	String uom 		= request.getParameter("uom");
	String plant 		= request.getParameter("plant");
	String Comments		= request.getParameter("commentText");
	String prno		= request.getParameter("reqNo");
	String prItmNo		= request.getParameter("prItmNo");
	String selectedVendors[]= request.getParameterValues("selChk");
	String templateCode 	= (String)session.getValue("TEMPLATE");
	String purchReq		= request.getParameter("purchReq1");
	String valType		= request.getParameter("valuationType");

	String msgText 		= "purchReq:"+purchReq+"***currSysKey:"+currSysKey+"***qtnEndDate:"+qtnEndDate+"***material:"+material+"***delivDate:"+delivDate+"***plant:"+plant+"***prno:"+prno;
	String msgSubject     	= "PRODUCTION>>RFQ ERROR";
	
	if(plant==null || "null".equals(plant) || "NA".equals(plant))
	 plant="";
	
	int vendorsCount =0;
	
	if(selectedVendors!=null)
	{
		vendorsCount	= selectedVendors.length;	
	}

	String[]   vendor    = new String[vendorsCount];
	String[]   quantity  = new String[vendorsCount];
	String[]   vendType  = new String[vendorsCount];
	String[]   agentCode = new String[vendorsCount];
	
	
	for(int i=0;i<vendorsCount;i++)
	{
		java.util.StringTokenizer vendSt =new java.util.StringTokenizer(selectedVendors[i],"#");
		try
		{
			vendSt.nextToken();
			vendor[i]	= vendSt.nextToken();
			quantity[i]	= vendSt.nextToken();
			vendType[i]	= vendSt.nextToken();
			
		}		
		catch(Exception e)
		{
		}
		if("N".equals(vendType[i]))
		{
			java.util.StringTokenizer typeSt =new java.util.StringTokenizer(vendor[i],"$");
			try
			{
				vendor[i]	= typeSt.nextToken();
				agentCode [i]	= typeSt.nextToken();
				if(agentCode[i]==null)
					agentCode [i]="";
			}
			catch(Exception e)
			{
			}			
		}
	}
			
	
	//String endDate = qtnEndDate;//dateConvertion(qtnEndDate,(String)session.getValue("DATEFORMAT"));
	String endDate = dateConvertion(qtnEndDate,(String)session.getValue("DATEFORMAT"));
	//out.println("==endDate="+endDate);

	int mm=Integer.parseInt(endDate.substring(3,5));
	int dd=Integer.parseInt(endDate.substring(0,2));
	int yy=Integer.parseInt(endDate.substring(6,10));

	GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
	Date eDate= g.getTime();
	
	endDate = endDate.substring(3,5)+"/"+endDate.substring(0,2)+"/"+endDate.substring(6,10);
	Date endDateFinal = new Date(endDate);
	String qtnEDate = qtnEndDate;//formatDate.getStringFromDate(eDate,"/",formatDate.DDMMYYYY);
	
	String endDateDB = endDate.substring(3,5)+"/"+endDate.substring(0,2)+"/"+endDate.substring(6,10);
	java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm a");
	
	Date qdt = new Date();
	String qtnDt = sdf.format(qdt);
	
	String today 	= qtnDt;//formatDate.getStringFromDate(new Date(),"/",formatDate.DDMMYYYY);
	
	//out.println("==endDateFinal="+endDateFinal);
	//out.println("==qtnEDate="+qtnEDate);
	
	GregorianCalendar escG=new GregorianCalendar(yy,mm-1,dd);
	Date eDateEsc=escG.getTime();
	Date currentDateX = new Date();
	Date currentDate = new Date(currentDateX.getYear(),currentDateX.getMonth(),currentDateX.getDate(),0,0,0);
	long durationVal = (eDateEsc.getTime()-currentDate.getTime());
	int duration =(int) (durationVal/(24*60*60*1000));
	duration = duration + 1;
	
	ezc.ezparam.ReturnObjFromRetrieve rfqRet = null;
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	
	EzcParams 		ezcparams		= new ezc.ezparam.EzcParams(false);
	EzcParams 		ezcparamsSAP		= new ezc.ezparam.EzcParams(false);	
	EziRFQHeaderParams 	ezirfqheaderparams    	= new EziRFQHeaderParams();
	EziRFQHeaderParams	headerParams		= new EziRFQHeaderParams();
	EziRFQHeaderTable 	ezirfqheadertable 	= new EziRFQHeaderTable();
	EziRFQHeaderTableRow 	ezirfqheadertablerow   	= null;
	EziRFQDetailsTable 	ezirfqdetailstable 	= new EziRFQDetailsTable();
	EziRFQDetailsTableRow 	ezirfqdetailstablerow 	= null;	
	EziRFQItemTable     	itemTable       	= new EziRFQItemTable();
	EziRFQItemTableRow	itemTableRow		= null;
	EziRFQItemQtyTable  	qtyTable		= new EziRFQItemQtyTable();
	EziRFQItemQtyTableRow 	qtyTableRow		= null;
	EziRFQVendAddrTable 	vendAddr		= new EziRFQVendAddrTable();
	EziRFQVendAddrTableRow 	vendAddrRow  		= null;
  	EziAuditTrailTable eziaudittable = new EziAuditTrailTable();
  	EziAuditTrailTableRow 	eziaudittablerow 	= null;	

	
	String purchOrg    = (String)Session.getUserPreference("PURORG");
	String purGrp  	   = (String)Session.getUserPreference("PURGROUP");
	String defCollRfq  = (String)Session.getUserPreference("COLLECTIVERFQ");
		
	
	boolean messflg	   = false;

	headerParams.setCollectiveRFQNo(collNo);
	headerParams.setPRNo(prno);
	headerParams.setQuotationendDate(endDateFinal);
	headerParams.setPurchaseGrp(purGrp);

	
	int item = 10;
	
	itemTableRow	= new EziRFQItemTableRow();
	itemTableRow.setPOItm(item+"");
	itemTableRow.setMaterial(material);
		
	itemTableRow.setPlant(plant);
	
	if(prno==null || "null".equals(prno) || "".equals(prno.trim()))
	itemTableRow.setUOM(uom);
	
	itemTableRow.setComments(Comments);    
	itemTable.appendRow(itemTableRow);
		
	//out.println("==delivDate=="+delivDate);
	int mm1=Integer.parseInt(delivDate.substring(3,5));
        int dd1=Integer.parseInt(delivDate.substring(0,2));
        int yy1=Integer.parseInt(delivDate.substring(6,10));
        GregorianCalendar g1=new GregorianCalendar(yy1,mm1-1,dd1);
        Date delDate=g1.getTime();
        String dDate 	= delivDate;//formatDate.getStringFromDate(delDate,"/",FormatDate.MMDDYYYY);		
	String dDate1	= delivDate;//formatDate.getStringFromDate(delDate,".",FormatDate.MMDDYYYY);		

	String delivDateDB = delivDate.substring(3,5)+"/"+delivDate.substring(0,2)+"/"+delivDate.substring(6,10);
	//out.println("==vendorsCount=="+vendorsCount);
	
	for(int i=0;i<vendorsCount;i++)
	{
		ezc.ezcommon.EzLog4j.log("=item="+item,"I");
		ezc.ezcommon.EzLog4j.log("=prItmNo="+prItmNo,"I");
		ezc.ezcommon.EzLog4j.log("=quantity="+quantity[i],"I");
		ezc.ezcommon.EzLog4j.log("=dDate="+dDate,"I");
		ezc.ezcommon.EzLog4j.log("=vendor[i]="+vendor[i],"I");
		ezc.ezcommon.EzLog4j.log("=agentCode[i]="+agentCode[i],"I");
		ezc.ezcommon.EzLog4j.log("=matDesc="+matDesc,"I");
		
		
		qtyTableRow     =  new EziRFQItemQtyTableRow();
		qtyTableRow.setItmNo(item+"");
		qtyTableRow.setPRItmNo(prItmNo);
		qtyTableRow.setQuantity(quantity[i]);
		qtyTableRow.setDelDate(dDate);
		qtyTable.appendRow(qtyTableRow);
		item = item+10;
		vendAddrRow 	= new EziRFQVendAddrTableRow();		
		vendAddrRow.setVendor(vendor[i]);
		vendAddrRow.setAgent(agentCode[i]);
		vendAddr.appendRow(vendAddrRow);
		itemTableRow.setShortText(matDesc);
	}	
	
	ezcparamsSAP.setObject(headerParams);
	ezcparamsSAP.setObject(itemTable);
	ezcparamsSAP.setObject(qtyTable);
	ezcparamsSAP.setObject(vendAddr);
	Session.prepareParams(ezcparamsSAP);
	
	ezc.ezcommon.EzLog4j.log("***ezCreateRFQ.jsp*Before**ezCreateRFQ","I");
	rfqRet = (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezCreateRFQ(ezcparamsSAP);
	ezc.ezcommon.EzLog4j.log("***After ezCreateRFQ.jsp***ezCreateRFQ"+rfqRet.toEzcString(),"I");
	
	if(rfqRet.getRowCount() > 0)
		collNo = rfqRet.getFieldValueString(0,"COLLECTIVERFQ");
	int rfqCount = rfqRet.getRowCount();
	boolean isError = false;
	String retMessage = "";
	String retWarnMessage = "";	
	String retTemp 	  = "";
	int errMsgCnt = 0;
	int wrngMsgCnt = 0;
  	java.util.Vector vendVect = new java.util.Vector();
	
	java.util.Hashtable errMsgHash=new java.util.Hashtable();
	errMsgHash.put("06_053","No Selectable Items exist for PR");
	errMsgHash.put("06_199","Missing Authorization");
	errMsgHash.put("ME_046","Material Not Maintained by Purchasing");
	errMsgHash.put("ME_003","Plant Not Maintained");
	errMsgHash.put("00_055","Required Fields Missing");
	
	int ind =0;
	if(rfqCount>0)
	{

		messflg = true;
		if(messflg)
	 		retMessage = "<Tr><Td align='center'></Td><Th>"+"RFQ created for selected vendors successfully </Th></Tr>";		
		else
	 		retMessage = "<Tr><Td align='center'></Td><Th>"+"RFQ added to the Collective RFQ No : "+collNo+" </Th></Tr>";		

		for(int i=0;i<=rfqCount;i++)
		{
			if(rfqRet.getFieldValueString(i,"MSGTYP").equals("E"))
			{
				String errorMsg = rfqRet.getFieldValueString(i,"MESSAGE");
								
				msgText += "MSGV1>>>>"+rfqRet.getFieldValueString(i,"MSGV1")+"<Br>";
				msgText += "MSGV2>>>>"+rfqRet.getFieldValueString(i,"MSGV2")+"<Br>";
				msgText += "MSGV4>>>>"+rfqRet.getFieldValueString(i,"MSGV4")+"<Br>";								
				msgText += "MSGID>>>>"+rfqRet.getFieldValueString(i,"MSGID")+"<Br>";												
				msgText += "MSGNR>>>>"+rfqRet.getFieldValueString(i,"MSGNR")+"<Br>";	
				
				String e1=rfqRet.getFieldValueString(i,"MSGID")+"_"+rfqRet.getFieldValueString(i,"MSGNR");
				String myErrMsg = "";
				if(errMsgHash.get(e1) != null)
					myErrMsg = (String)errMsgHash.get(e1);
				
				//retMessage = "Error Creating RFQ"+"<br>"+myErrMsg;
				if(errMsgCnt==0)
					retMessage = errorMsg;
				else
					retMessage = retMessage+"<Br>"+errorMsg;
					
				errMsgCnt++;	
				isError = true;
				break;
			
			}
			else if(rfqRet.getFieldValueString(i,"MSGTYP").equals("S") && rfqRet.getFieldValueString(i,"MSGNR").equals("017"))
			{
				String rfq 	  = rfqRet.getFieldValueString(i,"MSGV2");
				String vendfrmsap = rfqRet.getFieldValueString(i,"MSGV4");
				
			ezc.ezcommon.EzLog4j.log("=endDateDB="+endDateDB,"I");
				ezirfqheadertablerow = new EziRFQHeaderTableRow();
				ezirfqheadertablerow.setCollectiveRFQNo(collNo);
				ezirfqheadertablerow.setRFQNo(rfq);
				ezirfqheadertablerow.setSysKey((String)session.getValue("SYSKEY"));
				ezirfqheadertablerow.setSoldTo(vendfrmsap);
				ezirfqheadertablerow.setPRNo(prno);
				ezirfqheadertablerow.setPRItmNo(prItmNo);
				ezirfqheadertablerow.setStatus("N");
				ezirfqheadertablerow.setRFQDate(today);
				ezirfqheadertablerow.setValidUpto(endDateDB);
				ezirfqheadertablerow.setCreatedBy(Session.getUserId());
				ezirfqheadertablerow.setModifiedBy(Session.getUserId());
				ezirfqheadertablerow.setPurchaseOrg(purchOrg); 
				ezirfqheadertablerow.setPurchaseGrp(purGrp); 
				ezirfqheadertablerow.setVendorType(vendType[ind]); 
				ezirfqheadertablerow.setAgentCode(agentCode[ind]); 
				ezirfqheadertablerow.setReleaseIndicator("N"); 
				ezirfqheadertablerow.setRankStatus(""); 
				ezirfqheadertablerow.setExt1(Comments); 
				ezirfqheadertablerow.setExt2(""); 
				ezirfqheadertablerow.setExt3("N"); 
				ezirfqheadertablerow.setPRDetails(clubbedPRsStr);
				ezirfqheadertablerow.setValType(valType);				
				ezirfqheadertable.appendRow(ezirfqheadertablerow);
				
				int line = 10;
				
				ezirfqdetailstablerow = new EziRFQDetailsTableRow();
				ezirfqdetailstablerow.setRFQNo(rfq); 
				ezirfqdetailstablerow.setLineNo(line+""); 
				ezirfqdetailstablerow.setCounter("0"); 
				ezirfqdetailstablerow.setMaterial(material); 
				ezirfqdetailstablerow.setMaterialDesc(matDesc);
				ezirfqdetailstablerow.setUOM(uom); 
				ezirfqdetailstablerow.setDeliveryDate(delivDateDB);
				ezirfqdetailstablerow.setQuantity(quantity[ind]); 
				ezirfqdetailstablerow.setPlant(plant); 
				ezirfqdetailstablerow.setPrice("0"); 
				ezirfqdetailstablerow.setRemarks(" "); 
				ezirfqdetailstablerow.setExt1(""); 
				ezirfqdetailstablerow.setExt2(""); 
				ezirfqdetailstablerow.setExt3(""); 
				ezirfqdetailstable.appendRow(ezirfqdetailstablerow);
        
				eziaudittablerow 	= new EziAuditTrailTableRow();	
				eziaudittablerow.setDocId(rfq);
				eziaudittablerow.setDocType("AN");
				eziaudittablerow.setDocCategory("A");
				eziaudittablerow.setUserName(Session.getUserId());
				eziaudittablerow.setFMName("Z_EZ_RFQ_CREATE");
				eziaudittablerow.setIPAddress(request.getRemoteAddr());
				eziaudittablerow.setPurOrg(purchOrg);
				eziaudittablerow.setPurGrp(purGrp);
				eziaudittablerow.setComments("RFQ has been created");
				eziaudittablerow.setChangeInd("I");
				eziaudittable.appendRow(eziaudittablerow);


				retTemp = "<Tr><Td align='center'><!--<Input type=checkbox name=chk1 value='"+rfq+"¥"+vendfrmsap+"¥"+collNo+"'>--></Td><Td>"+(ind+1) +".RFQ No : "+rfq+"      Vendor: "+vendfrmsap+"<br></Td></Tr>";
				ind++;
			}
			else if("W".equals(rfqRet.getFieldValueString(i,"MSGTYP")) || "I".equals(rfqRet.getFieldValueString(i,"MSGTYP")))
			{
				String warningMsg = rfqRet.getFieldValueString(i,"MESSAGE");
				if(wrngMsgCnt==0)
					retWarnMessage = warningMsg;
				else
					retWarnMessage = retWarnMessage+"<Br>"+warningMsg;
				
				wrngMsgCnt++;
			}
			retMessage = retMessage+retTemp; 
			retTemp ="";
		}
	}
	else
	{
		retMessage = "Error in Creating RFQ";
		isError = true;
	}
	if(!isError)
	{		
		ezcparams.setObject(ezirfqheadertable);
		ezcparams.setObject(ezirfqdetailstable);
		ezcparams.setLocalStore("Y");
		Session.prepareParams(ezcparams);
	ezc.ezcommon.EzLog4j.log("::::::::Before ezAddRFQ:::::::::::","D");
		ezrfqmanager.ezAddRFQ(ezcparams);
    
    		ezcparamsSAP.setObject(eziaudittable);
    		Session.prepareParams(ezcparamsSAP);
    		ezrfqmanager.ezAddAuditTrail(ezcparamsSAP);
 %>
		<%//@ include file="ezSendQuotationMail.jsp" %>					
<%
		/***
		     Checking for expiry of the quotation -- start
		***/

		ezc.ezworkflow.client.EzWorkFlowManager EzWorkFlow = new ezc.ezworkflow.client.EzWorkFlowManager();
		ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"PARTICIPANT","PARTICIPANT_TYPE","ROLE","STATUS","SYSKEY","DOCID","TEMPLATE","AUTHKEY","MODIFIEDBY","ACTIONCODE","DELPARTICIPANT","DELPARTICIPANTTYPE","ADDORUPDATE","PREVPARTICIPANT","PREVPARTICIPANT_TYPE","INITIATOR","WFTYPE","MAIL_EXTS","COMMENTS"});
		finalRet.setFieldValue("PARTICIPANT"		,	Session.getUserId());
		finalRet.setFieldValue("PARTICIPANT_TYPE"	,	"-");
		finalRet.setFieldValue("ROLE"			,	"-");
		finalRet.setFieldValue("STATUS"			,	"EXPIRY");
		finalRet.setFieldValue("SYSKEY"			,	(String)session.getValue("SYSKEY"));
		finalRet.setFieldValue("DOCID"			,	collNo);
		finalRet.setFieldValue("TEMPLATE"		,	templateCode);
		finalRet.setFieldValue("AUTHKEY"		,	"QCF_EXPIRY");
		finalRet.setFieldValue("MODIFIEDBY"		,	Session.getUserId());
		finalRet.setFieldValue("ACTIONCODE"		,	"-");
		finalRet.setFieldValue("DELPARTICIPANT"		,	"-");
		finalRet.setFieldValue("DELPARTICIPANTTYPE"	,	"-");
		finalRet.setFieldValue("ADDORUPDATE"		,	"ADD");
		finalRet.setFieldValue("PREVPARTICIPANT"	,	"-");
		finalRet.setFieldValue("PREVPARTICIPANT_TYPE"	,	"-");
		finalRet.setFieldValue("INITIATOR"		,	"-");
		finalRet.setFieldValue("WFTYPE"			,	"-");
		finalRet.setFieldValue("MAIL_EXTS"		,	"-");
		finalRet.setFieldValue("COMMENTS"		,	duration+"");
		finalRet.addRow();

		//EzWorkFlow.doEscalate(finalRet,null);

		/***
		     Checking for expiry of the quotation -- End
		***/		
	}
	else
	{
		java.util.Vector extMailIds = new java.util.Vector();
		extMailIds.addElement("vsanampudi@answerthink.com");
		extMailIds.addElement("ezcsupport@answerthink.com");
%>
		<%//@ include file="../Inbox/ezSendExternalMail.jsp" %>				
<%	
	}
	
%>
<html>
<head>
<title>
	Message
</title>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>



function checkAll()
	{
		var chkObj 	= document.myForm.chk;
		var chkObj1 	= document.myForm.chk1;
		var chkLen	= chkObj1.length;
		var chkValue	= "";
		var count	= 0;
	
		if(chkObj.checked)
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = true;
				}
			}
			else
			{
				chkObj1.checked = true;
			}
		}
		else
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = false;
				}
			}
			else
			{
				chkObj1.checked = false;
			}
		}
	}
	
	
	function checkSelction()
	{
		var rfqObj = document.myForm.chk1;
		var rfqLen = "";
		var count = 0;
		var args = "";
		var selRfq = "";
		var soldTo = "";

		if(rfqObj != null)
		{
			rfqLen = document.myForm.chk1.length
			if(!isNaN(rfqLen))
			{

				for(i=0;i<rfqLen;i++)
				{
					if(document.myForm.chk1[i].checked)
					{
						count++;
					}
				}
			}
			else
			{
				if(document.myForm.chk1.checked)
				{
					count++;
				}	
			}
		}

		
		if(count==0)
		{
			alert("Please select atleast one RFQ to Invite");
			return;
		}
		else
			return true;
	}	
	
	function sendInvitation()
	{
		if(checkSelction())
		{
			if(confirm("By pressing OK you can send an Invitation."))
			{					
				document.myForm.action="ezCounterOffer.jsp";
				document.myForm.submit();
			}

		}
	}




function funGo()
{
  document.myForm.action="ezVendorViewList.jsp";
  document.myForm.submit();
}
function funOk()
{
	document.myForm.action="../RFQ/ezListPR.jsp?Status=R";
  document.myForm.submit();
}
</script>
<script language="Javascript1.2">
	am = "This function is disabled!";
	bV  = parseInt(navigator.appVersion)
	bNS = navigator.appName=="Netscape"
	bIE = navigator.appName=="Microsoft Internet Explorer"
	function nrc(e) 
	{
	   if (bNS && e.which > 1)
	   {
	      alert(am)
	      return false
	   } 
	   else if (bIE && (event.button >1)) 
	   {
	     alert(am)
	     return false;
	   }
	}
	document.onmousedown = nrc;
	if (document.layers) window.captureEvents(Event.MOUSEDOWN);
	if (bNS  && bV<5) window.onmousedown = nrc;
	
</script>

</head>
<body >
<form name="myForm" method="post">
<input type="hidden" name="reqFrom" value="InviteGrp">

<%
	String display_header = "";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
<br>
<br>

<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
	String align = "center";
	if(isError)
	{
		align = "left";
%>
		<tr align="center">
		    <th align="center" colspan=2><Font size=2 color=red><B>ERROR</B></Font></th>
  		</tr>
<%
	}
%>
  <tr align="<%=align%>">
    <th align="<%=align%>"><%=retMessage%></th>
  </tr>
</table>
<Br><Br>
<%
	if(!"".equals(retWarnMessage))
	{
%>
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
		<Table id="InnerBox1Tab" width=60% align=center  borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<tr align="center">
		    <th align="center" colspan=2><Font size=2 color=white><B>WARNING/INFO</B></Font></th>
  		</tr>
			
			<tr align="center">
			    <th align="left" colspan=2><%=retWarnMessage%></th>
			</tr>
		</Table>
		</Div>
<%
	}  	
%>
<br><br><br><br>
<center>
<%
if(isError)
{
      buttonName = new java.util.ArrayList();
      buttonMethod = new java.util.ArrayList();
      
      buttonName.add("&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;");      
      buttonMethod.add("funGo()");
      out.println(getButtonStr(buttonName,buttonMethod));
}
else
{
      buttonName = new java.util.ArrayList();
      buttonMethod = new java.util.ArrayList();
      
      buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;");  
      buttonMethod.add("funOk()");
      
   //   buttonName.add("&nbsp;&nbsp;Invite&nbsp;&nbsp;");  
   //   buttonMethod.add("sendInvitation()");
      out.println(getButtonStr(buttonName,buttonMethod));
}
%>
</center>
<Div id="MenuSol"></Div>
<input type="hidden" name="purchaseHidden"   value="<%=purchReq%>">
</form>
</body>
</html>

