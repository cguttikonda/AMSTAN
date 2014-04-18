<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Materials/iListSamplePOs.jsp" %>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<Script>
var tabHeadWidth=80
var tabHeight="65%"
</Script>

<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

</head>

<body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm"  action="ezShipPOReceiptDetails.jsp" method="post">
<%
	int count=sampmat.getRowCount();
	if(count==0)
	{
%>
	<br><br><br><br><br>
	<TABLE width=55% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<Th width=100%>No Purchase Orders created for Sample Materials .</th>
	</tr>
	</table>

<%	return;
	}

	String bool="false";
	for(int i=0;i<count;i++)
	{
 	   String poNumber = sampmat.getFieldValueString(i,"PONO");
	   if(!poNumber.equals("Samples"))
	   {
	   		bool="true";
	   }
	}

%>
<%


	if(bool.equals("false"))
	{
%>
	<br><br><br><br><br>
	<TABLE width=55% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<Th width=100%>No Purchase Orders created for Sample Materials .</th>
	</tr>
	</table>

<%	return;
	}
%>
<TABLE width="40%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr align="center">
    <td class="displayheader">List Sample POs</td>
  </tr>
</table>
<br>
<DIV id="theads">
<TABLE id="tabHead" width="80%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      <tr>
        <th align="center" width="30%">PO No</th>
        <th align="center" width="40%">Description</th>
        <th align="center" width="30%"> Date</th>
      </tr>
</table>
</div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%

        FormatDate fd  = new FormatDate();

	for(int i=0;i<count;i++)
	{

	   String poNumber = sampmat.getFieldValueString(i,"PONO");

	   if(!poNumber.equals("Samples"))
	   {


		String createdDate=fd.getStringFromDate((Date)sampmat.getFieldValue(i,"PODATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));


%>
		<tr>
		<td align="center" width="30%"><a href="../Materials/ezSamplePoLineItems.jsp?PurchaseOrder=<%=poNumber%>"><%=poNumber%></a></td>
		<td align="left" width="40%"><%=sampmat.getFieldValueString(i,"MATERIALNAME")%></td>
		<td align="center" width="30%"><%=createdDate%></td>
		</tr>
<%	   }
	}
%>
</table>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
