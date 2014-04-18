<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Reports/iChangeReportFinal.jsp" %>

<html>
<head>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/ezTrim.js"></script>
	<script src="../../Library/JavaScript/ezSelSelect.js"></script>
	<script src="../../Library/JavaScript/EzDMYCalender.js"></script>
	<Script src="../../Library/JavaScript/Reports/ezChangeReportFinal.js">	</Script>	
</head>
<body onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form name="addForm" method="post">


<input type="hidden" name="reportNo" value="<%=reportNo%>">
<input type="hidden" name="system" value="<%=system%>">
<input type="hidden" name="sysDesc" value="<%=sysDesc%>">
<input type="hidden" name="reportDomain" value="<%=reportDomain%>">
<input type="hidden" name="reportType" value="<%=reportType%>">
<input type="hidden" name="reportName" value="<%=reportName%>">
<input type="hidden" name="reportDesc" value="<%=reportDesc%>">
<input type="hidden" name="exeType" value="<%=exeType%>">
<input type="hidden" name="visibility" value="<%=visibility%>">
<input type="hidden" name="status" value="<%=status%>">

<br>
<Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center">
	<Td class="displayheader">Edit Report - Change Default Values</Td>
</Tr>
</Table>

<Table  align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="89%">
<Tbody>
<Tr>
	<Th align="right">Name</Th>
	<Td align="left"><%=reportName%></Td>
	<Th align="right">Description</Th>
	<Td align="left" colspan="5"><%=reportDesc%></Td>
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
<Table id="tabHead" align=center class=tableClass border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<Tr align="center" valign="middle">
	<Th width="30%" >Description</Th>
	<Th width="17%">Retreving Mode</Th>
	<Th width="11%">Operator</Th>
	<Th width="16%" >From</Th>
	<Th width="16%" >To</Th>
	<Th width="10%" >Multiple</Th>
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
		

		paramMod[i]=("µ".equals(paramMod[i]))?"I":paramMod[i];
		paramOpt[i]=("µ".equals(paramOpt[i]))?"EQ":paramOpt[i];
%>
		<input type="hidden" name="paramNo" value="<%=paramNo[i]%>" >
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
			<Td  width="30%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"DESCRIPTION")%>
			</Td>
			<Td  width="17%" align="left" <%=mandcolor%>>
				<%=finalReturnObject.getFieldValueString(i,"RETREIVE_MODE")%>
			</Td>
			<Td  width="11%" align="left" <%=mandcolor%>>
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
</Div>
<Div id="ButtonDiv" align = "center" style="position:absolute;top:90%;width:100%">
	<Table align=center  class=tableClass border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="40%">
	<Tr>
		<Td align=center>
			<a href='JavaScript:ezFormSubmit("1")'><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" alt="save" title="save" border="none"></a>
		</Td>	
		<Td align=center>
			<a href='JavaScript:ezFormSubmit("2")'><img src="../../Images/Buttons/<%= ButtonDir%>/execute.gif" alt="execute" title="execute" border="none"></a>
		</Td>
		<Td align=center>
			<a href="JavaScript:ezBack()"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" alt="back" title="back" border="none"></a>
		</Td>
	</Tr>
	</Table>
</Div>
<%
	for(int i=0;i<returnRowCount;i++)
	{
%>
		<script>
			setListBox(document.addForm.paramMod[<%=i%>],"<%=paramMod[i]%>")
			setListBox(document.addForm.paramOpt[<%=i%>],"<%=paramOpt[i]%>")
		</script>
<%
	}
%>	

</Form>
</Body>
</Html>



































