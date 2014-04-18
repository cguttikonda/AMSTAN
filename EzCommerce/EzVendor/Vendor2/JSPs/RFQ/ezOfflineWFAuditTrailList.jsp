<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Materials/iGetUploadTempDir.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iOfflineWFAuditTrailList.jsp" %>
<html>
<head>
<Title>WorkFlow Audit Trail List For Collective RFQ No:<%=docId%></Title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<script>
var tabHeadWidth = 98;
var tabHeight="65%";
if(screen.width==800)
{
	tabHeight="40%";
}	
function submitPage()
{
	document.myForm.submit()
}
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/Misc/ezWFAuditTrailList.js"></Script>
</head>
<Body onLoad="onLoad="scrollInit(<%=scrollInit%>)" onresize="scrollInit(<%=scrollInit%>)" scroll=no >
<Form name="myForm">
<input type=hidden name='commentsField'>
<%
	String display_header = "QCF Audit Trail For Collective RFQ No:"+docId;
%>	
<!--
<Table style="background-color:#95b2c1" id="header" width="100%" border="0" align="center">
	<Tr style="background-color:#95b2c1">
		<Td width="100%" style="background-color:#95b2c1">
			<Table border="0" cellpadding="0" cellspacing="0" width="100%"  >
				
				<Tr valign="middle" class=trclass height=30 style="background-color:#95b2c1">
				<Td style="background-color:#95b2c1" width="60%" valign="middle" align="center">
						<B><%//=display_header%></B>
				</Td>
				</Tr>
			</Table>
		</Td>
	</Tr>
</Table>
-->


<%
	if(request.getParameter("wf_trail_list")!=null && !"null".equals(request.getParameter("wf_trail_list")))
	{
		if(retCount>0)
		{
%>	<BR>
			<Div id="theads">
			<Table id="tabHead" align=center width="98%" class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
				<Tr>
					<Th width="10%"  align="center">Audit</Th>
					<Th width="48%" align="center">Action</Th>
					<Th width="25%" align="center">Date </Th>
					<Th width="17%" align="center">Time Taken</Th>
				</Tr>
			</Table>
			</Div>
			<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:55%;left:2%">
			<Table id="InnerBox1Tab" width="100%" align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1">
<%
				String comments = "";
				for(int i=0;i<retCount;i++)
				{
					comments = retGetWFAuditTrailNos.getFieldValueString(i,"EWAT_COMMENTS");
					if(comments.indexOf("$") != -1)
					{
						comments = comments.substring(comments.indexOf("$")+1,comments.length());
					}
%>
					<Tr>
						<Td width="10%" align="center"><%=retGetWFAuditTrailNos.getFieldValueString(i,"EWAT_AUDIT_NO")%>&nbsp;</Td>
						<Td width="48%" title='<%=comments%>'><%=comments%>&nbsp;</Td>
						<Td width="25%" align="center"><%=fd.getStringFromDate((Date)retGetWFAuditTrailNos.getFieldValue(i,"EWAT_DATE"),".",ezc.ezutil.FormatDate.DDMMYYYY)%>&nbsp;&nbsp;<%=retGetWFAuditTrailNos.getFieldValue(i,"AUDIT_TIME")%></Td>
						<Td width="17%" align="center"><%=retGetWFAuditTrailNos.getFieldValueString(i,"TIME_DIFF")%>&nbsp;</Td>
					</Tr>
<%
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
				<Table align="center" style="width:50%" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1>
					<Tr>
						<Th >List Not Found For This Document Number.</Th>
					</Tr>
				</Table>
			</Div>	
			
			
<%
		}
	}
%>		

<Div id="ButtonsDiv" align=center style="position:absolute;visibility:visible;width:100%;top:90%">
		
<%				 
	    butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");  
	    butActions.add("window.close()");
	    out.println(getButtons(butNames,butActions));
%>
			
</Div>	
<Div id="MenuSol">
</Div>
</form>
</body>
</html>