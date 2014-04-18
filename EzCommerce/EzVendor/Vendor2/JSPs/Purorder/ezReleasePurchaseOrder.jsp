<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*" %>
<jsp:useBean id="Session" class ="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class ="ezc.ezvendorapp.client.EzVendorAppManager" scope="page"></jsp:useBean>
<%
	ezc.ezvendorapp.params.EzPOAcknowledgementTable table = new ezc.ezvendorapp.params.EzPOAcknowledgementTable();
	ezc.ezvendorapp.params.EzPOAcknowledgementTableRow tableRow = null;
	
	FormatDate formatDate = new FormatDate();
	java.util.Date dateObj = new java.util.Date();
	String date = formatDate.getStringFromDate(dateObj,".",FormatDate.DDMMYYYY);
	
	Hashtable mailData = new Hashtable();
	
	String msgType 		= "POREL";
	boolean sendToExt 	= true ;  
	boolean isVendor 	= false;

	String purchaseOrder = "";
	String mailer	     = "";
	String orderType     = "";
	String poSyskey      = "";
	String temp	     = "";	
	
	String POString      = request.getParameter("poData");
	if(POString.endsWith("µ"))
	{
		POString = POString.substring(0,POString.length()-1);
	}
	if(POString.indexOf("µ") == -1)
	{
		StringTokenizer poToken = new StringTokenizer(POString,"¥");
		purchaseOrder = (String)poToken.nextElement();
		mailer	      = (String)poToken.nextElement();
		orderType     = (String)poToken.nextElement();
		poSyskey      = (String)poToken.nextElement();  
		mailer	      = mailer+"##"+poSyskey;
		
		tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
		tableRow.setDocNo(purchaseOrder);
		tableRow.setDocStatus("A");
		tableRow.setModifiedOn(date);
		tableRow.setHeaderText((String)Session.getUserId()+"¥"+dateObj);
		table.appendRow(tableRow);
		
		if(mailData.containsKey(mailer))
		{
			temp = ((String)mailData.get(mailer))+", "+purchaseOrder;
			mailData.put(mailer,temp);
		}
		else
		{
			mailData.put(mailer,purchaseOrder);
		}			
	}
	else
	{
		StringTokenizer mainPOToken = new StringTokenizer(POString,"µ");
		String subPOString = "";
		while(mainPOToken.hasMoreElements())
		{
			subPOString = (String)mainPOToken.nextElement();
			StringTokenizer subPOToken = new StringTokenizer(subPOString,"¥");
			purchaseOrder = (String)subPOToken.nextElement();
			mailer	      = (String)subPOToken.nextElement();
			orderType     = (String)subPOToken.nextElement();
			poSyskey      = (String)subPOToken.nextElement();
			mailer	      = mailer+"##"+poSyskey;
			
			tableRow = new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();
			tableRow.setDocNo(purchaseOrder);
			tableRow.setDocStatus("A");
			tableRow.setModifiedOn(date);
			tableRow.setHeaderText((String)Session.getUserId()+"¥"+dateObj);
			table.appendRow(tableRow);

			if(mailData.containsKey(mailer))
			{
				temp = ((String)mailData.get(mailer))+", "+purchaseOrder;
				mailData.put(mailer,temp);
			}
			else
			{
				mailData.put(mailer,purchaseOrder);
			}			
		}	
	}
	ezc.ezparam.EzcParams ezParams = new ezc.ezparam.EzcParams(true);
	ezParams.setLocalStore("Y");
	ezParams.setObject(table);
	Session.prepareParams(ezParams);
	AppManager.ezUpdatePOAcknowledgement(ezParams);
	
	
	if("B".equals(orderType))
		response.sendRedirect("ezListBlockedPOs.jsp");
	if("R".equals(orderType))
		response.sendRedirect("ezListAcknowledgedPOs.jsp?type=Rejected");
		
%>
<%@include file="ezSendMailCounter.jsp"%>
<Div id="MenuSol"></Div>