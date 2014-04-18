<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ include file="../../../Includes/JSPs/News/iNews.jsp"%>
<html>
<head>	
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body topmargin = "0" leftmargin = "0" scroll=no>
<%

	String display_header= "Details";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<BR>

<Div id='inputDiv' style='position:absolute;background-color:#FFFFFF;align:center;top:22%;width:100%;height:60%'>
<Table width="85%" height="100%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'#F3F3F3'" valign=middle align=right>
		<Table width="100%" height="100%" border="1" cellspacing="0" cellpadding="10" align=center valign=center>
		<Tr>
			<Td width="2%" style='background:#F3F3F3' valign=top>
<%
			int newsCnt =newsRet.getRowCount();
			for(int i=0;i<newsCnt;i++)
			{
				if(newsId != null && newsRet.getFieldValueString(i,"EZN_ID").equals(newsId))
				{
%>
					<b><%=newsRet.getFieldValueString(i,"EZN_TEXT")%></b>
<%	
					break;
				}
			}
%>	
			</Td>
		</Tr>	
		</Table>
	</Td>
	<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>

<Div id="ButtonDiv"  style="position:absolute;left:0%;width:100%;top:85%">
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
