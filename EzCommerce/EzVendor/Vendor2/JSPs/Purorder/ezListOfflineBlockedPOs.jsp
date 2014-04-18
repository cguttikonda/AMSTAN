<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Jsps/Purorder/iListOfflineBlockedPO.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListBlockedPO_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iWFMethods.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Unreleased Purchase Orders To be Approved</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script>
 var tabHeadWidth=92
 var tabHeight="65%"
 var selBlockedPo_L='<%=selBlockedPo_L%>';
 
 function getAmndPODtl(ponum)
 {
 	var url="../Rfq/ezGetAmndPOdetails.jsp?PurOrderNum="+ponum+"&POorCon=P";
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
 		if(count = 0)
 		{
 			alert("Please select only atleast 1 Collective RFQ No to see Audit");
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
 			alert("Please select the PO Number No to see Audit");
 			return;
		}
 	}
 	document.myForm.wf_trail_list.value = colno
 	var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=PO_RELEASE&wf_trail_list="+colno
 	var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
 	
 	//document.myForm.action = "../Misc/ezOfflineWFAuditTrailList.jsp"
 	//document.myForm.submit()
}
</script>
<script src="../../Library/JavaScript/ezTabScroll.js"></script>
<script src="../../Library/JavaScript/Purorder/ezListBlockedPOs.js"></Script>
</head>
<%
	String display_header ="" ;
	String dispMsg ="";
	if("Amend".equals(orderType))
	{
		display_header = "UnReleased Purchase Orders";
		dispMsg = "No UnReleased Purchase Orders" ;
	}	
	else
	{
		display_header = blockPo_L;
		dispMsg = "No Blocked Purchase Orders" ;
	}	
		
%>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm" method="POST">
<input type=hidden name='wf_trail_list'>
<input type=hidden name='wf_trail_type' value='PO_RELEASE'>


	<%//@ include file="../../../Offline/JSPs/ezOfflineDisplayHeader.jsp"%>	
	



<%
	
	
	int n=0;
	java.util.Hashtable orgHash=new java.util.Hashtable();	
	if(Count==0)
	{
		response.sendRedirect("../Misc/ezOfflineMessage.jsp?MESSAGE=No Purchase Orders pending for your approval&DEFAULT_PAGE=EMPTY");
	}
	else
	{
		String userId = Session.getUserId();
		String delegated = "";
        	String isDelegate = "";

%>
		<input type=hidden name='prevStatus' value='BLOCKED'>
<%
	
 	
%>
		<BR>
		<Div id="theads">
			<Table  id="tabHead"  width="92%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
			<Caption><Font color='#083D65' face="Verdana" size=2><B>Purchase Orders pending for approval</Font></caption>
			  <Tr align="center" valign="middle">
     				<Th width="5%">&nbsp;</Th>
     				<Th width="10%"> <%=poNo_L%></Th>
     				<Th width="10%">Vendor</Th>
            			<Th width="24%">Vendor Name</Th>
     				<Th width="11%"> Amended Details</Th>
    				<Th width="12%"> <%=ordDate_L%></Th>
				<Th width="14%"> Purch. Group</Th>
				<Th width="15%"> Query Status</Th>
				<Th width="4%"> Del</Th>
			 </Tr>
			</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:87%;height:65%">
		<Table  id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
 <%
 
 
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	
        	String vendorNo = "";
        	java.util.Hashtable collSyskey=new java.util.Hashtable();
        	String orgStr=null;
		for(int i=0;i<Count;i++)
     		{
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
			
			vendorNo = ret.getFieldValueString(i,"EXT1");
			String vendorName = (String)venodorsHT.get(vendorNo.trim());
			if(vendorName == null || "null".equals(vendorName) || "".equals(vendorName))
				vendorName = "Not Synchronized";
			poNum = ret.getFieldValueString(i,"DOCNO");
			
			collSyskey.put(poNum.trim(),ret.getFieldValueString(i,"SYSKEY"));
			if(!orgHash.contains(ret.getFieldValueString(i,"SYSKEY"))){
				orgHash.put(ret.getFieldValueString(i,"SYSKEY"),getDesiredValue(Session,ret.getFieldValueString(i,"SYSKEY"),"PURGROUP"));
			}
			
			orgStr=(String)orgHash.get(ret.getFieldValueString(i,"SYSKEY"));
			if(orgStr==null)orgStr="";
			
 %>
			<Tr>
				<Td width="5%" align="center"><input type="radio" name=chk1 value="<%=poNum%>"></Td>
				<Td width="10%" align="center"><a href="ezBlockedOfflinePoLineitems.jsp?ISDELEGATE=<%=isDelegate%>&PurchaseOrder=<%=poNum%>&type=<%=orderType%>&POORCONTRACT=PO&vendorNo=<%=ret.getFieldValueString(i,"EXT1")%>" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></Td>
				<Td width="10%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a></Td>
        			<Td width="24%" align=left><%=vendorName%>&nbsp;</Td>
				<Td width="11%" align="center">
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

			<Td width="12%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></Td>
			<Td width="14%" align="center"><%=orgStr%><%//=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>">
				<input type="hidden"  name="poNo" value="<%=poNum%>" >
			</Td>
			<Td width="15%" align="center"><%=ret.getFieldValueString(i,"REMARKS")%></Td>	
			<Td width="4%" align="center"><%=isDelegate%></Td>	
					
					
	    		</Tr>
 <%				 
 				
		}
		
		session.putValue("COLLSYSKEY",collSyskey);
		
 %>

		</Table>
		</Div>
<%
		if(Count>0)
		{
%>
			<Div id="back" align=center style="position:absolute;top:90%;visibility:visible;width:100%">
			<span id="EzButtonsSpan" >
<%  
                	    buttonName = new java.util.ArrayList();
			    buttonMethod = new java.util.ArrayList();
			    buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
			    buttonMethod.add("showTrail()");
			    out.println(getButtonStr(buttonName,buttonMethod));	
%> 
			</span>
			<span id="EzButtonsMsgSpan" style="display:none">
			<Table align=center>
				<Tr>
					<Td class="labelcell">Your request is being processed... Please wait</Td>
				</Tr>
			</Table>
			</span>
			</Div>
<%
		}
%>

<script>
		if('<%=Count%>'==0)
		{
			if(document.getElementById("InnerBox1Div")!=null)
			  document.getElementById("InnerBox1Div").style.visibility="hidden"

			if(document.getElementById("InnerBox1Tab")!=null)
			  document.getElementById("InnerBox1Tab").style.visibility="hidden"

			if(document.getElementById("theads")!=null)
			  document.getElementById("theads").style.visibility="hidden"

			if(document.getElementById("tabHead")!=null)
			  document.getElementById("tabHead").style.visibility="hidden"

			if(document.getElementById("back")!=null)
			 document.getElementById("back").style.visibility="hidden"

			if(document.getElementById("header")!=null)
			  document.getElementById("header").style.visibility="visible"

			if(document.getElementById("nocount")!=null)
			document.getElementById("nocount").style.visibility="visible"

		}
</script>
<input type="hidden"  name="POrCON" value="PO" >
<input type='hidden' name='type' value='<%=orderType%>' >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
<%

  	}
%>
