<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iWFListQcfs.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
var tabHeadWidth=98
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>


<script>
	var newWindow

	function funUnload()
	{
		if(newWindow!=null && newWindow.open)
		{
		  newWindow.close();
		}
	}
	
	function showVendors(collRfq,proc)
	{
		var url="ezShowVendors.jsp?collRfq="+collRfq+"&process="+proc;
		newWindow=window.open(url,"VendWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
	}
	function showGraph(collRfq)
	{
		var url="ezReportChart.jsp?collRFQ="+collRfq;
		newWindow=window.open(url,"ReportWin","width=750,height=550,left=20,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");

	}
	function hideButton()
	{
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
		}
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
 			alert("Please select the Collective RFQ No to see Audit");
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
 			alert("Please select the Collective RFQ No to see Audit");
 			return;
		}
 	}
 	 hideButton()
 	document.myForm.wf_trail_list.value = colno;
 	location.href='../Misc/ezWFAuditTrailList.jsp?wf_trail_type=QCF_RELEASE&wf_trail_list='+colno
 	//document.myForm.action='../Misc/ezWFAuditTrailList.jsp'
 	//document.myForm.submit()
}

function funBack()
{
	document.location.href="../Misc/ezSBUWelcome.jsp";
}

</script>

</head>
<body onLoad="scrollInit(<%=scrollInit%>)" onResize="scrollInit(<%=scrollInit%>)" onUnload="funUnload()" scroll=no>
<form name="myForm">
<input type=hidden name="PAGE" value="ACT">
<input type=hidden name=wf_trail_list >
<input type=hidden name='quantity' value=''>
<input type=hidden name='action' value=''>
<input type=hidden name='type' value=''>

