<%@ page import="java.util.*" %>
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<%
	String fd=request.getParameter("fromDate");
	String td=request.getParameter("toDate");
	String WebSysKey= request.getParameter("WebSysKey");
	String fromDate=request.getParameter("fromDate");
	String toDate=request.getParameter("toDate");

	String bussArea = "Purchase Area";
	if(areaFlag.equals("C"))
		bussArea = "Sales Area";
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script>
function getDefaultsFromTo()
	{
<%
	if(fd != null && td != null)
		{
%>
<%
		}
	else
		{
%> /////167
		toDate = new Date();
		today = toDate.getDate();
		thismonth = toDate.getMonth()+1;
		thisyear = toDate.getYear();
		if(today < 10)
			today = "0"+today;
		if(thismonth < 10)
			thismonth = "0" + thismonth;
		document.myForm.fromDate.value = thismonth+"/"+today+"/"+thisyear;
		document.myForm.toDate.value = thismonth+"/"+today+"/"+thisyear;
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
		document.myForm.action="ezSaveClearWebStatsBySBU.jsp";
		a=confirm("It will clear the Webstatistics between selected dates.Do you want to clear")
		if(a)
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
		document.myForm.WebSysKey.focus()
}
</script>
</head>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
		<BODY onLoad="getDefaultsFromTo();funFocus()" >
<%
		}
	else
		{
%>
		<body>
<%
		}
%>	

<form name=myForm method=post action="">
<br>
<%
	if ( sysRows > 0 )
		{
%>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr>
	<Td class=displayHeader align = center>Clear Web Stats</Td>
</Tr>
</Table>
<input type=hidden name="Area" value="<%=areaFlag%>">
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
      	<Th align="right" width = "40%"><%=bussArea%>:</Th>
      	<Td>
      	<div id = "listBoxDiv">
        <select name="WebSysKey" Style = "width:100%" id = "FullListBox">
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
			<option value="'<%=ret.getFieldValue(i,SYSTEM_KEY)%>'"> <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
<%
			}
%>
        </select>
        <script>
			document.myForm.WebSysKey.options[0].value="<%=all.toString()%>"
	</script>
      	</Td>
    	</Tr>
    	<Tr>
      	<Th align = "right" width = "40%">From:</Th>
      	<Td>
        <input type=text class = "InputBox" name="fromDate" size=11 value="<%=fromDate%>">
        <a href="javascript:showCal('document.myForm.fromDate',50,50)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" >
        </a> </Td>
    	</Tr>
    	<Tr>
      	<Th align = "right" width = "40%">To:</Th>
      	<Td>
        <input type=text class = "InputBox" name="toDate" size=11 value="<%=toDate%>">
        <a href="javascript:showCal('document.myForm.toDate',50,50)"> <img border=no style="cursor:hand" src="../../Library/JavaScript/calender.gif" alt = "Calender" align="middle" >
        </a></Td>
    	</Tr>
</Table>
<br>
<center>
<img src="../../Images/Buttons/<%= ButtonDir%>/clear.gif" style="cursor:hand" onClick="funSubmit()"></Td>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();getDefaultsFromTo()" ></a>
</Td>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a></Td>
<center>
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
</form>
</body>
</html>
