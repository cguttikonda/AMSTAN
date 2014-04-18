<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*,java.text.*" %>
<%@ page import="ezc.ezutil.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iListReceipts.jsp" %>
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
<form name="myForm" method="post">
<%
	int count=sampmat.getRowCount();
	if(count==0)
	{
%>
	<br><br><br><br><br>
	<TABLE width=80% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<tr>
	<Th>Vendor : <%=session.getValue("Vendor")%> has not send Samples .</th>
	</tr>
	</table>

<%
	return;
	}
%>
<TABLE width="40%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
  <tr align="center">
    <td class="displayheader">List Receipts</td>
  </tr>
</table>
<br>
<DIV id="theads">
<TABLE id="tabHead" width="80%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
      <tr>
        <th align="center" width="35%">Material Description</th>
        <th align="center" width="20%">PO No</th>
        <th align="center" width="15%">Order Date</th>
        <th align="center" width="15%">Submission Date</th>
        <th align="center" width="15%">Details</th>
      </tr>
</table>
</div>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%;left:2%">
<TABLE  id="InnerBox1Tab" width="100%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%

	FormatDate fd = new FormatDate();

	for(int i=0;i<count;i++)
	{
		String createdate = fd.getStringFromDate((Date)sampmat.getFieldValue(i,"SUBMISSIONDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String sampleId=sampmat.getFieldValueString(i,"SAMPLEID");
		String poNumber=sampmat.getFieldValueString(i,"PONO");
		      poNumber = poNumber.equals("Samples") ? "NA":poNumber;
		String orderDate=sampmat.getFieldValueString(i,"PODATE");
		if(!orderDate.equals("null"))
		{
			orderDate = fd.getStringFromDate((Date)sampmat.getFieldValue(i,"PODATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
			if(("01.01.1900".equals(orderDate)))
			{
				orderDate="NA";	
			}
		}
		else
		{
		       orderDate="NA";
		}

%>
		<tr>
		<td align="left" width="35%"><a href="ezViewVendorQuestionnaire.jsp?chk1=<%=sampmat.getFieldValueString(i,"MATERIALID")%>" ><%=sampmat.getFieldValueString(i,"MATERIALNAME")%></a></td>
		<td align="center" width="20%"><%=poNumber%>&nbsp;</td>
		<td align="center" width="15%"><%=orderDate%>&nbsp;</td>
		<td align="center" width="15%"><%=createdate%></td>
		<td align="center" width="15%"><a href="ezViewReceiptDetails.jsp?SampleId=<%=sampleId%>&materialdesc=<%=sampmat.getFieldValueString("MATERIALNAME")%>">click</a></td>
		</tr>



<%
	}
%>
</table>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
