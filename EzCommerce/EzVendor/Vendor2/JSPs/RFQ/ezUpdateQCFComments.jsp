<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iWFAuditTrailList.jsp" %>
<%@ include file="../../../Includes/JSPs/Rfq/iUpdateQCFComments.jsp" %>
<html>
<head>
<script>
	var tabHeadWidth=90
	var tabHeight="65%"
	function submitPage()
	{
		document.myForm.submit()
	}
	function funBack()
	{
		document.location.href="../Misc/ezSBUWelcome.jsp";
	}
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Rfq/ezUpdateQCFComments.js"></Script>
<Title>Queries List -- Powered by EzCommerce India(An Answerthink Company)</Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form name="myForm">
<input type=hidden name='wf_trail_type' value='QCF_RELEASE'>
<input type=hidden name='rqstMenu' value='<%=rqstMenu%>'>

<%
	String display_header = "QCF COMMENTS LIST";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>
<%

if(myRetCnt>0)
{
%>
<TABLE align=center width="50%" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
	<Tr>
		<Th width="35%">Collective RFQ No</Th>
		<Td width="55%">
			<Select name="wf_trail_list" id="listBoxDiv1"  onchange='submitPage()' style="width:100%">
				<Option value="">--Select--</Option>
<%
				for(int k=0;k<myRetCnt;k++)
				{
					String cmstr = myRet.getFieldValueString(k,"DOCID");
					if(collNo == cmstr || collNo.equals(cmstr))
					{
%>				
						<Option value='<%=myRet.getFieldValueString(k,"DOCID")%>' selected><%=myRet.getFieldValueString(k,"DOCID")%></Option>
<%
					}
					else
					{		
%>
						<Option value='<%=myRet.getFieldValueString(k,"DOCID")%>'><%=myRet.getFieldValueString(k,"DOCID")%></Option>
<%
					}	
				}
%>				
				
			</Select>
		</Td>
	</Tr>
</Table>

<%
	if(request.getParameter("wf_trail_list")!=null && !"null".equals(request.getParameter("wf_trail_list")))
	{
		if(retCount>0)
		{
%>	
			<Div id="theads">
				<Table id="tabHead" align=center class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="80%">
					<Tr>
						<Th width="80%">COMMENTS</Th>
						<Th width="20%">&nbsp;</Th>
					</Tr>
				</Table>
			</Div>
			<DIV id="InnerBox1Div">
				<Table id="InnerBox1Tab" align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 width="89%">
<%	
			for(int i=0;i<retCount;i++)
			{
				if(userId.equals(commentsRet.getFieldValueString(i,"QCF_USER")))
				{
%>	
				<Tr>
					<Td width="80%" wrap><%=commentsRet.getFieldValueString(i,"QCF_COMMENTS")%></Td>
					<Td align="center" width=20%><a href="JavaScript:funOpenReplyWin('<%=commentsRet.getFieldValueString(i,"QCF_CODE")%>','<%=commentsRet.getFieldValueString(i,"QCF_COMMENT_NO")%>','<%=commentsRet.getFieldValueString(i,"QCF_DEST_USER")%>','<%=commentsRet.getFieldValueString(i,"QCF_USER")%>','<%=commentsRet.getFieldValueString(i,"QCF_COMMENTS")%>')" title="Click to Update"><Font color="red">Modify</Font></a></Td>
					
				</Tr>
		
<%
				}
			}
%>
			</Table>
			</Div>	
<%
		}
		if(retCount==0)
		{
%>
			<DIV style="position:absolute;width:100%;height:40%;top:45%">
				<Table align="center" style="width:30%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
					<Tr>
						<Th width="25%">Comments not found for this Collective RFQ Number</Th>
					</Tr>
				</Table>
			</Div>	
<%
		}
	}
	else
	{
%>		
		<DIV style="position:absolute;width:100%;height:40%;top:25%">
			<Table align="center" style="width:40%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th width="25%">Please select Col.RFQ No and click OK button.</Th>
				</Tr>
			</Table>
		</Div>
<%
	}
}
else
{
%>
		<DIV style="position:absolute;width:100%;height:40%;top:25%">
			<Table align="center" style="width:40%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th width="25%">No QCF Found to change the Comments</Th>
				</Tr>
			</Table>
		</Div>
	<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
		butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
		butActions.add("funBack()");	
		out.println(getButtons(butNames,butActions));
%>
	</Div>
<%
}
%>
<Div id="MenuSol">
</Div>	
</form>
</body>
</html>
