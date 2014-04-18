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
	var tabHeadWidth=95
	var tabHeight="70%"
	if(screen.width==800)
	{
		tabHeight="57%";
	}
</Script>
<script>
var newWindow
</script>
 <script src="../../Library/JavaScript/Rfq/ezListQCS.js"></Script>
 <Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
 <Script>
 function showTrail()
 {
 	var radLen = document.myForm.collectiveRFQNo.length
 	var colno = 0
 	if(!isNaN(radLen))
 	{
		for(i=0;i<radLen;i++)
		{
			if(document.myForm.collectiveRFQNo[i].checked)
			{
				colno = document.myForm.collectiveRFQNo[i].value
				break;
			}
		}
 	}
 	else
 	{
 		colno = document.myForm.collectiveRFQNo.value	
 	}
 	document.myForm.wf_trail_list.value = colno
 	hideButton();
 	document.myForm.action = "../Misc/ezWFAuditTrailList.jsp"
 	document.myForm.submit()
}
function funBack()
{
	document.location.href="../Misc/ezSBUWelcome.jsp";
}

</Script>
</head>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm">
<input type ="hidden" name="status" value ="<%=status%>">
<input type ="hidden" name="reasons" value ="">
<input type=hidden name=wf_trail_list >
<input type=hidden name=wf_trail_type value='QCF_RELEASE' >
<%
	String display_header = "Collective RFQs List";
	if("A".equals(request.getParameter("Type")))
		display_header = "QCF List";
	if("CR".equals(request.getParameter("status")))
		display_header = "QCF List - Not Yet Submitted For Approval";		
  	if("E".equals(type))
		display_header = "Expired QCF List";   

	