<%
	String display_header = "";
	if(myRetCount>0)
	{
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
				
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		//grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

		Vector grColNames = new Vector();
		grColNames.addElement("RFQ_DATE");
		//grColNames.addElement("VALID_UPTO");
		EzGlobal.setColNames(grColNames);

		globalRet = EzGlobal.getGlobal(myRet);
	
		display_header = delHead+"QCF List - Pending For Approval";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<Br>
	<DIV id="theads">
	<table  id="tabHead" width="98%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
  	<tr align="center" valign="middle">
  	<th width="3%">&nbsp;</th>
	<th width="10%">Col.RFQ No</th>
	<th width="15%">Material</th>
	<th width="8%">Date</th>
	<th width="8%">Valid<BR>Upto</th>
	<th width="5%">Vndrs<BR>Sent<BR>To</th>
	<th width="5%">Qtd</th>
	<th width="5%">Not<BR>Qtd</th>
	<th width="15%">Status</th>
	<th width="15%">To Act</th>
	<th width="14%">Query Status</th>
  	</tr>
	</Table>
	</DIV>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

<%
	FormatDate fD = new FormatDate();
	String nextParType = "";
	String nextPar = "";
	boolean hlink = false;
	String escRow = "";
	String txtBg  = "tx";
	
	for(int i=0;i<myRetCount;i++)
	{
		java.util.Date rfqDate		= (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
		java.util.Date validUpto 	= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
		String nextPart 		= (String)nextParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String delPart 			= (String)delParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		String concat 		= "";
		String recStatus 	= "";
		String isDelParticipant = "";
		int rowId 		= retobj.getRowId("DOCID",myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
		
		
		
		nextParType = myRet.getFieldValueString(i,"NEXTPARTICIPANTTYPE");
		nextPar = myRet.getFieldValueString(i,"NEXTPARTICIPANT");
		
		if("G".equals(nextParType))
		{
			if(nextPar.equals(participant))
				hlink = true;
			else
				hlink = false;
		}
		if("R".equals(nextParType))
		{
			if(nextPar.equals(wfRole))
				hlink = true;
			else
				hlink = false;
		}
		if("U".equals(nextParType))
		{
			if(nextPar.equals(userName))
				hlink = true;
			else
				hlink = false;
		}
		delPart = delPart.trim();
		if(delPart.equals(userName) || delPart.equals(participant) || delPart.equals(userRole))
			hlink = true;
			
			
		if(rowId != -1)
		{
			recStatus = retobj.getFieldValueString(rowId,"STATUS");
			if(participant.equals(retobj.getFieldValueString(rowId,"DELPARTICIPANT")))
				isDelParticipant = retobj.getFieldValueString(rowId,"DELPARTICIPANT");
			else
				isDelParticipant = "NO";
		}	
		
		if(!type.equals("D"))
		{
			if(!userRole.equals("VP"))
			{
				if(nextPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
			}
			else
			{
				if(nextPart.equals((String)session.getValue("ROLE")))
				{
					if(rowId==-1)
					{
						concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
					else
					{
						//if(retobj.getFieldValueString(rowId,"STATUS").equals("QCFSUBMITTEDBYVP"))
						if(retobj.getFieldValueString(rowId,"STATUS").equals("SUBMITTED"))
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
						else
							concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
					}
				}	
				else
				{
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
				}	
			}
		}
		else
		{
				if(delPart.equals((String)Session.getUserId()))
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','A','"+type+"'";
				else
					concat = "'"+myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")+"','"+myRet.getFieldValueString(i,"QUANTITY")+"','N','"+type+"'";
		
		}
		
		int totQuoted	= Integer.parseInt(myRet.getFieldValueString(i,"TOT_QUOTED"));
		
		if("Y".equals(myRet.getFieldValueString(i,"ISESCALATE")))
		{
			escRow = "class='redalert'";
			txtBg = "class='tx1'";
		}	
		else	
		{
			escRow = "";
			txtBg = "class='tx'";
		}
%>   
		<tr>
			<input type=hidden name='qcfNumber' value='<%=concat%>'>
			<Td <%=escRow%>  width="3%" align=center><input type=radio name=chk1 value="<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>"></Td>
			<Td <%=escRow%>  width="10%">
<%
			if(totQuoted>3){
%>
				<a href = 'ezListRFQByCollectiveRFQ.jsp?collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>&isdelegate=<%=isDelParticipant%>&urlFrom=WFListQCF'><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>							
<%
			}else if(totQuoted>0 && !"APPROVED".equals(myRet.getFieldValueString(i,"WFSTATUS")) && hlink)
			{
%>				
				<a href = "ezQuotationComparisionForm.jsp?PAGE=ACT&collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>" onClick="hideButton()"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>
<%			}
			else
			{
%>				
				
				<a href = "ezQuotationComparisionForm.jsp?collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>" onClick="hideButton()"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>
<%			}
%>
			</td>
			<Td <%=escRow%>  width="15%"><input type=text <%=txtBg%> size=21 readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>' title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
			<!--<Td <%=escRow%>  width="8%"><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>-->
			
			<Td <%=escRow%>  width="8%"><%=globalRet.getFieldValue(i,"RFQ_DATE")%></td>
			<!--<Td <%=escRow%>  width="8%"><%=globalRet.getFieldValue(i,"VALID_UPTO")%></td>-->
			<Td <%=escRow%>  width="8%"><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>
			
			<Td <%=escRow%>  width="5%" align="center"><a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','A')"><%=myRet.getFieldValueString(i,"TOT_RFQ")%></a></td>
			<Td <%=escRow%>  width="5%" align="center">
<%
			if("0".equals(myRet.getFieldValueString(i,"TOT_QUOTED")))
			{
%>
				<%=myRet.getFieldValueString(i,"TOT_QUOTED")%>
<%
			} 
			else 
			{
%>
				<a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','Y')"><%=myRet.getFieldValueString(i,"TOT_QUOTED")%></a>
<%
			}
%>			
			</td>
			<Td <%=escRow%>  width="5%" align="center">
<%			
			if("0".equals(myRet.getFieldValueString(i,"TOT_NOT_QUOTED")))
			{
%>
				<%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%>
<%
			} 
			else 
			{
%>

				<a href="javascript:showVendors('<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>','N')"><%=myRet.getFieldValueString(i,"TOT_NOT_QUOTED")%></a>
<%
			}
%>
			</td>
<%					
			String statusDate = myRet.getFieldValueString(i,"WFDATE");
%>
		    	<Td <%=escRow%>  width="15%" title='<%=myRet.getFieldValueString(i,"WFSTATUS")%> By <%=myRet.getFieldValueString(i,"SENTBY")%> On <%=modifyDate(statusDate)%>'><%=myRet.getFieldValueString(i,"WFSTATUS")%> By <%=getUserName(Session,myRet.getFieldValueString(i,"SENTBY"),"U",(String)session.getValue("SYSKEY"))%> On <%=modifyDate(statusDate)%></td>
		    	<Td <%=escRow%>  width="15%">
<%
		    	if("APPROVED".equals(myRet.getFieldValueString(i,"WFSTATUS")))
		    	{
		    		out.println("-");
		    	}
		    	else
		    	{
%>
				    	<%=getUserName(Session,myRet.getFieldValueString(i,"NEXTPARTICIPANT"),myRet.getFieldValueString(i,"NEXTPARTICIPANTTYPE"),(String)session.getValue("SYSKEY"))%>
<%
			}   	
%>
			</td>
			<Td <%=escRow%>  width="14%"><%=myRet.getFieldValueString(i,"REMARKS")%></td>
	      	</tr>
<%
	}
%>
	</table>
	</div>

	<input type="hidden" name="QcfNumber">
	<input type="hidden" name="comments">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="Created">
	
	
<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:90%">
<Span id="EzButtonsSpan" >

<%
	        butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
	        butActions.add("showTrail()");
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
	

<% }else{ %>

	<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	
	<br><br><br>
	<table width="50%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<tr align="center">
	<th>No QCFs Found.</th>
	</tr>
	</table>
	<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:90%">
<%
	 butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
    	 butActions.add("funBack()");	
    	 out.println(getButtons(butNames,butActions));
%>
	</Div>
	<%}%>
<input type="hidden" name="Type" value="<%=type%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
