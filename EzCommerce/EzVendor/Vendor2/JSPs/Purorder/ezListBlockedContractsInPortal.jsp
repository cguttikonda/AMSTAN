<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListBlockedContractsInPortal.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iListAcknowledgedPO_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetVendorDesc.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Blocked Purchase Orders in Portal</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
 	var tabHeadWidth=85
 	var tabHeight="65%"
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script src="../../Library/JavaScript/Purorder/ezListBlockedPOs.js"></Script>
<script>

function getAgmtDtl(agmtNo)
{
	var url="../Rfq/ezGetAgreementDetails.jsp?agmtNo="+agmtNo;
	var sapWindow=window.open(url,"newwin","width=500,height=350,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}

function releasePO()
{
	/*if(!checkRoleAuthorizations("SEND_INVITATION"))
	{
		alert("You are not authorized to send contract to vendor");
		return;
	}*/
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
    alert("Please select Contract(s) to send")
  }
  else
  {
    hideButton();	
    document.myForm.action="ezReleasePurchaseOrder.jsp";
    document.myForm.submit();
   }
	
}
function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
}
		function funBack()
		{
			document.location.href="../Misc/ezSBUWelcome.jsp";
		}

</script>
</head>
<%
	String userRole = (String)Session.getUserPreference("USERROLE");
	String display_header = "Contracts Blocked For Supplier View";
	String dispMsg = "No Contracts Blocked For Supplier" ;
%>
<body bgcolor="#FFFFF7" onLoad="scrollInit('SHOWTOT')" onResize="scrollInit('SHOWTOT')" scroll=no>
<form name="myForm" method="POST">
<%@ include file="../Misc/ezDisplayHeader.jsp"%>	
<Br>
<%
	if(Count==0)
	{
%>		
		<Div id="nocount" style="position:absolute;top:40%;width:100%;visibility:visible">
			<Table width="30%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			 <Tr align="center">
			  	<Th><%=dispMsg%></Th>
			 </Tr>
			</Table>
		</Div>
		
		<Div id="back" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
		<%
			buttonName.add("&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;");   
			buttonMethod.add("funBack()");
			
			out.println(getButtonStr(buttonName,buttonMethod));
		%>
 
		</Div>
<%
	}
	else
	{
		String dateSep = (String)session.getValue("DATESEPERATOR");
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
													
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("MM"+dateSep+"dd"+dateSep+"yyyy hh:mm");
		

		Vector grColNames = new Vector();
		grColNames.addElement("MODIFIEDON");
		EzGlobal.setColNames(grColNames);

		globalRet = EzGlobal.getGlobal(ret);
%>
		
		<Div id="theads">
			<Table  id="tabHead"  width="85%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			  <Tr align="center" valign="middle">
			  
<%
			if(!userRole.equals("SP"))
			{
%>			  
				<Th width="5%">&nbsp;</Th>
<%
			}
%>
     				
     				<Th width="12%"> Contract No</Th>
     				<Th width="12%"> Vendor </Th>
     				<Th width="34%">Vendor Name</Th>
    				<Th width="19%"> Order Date</Th>
				<Th width="23%"> Blocked Date</Th>
			 </Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:87%;height:57%">
		<Table  id="InnerBox1Tab" align=center width=100%  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
 <%
 	
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	String poNum = "";
        	String vendorNo = "";
		for(int i=0;i<Count;i++)
     		{
		   	poNum = ret.getFieldValueString(i,"DOCNO");
		   	vendorNo = ret.getFieldValueString(i,"EXT1");
 %>
	 		<Tr>
<%
			if(!userRole.equals("SP"))
			{
%>			  
     				<Td width="5%" align="center"><input type="checkbox" name=chk1 value="<%=poNum%>"></Td>
<%
			}
%>			
	     			<td width="12%" align="center"><a href="../Rfq/ezGetAgrmtDetails.jsp?agmtNo=<%=poNum%>&viewType=BLOCK" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></td>
	     			<Td width="12%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a><input type="hidden" name="<%=poNum%>Vndr" value="<%=vendorNo%>"></Td>
	     			<Td width="34%" align="left"><%=venodorsHT.get(vendorNo.trim())%></Td>
    				<Td width="19%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
				<!--<Td width="19%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></Td>
				-->
				<Td width="23%" align="center"><%=globalRet.getFieldValue(i,"MODIFIEDON")%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></Td>
    			</Tr>
 <%				 
		}
	}	
 %>
 	</Table>
	</Div>
	<input type="hidden" name="fromPortal" value="FROMCONTRREL">
	<input type="hidden" name="POrCON" value="SENDTOVENDOR">
	
<%
	if(Count!=0)
	{
%>		
		<Div id="back"  style="position:absolute;top:90%;left:40%;visibility:visible">
		<Span id="EzButtonsSpan" >
<%		
		buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		buttonMethod.add("funBack()");	

		if(!userRole.equals("SP"))
		{
			buttonName.add("&nbsp;&nbsp;Send To Vendor&nbsp;&nbsp;");   
			buttonMethod.add("releasePO()");	
		}
		out.println(getButtonStr(buttonName,buttonMethod));
		
%>		
		</Span>
				 
		<Span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td >Your request is being processed... Please wait</Td>
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