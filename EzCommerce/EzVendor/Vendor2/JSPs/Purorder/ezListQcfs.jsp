<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@include file="../../../Includes/JSPs/Purorder/iListQcfs.jsp" %>


<%
	
	if(retobj.getRowCount()>0)
	{
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
var tabHeadWidth=96
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>


<script>
	var newWindow

	function showComments(qcfNumber,status,createdby)
	{
		newWindow=window.open("ezQcfComments.jsp?qcfNumber="+qcfNumber+"&status="+status+"&createdBy="+createdby,"myWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}

	function funUnload()
	{
		if(newWindow!=null && newWindow.open)
		{
		  newWindow.close();
		}
	}


</script>



</head>
<body onLoad="scrollInit()" onResize="scrollInit()" onUnload="funUnload()" scroll=no>
<form name="myForm" method="post">
	<table  id="Header" width="50%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
 <tr>
	<th width="50%" valign="middle">Collective RFQs List</th>
	</tr>
	</table><br><br>

	<DIV id="theads">
	<table  id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
  	<tr align="center" valign="middle">
  	<th width="20%">Collective RFQ No</th>
  	<th width="17%">Created By</th>
  	<th width="15%">Created Date</th>
  	<th width="17%">Last Action By</th>
  	<th width="15%">Last Action Date</th>
  	<th width="16%">Status</th>
  	</tr>
	</Table>
	</DIV>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

	<%

	FormatDate fd = new FormatDate();
     	int Count = retobj.getRowCount();
     	String statMessage="";
	for(int i=0;i<Count;i++)
     	{		
     		String stat = retobj.getFieldValueString(i,"STATUS");
     		if(stat.equals("QCFSUBMITTEDBYVP"))
     			statMessage="Approved";
     		else if(stat.equals("QCFSUBMITTEDBYPH"))
     			statMessage="Submitted";	
     		else if(stat.equals("QCFSUBMITTEDBYPP"))
			statMessage="Submitted";		
     		else if(stat.equals("QCFRETURNEDBYVP"))
     			statMessage="Returned";		
     		else if(stat.equals("QCFRETURNEDBYPH"))
     			statMessage="Returned";		
		     			
	%>
		<tr>
		<td align="left" width="20%"><a href="JavaScript:showComments('<%=retobj.getFieldValueString(i,"DOCID")%>','<%=retobj.getFieldValueString(i,"STATUS")%>','<%=retobj.getFieldValueString(i,"CREATEDBY")%>')"><%=retobj.getFieldValueString(i,"DOCID")%></a></td>
		<td align="center" width="17%"><%=retobj.getFieldValueString(i,"CREATEDBY")%></td>
		<td align="center" width="15%"><%=fd.getStringFromDate((Date)retobj.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
		<td align="center" width="17%"><%=retobj.getFieldValueString(i,"MODIFIEDBY")%></td>
		<td align="center" width="15%"><%=fd.getStringFromDate((Date)retobj.getFieldValue(i,"MODIFIEDON"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
		<td align="center" width="16%"><%=statMessage%></td>
		</tr>
	<%}%>
	</table>
	</div>

	<input type="hidden" name="QcfNumber">
	<input type="hidden" name="comments">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="Created">

<% }else{ %>

	<br><br><br>
	<table width="60%" align="center" border=0>
	<tr align="center">
	<th>No QCFs Found.</th>
	</tr>
	</table>
	<%}%>
<input type="hidden" name="Type" value="<%=type%>">	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
