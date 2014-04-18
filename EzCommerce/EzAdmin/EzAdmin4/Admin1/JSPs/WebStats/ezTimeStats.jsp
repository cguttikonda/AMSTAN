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
	<%@ include file="../../../Includes/JSPs/WebStats/iCalendar.jsp"%> 
	<script language="JavaScript" src="../../Library/JavaScript/ezTabScroll.js"></script>
	
	<script>
	function getDefaultsFromTo()
	{
<%
		java.util.Date today = new java.util.Date();
		java.util.Date tomorrow = new java.util.Date();
		today.setDate(today.getDate()-1);
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
			document.myForm.action="ezTimeStats.jsp";
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
		document.myForm.action="ezTimeStatsExcel.jsp";
		document.myForm.submit();
		}
		else
		{
		alert("Please Select <%=bussArea%>")
		document.myForm.WebSysKey.focus()
		}
	}


	function funShowUsers(hr,users)
	{
		myURL="ezTimeStatsUsers.jsp?Users="+ users +"&Hour=" + hr
		ezWin=window.open(myURL,"stats","status=no,toolbar=no,menubar=no,location=no,top=100,left=100,width=450,height=300");
	}
	function funFocus()
	{
		if(document.myForm.WebSysKey!=null)
			document.myForm.WebSysKey.focus();
	}
	</script>
</head>
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
		{
%>
		<BODY onLoad="getDefaultsFromTo();scrollInit();funFocus()" onResize="scrollInit()" scroll="no">
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
<%
	if ( sysRows > 0 )
	{
%>
		 <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center">
		    <Th><nobr><%=bussArea%></nobr></Th>
		    <Td width = "30%"><select name="WebSysKey" Style = "width:100%" id = "FullListBox">
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
   		     </Td>
		    <script>
			document.myForm.WebSysKey.options[1].value="<%=all.toString()%>"
		    </script>

		 <Th>From</Th>

		 <Td><nobr><input type=text class = "InputBox" name="fromDate" size=11 value="<%=fromDate%>" readonly>
        &nbsp;<%=getDateImage("fromDate")%>
        </a> </nobr></Td>
		   <Th>To</Th>
		   <Td><nobr><input type=text class = "InputBox" name="toDate" size=11 value="<%=toDate%>" readonly>
         &nbsp;<%=getDateImage("toDate")%>
        </a></nobr></Td>
		   <Td><img src="../../Images/Buttons/<%= ButtonDir%>/show.gif" height="20" style="cursor:hand" onClick="funSubmit()"></Td>
		  </Tr>
		</Table>
		<%
		if(WebSysKey!=null)
		{
		%>
			<%@ include file="../../../Includes/JSPs/WebStats/iTimeStats.jsp"%>
		<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class = "displayheader" align = "center">Time Stats By <%=bussArea%></Td>
		</Tr>
		</Table>
		<div id="theads">
		<Table id="tabHead" width="95%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		</Table>
		</div>
		<div id="InnerBox1Div">
		 <Table id="InnerBox1Tab" width="75%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Td class=blankcell>
			<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th width="40%" align=center>Time</Th>
				<Th width="60%">Frequency</Th>
			</Tr>
			<%

			int mTot=0;
			String users = null;
			for(int i=0;i<=11;i++)
			{
			  int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
			  mTot=mTot+temp;
			  users=retWebStats.getFieldValueString(i,"USERS");

			%>
			<Tr>
				<Th width="40%" align=center><%=i%>-<%=i+1%></Td>
				<Td width="60%" align=right>
				<%
				 if(temp==0)
				 {
					out.println(temp);
				}
				else
				{
				%>
					<a href='#' onClick='funShowUsers(<%=i%>,"<%=users%>")'><%=temp%></a>
				<%
				}
				%></Td>

			</Tr>
			<%
			}
			%>
			<Tr>
				<Th width="40%" align=center>Total</Td>
				<Td width="60%" align=right><%=mTot%></Td>
			</Tr>


			</Table>
			</Td>
			<Td class=blankcell>
			<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<Th width="40%" align=center>Time</Th>
				<Th width="60%">Frequency</Th>
			</Tr>
<%
			int eTot=0;
			for(int i=12;i<=23;i++)
			{
			  int temp=Integer.parseInt(retWebStats.getFieldValueString(i,"FREQUENCY"));
			  eTot=eTot+temp;
			   users=retWebStats.getFieldValueString(i,"USERS");
%>
			<Tr>
				<Th width="40%" align=center><%=i%>-<%=i+1%></Td>
				<Td width="60%" align=right>
				<%
				 if(temp==0)
				 {
					out.println(temp);
				}
				else
				{
				%>
					<!-- a href='JavaScript:Void(0)' onClick='funShowUsers(<%=i%>,"<%=users%>")' ><%=temp%></a -->
					<a href='#' onClick='funShowUsers(<%=i%>,"<%=users%>")'><%=temp%></a>
				<%
				}
				%>

				</Td>

			</Tr>
			<%
			}
			%>
			<Tr>
				<Th width="40%" align=center>Total</Td>
				<Td width="60%" align=right><%=eTot%></Td>
			</Tr>


			</Table>
			</Td>


		</Tr>

		</Table>
</div>
<div id = "ButtonDiv" align = "center" style = "position:absolute;top:90%;width:100%">
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
		<div id="ButtonDiv" align="center">
		<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

		</center>
</div>
<%
	}
%>
</form>
</body>
</html>
