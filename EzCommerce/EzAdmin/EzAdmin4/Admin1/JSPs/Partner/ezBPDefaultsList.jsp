<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iBPDefaultsList.jsp"%>
<html>
<head>

<script src="../../Library/JavaScript/Partner/ezBPDefaultsList.js">
</script>

<Title>Business Partner Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body OnLoad="placeFocus()">
<Table  width="50%" border="0" align="center">
  <Tr align="center">
    <Td class="displayheader">Business Partner Defaults
 </Td>
  </Tr>
</Table>
<br>

<form name=myForm method=post action="ezSaveBPDefaultsList.jsp">
<%
String arDesc = (FUNCTION.equals("AG") )?"Customer":"Vendor";
%>
  <Table  width="50%" border="1" align="center">

      <Tr>
        <Td width="48%" class="labelcell">Business Partner:</Td>
        <Td width="52%" class="blankcell"><input type=text class = "InputBox" readonly name="BusPartnerDesc" value="<%=bpdesc%>">
        </Td>
      </Tr>
    <Tr>
      <Td width="43%" class="labelcell"><%=arDesc%>:</Td>
      <Td width="57%" class="blankcell"><input type=text class = "InputBox" readonly name="SoldTo" value="<%=Sold_To%>">
      </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell">Area:</Td>
      <Td width="57%" class="blankcell"><input type=text class = "InputBox" readonly name="SysKey" value="<%=sys_key%>">
      </Td>
    </Tr>
  </Table>
  <div align="center"><br>
  </div>
  <Table  width="60%" align="center">
    <Tr>
      <Th width="100%" colspan="2" > The following <%=arDesc%> defaults are dependent
        on the area.<font color="#FFFF00"> </font>For a list of <%=arDesc%>
        only defaults
			<a class = "subclass" href="ezBPCustOnlyDefaultsList.jsp?BusinessPartner=<%=Bus_Partner%>&SoldTo=<%=Sold_To%>&SysKey=<%=sys_key%>&FUNCTION=<%=FUNCTION%>" >
        <b>Click Here</b> <font color="#FFFF00">

		</a>

        </font></Th>
    </Tr>
    <%
		int defRows = reterpdef.getRowCount();
		String defDescription = null;

		if ( defRows > 0 ) {
	%>
		    <Tr align="left">
		      <Th width="40%" class="labelcell" >List Of Defaults</Th>
		      <Th width="60%" class="labelcell" >Defaults Value</Th>
		    </Tr>

<%
	for ( int i = 0 ; i < defRows; i++ ){
%>
    <Tr align="left">
      <Td valign="top">
<%

	/** Added by Venkat - Because we dont want to show system number **/
        String dKey = reterpdef.getFieldValueString(i,ERP_CUST_DEFAULTS_KEY);
        dKey = dKey.trim();
        if ( dKey.equals("SYSNO") )
        {
%>
		<input type="hidden" name="DefaultsKey_<%=i%>" value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_KEY))%> >
		<input type="hidden" name="DefaultsValue_<%=i%>" value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE))%> >
        	continue;
<%
        }
 %>
      		<input type="hidden" name="ChangeFlag_<%=i%>" value="N" >
<%

		defDescription = (String)(reterpdef.getFieldValue(i,"EUDD_DEFAULTS_DESC"));

		if (defDescription != null)
				{
				out.println(defDescription);
				defDescription=defDescription.trim();
				}
%>

		<input type="hidden" name="DefaultsKey_<%=i%>" value=<%=(String)(reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_KEY))%> >


      <Td valign="top">
<%
		String defValue = (String)reterpdef.getFieldValue(i,ERP_CUST_DEFAULTS_VALUE);
		if (defValue != null){
		      defValue=defValue.trim();
%>
		  	<input type=text class = "InputBox" name="DefaultsValue_<%=i%>" size="15" value=<%=defValue%> >
<%
		}else{

		      defValue="";
%>
		      <input type=text class = "InputBox" name="DefaultsValue_<%=i%>" size="15" value=<%=defValue%> >
<%
		}
%>
		</Td>
		    </Tr>
<%
	}//End for
%>
		<input type="hidden" name="TotalCount" value=<%=defRows%> >
		<input type="hidden" name="BusPartner" value=<%=Bus_Partner%> >

  </Table>
  <p align="center" class="blankcell">

   <input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" >
  </p>

<%
}
else
{
%>
  </Table>
  <p align="center" class="blankcell">
    Currently There are No Defaults set for this Partner
  </p>
<%
}//End If
%>
<input type="hidden" name="FUNCTION" value="<%=FUNCTION%>">
</form>

<%

	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{

%>
	<script language="JavaScript">
		alert('Sales Area specific defaults updated for business partner');
	</script>
<%
	}
%>
</body>
</html>