<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/Jsps/Misc/iblockcontrol.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iAddQcfQueriesWindow.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

<html>
<head>
<Title>Queries Add Form-- Powered by Answerthink India Pvt Ltd. </Title>
<base TARGET="_self">
<Script src="../../Library/JavaScript/Rfq/ezQCS.js"></Script>
<Script>
function closeWindow()
{
	
	if(Trim(document.myForm.qcfComments.value)=="")
	{
		alert("Please Enter Query String");
		document.myForm.qcfComments.value=""
		document.myForm.qcfComments.focus();		
		return;
	}
	else if(document.myForm.qcfComments.value.length>1000)
	{
		alert("Query Should Not Exceed 1000 Characters");
		document.myForm.qcfComments.focus();
		return;
	}
	var dialogvalue=window.showModalDialog("ezQueryToUser.jsp",window.self,"center=yes;dialogHeight=20;dialogWidth=30;help=no;titlebar=no;status=no;resizable=no")
	if(dialogvalue != null && dialogvalue != "")
	{
		window.opener = window.dialogArguments;
		document.myForm.QcfNumber.value		=	window.opener.document.myForm.QcfNumber.value;
		document.myForm.qcsCommentNo.value	=	window.opener.document.myForm.qcsCommentNo.value;
		document.myForm.Type.value		=	window.opener.document.myForm.commentType.value;
		document.myForm.Initiator.value		=	dialogvalue;
		document.getElementById("ButtonsDiv").style.visibility="hidden"
		document.getElementById("msgDiv").style.visibility="visible"
		document.myForm.action="ezAddSaveQcfQuery.jsp";
		document.myForm.submit();
	}	
}


</Script>

</head>
<Body scroll="no">
<Form name="myForm">
<Input type=hidden name='QcfNumber'>
<Input type=hidden name='qcsCommentNo'>
<Input type=hidden name='Type'>
<Input type=hidden name='Initiator'>
<Input type=hidden name='DOCTYPE' value='<%=DOCTYPE%>'>
<Input type=hidden name='VENDOR' value='<%=VENDOR%>'>
<Input type=hidden name='QRYCOUNT' value='<%=(qcsCount+1)%>'>


