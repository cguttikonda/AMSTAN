<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp" %>
<%@ include file="../../../Includes/JSPs/WorkFlow/iDeleteDelegationInfo.jsp"%>
<html>
<head>
<Title></Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script src="../../Library/JavaScript/chkEditAndDelete.js"></Script>
<Script src="../../Library/JavaScript/ezSubmitForm.js"></Script>
<Script src="../../Library/JavaScript/ezSortTableData.js"></Script>
</head>
<Body onLoad="scrollInit();ezInitSorting()" onresize="scrollInit()" scroll=no >
<form name="myForm">
<%
	String flag="";
	if(retObj!=null)
	{
	
		if(!retObj.isError())
		{
	
			response.sendRedirect("ezDelegationInfoList.jsp");
		}
		else
		{
	
%>
		<br>
		<br>
	<Table  align=center cellPadding=2 cellSpacing=0 width="100%">
		<Tr>
			<Td align=center class=blankCell><font color=red><b>Unable to Delete Selected Delegation since they have Delegation Conditions</b></font></Td>
		</Tr>
		</Table>
		<br>
					<Div id="theads">
					<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="60%">
					<Tr>
					<Th width=50%>Delegation</Th>
					<Th width=50%>Conditions</Th>
					</Table>
					</div>
					<DIV id="InnerBox1Div">

					<Table id="InnerBox1Tab" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
					for(int i=0;i<retObj.getRowCount();i++)
					{

%>
						<Tr>
							<Td width="50%"><%=retObj.getFieldValue(i,"DELEGATIONID")%></Td>
							<Td width="50%"><%=retObj.getFieldValue(i,"DESCRIPTION")%></Td>
						</Tr>
<%					}
%>
			</Table>
		</Div>
			<Div align=center id="ButtonDiv" style="position:absolute;top:92%;width:100%">
				<a href="ezDelegationInfoList.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
			</Div>
<%
		}
	}
	else
	{
	
		response.sendRedirect("ezDelegationInfoList.jsp");
	}
%>
</form>
</body>
</html>
