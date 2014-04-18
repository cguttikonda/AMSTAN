<%@ page import="ezc.messaging.params.*" %>
<jsp:useBean id="mailManager" class="ezc.client.EzMessagingManager" scope="session" />

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iWelcome.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iWelcome_Lables.jsp" %>

<script>
function news()
{
	attach=window.open("ezNewsPopup.jsp","UserWindow1","width=700,height=300,left=150,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
</script>
<%
	String userRole = (String)session.getValue("UserRole");
	//out.println(application.getAttribute("CARRIER_INFO"));
	int accepted 		= 0;
	int transferred 	= 0;
	int rettransferred 	= 0;
	int bonusalert		= 0;
      	int submitted		= 0;
      	int dispatchcount	= 0;
      	
	ReturnObjFromRetrieve retobj = null;

	String user		= Session.getUserId();
	String LAST_LOGIN_DATE	= (String)session.getValue("LAST_LOGIN_DATE");
	String LAST_LOGIN_TIME	= (String)session.getValue("LAST_LOGIN_TIME");
	String agentCode	= (String)session.getValue("AgentCode");
	String salesAreaCode	= (String)session.getValue("SalesAreaCode");
	
	LAST_LOGIN_TIME="00:00:00";

	ReturnObjFromRetrieve disretobj=null;

	String soldto		= "";
	StringTokenizer stoken	= new StringTokenizer(agentCode,",");

	if (stoken.countTokens()>1)
	{
		while(stoken.hasMoreTokens()) soldto+=stoken.nextToken()+",";
		soldto=soldto.substring(0,soldto.length()-1);
	}
	else
		soldto=agentCode;

	if(userRole.equals("CM"))
	{
		/*
		EzcParams params=new EzcParams(true);
		params.setLocalStore("Y");
		EziDispInfoHeaderInputParams disParams=new EziDispInfoHeaderInputParams();

		disParams=new EziDispInfoHeaderInputParams();
		disParams.setSoldTo(soldto);
		disParams.setSysKey(salesAreaCode);
		disParams.setStatus("'D'");
		try{
		int yy =Integer.parseInt(LAST_LOGIN_DATE.substring(6,10));
		int mm =Integer.parseInt(LAST_LOGIN_DATE.substring(0,2));
		int dd=Integer.parseInt(LAST_LOGIN_DATE.substring(3,5));
		disParams.setFromDate(mm+"/"+dd+"/"+yy);

		}catch(Exception e){}

		params.setObject(disParams);
		Session.prepareParams(params);
		try{

			disretobj=(ReturnObjFromRetrieve)DispatchInfoManager.ezGetSalesOrders(params);
			 dispatchcount=disretobj.getRowCount();
		}catch(Exception e){}
		*/

	}else if(userRole.equals("CU"))
	{
		/*if(session.getValue("disAlert") != null)
		{
			dispatchcount = Integer.parseInt((String)session.getValue("disAlert"));
		}else
		{
			ezc.ezdispatch.client.EzDispatchInfoManager EzManager = new ezc.ezdispatch.client.EzDispatchInfoManager();
			EzcParams params=new EzcParams(true);
			EziDispatchParams iParams=new EziDispatchParams();
			java.util.GregorianCalendar fromDate = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
			java.util.GregorianCalendar toDate =(java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();

			try{
			int yy =Integer.parseInt(LAST_LOGIN_DATE.substring(6,10));
			int mm =Integer.parseInt(LAST_LOGIN_DATE.substring(0,2));
			int dd=Integer.parseInt(LAST_LOGIN_DATE.substring(3,5));
			fromDate =new java.util.GregorianCalendar(yy,(mm-1),dd);
			}catch(Exception e){}

			iParams.setSelection("D");
			iParams.setFromDate(fromDate.getTime());
			iParams.setToDate(toDate.getTime());
	
			EzBill_headerTable headerTable = new EzBill_headerTable();
			EzBill_itemTable itemTable = new  EzBill_itemTable();
			EzBapidlvhdrTable dlvHTable = new EzBapidlvhdrTable();

			iParams.setBillingHeadersOut(headerTable);
			iParams.setBillingItemsOut(itemTable);	
			iParams.setDelivHdr(dlvHTable);
	
			params.setObject(iParams);
			Session.prepareParams(params);
			try{
				//EzoDispatch finalRetObj=(EzoDispatch)EzManager.ezGetCustomerDeliveries(params);
				//ReturnObjFromRetrieve dlvH = finalRetObj.getDelivHdr();
				///ReturnObjFromRetrieve disheader = finalRetObj.getBillingHeadersOut();
				///ReturnObjFromRetrieve disitem = finalRetObj.getBillingItemsOut();
				//dispatchcount=dlvH.getRowCount();
				session.putValue("disAlert",String.valueOf("0"));
			}catch(Exception e){}
		}*/
		

	}else if(userRole.equals("LF"))
	{	
		/*if(session.getValue("BonusAlert") != null)
		{

			bonusalert = Integer.parseInt((String)session.getValue("BonusAlert"));
		}else
		{*/
%>
		<%  ///@ include file="../../../Includes/JSPs/Sales/iGetSalesAreaDefaults.jsp"%>
<%
		/*EzcParams ezcpparams = new EzcParams(true);
		EzAlertStructure astruct = new EzAlertStructure();
		EzBonusTable tab = new EzBonusTable();
		String soffice=(String)session.getValue("SalesOffice");
		try
		{
		soffice = soffice.substring(0,soffice.indexOf(","));
		}catch(Exception e){}
		astruct.setDistriChannel(distributionChannel);
		astruct.setSalesOrg(salesOrg);
		astruct.setFlag("B");
		astruct.setSalesOffice(soffice);

		EziAlertParams inparams=new EziAlertParams();
		inparams.setAlertStruct(astruct);
		inparams.setMatList(tab);

		ezcpparams.setObject(inparams);
		Session.prepareParams(ezcpparams);

		try{
		EzoAlerts ezo= (EzoAlerts)AlertManager.ezGetBonusAlerts(ezcpparams);
	 	ReturnObjFromRetrieve matList =(ReturnObjFromRetrieve)ezo.getMatList();
		bonusalert=matList.getRowCount();

		session.putValue("BonusAlert",String.valueOf(bonusalert));
		 }catch(Exception e){}
		}*/

	}



%>

<html>
<Style>
	a{
	   color: #00385D;
	   text-decoration:none;
	}
	
	a:link{
	   color: #00385D;
	   text-decoration:none;
	}
	
	a:hover{
	   color: #00385D;
	   text-decoration:underline;
	   
	}
	
	a:visited{
	   color: #00385D;
	}
</Style>
<head>	
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body class=welcomebody topmargin = "0" leftmargin = "0" scroll=no>
<%
	String display_header = chgSinceLost_L;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href ="#" onClick="news()"><%@ include file="ezNews.jsp"%></a>
<%
	StringTokenizer stoken1=new StringTokenizer(agentCode,",");
	String SoldTos ="";
	if (stoken1.countTokens()>1)
	{
		while(stoken1.hasMoreTokens())
		{
			if(SoldTos.trim().length() ==0)
				SoldTos="'"+stoken1.nextToken()+"'";
			else
				SoldTos+=",'"+stoken1.nextToken()+"'";
		}
	}
	else
		SoldTos="'"+agentCode+"'";

	Date dd=new Date();
	dd.setTime(dd.getTime()+10000000);
	SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy hh:mm:ss:SS a");
	String today=sdf.format(dd);

	String query = " ";
	String query1="EZC_SALES_DOC_HEADER WHERE EWDHH_DOC_ID=ESDH_DOC_NUMBER and ESDH_SOLD_TO in("+SoldTos+") and EWDHH_CREATED_BY NOT IN('"+(String)Session.getUserId()+"')";

	ezc.ezparam.EzcParams mainParams1 = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFDocHistoryParams wfdocparams= new ezc.ezworkflow.params.EziWFDocHistoryParams();
	wfdocparams.setModifiedOn1(""+LAST_LOGIN_DATE+"'");
	wfdocparams.setModifiedOn2(today+"'");
	wfdocparams.setSysKey("'"+salesAreaCode+"'");
	wfdocparams.setRef1(query);
	wfdocparams.setStatus("'TRANSFERED'");
	wfdocparams.setRef2(query1);
	wfdocparams.setIsGroupBy("true");
	wfdocparams.setGroupOn(new String[]{"EWDHH_WF_STATUS"});
	mainParams1.setObject(wfdocparams);
	Session.prepareParams(mainParams1);

	ezc.ezparam.ReturnObjFromRetrieve listRet=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWFDocList(mainParams1);

	int rowId=-1;

	rowId=listRet.getRowId("EWDHH_WF_STATUS","TRANSFERED");
	if(rowId!=-1)
		transferred = Integer.parseInt(listRet.getFieldValueString(rowId,"EZCOUNT"));

	rowId=listRet.getRowId("EWDHH_WF_STATUS","RETTRANSFERED");
	if(rowId!=-1)
		rettransferred = Integer.parseInt(listRet.getFieldValueString(rowId,"EZCOUNT"));

	rowId=listRet.getRowId("EWDHH_WF_STATUS","RETCMTRANSFER");
	if(rowId!=-1)
		rettransferred +=Integer.parseInt(listRet.getFieldValueString(rowId,"EZCOUNT"));
%>

<Div id='inputDiv' style='position:absolute;background-color:#FFFFFF;top:35%;width:100%;height:20%;align:center' align=center>
<Table width="60%" height="30%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr >
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
	<Table border="0" align="center" valign=middle width="100%" cellpadding=10 cellspacing=10 class=welcomecell>
	<Tr>
		<Td width="10%" style='background:#F3F3F3'>&nbsp;</Td>
		<Td style='background:#F3F3F3;font-size=11px;color:#F3F3F3;font-weight:bold;' width='45%'>

<%
	if(transferred == 0)
	{
		out.println("<span class=alertcell><b>"+noNewAccOrd_L+"</b></span>");
	}
	else
	{
		out.println("<a style='color:#660000'    href=\"../Sales/ezListSalesOrders.jsp?newFilter=Y&orderStatus='TRANSFERED'&SearchType=&welcome=Y&RefDocType=P\" onMouseover=\"window.status=' '; return true\" onMouseout=\"window.status=' ';  return true\"><span class=alertcell><b>"+transferred  +"&nbsp;New Accepted Orders </b></span></a>");
	}
%>
		</Td>
		
		<Td style='background:#F3F3F3;font-size=11px;color:#660000;font-weight:bold;' width='45%'>

<%
	int emailMsgs	 = 0;
	EzcMessageParams  ezcMessageParams = new EzcMessageParams();
	EzMessageParams ezMessageParams = new EzMessageParams();
	ezMessageParams.setClient("200");
	ezMessageParams.setToFolderId("1000");
	ezMessageParams.setLanguage("EN");
	ezcMessageParams.setObject(ezMessageParams);
	Session.prepareParams(ezcMessageParams);
	ezc.ezparam.ReturnObjFromRetrieve retMsgList = (ezc.ezparam.ReturnObjFromRetrieve)mailManager.getPersonalNewMsgHeader(ezcMessageParams);
	retMsgList.check();
	if(retMsgList != null)
		emailMsgs = retMsgList.getRowCount();
	
	Integer i=new Integer(retMsgList.getRowCount());
	session.putValue("MailCount",i);

	if(emailMsgs > 0)
		out.println("<a href='../Inbox/ezListPersMsgs.jsp' style='color:#660000'><span class=alertcell><b>"+emailMsgs +" &nbsp;New Mail(s)</b></span></a>");
	else
		out.println("<span class=alertcell><b>No New Mails</b></span>");
%>
		</Td>
		<Td width="10%" style='background:#F3F3F3'>&nbsp;</Td>
	</Tr>
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

<!--<Div id='inputDiv1' style='position:absolute;background-color:#FFFFFF;align:center;top:50%;width:100%;height:10%'>
<Table width="60%" height="5%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr height=50px>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3';font-size:12px" valign=middle align=center>
	<Table border="0" align="center" valign=middle width="100%" cellpadding=10 cellspacing=10 class=welcomecell>
	<Tr>
	<td style="background-color:'F3F3F3';font-size=11px;font-weight:bold" valign=middle align=center><span class=alertcell><a href='../Sales/ezATPSearchOptions.jsp' style='cursor:hand'>Stock Check </a></span></Td>
	<Td style="background-color:'F3F3F3';font-size=11px;font-weight:bold" valign=middle align=center><span class=alertcell><a href='../MaterialSearch/ezSearchMaterials.jsp' style='cursor:hand'>Advanced Product Search </a></span></Td>
	</tr> 
	</table>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>-->


<Div id="MenuSol"></Div>
