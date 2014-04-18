<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<jsp:useBean id="CatalogManager" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%
	EzcUserParams auparams= new EzcUserParams();
	Session.prepareParams(auparams);
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	auparams.createContainer();
	auparams.setObject(ezcUserNKParams);
	ReturnObjFromRetrieve allUsersRet = (ReturnObjFromRetrieve)UserManager.getAllBussUsers(auparams);

	ReturnObjFromRetrieve retPartners = null;
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);
	retPartners =(ReturnObjFromRetrieve) BPManager.getBussPartners(bparams);

	int retPartnersCount = retPartners.getRowCount();
	if ( retPartnersCount > 0 )
	{
		for ( int i = retPartnersCount-1 ; i >=0  ; i-- )
		{
			if(retPartners.getFieldValueString(i,"EPBC_INTRANET_FLAG").equals("N"))
			{
				retPartners.deleteRow(i);
			}
		}
	}
	retPartnersCount = retPartners.getRowCount();
	for(int i=retPartnersCount-1;i>=0;i--)
	{
		if("0".equals(retPartners.getFieldValueString(i,"EBPC_CATALOG_NO")))
			retPartners.deleteRow(i);
	}
	retPartnersCount = retPartners.getRowCount();
	retPartners.sort(new String[]{"ECA_COMPANY_NAME"},true);
%>

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
%>
<html>
<head>
	<Title>Quick Add Service Internal User</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script src="../../Library/JavaScript/User/ezUserRoles.js"></script>
	<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/CheckFormFields.js"></script>
	<script src="../../Library/JavaScript/User/ezPreQuickAddInternalSalesUser.js"></script>
	<Script>
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
<form name=myForm method=post  onSubmit = "return chkUserExists()" action="ezQuickAddInternalServiceUser.jsp">
<%
int retCount = ret.getRowCount();
if(retCount==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are no Service Areas to List</Th>
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
if(retPartnersCount==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
	    	<Th>There are no Internal Partners to List</Th>
  	</Tr>
	</Table>
	<br>
	<center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}
	if(retcat.getRowCount()==0)
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
		<Td class = "displayheader" align = "center" colspan = 4>Quick Add Service Internal User</Td>
	</Tr>
	<Tr>
		<Th width = "15%" align = "right">User ID*</Th>
		<Td width = "35%"><input type = "text" class = "InputBox" name = "userId" size = 15 maxlength = "10"></Td>
		<Th width = "20%" align = "right">User Name*</Th>
		<Td width = "30%"><input type = "text" class = "InputBox" name = "userName" size = 15 maxlength = "60"></Td>
	</Tr>
	<Tr>
		<Th width = "15%" align = "right">Role*</Th>
		<td width = "35%" colspan =3>
		<select name=role id = "FullListBox" style = "width:100%">
		<Option value = "">--Select Role--</Option>
		<script>
		for(var i=0;i<userroles.length;i++)
		{
				document.write("<option value="+userroles[i].RoleCode+">"+userroles[i].RoleDesc+"  ("+userroles[i].RoleCode+")"+"</option>");
		}
		</script>
		</select>
		</Td>
	<Tr>
	</Tr>
		<Th  width = "20%" align = "right">Business Partner*</Th>
		<Td width = "30%">
		<select name="busspartner" id="FullListBox" style = "width:100%">
		<Option value = "">--Select Business Partner--</Option>
<%
		for ( int i = 0 ; i < retPartnersCount ; i++ )
		{
%>
				<option value=<%=retPartners.getFieldValueString(i,"ECA_NO")%>>
      					<%=((String)retPartners.getFieldValue(i,"ECA_COMPANY_NAME"))%>
				</option>
<%
	   	}
%>
		</select>
		</Td>
		<Th align="right">Catalog</Th>
		<Td>
<%
		int catRows = retcat.getRowCount();
%>
		<select name="catnum" id="FullListBox">
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
       	<Table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
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

		<label for="cb_<%=i%>">
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
		<a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>">
		<input type = "CheckBox" name = "syskey" id="cb_<%=i%>" value = "<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>" >
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
