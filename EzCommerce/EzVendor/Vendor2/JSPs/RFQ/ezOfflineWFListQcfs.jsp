<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iOfflineWFListQcfs.jsp" %>
<%
	String display_header = "";
%>

<Html>
<Head>
<Title>QCF's pending for your approval</Title>
<Script>
	var tabHeadWidth=96
	var tabHeight="85%"
</Script>
<Script src="../../Library/JavaScript/ezTabMultiScroll.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezTabFunctions.js"></Script>
<script src="../../Library/JavaScript/Misc/ezHideButtons.js"></script>
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
 function callQCForm(collNo,typeFlg,delVal)
 {
 	document.body.style.cursor="wait"
	document.myForm.collectiveRFQNo.value=collNo;
	document.myForm.Type.value =typeFlg;
	document.myForm.DelType.value =delVal;
	hideButton();
	document.myForm.submit();

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
 	document.myForm.wf_trail_list.value = colno;
 	var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=QCF_RELEASE&wf_trail_list="+colno
 	
 	var mywind=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
}

</script>

</head>

<Body  onLoad="scrollMultiInit();showDiv('1','2');" onResize="scrollMultiInit()" onUnload="funUnload()" scroll=no>
<form name="myForm" action ="ezOfflineQuotationComparisionForm.jsp" method="post">
<input type=hidden name=divtabnum value='0'>
<input type=hidden name=wf_trail_list >
<input type=hidden name='quantity' value=''>
<input type=hidden name='action' value=''>
<input type=hidden name='type' value=''>
<input type=hidden name='DelType' value=''>
<%
	java.util.Hashtable  quoteHash=new java.util.Hashtable();
	if(myRetCount>0)
	{
				
	int activeQCFs  = activeRetNew.getRowCount();
	int expiredQCFs = expiredRet.getRowCount();
	
	int tabCount = 2;
	java.util.Hashtable tabHash = new java.util.Hashtable();
	tabHash.put("TAB1","Active&nbsp;("+activeQCFs+")");
	tabHash.put("TAB2","Expired&nbsp;("+expiredQCFs+")");
	
%>
<BR>
	<Table align=center border=0 cellPadding=0 cellSpacing=1  width=90% height="80%">
	<Tr height=10>
	<Td class='blankcell'>
		<%@ include file="../Misc/ezTabDisplay.jsp"%>	
	</Td>
	</Tr>
	<Tr>
	<Td valign="top" class='blankcell' style="background-color:'#E6E6E6'">	<BR><BR>	
<%
	String qcfTypeDsiplay = "";
	for(int m=1;m<3;m++)
	{
		String left="";
		if(m==1)
		{
			qcfTypeDsiplay = "Active";
			myRet = activeRetNew;
			left="left:0%";
		}
		else
		{
			myRet = expiredRet;
			left="left:3%";
			qcfTypeDsiplay = "Active";
		}
		myRetCount=myRet.getRowCount();
		
		ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
											
		Vector grtypes = new Vector();
		grtypes.addElement("date");
		//grtypes.addElement("date");
		grtypes.addElement("date");
		EzGlobal.setColTypes(grtypes);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm");

		Vector grColNames = new Vector();
		grColNames.addElement("RFQ_DATE");
		//grColNames.addElement("VALID_UPTO");
		grColNames.addElement("WFDATE");
		EzGlobal.setColNames(grColNames);
		
		globalRet = EzGlobal.getGlobal(myRet);
		
		
%>
		<Div id="tab<%=m%>" style="position:absolute;height:100%;width:100%;visibility:hidden">
<%
		
		
		if(myRetCount>0)
		{
%>
			

			<DIV  id="theads<%=m%>">
				<table  id="tabHead<%=m%>" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
				<tr align="center" valign="middle">
				<th width="4%">&nbsp;</th>
				<th width="10%">Col.RFQ No.</th>
<%				
				if(m==1){
%>				
					<th width="15%">Material</th>
<%					
				}else
				{
%>
					<th width="25%">Material</th>
<%
				}
%>
				<th width="10%">Created Date</th>
				<th width="10%">Valid Upto</th>
				<th width="10%">QCF Status</th>
				<th width="12%">Submitted By</th>
				<th width="11%">Submitted On</th>
<%
				if(m==1){
%>
				<th width="10%">Time Elapsed</th>
				<th width="8%">Query Status</th>
<%
				}else{
%>
				<th width="8%">Query Status</th>				
<%
				}
%>
				</tr>
				</Table>
			</DIV>



			<DIV id="InnerBox<%=m%>Div" style="overflow:auto;position:absolute;width:100%;height:85%;">
			<TABLE id="InnerBox<%=m%>Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>

<%
			FormatDate fD = new FormatDate();
			String nextParType = "";
			String nextPar = "";
			boolean hlink = false;
			String escRow = "";
			String txtBg  = "tx";

			String delVal = "";
			for(int i=0;i<myRetCount;i++)
			{
				String rfqDate = "",validUpto="",statusDate="";
				
				if(m == 1)
				{
					rfqDate 	= globalActiveRet.getFieldValueString(i,"RFQ_DATE");
					validUpto 	= globalActiveRet.getFieldValueString(i,"VALID_UPTO");
					statusDate 	= globalActiveRet.getFieldValueString(i,"WFDATE");
				}
				if(m == 2)
				{
					rfqDate 	= globalExpiredRet.getFieldValueString(i,"RFQ_DATE");
					validUpto 	= globalExpiredRet.getFieldValueString(i,"VALID_UPTO");
					statusDate 	= globalExpiredRet.getFieldValueString(i,"WFDATE");
				}	
				
				String nextPart 		= (String)nextParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
				String delPart 			= (String)delParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
				java.util.Date wfdate		= (java.util.Date)myRet.getFieldValue(i,"WFDATE");
				String boldflg="";
				String colletiveRfq	= myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO");
				String totVend		= myRet.getFieldValueString(i,"TOT_RFQ");
				String quotedVend	= myRet.getFieldValueString(i,"TOT_QUOTED");
				String notQuotedVend	= myRet.getFieldValueString(i,"TOT_NOT_QUOTED");
				type="";
				quoteHash.put(colletiveRfq,totVend+" ##"+quotedVend+" ##"+notQuotedVend);
				
				if(wfdate!=null && lastLogDate!=null){
					if(lastLogDate.compareTo(wfdate)<=0)
						boldflg="<b>";
				}	

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
				
				
				int totQuoted	= 0;
				try{
					totQuoted	= Integer.parseInt(myRet.getFieldValueString(i,"TOT_QUOTED"));
				}catch(Exception e)
				{
				
				}
				String wfStatus = myRet.getFieldValueString(i,"WFSTATUS");
				if("Y".equals(myRet.getFieldValueString(i,"ISESCALATE")))
				{
					//escRow = "class='redalert'";
					txtBg = "class='tx'";
					//txtBg = "class='tx1'";
					wfStatus = "Escalated";
				}	
				else	
				{
					escRow = "";
					txtBg = "class='tx'";
				}
				
				delPart = delPart.trim();
				if(delPart.equals(userName) || delPart.equals(participant) || delPart.equals(userRole))
				{
					hlink = true;	
					delVal = "D";
				}	
				else 
					delVal = "N";
				
				
%>   
				<tr>
					<input type=hidden name='qcfNumber' value='<%=concat%>'>
					<Td <%=escRow%>  width="4%" align=center><input type=radio name=chk1 value="<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>"></Td>
					<Td <%=escRow%>  width="10%" align="center"><%=boldflg%>
<%
					if(totQuoted>3){
%>
						<a href = 'ezOfflineListRFQByCollectiveRFQ.jsp?collectiveRFQNo=<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>&Type=<%=type%>&isdelegate=<%=isDelParticipant%>&urlFrom=WFListQCF' onClick="hideButton()"><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>													
<%
					}
					else if(totQuoted>0 && !"APPROVED".equals(myRet.getFieldValueString(i,"WFSTATUS")) && hlink)
					{
%>						<a href = 'JavaScript:callQCForm("<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>","<%=type%>","<%=delVal%>")' ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>
<%					}
					else
					{
%>						<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>
<%					}
%>
					</td>
					
<%					if(m==1)
					{
%>						<Td <%=escRow%>  width="15%" ><input type=text <%=txtBg%> size=24 readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>' title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
<%					}
					else
					{
%>						<Td <%=escRow%>  width="25%" ><input type=text <%=txtBg%> size=42 readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>' title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
<%					}
%>
					<!--
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=rfqDate%></td>
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=validUpto%></td>
					-->	
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=globalRet.getFieldValue(i,"RFQ_DATE")%></td>
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=validUpto%></td>
						<!--<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=globalRet.getFieldValue(i,"VALID_UPTO")%></td>-->
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=wfStatus%></td>
					
					
						<Td <%=escRow%>  width="12%" title='<%=myRet.getFieldValueString(i,"WFSTATUS")%> By <%=myRet.getFieldValueString(i,"SENTBY")%> On <%=statusDate%>'>
						<%=boldflg%><%=getUserName(Session,myRet.getFieldValueString(i,"SENTBY"),"O",(String)session.getValue("SYSKEY"))%> 
					</td>
					<!--<Td <%=escRow%>  width="11%" align="center"><%=boldflg%><%=statusDate%></Td>-->
					<Td <%=escRow%>  width="11%" align="center"><%=boldflg%><%=globalRet.getFieldValue(i,"WFDATE")%></Td>
<%
					if(m==1){
%>
						<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=millisecondsToString(myRet.getFieldValueString(i,"TIMELEFT"))%></Td>
						<Td <%=escRow%> align=center width="8%"><%=boldflg%><%=myRet.getFieldValueString(i,"REMARKS")%></td>
<%
					}else{
%>
						<Td <%=escRow%> align=center width="8%"><%=boldflg%><%=myRet.getFieldValueString(i,"REMARKS")%></td>
<%
					}
%>
					
				</tr>
<%
			}
%>
			</table>
			</div>
		
<%

		}
		else
		{
%>		
			<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
			<TABLE id="tabHead" valign="middle" width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
			  <Tr align="center" valign="middle">
			    <Th width=60%><BR>&nbsp;<BR>No <%=qcfTypeDsiplay%> QCFs pending for your approval<BR>&nbsp;<BR>&nbsp;<BR></Th>
			  </Tr>
			</Table>
<%

		}
%>
	</Div>
<%
	}
%>
	</Td>
	</Tr>
	</Table>
	
	<input type="hidden" name="collectiveRFQNo">
	<input type="hidden" name="QcfNumber">
	<input type="hidden" name="comments">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="Created">
	
	<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:90%">
	<span id="EzButtonsSpan" >
<%
	butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Audit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"); 
	butActions.add("showTrail()");
	out.println(getButtons(butNames,butActions));
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
		session.putValue("QUOTEHASH",quoteHash);
	}
	else
	{
		response.sendRedirect("../Misc/ezOfflineMessage.jsp?MESSAGE=No QCFs pending for your approval&DEFAULT_PAGE=EMPTY");
	}
%>
	<input type="hidden" name="Type" value="<%=type%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
