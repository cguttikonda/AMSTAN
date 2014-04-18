<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListBusAreas.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<%
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
		if(!("0".equals(retPartners.getFieldValueString(i,"EBPC_CATALOG_NO"))))
			retPartners.deleteRow(i);
	}
	retPartnersCount = retPartners.getRowCount();
	retPartners.sort(new String[]{"ECA_COMPANY_NAME"},true);
%>
<html>
<head>
<Title>Vendor Synchronizion Configuration</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src="../../Library/JavaScript/User/ezUserRoles.js"></script>
<Script src="../../Library/JavaScript/User/ezMassSynch.js"></script>
<Script>
function funFocus()
{
	if(document.myForm.syskey!=null)
		document.myForm.syskey.focus();
}
</Script>
</head>
<body onLoad = funFocus()>
<%
	String syskey=request.getParameter("syskey");
	String prop=request.getParameter("prop");
	String role=request.getParameter("role");
	String catnum="0";
	String from=request.getParameter("from");
	String to=request.getParameter("to");
	String busspartner=request.getParameter("busspartner");

	syskey=(syskey==null || "null".equals(syskey))?"":syskey;
	prop=(prop==null || "null".equals(prop))?"":prop;
	role=(role==null || "null".equals(role))?"":role;
	from=(from==null || "null".equals(from))?"":from;
	to=(to==null || "null".equals(to))?"":to;
	catnum=(catnum==null || "null".equals(catnum))?"":catnum;
	busspartner=(busspartner==null || "null".equals(busspartner))?"":busspartner;
%>
<form name=myForm method=post onSubmit = "return checkAll()"  action="ezInternalMassVendSynch.jsp">
<%
int retCount = ret.getRowCount();
if(retCount==0)
{
%>
	<br><br><br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr align="center">
    	<Th>There are no Purchase Areas to List</Th>
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
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</center>
<%
	return;
}
%>
	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Th>EzCommerce Mass Internal Vendor Synchronization</Th>
		</Tr>
	</Table>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
		<Th align="right" width = "30%">Business Area</Th>
		<Td>
		<Select name = "syskey" id = "FullListBox" Style = "width:100%">
<%
		ret.sort(new String[]{"ESKD_SYS_KEY_DESC"},true);
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
		<Th align="right">Role</Th>
		<td>
		<select name=role id = "FullListBox" Style = "width:100%">
		<script>
			for(var i=0;i<userroles.length;i++)
			{
				var userrole='<%=role%>';
				if(userroles[i].RoleCode==userrole)
				{
					document.write("<option value="+userroles[i].RoleCode+" selected>"+userroles[i].RoleDesc+"  ("+userroles[i].RoleCode+")"+"</option>");
				}
				else
				{
					document.write("<option value="+userroles[i].RoleCode+">"+userroles[i].RoleDesc+"  ("+userroles[i].RoleCode+")"+"</option>");
				}
			}
		</script>
		</select>
		</Td>
	</Tr>
	<Tr>
		<Th align="right">Business Partner</Th>
		<Td>
		<select name="busspartner" id = "FullListBox" Style = "width:100%">
<%
		for ( int i = 0 ; i < retPartnersCount ; i++ )
		{
			if(retPartners.getFieldValueString(i,"EPBC_INTRANET_FLAG").equals("Y"))
			{
	   			if (busspartner.equals(retPartners.getFieldValueString(i,"ECA_NO")))
				{
%>
					<option value=<%=retPartners.getFieldValueString(i,"ECA_NO")%> Selected>
	      					<%=((String)retPartners.getFieldValue(i,"ECA_COMPANY_NAME"))%>
					</option>
<%
				}
				else
				{
%>
					<option value=<%=retPartners.getFieldValueString(i,"ECA_NO")%>>
	      					<%=((String)retPartners.getFieldValue(i,"ECA_COMPANY_NAME"))%>
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
</form>
</html>