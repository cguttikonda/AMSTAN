<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/Jsps/Purorder/iListOfflineBlockedContract.jsp"%>
<%@ include file="../../../Includes/Jsps/Labels/iListBlockedPO_Labels.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iGetVendorDesc.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iWFMethods.jsp"%>
<%@page import="ezc.ezutil.*"%>

<html>
<head>
<title>List of Unrealsed Contracts</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
<script>
 	var tabHeadWidth=95
 	var tabHeight	="65%"
 	var selBlockedPo_L='<%=selBlockedPo_L%>';

	function getAgmtDtl(agmtNo)
	{
		location.href="../Rfq/ezGetOfflineAgrmtDetails.jsp?agmtNo="+agmtNo;
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
		var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=CON_RELEASE&wf_trail_list="+colno
		var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function ezBack()
	{
		document.myForm.action = '../Misc/ezSBUWelcome.jsp'
		document.myForm.submit();
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
	java.util.Hashtable orgHash=new java.util.Hashtable();	
%>
<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<form name="myForm">
<input type=hidden name='wf_trail_list'>
<input type=hidden name='wf_trail_type' value='CON_RELEASE'>

<%
	int n=0;
	if(Count==0)
	{
		response.sendRedirect("../Misc/ezOfflineMessage.jsp?MESSAGE=No Contracts pending for your approval&DEFAULT_PAGE=EMPTY");
	}
	else
	{
		String userId = Session.getUserId();
		String delegated = "";
        	String isDelegate = "";	
%>		
			
		<input type=hidden name='prevStatus' value='BLOCKED'>
		<BR>
		<Div id="theads">
		<Table  id="tabHead"  width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
		<Caption><Font color='#083D65' face="Verdana" size=2><B>Contracts pending for approval</Font></Caption>
			<tr align="center" valign="middle">
     				<th width="5%">&nbsp;</th>
     				<th width="10%">Contract No</th>
     				<Th width="10%">Vendor</Th>
            			<Th width="22%">Vendor Name</Th>
     				<Th width="12%"> Amended Details</Th>
    				<th width="12%"><%=ordDate_L%></th>
				<th width="10%">Purch. Group</th>
				<th width="8%">Query Status</th>
				<th width="8%">Delegated</th>
			 </tr>
		</Table>
		</Div>
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:87%;height:65%">
		<Table  id="InnerBox1Tab" align=center width=100%  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
 <%
  		ezc.ezutil.FormatDate fD=new ezc.ezutil.FormatDate();
        	String vendorNo = "";
        	String orgStr=null;
        	java.util.Hashtable collSyskey=new java.util.Hashtable();
		for(int i=0;i<Count;i++)
    		{
			
			if(ret.getFieldValueString(i,"DOCSTATUS").equals("M"))	
			{
		   		poNum = ret.getFieldValueString(i,"DOCNO");
		   		vendorNo = ret.getFieldValueString(i,"EXT1");
				String vendorName = (String)venodorsHT.get(vendorNo.trim());
				if(vendorName == null || "null".equals(vendorName) || "".equals(vendorName))
					vendorName = "Not Synchronized";
		   		
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
		   		collSyskey.put(poNum.trim(),ret.getFieldValueString(i,"SYSKEY"));
		   		if(!orgHash.contains(ret.getFieldValueString(i,"SYSKEY")))
				  {
				    orgHash.put(ret.getFieldValueString(i,"SYSKEY"),getDesiredValue(Session,ret.getFieldValueString(i,"SYSKEY"),"PURGROUP"));
				  }
				orgStr=(String)orgHash.get(ret.getFieldValueString(i,"SYSKEY"));
				if(orgStr==null)orgStr="";
 %>
	 			<tr>
     					<td width="5%" align="center"><input type="radio" name=chk1 value="<%=poNum%>"></td>
	     				<!--<td width="20%" align="center"><a href="ezBlockedPoLineitems.jsp?PurchaseOrder=<%=poNum%>"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></td>-->
	     				
	     				<td width="10%" align="center"><a href="../Rfq/ezGetOfflineAgrmtDetails.jsp?ISDELEGATE=<%=isDelegate%>&agmtNo=<%=poNum%>&viewType=UNREL&POORCONTRACT=CON&RQSTFROM=PORTAL" onClick="hideButton()"><%=Long.parseLong(ret.getFieldValueString(i,"DOCNO"))%></a></td>
	     				
	   				 <Td width="10%" align="center"><a href = "javascript:funShowVndrDetails('<%=(String)session.getValue("SYSKEY")%>','<%=vendorNo%>')"><%=vendorNo%></a></Td>
             				 <Td width="22%" align="left"><%=vendorName%>&nbsp;</Td>
	     				<Td width="12%" align="center">
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
	     				
    					<td width="12%" align="center"><%=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"DOCDATE"),".",FormatDate.DDMMYYYY)%></td>
					<td width="10%" align="center"><%=orgStr%><%//=fD.getStringFromDate((java.util.Date)ret.getFieldValue(i,"MODIFIEDON"),".",FormatDate.DDMMYYYY)%><input type="hidden" name="actionStatus" value="<%=ret.getFieldValue(i,"actionStat")%>"></td>
					<Td width="8%" align="center"><%=ret.getFieldValueString(i,"REMARKS")%></Td>	
					<Td width="8%" align="center"><%=delegated%></Td>
					<input type="hidden"  name="poNo" value="<%=poNum%>" >
	    			</tr>
 <%				
			}
		}
		session.putValue("COLLSYSKEY",collSyskey);
 %>
		</table>
		</div>
		
		<input type="hidden"  name="POrCON" value="CONTRACT" >

		<Div id="back"  style="position:absolute;top:90%;width:100%;visibility:visible">
		<span id="EzButtonsSpan" >
<%  
                buttonName = new java.util.ArrayList();
                buttonMethod = new java.util.ArrayList();
		buttonName.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		buttonMethod.add("showTrail()");
		out.println(getButtonStr(buttonName,buttonMethod));	
		buttonName.clear();
		buttonMethod.clear();
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
	   		document.getElementById("nocount").style.visibility="visible"
	   	}
		</script>
<%	}
%>
	<input type='hidden' name='type' value='<%=orderType%>' >
</form>
<Div id="MenuSol"></Div>
</body>
</html>