%>	
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<Br>
<%
	if(myRetCount == 0)
	{
		
		
%>
		<br><br><br><br>
		<Table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<Tr align="center">
			<th>No Collective RFQs Exist.</th>
		</Tr>
		</Table>
		<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    		butActions.add("funBack()");	
    		out.println(getButtons(butNames,butActions));
%>
		</Div>

<%	}
	else
	{
	
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
		
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

		Vector grColNames = new Vector();
		grColNames.addElement("RFQ_DATE");
		grColNames.addElement("VALID_UPTO");
		EzGlobal.setColNames(grColNames);
		
		globalRet = EzGlobal.getGlobal(myRet);
	
%>
	<Div id="theads">
  	<Table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="95%">
	    	<Tr align="center" valign="middle">
	    	        <th width="5%">&nbsp;</th>
			<th width="10%">QCF</th>
			<th width="20%">Material</th>
			<th width="10%">RFQ Date</th>
			<th width="10%">RFQ Valid Upto</th>
			<th width="10%">Sent To</th>
			<th width="5%">Quoted</th>
			<th width="5%">Not<BR>Quoted</th>
			<th width="10%">Quotation<BR>Status</th>
<%
			if(!"CR".equals(status))
			{
%>
			<th width="15%">To Act</th>
<%
			}
%>
			
	    	</Tr>
 	</Table>
 	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:75%;">
	<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
<%	
	for(int i=0;i<myRetCount;i++)
	{
		java.util.Date rfqDate 	= (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
		java.util.Date validUpto= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
		int totQuoted		= Integer.parseInt(myRet.getFieldValueString(i,"TOT_QUOTED"));
		int totRFQs		= Integer.parseInt(myRet.getFieldValueString(i,"TOT_RFQ"));
		
		if(!participant.equals(myRet.getFieldValueString(i,"NEXTPARTICIPANT")) && participant.equals(myRet.getFieldValueString(i,"DELPARTICIPANT")))
			isDelParticipant = myRet.getFieldValueString(i,"NEXTPARTICIPANT");
		else
			isDelParticipant = "NO";		
			
			
%>   
		<tr>
			<td align="center" width="5%"><input type="radio" name="collectiveRFQNo" value="<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>"></td>
<%			if(totQuoted > 0)
			{
				if(totQuoted<4)
				{
				    if("A".equals(type))
				    {
%>					<td width="10%"><a href = 'ezQuotationComparisionForm.jsp?collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>&isdelegate=<%=isDelParticipant%>' onClick="hideButton()"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>
<%				
				    } 
				    else 
				    {
%>
					<td width="10%"><a href = 'ezQuotationComparisionForm.jsp?PAGE=NEW&status=<%=status%>&collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>&isdelegate=<%=isDelParticipant%>' onClick="hideButton()"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>
<%				    }	
				}
				else
				{
%>					<td width="10%"><a href = 'ezListRFQByCollectiveRFQ.jsp?collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>&isdelegate=<%=isDelParticipant%>'><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a></td>
<%				}
%>				<td width="20%" title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'><input type=text size=35 class=tx readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
<%			}
			else
			{
%>			
				<td width="10%"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></td>
				<td width="20%" title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'><input type=text size=35 class=tx readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
<%
			}
%>			
			<!--<td width="10%" align="center"><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>
			<td width="10%" align="center"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>-->
			<td width="10%" align="center"><%=globalRet.getFieldValue(i,"RFQ_DATE")%></td>
			<td width="10%" align="center"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>
			<!--<td width="10%" align="center"><%=globalRet.getFieldValue(i,"VALID_UPTO")%></td>-->
			
			<td width="10%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','A')"><%=myRet.getFieldValueString(i,"TOT_RFQ")%></a></td>
		    <%
		    	if("0".equals(myRet.getFieldValueString(i,"TOT_QUOTED")))
		    	{
		    %>
		 		<td width="5%" align="center"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></td>   
		    <%
		    	} else {
		    %>
				<td width="5%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','Y')"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></a></td>
		    <%
		    	}
		    	if("0".equals(myRet.getFieldValueString(i,"TOT_NOT_QUOTED")))
		    	{
		    %>
		    		<td width="5%" align="center"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></td>
		    <%
		    	} else {
		    %>
		    
				<td width="5%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','N')"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></a></td>
		    <%
		    	}
		    	String wfStatus = "";
		    	String wfiStatus = "";
		    	if("null".equals(myRet.getFieldValueString(i,"WFSTATUS")) || myRet.getFieldValueString(i,"WFSTATUS") == null)
		    	{
		    		wfiStatus  = "CREATED";
		    		if(totQuoted == 0)
		    			wfStatus = "Not yet quoted";
		    		else
		    			wfStatus = "Pending for approval";
		    	}	
		    	else
		    		wfStatus  = myRet.getFieldValueString(i,"WFSTATUS")+" On "+myRet.getFieldValueString(i,"WFDATE");
		    	
		    %>
		    	<td width="10%" title='<%=wfStatus%>'><%=wfStatus%></td>
		    <%
		    	if(!"CR".equals(status))
		    	{
				if(wfStatus.startsWith("APPROVED") || "CREATED".equals(wfiStatus))
				{
		    %>
					<td width="15%" nowrap>-</td>
		    <%
				}
				else
				{
					String userName = getUserName(Session,myRet.getFieldValueString(i,"NEXTPARTICIPANT"),myRet.getFieldValueString(i,"NEXTPARTICIPANTTYPE"),(String)session.getValue("SYSKEY"));	
		    %>
					<td width="15%" title='<%=userName%>'><%=userName%></td>
		    <%
			    	}
			 }   	
		    %>
		    
	      	</tr>
<%
	}
%>
	</table>
	</div>

	<div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
 	<Span id="EzButtonsSpan" >
		    
<%		    
        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    		butActions.add("funBack()");		    
		    
		    
 
 	String chkUserRole = (String)session.getValue("USERROLE");
 	if("MG".equals(chkUserRole) || "SM".equals(chkUserRole))
 	{
 
        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    		butActions.add("CloseQCF()");
 	}

 	if(!"CR".equals(status))
 	{
 
 		 
        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    		butActions.add("showTrail()");
		
 
 	}
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
<%   }  %>
</form>
<Div id="MenuSol"></Div>
</body>
</html>