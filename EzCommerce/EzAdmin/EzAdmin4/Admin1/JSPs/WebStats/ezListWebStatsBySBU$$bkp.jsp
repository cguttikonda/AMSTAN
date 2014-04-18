<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>


<%@ page import="java.util.*" %>
<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= request.getParameter("WebSysKey");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");
	String bussArea = "Purchase Area";
	if(areaFlag.equals("C"))
		bussArea = "Sales Area";
		
		//out.println("fdtd--->"+fd+"-->"+td);
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script>
function getDefaultsFromTo()
{

<%
	java.util.Date today = new java.util.Date();
	java.util.Date tomorrow = new java.util.Date();
	tomorrow.setDate(today.getDate()+1);
	ezc.ezutil.FormatDate format = new ezc.ezutil.FormatDate();
		
	if (("".equals(fd))&&("".equals(td)) || ("null".equals(fd))&&("null".equals(td)) || (fd==null)&&(td==null))
	{
%> 
		document.myForm.fromDate.value = "<%=format.getStringFromDate(today,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
		document.myForm.toDate.value = "<%=format.getStringFromDate(tomorrow,"/",ezc.ezutil.FormatDate.MMDDYYYY)%>";
<%
	}
%> 	

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
		document.myForm.action="ezListWebStatsBySBU.jsp";
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
		document.myForm.action="ezListViewWebStatsExcel.jsp";
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
<body bgcolor="#FFFFF7" onLoad='getDefaultsFromTo();scrollInit();funFocus()' onresize='scrollInit()' >
<form name=myForm method=post>
<br>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
 	<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
	    	<Th><%=bussArea%></Th>
		<Td width = "30%">
		<select name="WebSysKey" style = "width:100%"  id = "FullListBox">
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
			<option value="<%=ret.getFieldValue(i,SYSTEM_KEY)%>"><%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
		}
%>
     		</select>
		<script>
			document.myForm.WebSysKey.options[1].value="<%=all.toString()%>"
		</script>
		</Td>
	   	<Th>From</Th>
		<Td><nobr><input type=text class = "InputBox" name="fromDate" size=11 value="<%=fromDate%>" readonly>
        		<a href="javascript:showCal('document.myForm.fromDate',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</nobr></Td>
		<Th>To</Th>
		<Td><nobr><input type=text class = "InputBox" name="toDate" size=11 value="<%=toDate%>" readonly>
        		<a href="javascript:showCal('document.myForm.toDate',50,250)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" ></a>
		</nobr></Td>
		<Td><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" height="20" style="cursor:hand" onClick="funSubmit()"></Td>
	  	</Tr>
		</Table>
<%
	if(WebSysKey!=null)
	{
%>
		<%@ include file="../../../Includes/JSPs/WebStats/iListWebStats.jsp"%>
<%
		if(retWebStats.getRowCount()==0)
		{
%>
			<br><br><br><br>
			<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th>No user logged in yet</Th>
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
			<Td class = "displayheader" align = "center">View Webstats By <%=bussArea%></Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="13%" align=center rowspan=2>User Id</Th>
			<Th width="20%" align=center  rowspan=2>User Name</Th>
			<Th width="17%" align=center  rowspan=2>IP</Th>
			<Th width="25%" align=center colspan=2>Logged In</Th>
			<Th width="25%" align=center colspan=2>Logged Out</Th>
		</Tr>
		<Tr>
			<Th width="13%" align="center">Date</Th>
			<Th width="12%" align="center">Time</Th>
			<Th width="13%" align="center">Date</Th>
			<Th width="12%" align="center">Time</Th>
		</Tr>
		</Table>
		</div>
		<DIV id="InnerBox1Div">
		<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
		String userName = "";
		String fName = "",mName = "",lName = "";
		String loggedIn = "";
		String loggedOut = "";
		for(int i=0;i<retWebStats.getRowCount();i++)
		{
			loggedIn=GlobObj.getFieldValueString(i,"LOGGED_IN");
			loggedOut=GlobObj.getFieldValueString(i,"LOGGED_OUT");
			loggedOut=(loggedOut==null)||"null".equals(loggedOut)?"                     ":loggedOut;
			fName = retWebStats.getFieldValueString(i,"NAME");
			mName = retWebStats.getFieldValueString(i,"MIDDLENAME");
			lName = retWebStats.getFieldValueString(i,"LASTNAME");
			if(fName == null || "null".equals(fName)) fName="";
			if(mName == null || "null".equals(mName)) mName="";
			if(lName == null || "null".equals(lName)) lName="";
			userName = fName+" "+mName+" "+lName;
		%>
			<Tr>
			<Td width="13%" align=left><%=retWebStats.getFieldValue(i,"USER_ID")%></Td>
			<Td width="20%" align=left><%=userName%></Td>
			<Td width="17%" align=left><%=retWebStats.getFieldValue(i,"IP")%></Td>
			<Td width="13%" align=center><%=loggedIn.substring(0,10)%></Td>
			<Td width="12%" align=center><%=loggedIn.substring(11,19)%></Td>
			<Td width="13%" align=center><%=loggedOut.substring(0,10)%>&nbsp;</Td>
			<Td width="12%" align=center><%=loggedOut.substring(11,19)%>&nbsp;</Td>
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
 			<!--img src="../../Images/Buttons/<%= ButtonDir%>/downloadinexcel.gif" height="20" style="cursor:hand" onClick="funSubmit1()"-->
		</div>

	<%
	}
	else
	{
	%>
		<br><br><br><br>
		<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th>Please Select <%=bussArea%>, From Date, To Date and press Show to continue.</Td>
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
<%
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

</body>
</html>

