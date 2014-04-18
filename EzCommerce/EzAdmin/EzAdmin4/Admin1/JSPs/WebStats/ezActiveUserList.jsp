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
<script src="../../Library/JavaScript/Calender.js">
</script>
<script src="../../Library/JavaScript/ezAlign1.js">
</script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Script>
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
	function funFocus()
	{
		if(document.myForm.WebSysKey!=null)
			document.myForm.WebSysKey.focus();
	}	
	function funSubmit()
	{
		if(document.myForm.WebSysKey.selectedIndex!=0)
		{
			document.myForm.action="ezActiveUserList.jsp";
			document.myForm.submit();
		}
		else
		{
			alert("Please Select <%=bussArea%>")
			document.myForm.WebSysKey.focus()
		}
	}	
</Script>
</head>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
		<BODY onLoad="getDefaultsFromTo();scrollInit();funFocus()"  onresize='scrollInit()' >
<%
		}
	else
		{
%>
		<body onLoad='scrollInit()' onresize='scrollInit()'>
<%
		}
%>
<br>

<form name=myForm method=post action="">
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<%
	if ( sysRows > 0 )
		{
%>
		<Table  width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
		<Th width = "20%"><nobr><%=bussArea%></nobr></Th>
		<Td width = "80%">
		<div id = "listBoxDiv">
		<select name="WebSysKey" style = "width:100%" onChange ="funSubmit()" id = "FullListBox">
		<option value="">--Select <%=bussArea%>--</option>
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
		     	</div>
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
		<%@ include file="../../../Includes/JSPs/WebStats/iActiveUserList.jsp"%>
<%
		if(retWebStats.getRowCount()==0)
			{
%>
			<br><br><br><br>
			<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th>No Activated Users to List.</Th>
			</Tr>
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
				<Td class = "displayheader" align = "center">Active Users List By <%=bussArea%></Td>
			</Tr>
			</Table>
			<div id="theads">
		 	<Table id="tabHead" width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th width="30%" align=center>User Id</Th>
			<Th width="70%" align=center>User Name</Th>
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
				<Td width="30%" align=left><%=retWebStats.getFieldValue(i,"EU_ID")%></Td>
				<Td width="70%" align=left><%=userName%></Td>
				</Tr>
<%
				}
		}
%>
			</Table>
			</div>
		  	<div id="ButtonDiv" align=center style="position:absolute;top:80%;width:100%">
		 	<Table  width="30%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th width="60%">Total Users</Th>
			<Td width="40%" align=right><%=retWebStats.getRowCount()%></Td>
			</Tr>
			</Table>
			<br>
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
			<Th>Please Select <%=bussArea%>  to continue.</Th>
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
			<Th>No <%=bussArea%>s to List</Th>
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
