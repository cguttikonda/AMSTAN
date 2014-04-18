<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Purorder/iListBlockedPO.jsp"%>
<%@ include file="../../../Includes/JSPs/Labels/iListBlockedPO_Labels.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iGetVendorDesc.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Purchase Orders</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script>
 	var tabHeadWidth=94
 	var tabHeight	="65%"
 	var selBlockedPo_L='<%=selBlockedPo_L%>';



function getAgmtDtl(agmtNo)
{
	
	location.href="../Rfq/ezGetContractDetails.jsp?contractNo="+agmtNo;
	
}




function getAmndPODtl(ponum)
{
 	var url="../Rfq/ezGetAmndPOdetails.jsp?PurOrderNum="+ponum+"&POorCon=C";
 	var sapWindow=window.open(url,"newwin","width=800,height=500,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
}
function funShowVndrDetails(syskey,soldto)
{
	var retValue = window.showModalDialog("../RFQ/ezVendorContactDetails.jsp?SysKey="+syskey+"&SoldTo="+soldto,window.self,"center=yes;dialogHeight=25;dialogWidth=40;help=no;titlebar=no;status=no;minimize:yes")	
} 
function showTrail()
 {
 	var radLen = document.myForm.chk1.length 
 	var colno = 0
 	var count = 0
 	if(!isNaN(radLen))
 	{	
 		for(i=0;i<radLen;i++)
 		{
 			if(document.myForm.chk1[i].checked)
 				count++
 		}
 		if(count == 0)
 		{
 			alert("Please select Contract to view Audit");
 			return;
 		}
 		
 		for(i=0;i<radLen;i++)
 		{
			if(document.myForm.chk1[i].checked)
			{
				colno = document.myForm.chk1[i].value
				break;
			}
 		}
 	}
 	else
 	{
		if(document.myForm.chk1.checked)
		{
			colno = document.myForm.chk1.value
		}
		else
		{
 			alert("Please select Contract to view Audit");
 			return;
		}
 	}
 	document.myForm.wf_trail_list.value = colno
 	hideButton();
 	document.myForm.action = "../Misc/ezWFAuditTrailList.jsp"
 	document.myForm.submit()
}
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Purorder/ezListBlockedPOs.js"></Script>
</head>
<%
	String display_header ="" ;
	String dispMsg ="";
	display_header = "Unreleased  Contracts";
	dispMsg = "No Unreleased Contracts" ;
%>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm">
<input type=hidden name='wf_trail_list'>
<input type=hidden name='wf_trail_type' value='CON_RELEASE'>

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<Br>
<script>
	function ezBack()
	{
		document.myForm.action = '../Misc/ezSBUWelcome.jsp'
		document.myForm.submit();
	}
</script>
	
	
<%
	
	if(Count==0)
	{
%>		
		<div id="nocount" style="position:absolute;top:15%;width:100%;visibility:visible">
			<br><br><br>
			<Table width="30%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
				<tr align="center">
					<th><%=dispMsg%></th>
				</tr>
			</Table>
		</div>

<Div id="backtowelcome" align=center style="position:absolute;top:90%;visibility:visible;width:100%;visibility:hidden">
<%
	buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	buttonMethod.add("ezBack()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>

<%
	}
	else
	{
		
		String userId = Session.getUserId();
		String delegated = "";
        	String isDelegate = "";
		
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;

		Vector grtypes = new Vector();
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

		Vector grColNames = new Vector();
		grColNames.addElement("MODIFIEDON");
		EzGlobal.setColNames(grColNames);
		
		globalRet = EzGlobal.getGlobal(ret);
	
		
%>
		<input type=hidden name='prevStatus' value='BLOCKED'>
		
		<Div id="theads">
		<Table  id="tabHead"  width="94%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
			<tr align="center" valign="middle">
     				<th width="5%">&nbsp;</th>
     				<th width="11%">Contract No</th>
     				<Th width="11%">Vendor</Th>
     				<Th width="26%">Vendor Name</Th>
     				<Th width="15%"> Amended Details</Th>
    				<th width="12%"><%=ordDate_L%></th>
				<th width="12%">Blocked Date</th>
				<th width="8%">Delegated</th>
			 </tr>
		</Table>
		</Div>
		<Div id="InnerBox1Div">
		<Table  id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
 <%
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	String poNum = "";
        	String vendorNo = "";
		for(int i=0;i<Count;i++)
     		{
			
		   		poNum = ret.getFieldValueString(i,"DOCNO");
		   		vendorNo = ret.getFieldValueString(i,"EXT1");

			if(userId.equals(ret.getFieldValueString(i,"NEXT_D_PARTICIPANT")))
		   	{
		   		delegated = "YES";
		   		isDelegate = "Y";
		   	}	
		   	else
		   	{
		   		delegated = "&nbsp;";	
		   		isDelegate = "N";
		   	}		   		
		   		
 %>
	 			<tr>
     					<td width="5%" align="center"><input type="radio" name=chk1 value="<%=poNum%>"></td>
	     				
	     				
	     				<td width="11%" align="center"><a href="../Rfq/ezGetAgrmtDetails.jsp?ISDELEGATE=<%=isDelegate%>&agmtNo=<%=poNum%>&viewType=UNREL&POORCONTRACT=CON&RQSTFROM=PORTAL" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></td>
	     				
	   				 <Td width="11%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a></Td>
	   				  <Td width="26%" align="left"><%=venodorsHT.get(vendorNo.trim())%></Td>
	     				<Td width="15%" align="center">
<%
	   				if("U".equals(ret.getFieldValue(i,"EXT3")))
	   				{
%>
						<a href="javascript:getAmndPODtl('<%=ret.getFieldValueString(i,"DOCNO")%>')">Click</a>
<%
					}
					else
					{
%>
						&nbsp;
<%
					}
%>
					</Td> 				
	     				
    					<!--<td width="13%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></td>
					<td width="13%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></td>
					-->
					<td width="12%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></td>
					<td width="12%" align="center"><%=globalRet.getFieldValue(i,"MODIFIEDON")%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></td>
					<Td width="8%" align="center">
						<%=delegated%>
					</Td>
					
					<input type="hidden"  name="poNo" value="<%=poNum%>" >
	    			</tr>
 <%				
		}
 %>
		</table>
		</div>
		
		<input type="hidden"  name="POrCON" value="CONTRACT" >

<Div id="back"  style="position:absolute;top:90%;left:40%;visibility:visible">
<Span id="EzButtonsSpan" >
<%
	buttonName.add("&nbsp;&nbsp;&nbsp;Workflow Audit&nbsp;&nbsp;&nbsp;");   
	buttonMethod.add("showTrail()");
	
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


		
<%	}
%>
	<input type='hidden' name='type' value='<%=orderType%>' >
</form>
<Div id="MenuSol"></Div>
</body>
</html>