<%
	ezc.ezutil.FormatDate fD = new ezc.ezutil.FormatDate();
	String type = "";
	if(request.getParameter("TYPE") != null)
		type = request.getParameter("TYPE");
	if(qcsCount>0)
	{
%>
		<Br>
		<DIV style="position:absolute;overflow:auto;width:100%;height:40%;top:10%">
		<Table align="center" style="width:100%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
			<Tr>
				<Th colspan=3>List of Query/Reply</Th>
			</Tr>
		</Table>		
<%	
		String statusDate = "";
		for(int i=0;i<qcsCount;i++)
		{
			String  query_map = qcsRet.getFieldValueString(i,"QCF_COMMENT_NO");
			if(qcsRet.getFieldValueString(i,"QCF_QUERY_MAP") == "-1" || "-1".equals(qcsRet.getFieldValueString(i,"QCF_QUERY_MAP")))
			{
				/*
					java.util.Date stsDate	= (java.util.Date)qcsRet.getFieldValue(i,"QCF_DATE");
					statusDate = fD.getStringFromDate(stsDate,".",fD.DDMMYYYY);
				*/
				statusDate = globalRet.getFieldValueString(i,"QCF_DATE");
%>
				<Tr>
					<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
						<Tr>
							<Td>
									<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
									<Tr>
										<Th width="30%">Query sent by <%=qcsRet.getFieldValueString(i,"QCF_USER")%> to <%=qcsRet.getFieldValueString(i,"QCF_DEST_USER")%> on <%=statusDate%></Th>
										<Td width="70%"><%=qcsRet.getFieldValueString(i,"QCF_COMMENTS")%></Td>
									</Tr>
									</Table>
									<Table align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width=100%>
<%
										for(int k=0;k<qcsCount;k++)
										{
											if(query_map == qcsRet.getFieldValueString(k,"QCF_QUERY_MAP") || query_map.equals(qcsRet.getFieldValueString(k,"QCF_QUERY_MAP")))
											{
												/*
													stsDate	= (java.util.Date)qcsRet.getFieldValue(k,"QCF_DATE");
													statusDate = fD.getStringFromDate(stsDate,".",fD.DDMMYYYY);
												*/
												statusDate = globalRet.getFieldValueString(k,"QCF_DATE");
											
%>
												<Tr>
													<Th width="30%">Reply sent by <%=qcsRet.getFieldValueString(k,"QCF_USER")%> on <%=statusDate%></Th>
													<Td width="70%"><%=qcsRet.getFieldValueString(k,"QCF_COMMENTS")%></Td>
												</Tr>
<%
											}
										}
%>
									</Table>
							</Td>
						</Tr>
					</Table>

				</Tr>
<%
			}
			else
			if(qcsRet.getFieldValueString(i,"QCF_QUERY_MAP") == "0" || "0".equals(qcsRet.getFieldValueString(i,"QCF_QUERY_MAP")))
			{
				/*
					java.util.Date stsDate	= (java.util.Date)qcsRet.getFieldValue(i,"QCF_DATE");
					statusDate = fD.getStringFromDate(stsDate,".",fD.DDMMYYYY);
				*/
				statusDate = globalRet.getFieldValueString(i,"QCF_DATE");
			
%>
				<Table align="center" style="width:100%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
					<Tr>
						<Th width="30%">Query sent by <%=qcsRet.getFieldValueString(i,"QCF_USER")%> to <%=qcsRet.getFieldValueString(i,"QCF_DEST_USER")%> on <%=statusDate%></Th>
						<Td width="70%"><%=qcsRet.getFieldValueString(i,"QCF_COMMENTS")%></Td>
					</Tr>	
				</Table>
<%
			}
		}
%>
	</Div>
<%
	}		
	else
	{
%>
		<Div style="position:absolute;top:45%;width:100%;visibility:visible">
		<TABLE id="tabHead" width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		  <Tr align="center" valign="middle">
		    <Th width=60%>No queries posted for this document</Th>
		  </Tr>
		</Table>
		</Div>
<%
	}
	if(!"REPORT".equals(type))
	{
	if(qcsCount>0)
	{
%>
		<DIV style="position:absolute;width:100%;height:40%;top:65%">
<%
	}
	else
	{
%>	
		<DIV style="position:absolute;width:100%;height:40%;top:20%">
<%
	}
%>	

<%
	String firstValue = (String)session.getValue("FIRST");
	if(!"Y".equals(firstValue))
	{
%>	

			<Table align="center" style="width:80%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th>Query</Th>
				</Tr>
				<Tr>
					<Td><textarea rows=4 name="qcfComments" style="width:100%"></textarea></Td>
				</Tr>
			</Table>
<%
	}
%>	
		</Div>	
		<DIV id="ButtonsDiv" style="position:absolute;width:100%;top:90%">
<%			
			if(!"Y".equals(firstValue))
			{

      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Submit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
      butActions.add("closeWindow()");

			}

      butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
      butActions.add("window.close()");
    	out.println(getButtons(butNames,butActions));
%>
		</Div>
		<Div id="msgDiv" style="position:absolute;top:90%;width:100%;visibility:hidden" align="center">
			<Table align="center" width="60%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<Tr>
					<Th  align="center">Your request is being processed. Please wait ...............</Th>
				</Tr>
			</Table>
		</Div>
<%
	}
	else
	{
%>
		<DIV id="ButtonsDiv" style="position:absolute;width:100%;top:90%">
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
			butActions.add("window.close()");
			out.println(getButtons(butNames,butActions));
%>
		</Div>
<%
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
