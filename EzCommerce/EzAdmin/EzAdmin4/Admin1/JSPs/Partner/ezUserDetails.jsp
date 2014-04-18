<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminUser.jsp" %>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%@ include file="../../../Includes/JSPs/User/iListAllUsersBySysKey.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%@ page import="java.util.*" %>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

<%
	String partnerNo = request.getParameter("partnerNo");
	
	if(partnerNo!=null && !"null".equals(partnerNo))
		partnerNo = partnerNo.trim();
	
	String pNo   = "";
	boolean once = false;
	
%>
<body onLoad='scrollInit()' bgcolor="#FFFFF7" onResize='scrollInit()' scroll="no">
<form name=myForm method=post>
<br><br><br>
<DIV style="overflow:auto;position:absolute;left:7.5%;top:14%;width:93%">
<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
<Td class="displayheader">User(s) Details for this Partner:<%=partnerNo%></Td>
</Tr>
</Table>
</Div>
<div id="theads">
<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 >

</Table>
</div>
<div id="InnerBox1Div">
<Table id="InnerBox1Tab" width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
	for(int i=0;i<retUsers.getRowCount();i++)
	{
		if(retUsers.getFieldValueString(i,"EU_BUSINESS_PARTNER")!=null)
			pNo = retUsers.getFieldValueString(i,"EU_BUSINESS_PARTNER").trim();
		if(partnerNo.equals(pNo))
		{
			once = true;				
%>			
			<Tr>
				<Th style="text-align:center" width="50%">User Id</Th><Td>&nbsp;<%=retUsers.getFieldValueString(i,"EU_ID")%></Td>
			</Tr>
			<Tr>
				<Th style="text-align:center" width="50%">User Name</Th><Td>&nbsp;<%=retUsers.getFieldValueString(i,"EU_FIRST_NAME")%></Td>
			<Tr>	
				<Th style="text-align:center" width="50%">Email Id</Th><Td>&nbsp;<%=retUsers.getFieldValueString(i,"EU_EMAIL")%></Td>
			</Tr>
			<Tr></Tr>
			<Tr></Tr>
			<Tr></Tr>
<%		
			
					
		}
%>
					
<%
	
	}
%>
</Table>
</div>
<%
		if(!once)
		{
%>
			<DIV style="overflow:auto;position:absolute;left:7%;top:40%">
				<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
					<Tr align="center">
					<Td class="displayheader">No Users assigned to this Partner</Td>
					</Tr>
				</Table>
			</DIV>
<%
		}
%>		
		<DIV style="overflow:auto;position:absolute;left:42%;top:85%">
		<a href="JavaScript:window.close()"><img src="../../Images/Buttons/<%= ButtonDir%>/close.gif" border=none></a>
		</DIV>
</form>
</body>
</html>