<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iAddSystemDesc.jsp"%>
<%
//Added By Suresh Parimi to sort System Type Descriptions on 11th Aug 2003
	retsystype.sort(new String[]{"EST_DESC"},true);
//Suresh addition ends here.
%>
<html>
<head>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<Script src="../../Library/JavaScript/Config/ezAddSystemDesc.js"></Script>

<Title>Add System Data</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body OnLoad="document.myForm.SysType.focus()">
<br>

<form name=myForm method=post action="ezSaveSystemDesc.jsp" onSubmit="return chkVal()">

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Add System</Td>
  	</Tr>
	</Table>
<%
	String rKey = request.getParameter("key");
	String rSysType = request.getParameter("systype");
	String rDesc = request.getParameter("desc");
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
      	<Th colspan="2">
        <div align="center"> Please Enter System Information</div>
      	</Th>
    	</Tr>
    	<Tr>
      	<Td width="37%" class="labelcell">
        <div align="right">System Type:*</div>
      	</Td>
      	<Td width="63%">
<%
	//Display System Type ListBox********
	int typeRows = retsystype.getRowCount();
	String typeVal = null;
	if ( typeRows > 0 )
		{
%>
		
		<select name="SysType" id=ListBoxDiv>
		<option value='sel'>--Select System Type--</option>
<%
		for ( int i = 0 ; i < typeRows ; i++ )
			{
			typeVal = (String)(retsystype.getFieldValue(i,SYSTEM_TYPE_DESC));
			String aSysType = retsystype.getFieldValueString(i,SYSTEM_TYPE);
			String aSysDesc = retsystype.getFieldValueString(i,SYSTEM_TYPE_DESC);
			if ( rSysType != null && rSysType.equals(aSysType) )
				{
%>
		        	<option selected value=<%=aSysType%> >
		        	<%=aSysDesc%>
		        	</option>
<%
				}
			if(rSysType == null && typeVal.equals("Sap System"))
				{
%>
				<option selected value=<%=aSysType%>>
				<%=aSysDesc%>
			        </option>
<%	
				}
			else
				{
%>
				<option value=<%=aSysType%>>
		        	<%=aSysDesc%>
		        	</option>
<%
				}//end if
			}//End for
%>
	      	</select>
<%
		} //end if
%>
      	</Td>
    	</Tr>
    	<Tr>
      	<Td width="37%" class="labelcell">
        <div align="right">Language:*</div>
      	</Td>
      	<Td width="63%">
        <%@ include file="../../../Includes/Lib/ListBox/LBLanguage.jsp"%>
      	</Td>
    	</Tr>
	<Tr>
      	<Td width="37%" class="labelcell">
        <div align="right">System ID*:</div>
      	</Td>
      	<Td width="63%">
        <input type=text class = "InputBox" name=key width = "3" maxlength="3"  size="3">
      	</Td>
    	</Tr>
	<Tr>
      	<Td width="37%" class="labelcell">
        <div align="right">Description*:</div>
      	</Td>
      	<Td width="63%">
        <input type=text class = "InputBox" name=Desc maxlength="100" style="width:100%">
      	</Td>
    	</Tr>
</Table>
<br>
<div align="center">
    	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif">  
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>
<%
   	if ( rKey != null )
		{
%>
		<script Language="JavaScript">
		alert('System <%= rKey %> already exists. Try a different one');
		document.forms[0].key.value = '<%=rKey%>';
		document.forms[0].Desc.value = '<%=rDesc%>';
		document.forms[0].key.focus();
		</script>
<%
		}

%>
</form>
</body>
</html>
