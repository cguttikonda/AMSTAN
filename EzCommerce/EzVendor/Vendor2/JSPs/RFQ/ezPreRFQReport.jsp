<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iWFListQcfs.jsp" %>

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
	function showComments(qcfNumber)
	{
		document.myForm.QcfNumber.value=qcfNumber;
		document.myForm.action="ezRFQReport.jsp";
		document.myForm.submit();
	}

	function funUnload()
	{
		if(newWindow!=null && newWindow.open)
		{
		  newWindow.close();
		}
	}
	
	function showVendors(collRfq,proc)
	{
		var url="ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
		newWindow=window.open(url,"VendWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function showGraph(collRfq)
	{
		var url="ezTestReport.jsp?collRFQ="+collRfq;
		newWindow=window.open(url,"ReportWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

	}


</script>

</head>
<body onLoad="scrollInit()" onResize="scrollInit()" onUnload="funUnload()" scroll=no>
<form name="myForm" method="post">

<%
	String display_header = "Collective RFQs List";
	if(myRetCount>0)
	{
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>


	<DIV id="theads">
	<table  id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
  	<tr align="center" valign="middle">
	<th width="13%">Collective RFQ No.</th>
	<th width="36%">Material</th>
	<th width="12%">RFQ Date</th>
	<th width="12%">RFQ Valid Upto</th>
	<th width="8%">Vendors Sent To</th>
	<th width="8%">Quoted</th>
	<th width="8%">Not Quoted</th>
  	</tr>
	</Table>
	</DIV>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >


	<tr>

		<td width="13%"><a href = "javascript:showComments('11111')" >bbbbbbbb</a></td>
		<td width="36%"><a href="javascript:showGraph('2222')">aaaaaaaa</a></td>
		<td width="12%">1111111111</td>
		<td width="12%">222222222</td>
		<td width="8%"><a href="javascript:showVendors('3333333','A')">33333333</a></td>
	</tr>

<%
	FormatDate fD = new FormatDate();
	for(int i=0;i<myRetCount;i++)
	{
		java.util.Date rfqDate = (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
		java.util.Date validUpto = (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
		String nextPart = (String)nextParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String delPart = (String)delParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String concat = "";
		String recStatus = "";
		String isDelParticipant = "";
		int rowId = retobj.getRowId("DOCID",myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		if(rowId != -1)
		{
			recStatus = retobj.getFieldValueString(rowId,"STATUS");
			if(!participant.equals(retobj.getFieldValueString(rowId,"NEXTPARTICIPANT")) && participant.equals(retobj.getFieldValueString(rowId,"DELPARTICIPANT")))
				isDelParticipant = retobj.getFieldValueString(rowId,"NEXTPARTICIPANT");
			else
				isDelParticipant = "NO";
		}	
		
		
		if(!type.equals("D"))
		{
			if(!userRole.equals("VP"))
			{
				if(nextPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
			}
			else
			{
				if(nextPart.equals((String)session.getValue("ROLE")))
				{
					if(rowId==-1)
					{
						concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
					else
					{
						//if(retobj.getFieldValueString(rowId,"STATUS").equals("QCFSUBMITTEDBYVP"))
						if(retobj.getFieldValueString(rowId,"STATUS").equals("SUBMITTED"))
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
						else
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
				}	
				else
				{
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
				}	
			}
		}
		else
		{
				if(delPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
		
		}
%>   
		<tr>
			<!--<td width="13%"><a href = "javascript:showComments(<%=concat%>)" ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>-->
			<td width="13%"><a href = "javascript:showComments('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')" ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>
			<td width="36%"><a href="javascript:showGraph('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')"><%=myRet.getFieldValueString(i,"MATERIAL_DESC")%></a></td>
			<td width="12%"><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>
			<td width="12%"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>
			<td width="8%"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','A')"><%=myRet.getFieldValueString(i,"TOT_RFQ")%></a></td>
		   <%
			if("0".equals(myRet.getFieldValueString(i,"TOT_QUOTED")))
			{
		    %>
				<td width="8%" align="center"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></td>   
		    <%
			} else {
		    %>
				<td width="8%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','Y')"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></a></td>
		    <%
			}
			if("0".equals(myRet.getFieldValueString(i,"TOT_NOT_QUOTED")))
			{
		    %>
				<td width="8%" align="center"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></td>
		    <%
			} else {
		    %>

				<td width="8%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','N')"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></a></td>
		    <%
			}
		    %>
	      	</tr>
<%
	}
%>
	</table>
	</div>

	<input type="hidden" name="QcfNumber">
	<input type="hidden" name="comments">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="Created">

<% 
	}
	else
	{
		display_header = "";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

	<br><br><br>
	<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
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
