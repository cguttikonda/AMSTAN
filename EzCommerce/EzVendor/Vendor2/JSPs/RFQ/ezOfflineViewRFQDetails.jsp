<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>

<%@include file="../../../Includes/Jsps/Rfq/iOfflineViewRFQDetails.jsp"%>
<%@page import="ezc.ezutil.*"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	
<Script>
	var tabHeadWidth=96
	var tabHeight="65%"
</Script>

<Script>
	function goToPlantAddr(plant)
	{
		window.open("../Misc/ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=370,height=350");
	}

	function goBack(type){
		document.forms[0].action ="ezOfflineListRFQs.jsp?type=New";
		document.forms[0].submit();
	}
</Script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
function sendReminder()
{
	document.myForm.action = "ezSendReminderMail.jsp";
	document.myForm.submit();	
}
function RFQPrint()
{
	document.myForm.action = "ezRFQPrint.jsp";
	document.myForm.submit();	
}
</Script>
</head>

<body onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')">
<form  name="myForm">
<input  type="hidden" name="rfqVendor" value="<%=rfqVend%>">



<%
	String display_header = "RFQ Details";
%>	
	
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<%
	ezc.ezutil.FormatDate fd = new ezc.ezutil.FormatDate();
	Vector types = new Vector();
        types.addElement("date");
        EzGlobal.setColTypes(types);
		
        int rfqHeaderCnt =0;
        if(rfqHeader!=null)
        	rfqHeaderCnt = rfqHeader.getRowCount();
        	
     
        	
        if(rfqHeaderCnt!=0)
        {
        
        	
	String OrderDate = fd.getStringFromDate((Date)dtlXML.getFieldValue(0,"ORDERDATE"),".",fd.DDMMYYYY);
 %>
	<input type="hidden" name="type" value='<%=request.getParameter("type")%>'>
	<input type="hidden" name="EndDate" value="<%=CDate%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDate%>">

	<br>
	<table width="50%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr>
        	<th>RFQ No </th>
		<td><%=poNum%><input type="hidden" value="<%=poNum%>" name="PurchaseOrder"></td>
		<th>RFQ Date</th>
      		<td><%=OrderDate%></td>
	</tr>
	</table>
	<br>

	<Div id="theads">
 	<table id="tabHead" width="96%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
 	<tr align="center" valign="middle">
    	<th width="8%">Line</th>
    	<th width="22%">Material</th>
      	<th width="38%">Description</th>
      	<th width="8%">UOM</th>
     	<th width="12%">Qty</th>
     	<th width="10%">Plant</th>
 	</tr>
 	</table>
 	</div>


 	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:96%;height:60%;left:2%">
	<table id="InnerBox1Tab" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="100%">
<%
   	for(int i=0;i<Count;i++)
   	{
%>
     		<tr>
      		<td width="8%"><%=dtlXML.getFieldValueString(i, "POSITION")%></td>
      		<td width="22%">
<%		try
		{
			out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
		}
		catch(Exception e)
		{
			out.println(dtlXML.getFieldValueString(i,"ITEM"));
		}
%>
		</td>
      		<td width="38%">
		<!--<a href="../Materials/ezGetMaterialCharacteristics.jsp?material=<%//dtlXML.getFieldValueString(i,"ITEM")%>&plant=<%//dtlXML.getFieldValueString(i,"PLANT")%>&PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>" onMouseover="window.status='Click to view Material Characteristics. '; return true" onMouseout="window.status=' '; return true"><%//dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%></a>-->
		<%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%>
		</td>
      		<td align="center" width="8%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
      		<td align="right" width="12%"><%=dtlXML.getFieldValueString(i,"ORDEREDQUANTITY")%></td>
      		<td align="center" width="10%"><a href="JavaScript:void(0)" onClick=goToPlantAddr('<%=dtlXML.getFieldValueString(i,"PLANT")%>')><%=dtlXML.getFieldValueString(i,"PLANT")%></a>&nbsp;</td>
    		</tr>
<%	}
%>
  	</table>
	</div>
 	<div align='center' style='position:absolute;top:80%'>
 	<table align="center" width="100%" >
 	<tr align="center">
 	<td class=blankcell>
 	<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:goBack('<%=request.getParameter("type")%>')">
 	<img src="../../Images/Buttons/<%=ButtonDir%>/printversion.gif" style="cursor:hand" border=none onClick="javascript:RFQPrint()">
<%
	String soldTo = (String)session.getValue("SOLDTO");
	if(rfqVend!=null && !"null".equals(rfqVend)){
		soldTo=rfqVend;
	}
	String clsdDate = request.getParameter("EndDate");
	java.util.Date  tDate = new  java.util.Date();
	java.util.Date  cDate = new  java.util.Date();
	
	cDate.setDate(Integer.parseInt(clsdDate.substring(0,2)));
	cDate.setMonth(Integer.parseInt(clsdDate.substring(3,5))-1);
	cDate.setYear(Integer.parseInt(clsdDate.substring(6,10))-1900);
	String userType = (String)session.getValue("UserType");
	
	boolean showButtons = false;
	if("SP".equals(userRole) || "MG".equals(userRole) || "SM".equals(userRole))
		showButtons = true;

	if(!(userType.equals("3") && (cDate.getTime()>tDate.getTime())))
	{
		if(("N".equals(rfqHeader.getFieldValueString("STATUS")) || "R".equals(rfqHeader.getFieldValueString("STATUS"))) && (cDate.getTime()>tDate.getTime()) &&  showButtons)
		{
%>			
			
<%
			if("N".equals(rfqHeader.getFieldValueString("EXT3")))
			{
%>
				<a href="../Rfq/ezSendReminderMail.jsp?SoldTo=<%=soldTo%>&RfqNo=<%=poNum%>&fromFrame=Y&TOINVITE=Y"><img  src="../../Images/Buttons/<%=ButtonDir%>/sendinvitation.gif" border="none" style="cursor:hand" title="Send Invitation" onMouseover="window.status='Click to Send Mail. '; return true" onMouseout="window.status=' '; return true"></a>
<%
			}
			else
			{
%>
				<a href="../Rfq/ezOfflinePostQuote.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>&type=<%=request.getParameter("type")%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/quote.gif" border="none" style="cursor:hand" title="Quote" onMouseover="window.status='Click to Post Quote. '; return true" onMouseout="window.status=' '; return true"></a>			
				<a href="../Rfq/ezSendReminderMail.jsp?SoldTo=<%=soldTo%>&RfqNo=<%=poNum%>&fromFrame=Y"><img  src="../../Images/Buttons/<%=ButtonDir%>/sendreminder.gif" border="none" style="cursor:hand" title="Send Invitation" onMouseover="window.status='Click to Send Mail. '; return true" onMouseout="window.status=' '; return true"></a>
<%		
			}
		}
		else if((!"N".equals(rfqHeader.getFieldValueString("STATUS")))&&(QuotNo!=null)&&(QuotNo.trim().length() > 0))
		{
%>			
			<a href="../Rfq/ezViewQuoteDetails.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/viewquote.gif" border="none" style="cursor:hand" onMouseover="window.status='Click to view Quote. '; return true" onMouseout="window.status=' '; return true"></a>
<%		
		}
	}	
	else
	{
		if(("N".equals(rfqHeader.getFieldValueString("STATUS")) || "R".equals(rfqHeader.getFieldValueString("STATUS"))) && (cDate.getTime()>tDate.getTime()))
		{
%>			<a href="../Rfq/ezOfflinePostQuote.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>&type=<%=request.getParameter("type")%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/quote.gif" border="none" style="cursor:hand" onMouseover="window.status='Click to Post Quote. '; return true" onMouseout="window.status=' '; return true"></a>
<%		}
		else if((!"N".equals(rfqHeader.getFieldValueString("STATUS")))&&(QuotNo!=null)&&(QuotNo.trim().length() > 0))
		{
%>			<a href="../Rfq/ezViewQuoteDetails.jsp?PurchaseOrder=<%=poNum%>&EndDate=<%=CDate%>&OrderDate=<%=OrderDate%>"><img  src="../../Images/Buttons/<%=ButtonDir%>/viewquote.gif" border="none" style="cursor:hand" onMouseover="window.status='Click to view Quote. '; return true" onMouseout="window.status=' '; return true"></a>
<%		}
	}
%>
	</td>
	</tr>
	</table>
	</div>
<%	
	}
	else
	{
%>		<br><br><br>
		<table width="100%" align="center" border=0>
  		<tr align="center">
  		<Td  class=blankcell>
  			Sorry..This RFQ is created in offline</Td>
   		</Tr>
  		</table>
		<br><br>
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border=none onClick="javascript:history.go(-1)">
		</center>
<%	}
%>
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
