<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPDefaultsListBySysKey.jsp"%>
<%
	String areaFlag = (String)session.getValue("myAreaFlag");
%>
<html>
<head>
<script src="../../Library/JavaScript/Partner/ezBPDefaultsListBySysKey.js"></script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>
<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body onLoad="placeFocus();scrollInit()"  onresize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSaveBPDefaultsListBySysKey.jsp">

	<br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr align="center">
		<Td class="displayheader"><%=bpdesc%> Partner Defaults</Td>
	</Tr>
	</Table>
<%
	String arDesc = (FUNCTION.equals("AG") )?"Customer":"Vendor";
	String area = (FUNCTION.equals("AG") )?"Sales Area":"Purchase Area";
	String ERPCustDesc=request.getParameter("A"+Sold_To);
	String SADesc = request.getParameter("SADesc");
%>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Td width="40%" class="labelcell" align=right><%=area%>:</Td>
		<Td width="60%"><a href= "../Config/ezSetBusAreaDefaults.jsp?Area=<%=areaFlag%>&SystemKey=<%=sys_key%>"><%=SADesc%></a>
		<input type="hidden"  name="SysKey" value="<%=sys_key%>">
		<input type="hidden"  name="SoldTo" value="<%=Sold_To%>">
		<input type="hidden" name="SADesc" value="<%=SADesc%>">
		</Td>
	</Tr>
	</Table>

	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="89%">
	<Tr>
		<Th width="100%" colspan="2" > The following <%=arDesc%> defaults are dependent
		on the area.<font color="#FFFF00"> </font> for <%=arDesc%>
		only defaults
		<a class = "subclass" href="ezBPCustOnlyDefaultsListBySysKey.jsp?BusinessPartner=<%=Bus_Partner%>&SoldTo=<%=Sold_To%>&SysKey=<%=sys_key%>&FUNCTION=<%=FUNCTION%>&SADesc=<%=SADesc%>&ERPCustDesc=<%=ERPCustDesc%>" >
		<b>Click Here</b> <font color="#FFFF00">
		</a>
		</font></Th>
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
			<Th width="40%" class="labelcell" >Defaults</Th>
			<Th width="60%" class="labelcell" >Value</Th>
		</Tr>
		</Table>
		</div>

		<DIV id="InnerBox1Div" >
		<Table align="center" id="InnerBox1Tab" border=1 bordercolordark=#ffffff bordercolorlight=#000000 cellspacing=0 cellpadding=2 >

<%
		for ( int i = 0 ; i < defRows; i++ )
		{
			String dKey = reterpdef.getFieldValueString(i,ERP_CUST_DEFAULTS_KEY);
			dKey = dKey.trim();
			if(!dKey.equals("SYSNO"))
			{
%>
				<Tr align="left">
				<Td valign="top" width="40%">
<%
			}

			if ( dKey.equals("SYSNO") )
			{
 %>
				<input type="hidden" name="DefaultsKey"  value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_KEY))%> >
				<input type="hidden" name="DefaultsValue" value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE))%> >
<%
				continue;
			}
%>
			<input type="hidden" name="ChangeFlag"  value="N" >

<%
			defDescription = (String)(reterpdef.getFieldValue(i,"EUDD_DEFAULTS_DESC"));

			if (defDescription != null)
			{
%>
				<%=defDescription%>
<%
				defDescription=defDescription.trim();
			}
%>

			<input type="hidden" name="DefaultsKey" value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_KEY))%> >
			</td>
			<Td valign="top" width="60%">
<%
			String defValue = (String)reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE);
			if (defValue != null)
				defValue=defValue.trim();
			else
				defValue="";

			if(!"".equals(defValue))
			{
%>
				<input type=hidden name="OldVals" value="O<%=i%>">
<%
			}
%>
			<input type=text class = "InputBox" name="DefaultsValue" size="15" value=<%=defValue%> >
			</Td>
			</Tr>

<%
		}//End for
%>
		<input type="hidden" name="BusinessPartner" value=<%=Bus_Partner%> >
		</Table>
		</div>

		<div id="ButtonDiv"  align="center" style="position:absolute;top:90%;width:100%">
   		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
   		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</div>
<%
	}
	else
	{
%>

	<br><br>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
	<Tr>
		<Td class = "labelcell">
			<div align="center"><b>  Currently There are No Defaults set for this Partner.</b></div>
		</Td>
	</Tr>
	</Table>

	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

<%
	}//End If
%>
	<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
<%

	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{

%>
	<script language="JavaScript">
		alert(' Area specific defaults updated for business partner');

	</script>
<%
	}
%>

</form>
</body>
</html>
