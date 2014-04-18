 
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class ="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class ="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<%
	String sysKey = (String)session.getValue("SYSKEY");
	String soldTo = (String)session.getValue("SOLDTO");
	java.util.Date d = new java.util.Date();
	FormatDate formatDate = new FormatDate();
	String date=formatDate.getStringFromDate(d,".",FormatDate.DDMMYYYY);
	ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow=null;
	ezc.ezvendorapp.params.EzPOAcknowledgementTable table=new ezc.ezvendorapp.params.EzPOAcknowledgementTable();
	ezc.ezparam.EzcParams ezParams = new ezc.ezparam.EzcParams(true);
	ezParams.setLocalStore("Y");
	
	
	Hashtable mailData = new Hashtable();
	String temp = "";
	String msgType = "POACK";
	boolean sendToExt = true ;  
	boolean isVendor  = true;	
	

	String tempCodes[] = null;
	String purchaseOrder = "";
	String poNums[] = request.getParameterValues("chk1");
	int poLength = 0;
	if(poNums != null)
	{
		poLength = poNums.length;
	}
	for(int i=0;i<poLength;i++)
	{
		purchaseOrder = poNums[i];
		//out.println(purchaseOrder);
		tempCodes = (purchaseOrder).split("¥") ;
		tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
		tableRow.setDocNo(tempCodes[0]);
		tableRow.setDocStatus("X");
		tableRow.setModifiedOn(date);
		
		table.appendRow(tableRow);
		
		if(mailData.containsKey(tempCodes[1]))
		{
			temp = ((String)mailData.get(tempCodes[1]))+", "+tempCodes[0];
			mailData.put(tempCodes[1],temp);
		}
		else
		{
			mailData.put(tempCodes[1],tempCodes[0]);
		}
			
	}
	ezParams.setObject(table);
	Session.prepareParams(ezParams);
	AppManager.ezUpdatePOAcknowledgement(ezParams);
	response.sendRedirect("ezListAcknowledgedPOs.jsp?type=NotAcknowledged");
%>
<%@include file="ezSendMailCounter.jsp"%>
<Div id="MenuSol"></Div>

