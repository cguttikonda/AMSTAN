<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iSendReminders_Labels.jsp"%>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezutil.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>


<%
	String[] chk 		= request.getParameterValues("chk");
	 
	String tempCodes[] = null;
	Hashtable mailData = new Hashtable();
	String temp = "";
	String msgType = "POREMIND";
	boolean sendToExt = true ;  
	boolean isVendor  = false;	
	 
	
	String purchaseOrder = "";
	String sendToVendor = ""; 
	
	String mailer	     = "";
	String orderType     = "";
	String poSyskey      = "";
	
	
	/*String poNums[] = request.getParameterValues("chk1");
	int poLength = 0;
	if(poNums != null)
	{
		poLength = poNums.length;
	}
	for(int i=0;i<poLength;i++)
	{
		purchaseOrder = poNums[i];
		tempCodes = (purchaseOrder).split("¥") ;
		
		if(mailData.containsKey(tempCodes[1]))
		{
			temp = ((String)mailData.get(tempCodes[1]))+", "+tempCodes[0];
			mailData.put(tempCodes[1],temp);
		}
		else
		{
			mailData.put(tempCodes[1],tempCodes[0]);
		}
		
	 }*/
	 
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
	 
	 
	 
	 	 
	 String noDataStatement = remSentVen_L;
%>
<%@include file="ezSendMailCounter.jsp"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
function ezHref(param)
{
	document.myForm.action=param;
	document.myForm.submit();
}
</script>
</head>
<body scroll=no>
<form name=myForm>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
	
	out.println(getButtonStr(buttonName,buttonMethod));	
%>
</center>
</Div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

