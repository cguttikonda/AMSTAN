<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iViewDeliverySchedules_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Purorder/iViewDeliverySchedules.jsp"%>
<%@ page import="ezc.ezutil.*" %>

<html>
<head>
<title>Untitled Document</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<script>


	function showSpan(spId)
	{
		spanStyle=document.getElementById(spId).style
		if(spanStyle.display=="none")
			spanStyle.display=""
		else
			spanStyle.display="none"

	}

	function funSubmit(formEv)
	{
		document.myForm.action = formEv
		document.myForm.submit();
	}

	function formEvents(formEv,stat)
	{
		document.myForm.status.value=stat
		document.myForm.action=formEv;
		var url = "ezSelectAcknowledgeUsers.jsp";
		var hWnd = window.open(url,"UserWindow","width=300,height=300,left=280,top=200,resizable=yes,scrollbars=yes");
		if ((document.window != null) && (!hWnd.opener))
		hWnd.opener = document.window;

	}

</script>
<Script>
var tabHeadWidth=95
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body bgcolor="#FFFFFF" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>

<%
	String display_header = delSchPo_L+" "+Long.parseLong(poNum);
	
%>	
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	

<%	
	if(Count == 0)
	{
		String noDataStatement = noDelSchEx_L+" PO  "+Long.parseLong(poNum);
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%	
	}
	else
	{
		
%>
		
<br>
<form name="myForm">
<DIV id="theads">
  <table id="tabHead" width="95%" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    <tr>
      <th width="7%"><%=line_L%></th>
      <th width="18%"><%=mat_L%></th>
      <th width="40%"><%=desc_L%></th>
      <th width="7%"><%=uom_L%></th>
      <th width="17%"><%=reqQty_L%></th>
      <th width="11%"><%=reqDate_L%></th>
    </tr>
  </table>
</DIV>

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:60%;left:2%">
<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	FormatDate myFormat = new FormatDate();
	String date = "";
	String curLine="";
	String tempLine=null;
	for(int i=0;i<Count;i++)
	{
		date = myFormat.getStringFromDate((java.util.Date)retObj.getFieldValue(i,"DLVDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		tempLine=retObj.getFieldValueString(i,"LINENUM");
		
		if(!curLine.equals(tempLine))
		{
			String matNo=retObj.getFieldValueString(i,"MATERIAL");
			try
			{
				if(matNo != null && !"null".equals(matNo))
					matNo = Long.parseLong(matNo)+"";
				else
					matNo = "&nbsp;";
			}
			catch(Exception e){}
			String matDesc = retObj.getFieldValueString(i,"MATDESC");
			if(matDesc == null || "null".equals(matDesc))
				matDesc = "&nbsp;";
			String uomStr = retObj.getFieldValueString(i,"UOM");	
			if(uomStr == null || "null".equals(uomStr))
				uomStr = "&nbsp;";
%>
			<tr>
				<td width="7%" align="center"><%=tempLine%>&nbsp;</td>
				<td width="18%" align="left"><%=matNo%>&nbsp;</td>
				<td width="40%" align="left">&nbsp;<%=matDesc%></td>
				<td width="7%" align="center">&nbsp;<%=uomStr%></td>
				<td width="17%" align="right">&nbsp;
					<%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%>
				</td>
				<td width="11%" align="center">
					<%=date%>&nbsp;
				</td>
			</tr>
<%	
			curLine=retObj.getFieldValueString(i,"LINENUM");
		}
		else
		{     
%>
			<tr>
				<td width="7%" align="center">&nbsp;</td>
				<td width="18%" align="left">&nbsp;</td>
				<td width="40%" align="left">&nbsp;</td>
				<td width="7%" align="center">&nbsp;</td>
				<td width="17%" align="right"><%=getNumberFormat(retObj.getFieldValueString(i,"QUANTITY"),0)%></td>
				<td width="11%" align="center"><%=date%></td>
			</tr>
<%  	
			curLine=retObj.getFieldValueString(i,"LINENUM");
		}
	}
%>
	</table>
	</span>
	</div>

<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center>
<%
	String type=(String)session.getValue("UserType");

	buttonName 	= new java.util.ArrayList();
	buttonMethod 	= new java.util.ArrayList();

	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	
	if("3".equals(type))
	{
		buttonName.add("Acknowledge");
		buttonMethod.add("funSubmit(\"ezAddComittedDate.jsp\")");
		
		buttonName.add("Reject");
		buttonMethod.add("formEvents(\"ezComposeRejectMsg.jsp\",\"R\")");
	}

	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>

<input type="hidden" value="<%=request.getParameter("PurchaseOrder")%>" name="PurchaseOrder">
<input type="hidden" name="OrderDate" value="<%=request.getParameter("OrderDate")%>">
<input type='hidden' name='NetAmount' value='<%=request.getParameter("NetAmount")%>' >

<input type="hidden" name="status" value="">
<input type="hidden" name="toUser" value="">
<input type="hidden" name="orderType" value="<%=request.getParameter("orderType")%>">
</div>
</form>
<%
	}
%>
<Div id="MenuSol"></Div>
</body>
</html>

