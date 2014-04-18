<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iPreGraph.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iWFAuthList.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

	<script>
		function checkOpt()
		{
			if(document.myForm.fromDate.value=="")
			{
				alert("Please enter from date");
				return false;
			}
			if(document.myForm.toDate.value=="")
			{
				alert("Please enter to date");
				return false;
			}
			return true;
		}
	</script>
</head>
<body>
<form name=myForm onSubmit="return checkOpt()" action="ezShowGraph.jsp" method="post">
<br><br>
	<Table align=center width="70%" border=1 bordercolorlight=#000000 bordercolordark=#ffffff cellpadding=2 cellspacing=0>
	<Tr>
		<Td class=displayheader colspan=2 align=center>EzGraph</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>GraphType*</Td>
		<Td><div id=ListBoxDiv>
		<select name=graphType>
			<option value="BarGraph">BarGraph</option>
			<option value="PieGraph">PieGraph</option>
		</select></div>
		</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>SysKey*</Td>
		<Td><div id=ListBoxDiv1>
			<select name=sysKey>
			<option value="<%=allSysKeys%>">All</option>
<%
			int rCount=sysRet.getRowCount();
			for(int i=0;i<rCount;i++)
			{
%>
				<option value="<%=sysRet.getFieldValue(i,SYSTEM_KEY)%>" > <%=sysRet.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> </option>
<%
			}
%>
			</select></div>
		</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>Template*</Td>
		<Td><div id=ListBoxDiv2>
			<select name=template>
<%
			int tCount=templateRet.getRowCount();
			for(int i=0;i<tCount;i++)
			{
%>
				<option value="<%=templateRet.getFieldValueString(i,"TCODE")%>"><%=templateRet.getFieldValueString(i,"DESCRIPTION")%></option>
<%
			}
%>
			</select></div>
		</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>Transaction*</Td>
		<Td><div id=ListBoxDiv3>
			<select name=authKey>
<%
		int aCount=ret.getRowCount();
		for(int i=0;i<aCount;i++)
		{
%>
			<option value="<%=ret.getFieldValue(i,AUTH_KEY)%>"><%=ret.getFieldValue(i,AUTH_DESC)%></option>
<%
		}
%>
			</select></div>
		</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>Step</Td>
		<Td><input type=text class = "InputBox" name=step></Td>
	</Tr>
	<Tr>
		<Td class=labelcell>From*</Td>
		<Td>
			<input type=text class = "InputBox" name=fromDate readonly><img src="../../Images/calendar.gif" style="cursor:hand" onClick="showCal('document.myForm.fromDate',10,10)">
		</Td>
	</Tr>
	<Tr>
		<Td class=labelcell>To*</Td>
		<Td>
			<input type=text class = "InputBox" name=toDate readonly><img src="../../Images/calendar.gif" style="cursor:hand" onClick="showCal('document.myForm.toDate',10,10)">
		</Td>
	</Tr>
	</table>
		<input type=hidden name="NO" value="<%=gNo%>">
	<br>
	<center>
		
		<input type=image src="../../Images/Buttons/<%= ButtonDir%>/showgraph.gif" border=no>
	</center>
	
</form>
</body>
</html>