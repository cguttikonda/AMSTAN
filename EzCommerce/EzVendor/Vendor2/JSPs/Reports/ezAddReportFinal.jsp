<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezparam.*" %>
<%@ include file="../../../Includes/JSPs/Reports/iAddReportFinal.jsp" %>
<Html>
<Head>
	<Script src="../../Library/JavaScript/ezTabScroll.js">			</Script>
     	<Script src="../../Library/JavaScript/ezTrim.js">			</Script>
     	<Script src="../../Library/JavaScript/ezSelSelect.js">			</Script>
     	<Script src="../../Library/JavaScript/EzDMYCalender.js">		</Script>
	<Script src="../../Library/JavaScript/Reports/ezAddReportFinal.js">	</Script>
</Head>
<Body onLoad="scrollInit()" onResize="scrollInit()" scroll="no">
<Form name="addForm" method="post">

<input type="hidden" name="system" 	 value="<%=system%>">
<input type="hidden" name="sysDesc"	 value="<%=sysDesc%>">
<input type="hidden" name="reportDomain" value="<%=reportDomain%>">
<input type="hidden" name="reportType" 	 value="<%=reportType%>">
<input type="hidden" name="reportName"   value="<%=reportName%>">
<input type="hidden" name="reportDesc"   value="<%=reportDesc%>">
<input type="hidden" name="exeType" 	 value="<%=exeType%>">
<input type="hidden" name="visibility" 	 value="<%=visibility%>">
<input type="hidden" name="status" 	 value="<%=status%>">


<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center">
    		<Td  class="displayheader">Add Report</Td>
  	</Tr>
</Table>

<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<Tbody>
<Tr>
   	<Th  align="right">System</Th>
        <Td  align="left"><%=sysDesc%></Td>
        <Th  align="right">Domain</Th>
        <Td  align="left"><%=domainsDescHash.get(reportDomain)%></Td>
	<Th  align="right">Type</Th>
        <Td  align="left"><%=reportsDescHash.get(reportType)%></Td>
</Tr>
<Tr>
	<Th  align="right">Name</Th>
	<Td  align="left"><%=reportName%></Td>
	<Th  align="right">Description</Th>
	<Td  align="left" colspan="3"><%=reportDesc%></Td>
</Tr>
<Tr>
	<Th  align="right">Execution Type</Th>
	<Td  align="left"><%=exeDescHash.get(exeType)%></Td>
	<Th  align="right">Visibility</Th>
	<Td  align="left"><%=visibleDescHash.get(visibility)%></Td>
	<Th  align="right">Status</Th>
	<Td  align="left"><%=statusDescHash.get(status)%></Td>
</Tr>
</Tbody>
</Table>

<Div id="theads">
	<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
	<Tr align="center" valign="middle">
		<Th  width="33%"> Description 	</Th>
		<Th  width="16%"> Retreving Mode</Th>
		<Th  width="9%" > Operator	</Th>
		<Th  width="16%"> From		</Th>
		<Th  width="16%"> To		</Th>
		<Th  width="10%"> Multiple	</Th>
	</Tr>
	</Table>
</Div>

<DIV id="InnerBox1Div">
	<Table id="InnerBox1Tab" align=center  class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="100%">
<%
	for(int i=0;i<returnRowCount;i++)
	{
	
		IS_MANDATORY="X".equals(paramIsmand[i]);
		
		if(IS_MANDATORY)
		{
			mandcolor="class='changeC'";
			mandscript="onblur='chkMand("+i+")'";
		}else
		{
				mandcolor="";
				mandscript="";
		}
%>
		<input type="hidden" name="paramName" value="<%=paramName[i]%>">
		<input type="hidden" name="paramDesc" value="<%=paramDesc[i]%>" >
		<input type="hidden" name="paramIsSel" value="<%=paramIsSel[i]%>">
		<input type="hidden" name="paramIshide" value="<%=paramIshide[i]%>">
		<input type="hidden" name="paramLen" value="<%=paramLen[i]%>">
		<input type="hidden" name="paramType" value="<%=paramType[i]%>">
		<input type="hidden" name="paramDataType" value="<%=paramDataType[i]%>">
		<input type="hidden" name="paramIsmand" value="<%=paramIsmand[i]%>" >
		<input type="hidden" name="paramIsDef" value="<%=paramIsDef[i]%>" >
		<input type="hidden" name="paramMethod" value="<%=paramMethod[i]%>" >
		<input type="hidden" name="paramMulti" value="NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN¤NµNµNµNµNµNµNµNµNµNµN">

		<Tr align="center" valign="middle" <%=mandcolor%>>
			<Td  width="33%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"DESCRIPTION")%>
			</Td>
			<Td  width="16%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"RETREIVE_MODE")%>
			</Td>
			<Td  width="9%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"OPERATOR")%>
			</Td>
			<Td  width="16%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"FROM")%>
			</Td>
			<Td  width="16%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"TO")%>
			</Td>
			<Td  width="10%" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"MULTIPLE")%>	
			</Td>
		</Tr>
<%
	}
%>
	</Table>
</div>
<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
	<Table id="ButtonsTab" align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="40%">
	<Tr>
		<Td align=center class='blankcell'>
			<a href='JavaScript:ezFormSubmit("1")'><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" alt="save" title="save" border="none"></a>
		</Td>	
		<Td align=center class='blankcell'>
			<a href='JavaScript:ezFormSubmit("2")'><img src="../../Images/Buttons/<%= ButtonDir%>/execute.gif" alt="execute" title="execute" border="none"></a>
		</Td>
		<Td align=center class='blankcell'>
			<a href="JavaScript:ezBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="back" title="back" border="none"></a>
		</Td>
	</Tr>
	</Table>
</Div>
</Form>
</body>
</html>
