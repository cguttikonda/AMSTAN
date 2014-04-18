<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="CatalogManager" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<%!
	// Start Declarations
	final String CATALOG_DESC_NUMBER = "EPC_NO";
	final String CATALOG_DESC_LANG = "EPC_LANG";
	final String CATALOG_DESC = "EPC_NAME";
	//End Declarations
%>
<%
	ReturnObjFromRetrieve retcat = null;
	EzCatalogParams cparams = new EzCatalogParams();
	cparams.setLanguage("EN");
	Session.prepareParams(cparams);
	retcat = (ReturnObjFromRetrieve)CatalogManager.getCatalogList(cparams);

	EzcUserParams auparams= new EzcUserParams();
	Session.prepareParams(auparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	auparams.createContainer();
	auparams.setObject(ezcUserNKParams);
	ReturnObjFromRetrieve allUsersRet = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(auparams);
	//allUsersRet.toEzcString();
%>
<html>
<head>
	<Title>Quick Add Customer</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
	<script src="../../Library/JavaScript/User/ezPreQuickAddCustomer.js"></script>
	<script>
		userArray = new Array();
<%
		int allUserCount = allUsersRet.getRowCount();
		for(int i=0;i<allUserCount;i++)
		{
%>
			userArray[<%=i%>] = '<%=(allUsersRet.getFieldValueString(i,"EU_ID")).trim()%>'
<%
		}
%>
	</Script>
	
	
</head>
<body onLoad='funFocus();scrollInit()' onresize='scrollInit()' scroll = "no">
<form name=myForm method=post onSubmit = "return chkUserExists()" action="ezQuickAddCustomer.jsp">
<%
int retCount = ret.getRowCount();
if(retCount==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are no Sales Areas to List</Th>
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
<%
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
<br>
	<div id="theads">
       	<Table id="tabHead" width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Td class = "displayheader" align = "center">Quick Add Customer</Td>
	</Tr>
	</Table>
        <Table  width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th width = "25%" align="right">Sold To*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "soldTo" size = 15 maxlength = "10" onChange = "funUserId()"></Td>
		<Th width = "25%" align="right">User ID*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userId" size = 15 maxlength = "10"></Td>
	</Tr>
	<Tr>
		<Th width = "25%" align="right">Partner / User Name*</Th>
		<Td width = "25%"><input type = "text" class = "InputBox" name = "userName" size = 15 maxlength = "60"></Td>
	<Th width = "25%" align="right">Catalog*</Th>
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
	<Tr>
		<Th align = "right">Plant*</Th>
		<Td><input type = "text" class = "InputBox" name = "plant" size = 15 maxlength = "128"></Td>	
		<Td colspan = 2>&nbsp;</Td>
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
	for(int i=0;i<retCount;i++)
	{

%>
	<label for="<%=i%>">
<%
	if(i%3==0)
		{
%>
			</tr>
			<tr>
<%			
		}
%>
	<Td width = "33%" title = "(<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>">
		<input type = "CheckBox" name = "syskey" id="<%=i%>" value = "<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>" >
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>">
		<input type = "text" value = "(<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>) <%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>" size = "30" class = "DisplayBox" readonly Style = "Cursor:hand;text-decoration:underline">
		</a>
	</Td>
<%
	}
	if(retCount>3)
	{
		retCount = 3 - (retCount%3);
		for(int i=0;i<retCount;i++)
		{
%>
			<Td width = "33%">&nbsp;</Td>
<%
		}
	}
%>
	</label>
	</Tr>
	</Table>
	</Div>
	<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
	 	<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/continue.gif" name="Submit">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</div>
</form>
</html>
