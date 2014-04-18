<%@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session"/>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionsList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionStatList.jsp"%>
<%@ include file="../../../Includes/JSPs/WorkFlow/iActionStatDetails.jsp"%>

<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Html>
<Head>
<meta name="author"  content="EzWorkbench">
<Script src="../../Library/JavaScript/checkFormFields.js"></Script>
<script>

function setFieldValues()
{
	for(i=0;i<document.myForm.ResultStatus.length;i++)
	{
  		if(document.myForm.ResultStatus.options[i].value=='<%=detailsRet.getFieldValueString("RESULTSTATUS")%>')
			document.myForm.ResultStatus.options[i].selected=true;
	}

	document.myForm.ResultStatus.focus();
}	
 function checkOption(filename)
 {
	if(document.myForm.ResultStatus.selectedIndex!=0)
	{
		document.myForm.action=filename
		return true
			
	}
	else
	{
		alert("Please Select Result Status")
		return false
	}

}

</script>
</head>
<body onLoad="setFieldValues()">
<form name=myForm method=post onSubmit="return checkOption('ezEditSaveActionStat.jsp')">
<br>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	<Tr>
		<Td class="displayheader" align=center>Edit WorkFlow Action Result Status</Td>
	</Tr>
</Table>
<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0   width=80%>
	
	<Tr>
		<Td align=right class=labelcell width=35%>WF Action</Td>
		<Td width=65%><%=detailsRet.getFieldValueString("ACTDESC")%></Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell >Transaction</Td>
		<Td ><%=detailsRet.getFieldValueString("AUTHDESC")%></Td>
	</Tr>
	
	<Tr>
		<Td align=right class=labelcell >Result Status*</Td>
		<Td >
		<select name=ResultStatus style="width:100%" id=FullListBox>
		<option value="-">--Select Result Status--</option>
		<%
			listRet.sort(new String[]{"DESCRIPTION"},true);
		 	for(int i=0;i<listRet.getRowCount();i++)
		        {
			   	if(listRet.getFieldValueString(i,"STAT_OR_ACTION").equals("S"))
			   	{
		%>
				  	<option value="<%=listRet.getFieldValueString(i,"CODE")%>"><%=listRet.getFieldValueString(i,"DESCRIPTION")%></option>				
				
		<%		}
		        }
		%>
		</select>
		</Td>
	</Tr>
	
	
	
	
</Table>
<br>
<input type="hidden" name="Action" value="<%=detailsRet.getFieldValueString("ACTION")%>"%>
<input type="hidden" name="AuthKey" value="<%=detailsRet.getFieldValueString("AUTH_KEY")%>"%>
<center>
<input type=image src="../../Images/Buttons/<%= ButtonDir%>/save.gif"  alt="Click Here To Save" border=no>
<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset();javascript:setFieldValues()"></a>
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


</center>
</form>
</body>
</html>
