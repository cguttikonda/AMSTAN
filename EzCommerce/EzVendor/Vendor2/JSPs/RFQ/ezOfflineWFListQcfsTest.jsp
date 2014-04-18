<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ page import="ezc.ezutil.FormatDate,java.util.Date,javax.xml.parsers.*,org.w3c.dom.*,ezc.ezparam.ReturnObjFromRetrieve" %>
<%@ page import="javax.xml.transform.*,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult" %>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@include file="../../../Includes/Jsps/Rfq/iOfflineWFListQcfsTest.jsp" %>
<%
	String display_header = "";
	if(myRetCount>0)
		display_header = delHead+"QCF List - Pending For Approval By " +getUserName(Session,myRet.getFieldValueString(0,"NEXTPARTICIPANT"),myRet.getFieldValueString(0,"NEXTPARTICIPANTTYPE"));
%>
<html>
<head>
<Title><%=display_header%></Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Script>
var tabHeadWidth=90
var tabHeight="55%"
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
 function callQCForm(collNo,typeFlg)
 {
	document.myForm.collectiveRFQNo.value=collNo;
	document.myForm.Type.value =typeFlg;
	document.myForm.submit();

 }
 
 function showDiv(n)
 {
         var callflg=false;
         for(var i=1;i<=2;i++)
 	 {
 	 	if(document.getElementById("tab"+i)!=null){
 	 	callflg=true;
			if(i==n)
			{
				document.getElementById("tab"+i).style.visibility="visible"
				document.getElementById("tab"+i+"color").style.color="#000000"
			}
			else
			{
				document.getElementById("tab"+i).style.visibility="hidden"
				document.getElementById("tab"+i+"color").style.color="#ffffff"
			}
 		}
 	 }
 	 
 	 if(callflg)
 	  	tabfun(n)
}

