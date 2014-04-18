<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ include file="../../../Includes/JSPs/Misc/iNews.jsp"%>
<html>
<head>	
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<body topmargin = "0" leftmargin = "0" scroll=no>

<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:15%'>
<Table width="90%" height="90%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>

<%
	int newsCnt =newsRetObj.getRowCount();
	for(int i=0;i<newsCnt;i++)
	{
%>
	<Tr>
	
		<Td style="background:transparent" width="2%" style='background:#F3F3F3'>
			<b><%=(i+1)%>.</b>
		</Td>
		<Td style="background:transparent" width="75%" style='background:#F3F3F3'>
			<b><%=newsRetObj.getFieldValueString(i,"EZN_TEXT")%></b>
		</Td>
	</Tr>	
<%
	}
%>	
</Table>
</Div>
<Div id="ButtonDiv" align=left style="position:absolute;top:85%;visibility:visible;width:100%;">
<center>
<%

	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>		
</center>
</Div>
<Div id="MenuSol"></Div>
</body>
</html>