<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@include file="../../../Includes/JSPs/Rfq/iViewSchedules.jsp"%>
<%@ page import="ezc.ezutil.*" %>

<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script>
	function goToPlantAddr(plant)
	{
		window.open("../Purorder/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,width=300,height=300,left=250,top=200");
	}
	function goBack(){
		document.forms[0].action = "ezViewRFQDetails.jsp"
		document.forms[0].submit();
	}
	</script>
<Script>
var tabHeadWidth=94
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<form name="myForm" method="post">
	<input type="hidden" name="EndDate" value="<%=EndDate%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDate%>">
	<input type="hidden" value="<%=poNum%>" name="PurchaseOrder">
	<input type="hidden" name="type" value=<%=request.getParameter("type")%>>
<%
	 ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	 String display_header	= "Delivery Schedules For RFQ No : "+poNum;
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
 	<br><br>

	<DIV id="theads">
 	<table id="tabHead" width="94%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  >
 	<tr align="center" valign="middle">
     	<th width="8%">Line</th>
      	<th width="14%">Material</th>
      	<th width="39%">Description</th>
      	<th width="6%">UOM</th>
      	<th width="13%">Req. Qty </th>
     	<th width="10%">Req. Date</th>
	<th width="10%">Plant</th>
 	</tr>
	</table>
	</DIV>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:94%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
   	for(int i=0;i<Count;i++)
   	{
	       	String date = FormatDate.getStringFromDate((java.util.Date)retObj.getFieldValue(i,"DLVDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String plant = retObj.getFieldValueString(i,"PLANT");
%>
     		<tr>
		<td width="8%"><%=retObj.getFieldValueString(i,"LINENUM")%></td>
		<td width="14%">
<%
		try{
			out.println(Long.parseLong(retObj.getFieldValueString(i,"MATERIAL")));
		}catch(Exception e){
			out.println(retObj.getFieldValueString(i,"MATERIAL"));	
		}
%>
		</td>
     		<td width="39%"><%=retObj.getFieldValueString(i,"MATDESC")%></td>
		<td width="6%" align="center"><%=retObj.getFieldValueString(i,"UOM")%></td>
     		<td width="13%" align="right"><%=retObj.getFieldValueString(i,"QUANTITY")%></td>
      		<td width="10%" align="center"><%=date%></td>
      		<td width="10%" align="center">
			<a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='Click to view the Plant Address. '; return true" onMouseout="window.status=' '; return true">
			<%=plant%></a>&nbsp;</td>
		</tr>
<%
	}
%>
  	</table>
	</div>

 	<!--
 	<div align='center' style='position:absolute;top:92%'>
 	<table align="center" width="100%" >
 	<tr align="center">
 	<td class=blankcell>
	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  style="cursor:hand" border=0 onClick="javascript:goBack()">
	</td>
   	</tr>
  	</table>
	</div>-->
	<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
		
			buttonName.add("Back");
			buttonMethod.add("goBack()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		</div>
	<%@ include file="../Misc/AddMessage.jsp" %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
