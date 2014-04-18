<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/WebStats/iListBusAreas.jsp"%>

<%

	String WebSysKey= request.getParameter("WebSysKey");



%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script>
var tabHeadWidth=90
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

	<script>
	function getDefaultsFromTo()
	{

		for(i=0;i<document.myForm.WebSysKey.options.length;i++)
		{
			if(document.myForm.WebSysKey.options[i].value=="<%=WebSysKey%>")
			{
				document.myForm.WebSysKey.selectedIndex=i;
				
			}
		}

	}
	function funSubmit()
	{
		document.myForm.action="ezToBeActiveUserList.jsp";
		document.myForm.submit();
	}
</script>
</head>
<BODY onLoad="getDefaultsFromTo();scrollInit()"  onResize="scrollInit()">
<form name=myForm>
<input type=hidden name="Area" value=<%=areaFlag%>>
<input type="hidden" name="chkField">
<%
	int sysRows = ret.getRowCount();
	if ( sysRows > 0 )
	{
%>
		<TABLE width="40%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
		    <Th>Purchase Area</Th>
		    <Td>
		  <div id="listBoxDiv1">	
		    <select name="WebSysKey">
		    <%
			int count = ret.getRowCount();	
			if(count>1)
			{
		   %>	
		    	<option value="">All</option>
		    <%  } %>	

		     <%
			StringBuffer all=new StringBuffer("");
			for(int i=0;i<count;i++)
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
				out.println("<option value=\"'" + ret.getFieldValue(i,SYSTEM_KEY) + "'\">" + ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION) + "</option>");
			}
		     %>
		     </select>
		     </div>
		      <script>
			document.myForm.WebSysKey.options[0].value="<%=all.toString()%>"
		    </script>
   		     </Td>
		   <Td class="blankcell"><img src="../../Images/Buttons/<%=ButtonDir%>/gosmall.gif" height="20" style="cursor:hand" onClick="funSubmit()"></Td>
		  </Tr>
		</Table>
		<br>
	<%
	if(WebSysKey!=null)
	{
	%>
		<%@ include file="../../../Includes/JSPs/WebStats/iToBeActiveUsersList.jsp"%>
		<%
		if(retWebStats.getRowCount()==0)
		{
		%>	<BR><BR><BR>
			<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th align=center>There are no users to be activated.</Th>
			</Tr>
			</Table>

		<%
		}
		else
		{
		%>
		<DIV id="theads">
		<TABLE id="tabHead" width="90%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="30%" align=center rowspan=2>User Id</Th>
			<Th width="70%" align=center  rowspan=2>User Name</Th>

		</Tr>
		</table>
				</DIV>
				<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
				<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >


		<%
		for(int i=0;i<retWebStats.getRowCount();i++)
		{


		%>

		<Tr>
			<Td width="30%" align=left><%=retWebStats.getFieldValue(i,"EU_ID")%></Td>
			<Td width="70%" align=left><%=retWebStats.getFieldValue(i,"EU_FIRST_NAME")%></Td>

		</Tr>
		<%
		}
		}
		%>
		</Table>
		</div>
		</div>

		<div id='Div2' align='center' STYLE='overflow:auto;Position:Absolute;Left:6%;width:90%;height:10%;top:90%'>
		<TABLE width="30%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="60%">Total Users</Th>
			<Td width="40%" align=right><%=retWebStats.getRowCount()%></Td>
		</Tr>
		</Table>
		</div>

	<%
	}
	else
	{
	%>
		<br><br><br>
		<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th><b>Please Select Purchase Area and press Go to continue.</b></Th>
		</Tr>
		</Table>
	<%
	}
}
else
{
%>	
			<br><br><br>
			<TABLE width="70%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
			<Th align=center>No Purchase Area's to List</Th>
			</Tr>
			</Table>

<%
}
%>
</form>
</body>
</html>
