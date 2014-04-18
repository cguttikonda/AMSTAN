<jsp:useBean id="CatalogManager" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>

<%!
	// Start Declarations
	final String CATALOG_DESC_NUMBER 	= "EPC_NO";
	final String CATALOG_DESC_LANG 		= "EPC_LANG";
	final String CATALOG_DESC 		= "EPC_NAME";
	//End Declarations
%>
<%
	String userIdStr = "";

	try
	{
		userIdStr	= (Long.parseLong(soldTo))+"";
	}
	catch(Exception e)
	{
		userIdStr 	= soldTo;
	}

	ReturnObjFromRetrieve retcat = null;
	EzCatalogParams cparams = new EzCatalogParams();
	cparams.setLanguage("EN");
	Session.prepareParams(cparams);
	retcat = (ReturnObjFromRetrieve)CatalogManager.getCatalogList(cparams);

	int catRows = retcat.getRowCount();
	if(catRows==0)
	{
%>
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
		<Th>There are no Catalogs to List</Th>
		</Tr>
		</Table>
		<br>
		<center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>

<div id="theads" >
	<br>
      <Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th>Quick Add Customer</Th>
	</Tr>
	</Table>

        <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<input type = "hidden" name = "soldTo" value="<%=soldTo%>">
		<Th width = "25%" align="right">User ID*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userId" size = 15 maxlength = "10" value="<%=userIdStr%>"></Td>
		<Th width = "25%" align="right">Partner / User Name*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userName" size = 30 maxlength = "60"></Td>
		<input type="hidden" name = "plant" value="1000">
	</Tr>
	<Tr>
		<Th align = "right">E Mail*</Th>
		<Td><input type = "text" class = "InputBox" name = "email" size = 20 maxlength = "128"></Td>	
		<Th align = "right">Catalog*</Td>
		<Td>
			<select name="catnum" id=ListBoxDiv>
				<Option value = "">--Select Catalog--</Option>
<%
				if ( catRows > 0 )
				{
					retcat.sort(new String[]{CATALOG_DESC},true);
					for ( int i = 0 ; i < catRows ; i++ )
					{
%>
						<option value=<%=retcat.getFieldValueString(i,CATALOG_DESC_NUMBER)%>>
							<%=((String)retcat.getFieldValue(i,CATALOG_DESC))%>
						</option>
<%
	   				}
				}
%>

			</select>	
		</Td>	
	</Tr>
	</Table>
	<Table width = "89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >	
	<Tr>
		<Th align="center" width = "30%" colspan = 3>Business Area</Th>
	</Tr>
	</Table>
</Div>
	
<div id="InnerBox1Div">
        <Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
<%	
	String areaFlag = "C";
	String[] sortFields = {"SYSKEY"};
	retSalArea.sort(sortFields,true);

	for(int i=0;i<retRowCount;i++)
	{
	
		if(i!=0 && i%3==0)
		{
%>			</tr><tr>
<%		}
%>
		<Td width = "33%" title = "(<%=retSalArea.getFieldValueString(i,"SYSKEY")%>) <%=retSalArea.getFieldValueString(i,"SYSKEY_DESC")%>">
			<input type = "CheckBox" name = "syskey" id="<%=i%>" value = "<%=retSalArea.getFieldValueString(i,"SYSKEY")%>" checked>			
			<!--input type = "text" value = "(<%=retSalArea.getFieldValueString(i,"SYSKEY")%>) <%=retSalArea.getFieldValueString(i,"SYSKEY_DESC")%>" size = "40" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline"-->
			<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>">
			<input type = "text" value = "(<%=retSalArea.getFieldValueString(i,"SYSKEY")%>) <%=retSalArea.getFieldValueString(i,"SYSKEY_DESC")%>" size = "40" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline">
			</a>
		</Td>
<%	}
	if(retRowCount>3 && retRowCount%3!=0)
	{
		retRowCount = 3 - (retRowCount%3);
		for(int i=0;i<retRowCount;i++)
		{
%>			<Td width = "33%">&nbsp;</Td>
<%		}
	}
%>
	</Tr>
	</Table>
</Div>