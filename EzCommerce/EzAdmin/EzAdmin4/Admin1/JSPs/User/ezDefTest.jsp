
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<html>
<head>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<body onLoad='scrollInit()' onresize='scrollInit()'>
<br>
<%
	ezc.ezbasicutil.EzDefaults ezDef = new ezc.ezbasicutil.EzDefaults(Session);
	java.util.ArrayList keys = ezDef.getDefaultKeys();
	ezc.ezparam.ReturnObjFromRetrieve ret=null;
	int keysSize=keys.size();
	String s="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

%>
	<div id="theads">
	<Table id="tabHead" align=center>
	<Tr>
		<Th>
<%
			out.println(ezDef);
%>
		</Th>
	</Tr>
	</Table>
	</div>

	<div id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center >
	<Tr><Td>
<%
	for(int i=0;i<keysSize;i++)
	{
		
		ret=ezDef.getDefaultValues((String)keys.get(i));

%>		
		<Table width=100% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		<Tr>
			<Th colspan=5 ><div align=left>Key = <%=keys.get(i)%></div> <div align=right>  TimeTaken=<%=ezDef.myTime%>(MS)</div></Th>
		</Tr>
		<Tr>
<%		
		for(int j=0;j<ret.getColumnCount();j++)
		{
%>		
			<Th><%=ret.getFieldName(j)%></Th>		
<%			
		}
%>
		</Tr>
<%
		for(int j=0;j<ret.getRowCount();j++)
		{
%>
		<Tr>
			<Td><%=ret.getFieldValue(j,0)%></Td>
			<Td><%=ret.getFieldValue(j,1)%></Td>
			<Td><%=ret.getFieldValue(j,2)%></Td>
			<Td><%=((ret.getFieldValue(j,3)==null || "null".equals(ret.getFieldValueString(j,3)))?"&nbsp;":ret.getFieldValue(j,3))%></Td>
			<Td><%=((ret.getFieldValue(j,4)==null || "null".equals(ret.getFieldValueString(j,4)))?"&nbsp;":ret.getFieldValue(j,4))%></Td>
		</Tr>
<%
		}
%>
		</Table>
<%		
	}
	
%>

	</Td></Tr></Table></div>
</body>
</html>
