<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPCustOnlyDefaultsList.jsp"%>

<html>
<head>
<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7" scroll="auto">
<script src="../../Library/JavaScript/Partner/ezBPCustOnlyDefaultsList.js">
</script>


<%
String arDesc = (FUNCTION.equals("AG") )?"Customer":"Vendor";
%>

<Table  width="50%" border="0" align="center">
  <Tr align="center">
    <Td class="displayheader"><%=arDesc%> Only Defaults</Td>
  </Tr>
</Table>
<br>

<form name=myForm method=post action="ezSaveBPCustOnlyDefaultsList.jsp">
  <Table  width="50%" border="1" align="center">
    <Tr>
      <Td width="43%" class="labelcell">Business Partner:</Td>
      <Td width="57%" class="blankcell">
      <input type=text class = "InputBox" readonly name="bpdesc" size="40" value="<%=bpdesc%>">
      <input type="hidden" name="BusPartner" value="<%=Bus_Partner%>">
      </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell"><%=arDesc%>:</Td>
      <Td width="57%" class="blankcell"> <input type=text class = "InputBox" readonly name="SoldTo" value="<%=Sold_To%>">
      </Td>
    </Tr>
  </Table>
  <br>
  <Table  width="60%" align="center">
    <Tr>
      <Th width="100%" colspan="2" >The following defaults are specific to the
        <%=arDesc%>.For a list of <%=arDesc%> Defaults for a Area
		<a href="ezBPDefaultsList.jsp?BusPartner=<%=Bus_Partner%>&SoldTo=<%=Sold_To%>&area=<%=sys_key%>&FUNCTION=<%=FUNCTION%>" >
		 Click Here <font color="#FFFF00">

		</a>

	</font></Th>
    </Tr>
    <%
int defRows = reterpdef.getRowCount();
String defDescription = null;

if ( defRows > 0 ) {
%>
    <Tr align="left">
      <Th width="40%" class="labelcell" ><%=arDesc%> Defaults</Th>
      <Th width="60%" class="labelcell" >Defaults Value</Th>
    </Tr>
<%
	for ( int i = 0 ; i < defRows; i++ ){
        %>
    <Tr align="left">
      <Td valign="top">
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
      <Td valign="top">
<%
		String defValue = (String)reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE);
		if (defValue != null){
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
  <div align="center"><br>

  		<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
  </div>
<%
}
else
{
%>
  </Table>
  <div align="center"><br>
	Currently There are No <%=arDesc%> Dependent Defaults
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