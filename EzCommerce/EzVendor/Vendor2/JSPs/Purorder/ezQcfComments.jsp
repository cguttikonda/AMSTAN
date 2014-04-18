<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@page import="java.util.*,java.io.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@include file="../../../Includes/JSPs/Purorder/iGetQcfComments.jsp" %>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<html>
<head>
	<title>Document No : <%=qcfNum%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</title>
	<%
   	if(rowCount>1 && isNew.equals("Y"))
   	{
	%>
		<script>
		var sapWindow;
		var type="";
		
		if(parent.opener.document.myForm.Type!=null)
		{
			type=parent.opener.document.myForm.Type.value
		}

		function funSubmit(action)
		{
			
	   		if(document.myForm.comments.value=="")
	   		{
	   			alert("Please Enter Your Comments")
			   	document.myForm.comments.focus();
			   	return false;
			}
			else
		   	{
				//window.returnValue=document.myForm.QcfNumber.value+"^^^"+document.myForm.comments.value+"^^^"+action
				/*parent.opener.myForm.QcfNumber.value=document.myForm.QcfNumber.value
			     	parent.opener.myForm.comments.value=document.myForm.comments.value
		     		parent.opener.myForm.actionNum.value=action
				parent.opener.myForm.action="ezSaveQcfComments.jsp"
			     	parent.opener.myForm.submit();
		   		window.close()*/
				document.myForm.Type.value=type				
				document.myForm.actionNum.value=action
				document.myForm.action="ezSaveQcfComments.jsp"
			     	document.myForm.submit();
		   	}
		   	
		}
	function funPrint()
	{
		window.print();
	}

	function openWin(num)
	{
		var url="ezQcfSAPView.jsp?qcfNumber="+num;
		sapWindow=window.open(url,"newwin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}

	function funUnload()
	{
		if(sapWindow!=null && sapWindow.open)
		{
		  sapWindow.close();
		}
	}
	</script>
</head>
<body onUnload="funUnload()">
<form name="myForm" method="post">

	
	<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
	<tr>
	<td align=left> 
	<%  if(statMessage.equals("Approved"))
	    {
		out.println("<font color='green' size='2'>Current Status : "+statMessage+"</font>");

	   }else{
		out.println("<font color='red' size='2'>Current Status : "+statMessage+"</font>");
	   }	
	%>
	</td>
	<td align=right><!--<a href="javascript:openWin('<%//qcfNum%>')">SAP View</a>-->&nbsp;</td>
	</tr>
	<tr>
	<td align=center colspan=2>
	<pre><font size="2"><%=data%></font></pre>
	</td>
	<tr>
	</Table>
	<%


    	int Count = ret.getRowCount();	
    	if(Count>0)
    	{
	%>    
		
		<table id="Table1" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<tr align="center" valign="middle">
	     	<th width="15%">User</th>
     		<th width="25%">Date</th>
	    	<th width="60%">Comments</th>
  		</tr>
		<%	
		for(int i=0;i<Count;i++)
		{
			%>
			<tr>
			<td width="15%"><%=ret.getFieldValueString(i,"USER")%></td>		  
			<td width="25%" align="center"><%=ret.getFieldValueString(i,"DATE")%></td>
			<td width="60%"><%=ret.getFieldValueString(i,"COMMENTS")%></td>
			</tr>
			<% 
		}
	%>
	</table>
	<br>
	<% } %>	

	<%
	   boolean showComments=false;
	   if(userRole.equals("PP"))
	   {
	      if(!status.equals("QCFSUBMITTEDBYPP") && !status.equals("QCFSUBMITTEDBYPH") && !status.equals("QCFSUBMITTEDBYVP") && !status.equals("QCFRETURNEDBYVP"))
	      {
	      	  showComments=true;
	      }	

	   }else if(userRole.equals("PH")){
	   
	      if(!status.equals("QCFSUBMITTEDBYPH") && !status.equals("QCFRETURNEDBYPH") && !status.equals("QCFSUBMITTEDBYVP"))	
	      {
	      	  showComments=true;
	      }	

	  }else if(userRole.equals("VP")){
		
	      if(!status.equals("QCFSUBMITTEDBYPP") && !status.equals("QCFRETURNEDBYPH") && !status.equals("QCFSUBMITTEDBYVP") && !status.equals("QCFRETURNEDBYVP"))
	      {
	      	  showComments=true;
	      }	
	 }
	
	    if(showComments)
	    {
	%>
		<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
		<tr>
		<th width="100%" align=left>Comments</th>
		</tr>
		<tr>
		<td width="100%" align=center>
		<textarea rows=3 cols=80 name="comments" style="width:100%" class="control1"></textarea>
		</td>
		<tr>
		</Table>
		
	 <% } %>

	<center>
	<%
		if(!showComments)
		{
	%>	
		<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()"> 	  
		<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif" style="cursor:hand" border=none onClick="funPrint()">
			
	<%	}
		else
		{
			if(userRole.equals("VP"))
	   		{

	%> 			<img src="../../Images/Buttons/<%=ButtonDir%>/approve.gif" style="cursor:hand" border=none onClick="funSubmit('300004')">
				<img src="../../Images/Buttons/<%=ButtonDir%>/return.gif" style="cursor:hand" border=none onClick="funSubmit('300008')">
	<%		}else if(userRole.equals("PH")) {  %>
	
				<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="funSubmit('300002')">
				<img src="../../Images/Buttons/<%=ButtonDir%>/return.gif" style="cursor:hand" border=none onClick="funSubmit('300006')">
	<%		}else if(userRole.equals("PP")){      %>
				<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" style="cursor:hand" border=none onClick="funSubmit('300000')">

	<%		} 	%>
			<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif" style="cursor:hand" border=none onClick="funPrint()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/clear.gif" style="cursor:hand" border=none onClick="document.myForm.reset()">
			<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" style="cursor:hand" border=none onClick="window.close()">
			
	<%	}	%>	
	</center> 	
	<input type="hidden" name="QcfNumber" value="<%=qcfNum%>">
	<input type="hidden" name="Created" value="<%=createdBy%>">
	<input type="hidden" name="actionNum">
	<%
	}
	else
	{
	%>
	
	<br><br><br>
	<table width="60%" align="center" border=0>

  	<%
  	   if(rowCount<=1)
  	   {
  	%>     	<tr align="center"><th>The Document No : <%=qcfNum%> does not Exists.</th></tr>

  	<% }else{%>

  		<tr align="center"><th>You have already entered comments to the Document No : <%=qcfNum%></th></tr>
  		<tr align="center"><th><a href="ezQcfComments.jsp?qcfNumber=<%=qcfNum%>&status=<%=newStat%>"><font color=white>Click here to view Comments</font></a></th></tr>

  	<% } %>

	</table>
	<br><br>
	<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">
	</center>
	<%}%>
<input type=hidden name="Type"	value="">	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
