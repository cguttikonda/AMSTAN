<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Jsps/Purorder/iGetLocalPOList.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListAcknowledgedPO_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Purchase Orders in Portal</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
 	var tabHeadWidth=86
 	var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script src="../../Library/JavaScript/Purorder/ezListBlockedPOs.js"></Script>
<script>
function funBack()
{
	document.location.href="../Misc/ezSBUWelcome.jsp";
}

function funChangeStatus()
{
	var len=document.myForm.chk1.length
	var flag=false
	if(isNaN(len))
	{
		if(document.myForm.chk1.checked)
		flag=true
	}
	else
	{
		for(var j=0;j<len;j++)
		{
			if(document.myForm.chk1[j].checked)
			flag=true  
		}
	}
	if(!flag)
	{
		alert("Please select atleast one document")
	}
	else
	{
		if(confirm("Are you sure about deleting documents?"))
		{
			hideButton();
			document.myForm.action="ezDeletePurchaseOrder.jsp";
			document.myForm.submit();
		}
	} 

}


function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
} 

</script>
</head>
<%
	String userRole = (String)Session.getUserPreference("USERROLE");
	
	String display_header = "";
	String dispMsg = "";
	if("P".equals(orderType)){
		display_header = "Purchase Orders in Portal";
		dispMsg = "No Purchase Orders in Portal" ;
	}else{
		display_header = "Contracts in Portal";
		dispMsg = "No Contracts in Portal";
	}
%>
<body bgcolor="#FFFFF7" onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')" scroll=no>
<form name="myForm" method="POST">
<input type="hidden" name="type" value="<%=orderType%>">
<%@ include file="../Misc/ezDisplayHeader.jsp"%>	
<Br>
<%
	if(Count==0)
	{
%>		
		<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
			<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			 <Tr align="center">
			  	<Th><%=dispMsg%></Th>
			 </Tr>
			</Table>
		</Div>
		
		<Div id="back" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;");
    butActions.add("funBack()");
    out.println(getButtons(butNames,butActions));
%>
		</Div>
<%
	}
	else
	{
	
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
											
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm:ss");

		Vector grColNames = new Vector();
		grColNames.addElement("MODIFIEDON");
		EzGlobal.setColNames(grColNames);

		globalRet = EzGlobal.getGlobal(ret);
%>
		
		<Div id="theads">
			<Table  id="tabHead"  width="86%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			  <Tr align="center" valign="middle">
		  
     				<Th width="5%">&nbsp;</Th>
     				<Th width="12%"> PO No</Th>
     				<Th width="12%"> Vendor</Th>
     				<Th width="37%"> Vendor Name</Th>
    				<Th width="15%"> Order Date</Th>
				<Th width="22%"> Blocked Date</Th>
			 </Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:87%;height:57%">
		<Table  id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
 <%
 	
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	String poNum = "";
        	String vendorNo = "";
		for(int i=0;i<Count;i++)
     		{
		   	poNum = ret.getFieldValueString(i,"DOCNO");
		   	vendorNo = ret.getFieldValueString(i,"EXT1");
 %>		  
     				<Td width="5%" align="center"><input type="checkbox"  name=chk1 value="<%=poNum%>"></Td>
     				<Td width="12%" align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>&type=<%=orderType%>&POORCONTRACT=PO&RQSTFROM=PORTAL&vendorNo=<%=ret.getFieldValueString(i,"EXT1")%>" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></Td>
	     			<Td width="12%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a><input type="hidden" name="<%=poNum%>Vndr" value="<%=vendorNo%>"></Td>
	     			<Td width="37%" align="left"><%=venodorsHT.get(vendorNo.trim())%></Td>
    				<Td width="15%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></Td>
				<!--<Td width="18%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></Td>-->
				<Td width="22%" align="center"><%=globalRet.getFieldValue(i,"MODIFIEDON")%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></Td>
    			</Tr>
 <%				 
		}
	}	
 %>
 	</Table>
	</Div>
	<input type="hidden" name="fromPortal" value="FROMPORTAL">
<%
	if(Count!=0)
	{
		    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;");
		    butActions.add("javascript:funBack()");
		    
		    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp; Delete &nbsp;&nbsp;&nbsp;&nbsp;");
		    butActions.add("javascript:funChangeStatus()");
   
    
%>		
	<Div id="back"  style="position:absolute;top:90%;left:45%;visibility:visible">
	<Span id="EzButtonsSpan" >
<%
    		out.println(getButtons(butNames,butActions));
%>
	</Span>
					 
		<Span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
		</Span>
	</Div>

<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>