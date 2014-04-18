<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<jsp:useBean id="CatalogManager" class="ezc.client.EzCatalogManager" scope="session"></jsp:useBean>
<%!
	final String CATALOG_DESC_NUMBER = "EPC_NO";
	final String CATALOG_DESC_LANG = "EPC_LANG";
	final String CATALOG_DESC = "EPC_NAME";
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
<Title>Vendor Synchronizion Configuration</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/User/ezMassSynch.js"></script>
<Script>
function funFocus()
{
	if(document.myForm.syskey!=null)
		document.myForm.syskey.focus();
}
</Script>
</head>
<body onLoad = "funFocus()">
<%
	String syskey=request.getParameter("syskey");
	String prop=request.getParameter("prop");
	String catnum=request.getParameter("catnum");
	String from=request.getParameter("from");
	String to=request.getParameter("to");

	syskey=(syskey==null || "null".equals(syskey))?"":syskey;
	prop=(prop==null || "null".equals(prop))?"":prop;
	from=(from==null || "null".equals(from))?"":from;
	to=(to==null || "null".equals(to))?"":to;
	catnum=(catnum==null || "null".equals(catnum))?"":catnum;
%>
<form name=myForm method=post  onSubmit = "return checkAll()" action="ezMassServiceCustSynch.jsp">
<%
int retCount = ret.getRowCount();
if(retCount>0)
{
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
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>
<%
		return;
	}
%>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th>EzCommerce Mass Service  Synchronization</Th>
	</Tr>
	</Table>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th align="right" width = "30%">Business Area</Th>
		<Td>
		<Select name = "syskey" id = "FullListBox" style = "width:100%">
<%
		ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for(int i=0;i<retCount;i++)
		{
%>
			<Option value="<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>"><%=ret.getFieldValueString(i,"ESKD_SYS_KEY_DESC")%>  (<%=ret.getFieldValueString(i,"ESKD_SYS_KEY")%>)</Option>
<%
		}
%>
		</Select>
		</Td>
	</Tr>
	<Tr>
		<Th align="right">Catalog</Th>
		<Td>
<%
		int catRows = retcat.getRowCount();
%>
		<select name="catnum" id = "FullListBox" style = "width:100%">
<%
		if ( catRows > 0 )
		{
			retcat.sort(new String[]{CATALOG_DESC},true);
			for ( int i = 0 ; i < catRows ; i++ )
			{
				if (catnum.equals(retcat.getFieldValueString(i,CATALOG_DESC_NUMBER)))
				{
%>
					<option value=<%=retcat.getFieldValueString(i,CATALOG_DESC_NUMBER)%> Selected>
		      				<%=((String)retcat.getFieldValue(i,CATALOG_DESC))%>
					</option>
<%
				}
				else
				{
%>
					<option value=<%=retcat.getFieldValueString(i,CATALOG_DESC_NUMBER)%>>
	      					<%=((String)retcat.getFieldValue(i,CATALOG_DESC))%>
					</option>
<%
				}
		   	}
		}
%>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Th align="right">Property File*</Th>
		<Td><input type=text class = "InputBox"box name=prop value="<%=prop%>"></Td>
	</Tr>
	<Tr>
		<Th align="right">From*</Th>
		<Td><input type=text class = "InputBox"box name=from value="<%=from%>"></Td>
	</Tr>
	<Tr>
		<Th align="right">To*</Th>
		<Td><input type=text class = "InputBox"box name=to value="<%=to%>"></Td>
	</Tr>
	</Table>
	<br>
	<center>
		<input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/synchronize.gif" name="Submit">
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
}
else
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
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
}
%>
</form>
</html>