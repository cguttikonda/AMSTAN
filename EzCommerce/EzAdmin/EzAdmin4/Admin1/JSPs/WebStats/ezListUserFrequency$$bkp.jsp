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
	//fromDate,toDate
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
		document.myForm.action="ezListUserFrequency.jsp";
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
		document.myForm.action="ezListViewWebStatsFrequencyExcel.jsp";
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
	<BODY bgcolor="#FFFFF7" onLoad="getDefaultsFromTo();scrollInit();funFocus()" onresize='scrollInit()'>
<%
	}
	else
	{
%>
	<body>
<%
	}
%>
<form name=myForm method=post >
<br>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<%
	if ( sysRows > 0 )
	{
%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
		    	<Th><nobr><%=bussArea%></nobr></Th>
		    	<Td width = "30%"><select name="WebSysKey" Style = "width:100%"  id = "FullListBox">
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
			<%@ include file="../../../Includes/JSPs/WebStats/iListUserFrequency.jsp"%>
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
			}
			else
			{
%>
				<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Td class = "displayheader" align = "center">User Frequency By <%=bussArea%></Td>
				</Tr>
				</Table>
				<div id="theads">
				<Table id="tabHead" width="85%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
				<Tr>
					<Th width="15%" align=center>User Id</Th>
					<Th width="50%" align=center>User Name</Th>
					<Th width="35%" align=center>Frequency</Th>
				</Tr>
				</Table>
				</div>
				<DIV id="InnerBox1Div">
				<Table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
				String userName = "";
				String fName = "",mName = "",lName = "";
				retWebStats.sort(new String[]{"FREQUENCY"},false);
				for(int i=0;i<retWebStats.getRowCount();i++)
				{
					fName = retWebStats.getFieldValueString(i,"NAME");
					mName = retWebStats.getFieldValueString(i,"MIDDLENAME");
					lName = retWebStats.getFieldValueString(i,"LASTNAME");
					if(fName == null || "null".equals(fName)) fName="";
					if(mName == null || "null".equals(mName)) mName="";
					if(lName == null || "null".equals(lName)) lName="";
					userName = fName+" "+mName+" "+lName;
%>
					<Tr>
						<Td width="15%" align=left><%=retWebStats.getFieldValue(i,"USER_ID")%></Td>
						<Td width="50%" align=left><%=userName%></Td>
						<Td width="35%" align=left><%=retWebStats.getFieldValue(i,"FREQUENCY")%></Td>
					</Tr>
<%
				}
			}
			%>
			</Table>
			</div>
<%
			if(retWebStats.getRowCount()!=0)
			{
%>
				<div id="ButtonDiv" align = center style="position:absolute;top:90%;width:100%;">
					<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
				
				<!--Td><img src="../../Images/Buttons/<%= ButtonDir%>/downloadinexcel.gif" height="20" style="cursor:hand" onClick="funSubmit1()"></Td-->
				</div>
<%
			}
%>
<%
		}
		else
		{
%>
			<br><br><br><br>
			<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th>Please Select <%=bussArea%>, From Date, To Date and press Show to continue.</Th>
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
