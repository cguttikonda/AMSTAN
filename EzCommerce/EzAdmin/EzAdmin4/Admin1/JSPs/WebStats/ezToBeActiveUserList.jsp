<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%
	String WebSysKey= request.getParameter("WebSysKey");
	String bussArea = "Purchase Area";
	if(areaFlag.equals("C"))
		bussArea = "Sales Area";
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<script src="../../Library/JavaScript/ezAlign1.js">
	</script>
	<script>
	function getDefaultsFromTo()
	{

		for(i=0;i<document.myForm.WebSysKey.options.length;i++)
		{
			if(document.myForm.WebSysKey.options[i].value=="<%=WebSysKey%>")
			{
				document.myForm.WebSysKey.selectedIndex=i;
				break;
			}
		}

	}
	function funSubmit()
	{
		if(document.myForm.WebSysKey.selectedIndex!=0)
		{	
			document.myForm.action="ezToBeActiveUserList.jsp";
			document.myForm.submit();
		}
		else
		{
			alert("Please Select <%=bussArea%>")
			document.myForm.WebSysKey.focus()
		}
	}

	function funSubmit1()
	{
		if(document.myForm.WebSysKey.selectedIndex!=0)
		{	
			document.myForm.action="ezToBeActiveUserExcelList.jsp";
			document.myForm.submit();
		}
		else
		{
			alert("Please Select <%=bussArea%>")
			document.myForm.WebSysKey.focus()
		}
	}
	function funFocus()
	{
		if(document.myForm.WebSysKey!=null)
			document.myForm.WebSysKey.focus();
	}	
	</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
<BODY bgcolor="#FFFFF7"  onLoad="getDefaultsFromTo();scrollInit();funFocus()" onresize='scrollInit()' >
<%
		}
	else
		{
%>
		<body>
<%
		}
%>
<br>

<form name=myForm method=post>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<%
	if ( sysRows > 0 )
	{
%>
		<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
		    <Th><nobr>Purchase Area</nobr></Th>
		    <Td width = "90%">
		    <select name="WebSysKey" Style = "width:100%" id = "FullListBox" OnChange = "funSubmit()">
		    <option value="-">--Select <%=bussArea%>--</option>		    
		    <option value="">All</option>
		     <%
			StringBuffer all=new StringBuffer("");
			ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for(int i=0;i<ret.getRowCount();i++)
			{
				if(i==0)
				{
					all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}
				else
				{
					all.append(",");
					all.append("'" + ret.getFieldValue(i,SYSTEM_KEY) +"'");
				}
%>				
				<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
			}
		     %>
		     </select>
		      <script>
			document.myForm.WebSysKey.options[1].value="<%=all.toString()%>"
		    </script>
   		     </Td>

		  </Tr>
		</Table>
	<%
	if(WebSysKey!=null)
	{
	%>
		<%@ include file="../../../Includes/JSPs/WebStats/iToBeActiveUsersList.jsp"%>
		<%
		if(retWebStats.getRowCount()==0)
		{
		%>

					<br><br><br><br>
					<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
					<Tr><Th>No To be Activated Users to List.</Th></Tr>
					</Table>
					<br>
					<center>
						<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

					</center>

		<%
			return;
		}
		else
		{
		%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class = "displayheader" align = "center">To be Activated Users List By <%=bussArea%></Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class = "displayheader" align = center colspan = 2>To be Active Users List</Td>	
		</Tr>			
		<Tr>
			<Th width="25%" align=center >User Id</Th>
			<Th width="70%" align=center >User Name</Th>

		</Tr>
		</Table>
		</div>
					<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

<%
		String userName = "";
		String fName = "",mName = "",lName = "";
		for(int i=0;i<retWebStats.getRowCount();i++)
		{
			fName = retWebStats.getFieldValueString(i,"EU_FIRST_NAME");
			mName = retWebStats.getFieldValueString(i,"EU_MIDDLE_INITIAL");
			lName = retWebStats.getFieldValueString(i,"EU_LAST_NAME");
			if(fName == null || "null".equals(fName)) fName="";
			if(mName == null || "null".equals(mName)) mName="";
			if(lName == null || "null".equals(lName)) lName="";
			userName = fName+" "+mName+" "+lName;
%>

		<Tr>
			<Td width="25%" align=left><%=retWebStats.getFieldValue(i,"EU_ID")%></Td>
			<Td width="70%" align=left><%=userName%></Td>

		</Tr>
		<%
		}
		}
		%>
		</Table>
		</div>
		  <div align=center style="position:absolute;top:85%;width:100%">
		<Table  width="30%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="60%">Total Users</Th>
			<Td width="40%" align=right><%=retWebStats.getRowCount()%></Td>
		</Tr>
		</Table>
		</div>
		<div align=center style="position:absolute;top:92%;width:100%">
			<!--img src="../../Images/Buttons/<%= ButtonDir%>/downloadinexcel.gif" height="20" style="cursor:hand" onClick="funSubmit1()"-->		
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>

	<%
	}
	else
	{
	%>
		<br><br><br><br>
		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th>Please Purchase Area  to continue.</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
		
	<%
	}
}
else
{
%>
		<br><br><br><br>
		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th>No Purchase Areas to List</Th>
		</Tr>
		</Table>
		<br>
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
}
%>
</form>
</body>
</html>
