<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iListQcfs.jsp"%>
<%
	ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
	int myRetCount = myRet.getRowCount();
%>
<html>
<head>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<Script>
	var tabHeadWidth=90
	var tabHeight="70%"
</Script>
<script>
var newWindow

function showWin(qcf,quan)
{
	var url="ezQcfComments.jsp?qcfNumber="+qcf+"&quantity="+quan;
	newWindow=window.open(url,"myWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function showVendors(collRfq,proc)
{
	var url="ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
	newWindow=window.open(url,"VendWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function showGraph(collRfq)
{
	var url="ezReportChart.jsp?collRFQ="+collRfq;
	newWindow=window.open(url,"ReportWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

}

function funUnload()
{
	if(newWindow!=null && newWindow.open)
	{
	  newWindow.close();
	}
}
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm">
<%
	String display_header = "";
	if(myRetCount == 0)
	{
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>

		<br><br><br><br>
		<table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<tr align="center">
			<th>No Collective RFQs Exist.</th>
		</tr>
		</table>
		<br>
		<Center>
		
<%

	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	butActions.add("history.go(-1)");
    	out.println(getButtons(butNames,butActions));

%>
</Center>

<%
	}else{
	
		display_header = "Collective RFQs List";
%>
		<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<br>
	<DIV id="theads">
  	<table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="90%">
	    	<tr align="center" valign="middle">
			<th width="11%">Collective RFQ No.</th>
			<th width="34%">Material</th>
			<th width="10%">Quantity</th>
			<th width="12%">RFQ Date</th>
			<th width="12%">RFQ Valid Upto</th>
			<th width="6%">Vendors Sent To</th>
			<th width="6%">Quoted</th>
			<th width="6%">Not Quoted</th>
	    	</tr>
 	</table>
 	</DIV>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:70%;height:80%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%
	for(int i=0;i<myRetCount;i++)
	{
		java.util.Date rfqDate 	= (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
		java.util.Date validUpto= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
		int totQuoted		= Integer.parseInt(myRet.getFieldValueString(i,"TOT_QUOTED"));
%>   
		<tr>
<%			
			if(totQuoted > 0)
			{
%>			
				<td width="11%"><a href = "javascript:showWin(<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>,<%=myRet.getFieldValueString(i,"QUANTITY")%>)" ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>
<%			
			}
			else
			{
%>			
				<td width="11%"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></td>
<%
			}
%>			
			<td width="34%"><a href="javascript:showGraph('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>')"><%=myRet.getFieldValueString(i,"MATERIAL_DESC")%></a></td>
			<td width="10%" align="right"><%=myRet.getFieldValueString(i,"QUANTITY")%></td>
			<td width="12%" align="center"><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>
			<td width="12%" align="center"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>
			<td width="6%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','A')"><%=myRet.getFieldValueString(i,"TOT_RFQ")%></a></td>
		    <%
		    	if("0".equals(myRet.getFieldValueString(i,"TOT_QUOTED")))
		    	{
		    %>
		 		<td width="6%" align="center"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></td>   
		    <%
		    	} else {
		    %>
				<td width="6%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','Y')"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></a></td>
		    <%
		    	}
		    	if("0".equals(myRet.getFieldValueString(i,"TOT_NOT_QUOTED")))
		    	{
		    %>
		    		<td width="6%" align="center"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></td>
		    <%
		    	} else {
		    %>
		    
				<td width="6%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','N')"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></a></td>
		    <%
		    	}
		    %>
		    
	      	</tr>
<%
	}
%>
	</table>
	</div>


<%   }  %>	
</form>
<Div id="MenuSol"></Div>
</body>
</html>