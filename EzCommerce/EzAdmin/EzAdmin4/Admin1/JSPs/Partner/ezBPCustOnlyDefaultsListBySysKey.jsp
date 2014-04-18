<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustOnlyDefaultsList.jsp"%>

<html>
<head>
<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/Partner/ezBPCustOnlyDefaultsListBySysKey.js">
</script>

<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
</head>

<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll="no"><br>
<%
String arDesc = (FUNCTION.equals("AG") )?"Customer":"Vendor";
String area = (FUNCTION.equals("AG") )?"Sales Area":"Purchase Area";
String SADesc = request.getParameter("SADesc");
String ERPCustDesc = request.getParameter("ERPCustDesc");

%>
<form name=myForm method=post action="ezSaveBPCustOnlyDefaultsListBySysKey.jsp">

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
		<Td class="displayheader"> <%=bpdesc%> <%=arDesc%> Only Defaults</Td>
	</Tr>
	</Table>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Td width="40%" class="labelcell" align=right><%=area%>:</Td>
		<Td width="60%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=C&SystemKey=<%=sys_key%>"><%=sys_key%></a>

		<input type="hidden"  name="SysKey" value="<%=sys_key%>">
		<input type="hidden"  name="SoldTo" value="<%=Sold_To%>">
		<input type="hidden"  name="bpdesc"  value="<%=bpdesc%>">
		<input type="hidden" name="BusPartner" value="<%=Bus_Partner%>">
		</Td>
	</Tr>
	</Table>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Th width="100%" colspan="2" >The following defaults are specific to the
			<%=arDesc%>.For  <%=arDesc%> Defaults for a Area
			<a href="ezBPDefaultsListBySysKey.jsp?BusinessPartner=<%=Bus_Partner%>&SoldTo=<%=Sold_To%>&area=<%=sys_key%>&FUNCTION=<%=FUNCTION%>&SADesc=<%=SADesc%>&A<%=Sold_To%>=<%=ERPCustDesc%>" >
 			Click Here
			</a>
			</Th>
	</Tr>
	</Table>

<%
	int defRows = reterpdef.getRowCount();
	String defDescription = null;

	if ( defRows > 0 )
	{
%>
		<div id="theads">
		<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
		<Tr align="left">
			<Th width="40%" class="labelcell" ><%=arDesc%> Defaults</Th>
			<Th width="60%" class="labelcell" >Defaults Value</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div" >
		<Table id="InnerBox1Tab" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0">
<%
		for ( int i = 0 ; i < defRows; i++ )
		{
%>
			<Tr align="left">
			<Td valign="top" width="40%">
<%
			defDescription = reterpdef.getFieldValueString(i,"EUDD_DEFAULTS_DESC");
			if (defDescription != null)
			{
%>
				<%=defDescription%>
<%
			}
%>
			<input type="hidden" name="DefaultsKey_<%=i%>" value=<%=(reterpdef.getFieldValueString(i,ERP_CUST_DEFAULTS_KEY))%> >

			</Td>
			<Td valign="top" width="60%">
<%
			String defValue = (String)reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE);
			if (defValue != null)
			{
%>
				<input type=text class = "InputBox" name="DefaultsValue_<%=i%>" size="15" value=<%=defValue%> >
<%
			}else{
%>
				<input type=text class = "InputBox" name="DefaultsValue_<%=i%>" size="15" value="">
<%
			}
%>
			</Td>
			</Tr>
<%
		}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=defRows%> >

		</Table>
		</div>

		<div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>
<%
	}
	else
	{
%>
		</Table>
		<div align="center">
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr>
			<Td class = "labelcell">
			<div align="center"><b>Currently There are No <%=arDesc%> Dependent Defaults.</b></div>
			</Td>
		</Tr>
		</Table>
		<br>
		<img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" onClick="history.go(-1)" style="cursor:hand">
		</div>
<%
	}//End If
%>
	<input type="hidden" name="SysKey" value="<%=sys_key%>">
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>" >

	</form>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
	<script language="JavaScript">
		alert('Customer Specific defaults updated for the business partner');
	</script>
<%
	}
%>
</body>
</html>
