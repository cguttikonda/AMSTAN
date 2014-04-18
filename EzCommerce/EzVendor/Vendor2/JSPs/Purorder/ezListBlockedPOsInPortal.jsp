<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Jsps/Purorder/iListBlockedInPortal.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListAcknowledgedPO_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Blocked Purchase Orders in Portal</title>
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
function releasePO()
{
	/*if(!checkRoleAuthorizations("SEND_INVITATION"))
	{
		alert("You are not authorized to send purchase order to vendor");
		return;
	}*/
  
  var len=document.myForm.chk1.length
  var flag=false
  var temp=""
  if(isNaN(len))
  {
    if(document.myForm.chk1.checked)
      flag=true
  }
  else
  {
    for(var j=0;j<len;j++)
    {
      if(document.myForm.chk1[j].checked){
        flag=true  
        temp = temp+"µ"+document.myForm.chk1[j].value;
      }
    }
    document.myForm.poData.value=temp.substring(1,temp.length);
    //alert(document.myForm.poData.value);
  }
	if(!flag)
  {
    alert("Please select PO(s) to send")
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

</script>
</head>
<%
	String userRole = (String)Session.getUserPreference("USERROLE");
	String display_header = "Blocked Purchase Orders in Portal";
	String dispMsg = "No Blocked Purchase Orders in Portal" ;
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
			<Table width="30%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=0 >
			 <Tr align="center">
			  	<Th><%=dispMsg%></Th>
			 </Tr>
			</Table>
		</Div>
		
		<Div id="back" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
<%
    buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;");
    buttonMethod.add("funBack()");
    out.println(getButtonStr(buttonName,buttonMethod));
%>
		</Div>
<%
	}
	else
	{
		
		String tempChk="";
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
			<Table  id="tabHead"  width="86%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=0>
			  <Tr align="center" valign="middle">
<%
			if(!userRole.equals("SP"))
			{
%>			  
     				<Th width="5%">&nbsp;</Th>
<%
			}
%>
     				<Th width="12%"> PO No</Th>
     				<Th width="12%"> Vendor</Th>
     				<Th width="37%"> Vendor Name</Th>
    				<Th width="17%"> Order Date</Th>
				<Th width="22%"> Blocked Date</Th>
			 </Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:87%;height:57%">
		<Table  id="InnerBox1Tab" align=center width=100%  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=0 >
 <%
 	
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	String poNum = "";
        	String vendorNo = "";
		for(int i=0;i<Count;i++)
     		{
		   	poNum = ret.getFieldValueString(i,"DOCNO");
		   	vendorNo = ret.getFieldValueString(i,"EXT1");
		   	tempChk=poNum;//+"¥"+vendorNo.trim()+"¥"+"B¥"+(String)session.getValue("SYSKEY");
 %>
	 		<Tr>
<%
			if(!userRole.equals("SP"))
			{
%>			  
     				<Td width="5%" align="center"><input type="checkbox"  name=chk1 value="<%=tempChk%>"></Td>
<%
			}
%>			
	     			<Td width="12%" align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>&type=<%=orderType%>&POORCONTRACT=PO&RQSTFROM=PORTAL&vendorNo=<%=ret.getFieldValueString(i,"EXT1")%>&poSysKey=<%=ret.getFieldValueString(i,"DOCSYSKEY")%>" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></Td>
	     			<Td width="12%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a><input type="hidden" name="<%=poNum%>Vndr" value="<%=vendorNo%>"></Td>
	     			<Td width="37%" align="left"><%=venodorsHT.get(vendorNo.trim())%></Td>
    				<Td width="17%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
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
    buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp; Back &nbsp;&nbsp;&nbsp;&nbsp;");
    buttonMethod.add("javascript:funBack()");
    if(!userRole.equals("SP"))
    {
      buttonName.add("Release Order");
      buttonMethod.add("releasePO()");
    }
    
%>		
		<Div id="back"  style="position:absolute;top:90%;left:40%;visibility:visible">
		<Span id="EzButtonsSpan" >
<%
    out.println(getButtonStr(buttonName,buttonMethod));
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

<input type=hidden name=poData value="">
</form>
<Div id="MenuSol"></Div>
</body>
</html>