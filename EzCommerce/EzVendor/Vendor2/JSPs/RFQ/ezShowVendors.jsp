<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%

	String collRfq = request.getParameter("collRfq");
	String process = request.getParameter("process");
	
	ezc.ezparam.ReturnObjFromRetrieve ret = null;
	ezc.ezpreprocurement.client.EzPreProcurementManager manager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	mainParams.setLocalStore("Y");
	
	ezc.ezpreprocurement.params.EziRFQHeaderParams params = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	params.setExt1("QTNVND");
	params.setCollectiveRFQNo(collRfq);	
	mainParams.setObject(params);
	Session.prepareParams(mainParams);
	try
	{		
		ret = (ezc.ezparam.ReturnObjFromRetrieve)manager.ezGetRFQList(mainParams);		
	}
	catch(Exception e)
	{
		System.out.println("Exception Occured in ezShowVendors.jsp:"+e.getMessage());
	}
	
	int rowCount = 0;
	if(ret!=null)
		rowCount = ret.getRowCount();
	
	String heading	= "";
	String myStatus = "";

	if("A".equals(process))
	{
		heading	 = "Vendors Sent To";
		myStatus = "YN";
	}	
	else if("Y".equals(process))
	{
		heading	 = "Vendors Quoted";
		myStatus = "Y";
	}	
	else if("N".equals(process))
	{
		heading  = "Vendors Not Quoted";	
		myStatus = "N";
	}
	else if("R".equals(process))
	{
		heading  = "Proposed Vendors";	
		myStatus = "R";
	}
%>

<html>
<head>
<Title><%=heading%></Title>
<Script>
	var tabHeadWidth=90
	var tabHeight="35%"
</Script>
<Script>
function sendReminder()
{
	document.myForm.action = "ezSendReminderMail.jsp";
	document.myForm.submit();	
}
</Script>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body>
<form name="myForm">
<input type="hidden" name="fromFrame" value="Y">
<%
	if(rowCount>0)
	{
%>
	<br><br>	
	<Table id="header" align=center width="60%" border=0 borderColorDark=#ffffff borderColorLight=#000000  cellspacing="0" cellpadding="2">
	<Tr>
		<Th><%=heading%></Th>
	</Tr>
	</Table>
	<br>
	<Div id="theads" >
	<Table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
	<Tr align="center" valign="middle">
		<Th width="25%">Vendor</th>
		<Th width="50%">Name</th>
		<Th width="25%">RFQ</th>
	</Tr>
	 </Table>
 	</Div>
 	<Div id="InnerBox1Div" align="center" style="overflow:auto;position:absolute;width:90%;height:55%;left:6%">
	<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	if("R".equals(myStatus))
	{
		java.util.Vector myVect = new java.util.Vector();
		for(int i=0;i<rowCount;i++)
		{
		  if(!myVect.contains(ret.getFieldValueString(i,"SOLD_TO")))
		  {

			if(myStatus.equals(ret.getFieldValueString(i,"REL_STATUS")))
		       {
%>
			<Tr>
				<Td width="25%"><%=ret.getFieldValueString(i,"SOLD_TO")%></Td>
				<Td width="50%"><%=ret.getFieldValueString(i,"SOLD_TO_NAME")%></Td>
				<Td width="25%"><%=ret.getFieldValueString(i,"RFQ_NO")%></Td>
			</Tr>
<%			
			myVect.add(ret.getFieldValueString(i,"SOLD_TO"));
  	         	}
		  }	
		    
		}
	}
	else
	{
		java.util.Vector myVect = new java.util.Vector();
		for(int i=0;i<rowCount;i++)
		{
		    if(!myVect.contains(ret.getFieldValueString(i,"SOLD_TO")))
		    {

		       if(myStatus.indexOf(ret.getFieldValueString(i,"STATUS")) >= 0)
		       {
%>
			<Tr>
				<Td width="25%"><%=ret.getFieldValueString(i,"SOLD_TO")%></Td>
				<Td width="50%"><%=ret.getFieldValueString(i,"SOLD_TO_NAME")%></Td>
				<Td width="25%"><%=ret.getFieldValueString(i,"RFQ_NO")%></Td>
				<input type="hidden" name="SoldTo" value='<%=ret.getFieldValueString(i,"SOLD_TO")%>'>
				<input type="hidden" name="RfqNo" value='<%=ret.getFieldValueString(i,"RFQ_NO")%>'>
			</Tr>
<%
			myVect.add(ret.getFieldValueString(i,"SOLD_TO"));
		       }	
		    }
		}
	}	
%>
	</Table>
	</Div>
	<div id="buttons" style="position:absolute;top:75%;width:100%;visibility:visible" align="center">
<%		
		if("N".equals(myStatus))
		{
    
        butNames.add("&nbsp;&nbsp;&nbsp;Send Reminder&nbsp;&nbsp;&nbsp;");   
        butActions.add("sendReminder()");	
		}
      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
      butActions.add("window.close()");
      out.println(getButtons(butNames,butActions));

    
%> 		
</div>
<%	
	}
	else
	{
%>	
	<br><br><br><br><br>
	<Table width=50% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
		<Tr>
			<Th>These vendors are not Syncronized in the System</th>
		</Tr>
	</Table>
<div id="buttons" style="position:absolute;top:90%;width:100%;visibility:visible" align="center">
<%
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    butActions.add("window.close()");
    out.println(getButtons(butNames,butActions));
%>
</div>	
		
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>