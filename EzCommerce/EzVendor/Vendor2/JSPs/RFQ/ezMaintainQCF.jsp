<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iListRFQByCollectiveRFQ.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iQuotationComparisionForm.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iExecuteQCFReport.jsp"%>
<html>
<head>
	<Script>
		var tabHeadWidth=90
		var tabHeight	="<%=tabHeight%>"
	</Script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<Script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
	<Script src="../../Library/JavaScript/Rfq/ezQCSExt.js"></Script>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body  onLoad="scrollInit(<%=scrollInit%>)" onResize="scrollInit(<%=scrollInit%>)" scroll=no>
<form name="myForm" method="post">
<%
	if(qcfCount>0)
	{
		String materialNo 	= qcfRet.getFieldValueString(0,"MATNR");
		boolean submitionFlag=true;
		String subAlert="";
		java.util.Date currentDayDate = new java.util.Date();
		currentDayDate.setHours(0);currentDayDate.setMinutes(0);currentDayDate.setSeconds(0);
		for(int j=0;j<qcfCount;j++)
		{
			java.util.Date expiredDate=(Date)qcfRet.getFieldValue(j,"BNDDT");
			if(expiredDate!=null)
			{
				expiredDate.setHours(12);
				if(expiredDate.compareTo(currentDayDate)<0)
				{
					submitionFlag=false;
				}
				
			}
		}
		if(!submitionFlag)
		{
			if(showSubmit)
			{
				subAlert="You can't submit QCF,some of the RFQ's in list are expired";
			}
			else if(showApprove)
			{
				subAlert="You can't Approve QCF,some of the RFQ's in list are expired";
			}
			
		}	
%>	
		<input type=hidden name="actionNum"   >
		<input type=hidden name="prevStatus"  >
		<input type=hidden name="attachflag"  >
		<input type=hidden name="attachString">
		<input type=hidden name="QcfNumber" 	  value='<%=collNo%>'>
		<input type=hidden name="qcsCommentNo" 	  value='<%=(qcsCount+1)%>'>
		<input type=hidden name="isdelegate" 	  value='<%=isdelegate%>'>
		<input type=hidden name="initiator" 	  value='<%=initiator%>'>
		<input type=hidden name="hideBypassCount" value='-'>
		<input type=hidden name="byPassAllow"     value='-'>
		<input type=hidden name="nextPart"        value='<%=nextParticipant%>'>
		
		
		
		<Div width='100%' height='100%'>
		<Table style='width:100%;height=90%'>
		<Tr>
			<Td width='80%'>
				<iframe src='ezMaintainQcfSAPScreen.jsp'  style="width:100%;height=100%"></iframe>
			<Td>
			<Td valign=top width='20%'>
				<Table width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr><Th align=left><B>Propose Vendor</B></Th></Tr>
<%
				String vendNumber = "";
				String checkVendorNumber = "";
				String quoted = "";
				int colcount = qcfCount+1;
				for(int i=0;i<qcfCount;i++)
				{
					vendNumber = qcfRet.getFieldValueString(i,"LIFNR");
					disableByUsrRole = "";
					String Chkd ="";
					for(int k=0;k<myRetCnt;k++)
					{
						String chkPropose = myRet.getFieldValueString(k,"VEND_TYPE");
						checkVendorNumber = myRet.getFieldValueString(k,"VENDOR");
						quoted = (myRet.getFieldValueString(k,"STATUS")).trim();
						if(checkVendorNumber.equals(vendNumber))
						{
							disableByUsrRole = "";
							if(!"A".equals(chkPropose) || "APPROVED".equals(wfStatus) || "N".equals(quoted) || !allowPropose)
							{
								disableByUsrRole = "disabled";
							}
						}

						if((myRet.getFieldValueString(k,"RFQ_NO").trim().equals(qcfRet.getFieldValueString(i,"EBELN").trim())) && ("R".equals(myRet.getFieldValueString(k,"RELEASE_INDICATOR").trim())))
							Chkd ="checked";

					}
					if(allowPropose)
						disableByUsrRole = "";
					if(!"disabled".equals(disableByUsrRole))
						globalDisFlg=true;
%>				
					<Tr><Td><input type=checkbox name=propose value="<%=qcfRet.getFieldValueString(i,"EBELN")%>" <%=Chkd%> <%=disableByUsrRole%>><B><%=vendNumber%></B></Td></Tr>
<%
				}
%>
				</Table>
				<Table id='attachTable' border=0 width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
				<Td>
					<Table id='attachTable' border=0 width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
					<Tr>
					<Th align=left>
						<a href="JavaScript:funAttach()" title="Click Here To Attach A File"><Font color="white">Attach</Font></a>
					</Th>
					<Th align=right>
						<a href="JavaScript:funRemove()" title="Click Here To Remove Attached File"><Font color="white">Remove</Font></a>
					</Th>
					</Tr>
					</Table>
				</Tr>
				<Tr>
					<Td colspan=2>
						<select name="attachs" style="width:100%" size=4></select>
					</Td>		
				</Tr>
				</Table>
				<Table id='attachTable' border=0 width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr><Th align=left>View Attachments</Th></Tr>
				</Table>
			</Td>
		</Tr>
		</Table>
		</Div>
		
		
		
		
		
		
		
		
		
<%
	}
	else
	{
%>
		
		<br><br><br><br>
		<Table width="50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 align="center">
		<Tr align="center">
			<th>No RFQs Exist With collective RFQ:<%=collNo%> in SAP.</th>
		</Tr>
		</Table>
		<br>
		<Div id="buttons" style="position:absolute;top:92%;width:100%;visibility:visible" align="center">
<%
		    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
		    butActions.add("history.go(-1)");
		    out.println(getButtons(butNames,butActions));
%>
</Div>
<%
	}
	if(globalDisFlg)
		disableByUsrRole="";
	else
		disableByUsrRole="disabled";
%>
<Div id="MenuSol"></Div>
<input type="hidden" name="proposeFlg" value="<%=disableByUsrRole%>">
</Form>
</Body>
</Html>	