function tabfun(tNo)
{
	var totTabs=2;
	var id1="tab"+tNo+"_1";
	var id2=eval("document.myForm.tab"+tNo+"_2");
	var id3=eval("document.myForm.tab"+tNo+"_3");

	if(tNo==1)
	{
		document.myForm.startBack.src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_left.gif"
	 	document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_front.gif')"
	 	id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_right.gif'
	 	id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back1_left.gif'
	 	for(i=2;i<=totTabs;i++)
	 	{
	 		id1="tab"+i+"_1";
		 	id2=eval("document.myForm.tab"+i+"_2");
		 	id3=eval("document.myForm.tab"+i+"_3");
			document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif')"
			id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif'
			if(i==totTabs)
			{
				id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_end.gif'
			}
			else
			{
				id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif';
			}
 		}
	 }	
	 else
	 {
	 	document.myForm.startBack.src="../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_start.gif"
	 	if(tNo==totTabs)
	 	{
	 		document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_front.gif')";
			id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_right.gif';
			id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_end.gif';
			for(i=1;i<totTabs;i++)
			{
				id1="tab"+i+"_1";
				id2=eval("document.myForm.tab"+i+"_2");
				id3=eval("document.myForm.tab"+i+"_3");
				document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif')"
				id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif'
				if(i==totTabs-1)
				{
					id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_left.gif'
				}
				else
				{
					id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif';
				}
			}
	 	}
	 	else
	 	{
	 		for(i=1;i<=totTabs;i++)
			{
				id1="tab"+i+"_1";
				id2=eval("document.myForm.tab"+i+"_2");
				id3=eval("document.myForm.tab"+i+"_3");
				if(i==tNo)
				{
					document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_front.gif')"
					id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_right.gif'
					id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back1_left.gif'
				}
				else
				{
					document.getElementById(id1).style.backgroundImage="url('../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_fill_back.gif')"
					id2.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_right.gif'
					if(i==(parseInt(tNo)-parseInt(1)))
						id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_front_left.gif'
					else
						if(i==totTabs)
							id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back_end.gif'
						else
							id3.src='../../Images/Buttons/<%=ButtonDir%>/Inbox_files/tab_back2_left.gif'
				}
			}
		}
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
 	document.myForm.wf_trail_list.value = colno;
 	var url="../Misc/ezOfflineWFAuditTrailList.jsp?wf_trail_type=QCF_RELEASE&wf_trail_list="+colno
 	var mywind=newWindow=window.open(url,"ReportWin","width=700,height=300,left=150,top=150,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=yes");
 	
 	//document.myForm.action='../Misc/ezWFAuditTrailList.jsp'
 	//document.myForm.submit()
}

</script>

</head>

<body onLoad="showDiv('1');scrollInit(<%=scrollInit%>)" onResize="scrollInit(<%=scrollInit%>)" onUnload="funUnload()" scroll=no>
<form name="myForm" action ="ezOfflineQuotationComparisionForm.jsp" method="post">

<input type=hidden name=wf_trail_list >
<input type=hidden name='quantity' value=''>
<input type=hidden name='action' value=''>
<input type=hidden name='type' value=''>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>	


<%
	
	if(myRetCount>0)
	{
	
		
%>
	<%@ include file="ezOfflineWFListQcfsTab.jsp"%>	
<%
	for(int m=1;m<3;m++)
	{
		String left="";
		if(m==1){
			myRet = activeRet;
			left="left:2%";
		}
		else{
			myRet = expiredRet;
			left="left:5%";
		}	
		myRetCount=myRet.getRowCount();
		
		
		if(myRetCount>0)
		{
%>
			<Div id="tab<%=m%>" style="overflow:auto;position:absolute;height:86%;width:100%;visibility:hidden">

			<DIV id="theads">
				<table  id="tabHead" width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<tr align="center" valign="middle">
				<th width="5%">&nbsp;</th>
				<th width="12%">Col.RFQ No</th>
				<th width="23%">Material</th>
				<th width="12%">Created Date</th>
				<th width="10%">Valid Upto</th>

				<th width="13%">Submited By</th>
				<th width="10%">Submited On</th>
				<th width="10%">Query Status</th>
				</tr>
				</Table>
			</DIV>



			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:55%;<%=left%>">
			<TABLE id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >

<%
			FormatDate fD = new FormatDate();
			String nextParType = "";
			String nextPar = "";
			boolean hlink = false;
			String escRow = "";
			String txtBg  = "tx";

			String lastLogin =(String)session.getValue("LAST_LOGIN_DATE");

			java.util.Date lastLogDate=null;
			if((!"".equals(lastLogin))&&(lastLogin.length()>7))
			{
				int dateArray[] = fD.getMMDDYYYY(lastLogin,true);
				dateArray[0]=dateArray[0]-1;
				lastLogDate=new java.util.Date(dateArray[2]-1900,dateArray[0],dateArray[1]);
			}


			for(int i=0;i<myRetCount;i++)
			{
				java.util.Date rfqDate		= (java.util.Date)myRet.getFieldValue(i,"RFQ_DATE");
				java.util.Date validUpto 	= (java.util.Date)myRet.getFieldValue(i,"VALID_UPTO");
				String nextPart 		= (String)nextParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
				String delPart 			= (String)delParticipants.get(myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO"));
				String statusDate 		=  myRet.getFieldValueString(i,"WFDATE");
				java.util.Date wfdate		= (java.util.Date)myRet.getFieldValue(i,"WFDATE");
				String boldflg="";
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
					<Td <%=escRow%>  width="5%" align=center><input type=radio name=chk1 value="<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>"></Td>
					<Td <%=escRow%>  width="12%" align="center"><%=boldflg%>
<%
					if(totQuoted>0 && !"APPROVED".equals(myRet.getFieldValueString(i,"WFSTATUS")) && hlink)
					{
%>				
						<a href = 'JavaScript:callQCForm("<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>","<%=type%>")' ><%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%></a>

<%					}
					else
					{
%>
						<%=myRet.getFieldValueString(i,"COLLETIVE_RFQ_NO")%>
<%
					}
%>
					</td>
					<Td <%=escRow%>  width="23%" ><input type=text <%=txtBg%> size=26 readonly value='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>' title='<%=myRet.getFieldValueString(i,"MATERIAL_DESC")%>'></td>
					<Td <%=escRow%>  width="12%" align="center"><%=boldflg%><%=fD.getStringFromDate(rfqDate,".",fD.DDMMYYYY)%></td>
					<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=fD.getStringFromDate(validUpto,".",fD.DDMMYYYY)%></td>

					<Td <%=escRow%>  width="13%" title='<%=myRet.getFieldValueString(i,"WFSTATUS")%> By <%=myRet.getFieldValueString(i,"SENTBY")%> On <%=modifyDate(statusDate)%>'>
						<%=boldflg%><%=getUserName(Session,myRet.getFieldValueString(i,"SENTBY"),"O")%> 
					</td>
					<Td <%=escRow%>  width="10%" align="center"><%=boldflg%><%=modifyDate(statusDate)%></Td>
					<Td <%=escRow%>  width="10%"><%=boldflg%><%=myRet.getFieldValueString(i,"REMARKS")%></td>
				</tr>
<%
			}
%>
			</table>
			</div>
		</Div>
<%

		}
		else
		{
%>		
			<br><br><br><br><br>
			<TABLE width=90% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
			<tr>
			<Th>No QCFs Found.</th>
			</tr>
			</table>
<%

		}
	}
%>
	
	
	
	<input type="hidden" name="collectiveRFQNo">
	<input type="hidden" name="QcfNumber">
	<input type="hidden" name="comments">
	<input type="hidden" name="actionNum">
	<input type="hidden" name="Created">
	
	<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:90%">
	<Table align=center>
	<Tr>
		<Td class=blankcell>
			<img src="../../Images/Buttons/<%=ButtonDir%>/audit.gif" style="cursor:hand" border=none onClick="showTrail()">
		</Td>
	</Tr>
	</Table>
	</Div>
	


<% 
	}
	else
	{
%>

	

		<br><br><br>
		<table width="50%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th>No QCFs Found.</th>
		</tr>
		</table>
	
<%
	}
%>
	<input type="hidden" name="Type" value="<%=type%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
