<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iChangeBPInfo.jsp"%>
<%
	String statePrev="";
	String state="";
	String country="";
	if(numBP>0)
	{
	 	statePrev = retinfo.getFieldValueString(0,BP_STATE);
 		state = request.getParameter("State");
		if (state == null)
			state = statePrev;
	 	country = request.getParameter("Country");
		if (country == null)
			country = retinfo.getFieldValueString(0,BP_COUNTRY);
	}
%>
<html>
<head>
<script src="../../Library/JavaScript/Partner/ezChangeBPInfo.js"></script>
<Title>Change Business Partner Information</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<form name=myForm method=post action="ezSaveChangeBP.jsp">
<br>
<%
if(numBP > 0)
{
%>
   <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
  <Tr align="center">
    <Td class="displayheader">Change Partner Information</Td>
  </Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="50%">
    <Tr>
      <Td width="35%" class="labelcell" align = "right">Business Partner:</Td>
      <Td width="65%" class="blankcell">
      <a href = "../Partner/ezBPSummaryBySysKey.jsp?WebSysKey=<%=websyskey%>&Area=<%=Area%>&BusinessPartner=<%=Bus_Partner%>"><%=BPDesc%></a>
	   </Td>
	  </Tr>
 </Table>
   <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  	<Tr>
  		<Td>

        <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
          <Tr>
            <Td width="18%" class="labelcell">Company Name:</Td>
            <Td width="32%">
              <input type=text class = "InputBox" name="Company"  value = "<%=retinfo.getFieldValue(0,BP_COMPANY_NAME)%>" size="30" maxlength="64" >
            </Td>
          </Tr>
          <Tr>
            <Td width="18%" class="labelcell"> Description:</Td>
            <Td width="32%">
              <input type=text class = "InputBox" name="BPDescription" value = "<%=retinfo.getFieldValue(0,BP_DESC)%>" size="30" maxlength="40">
            </Td>
          </Tr>
<%
 	  	if ( catalog_number == null )catalog_number="0";
		if ( catalog_description == null)catalog_description="No Catalogs Selected";
%>
		            <Tr>
		              <Td width="18%" class="labelcell">Catalog:</Td>
		              <Td width="32%" >
<%
				if ( catalog_number.equals("0") )
				{
					catalog_description = "No Catalogs Selected";
%>

					<%=catalog_description%>
<%
				}
				else
				{
%>
					<a href = "../Catalog/ezShowCatalog.jsp?CatNumber=<%=catalog_number%>&catDesc=<%=catalog_description%>"><%=catalog_description%></a>
<%
				}
%>
		                <input type="hidden" name="CatDescription" size=30 value="<%=catalog_description%>">
		                <input type="hidden" name="CatalogNumber" value="<%=catalog_number%>">
		              </Td>
		            </Tr>

              <input type="hidden" name="ContactName" value = "<%=retinfo.getFieldValue(0,BP_NAME)%>" size="30" maxlength="64">
              <input type="hidden" name="Email"  value = "email@email.com" size="30" maxlength="64">
              <input type="hidden" name="WebAddress" value = "1-1-39 " size="30" maxlength="250">
              <input type="hidden" name="Address1" value = "7hills" size="30" maxlength="64">
              <input type="hidden" name="*Address2" value = "secunderabad" size="30" maxlength="64">
              <input type="hidden" name="City" value = "Hyderabad" size="30" maxlength="64">
              <input type="hidden" name="Country" value="IND"  >
              <input type="hidden" name="Zip" value = "111111" size="5" maxlength="10" >

              <input type="hidden" name="State" value="Andra Pradesh"  >
              <input type="hidden" name="Phone1" value="091040666" size="14" maxlength="14">
              <input type="hidden" name="*Phone2" value="091040666" size="14" maxlength="14">
              <input type="hidden" name="Fax" value="091040666" size="14" maxlength="14">
      </Table>
      </Td>
      <Td valign = top>
      	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0  width = "100%">
      	<Tr>
            <Td colspan="2" class="labelcell">
<%
				String UnlimitedFlag = null;
				UnlimitedFlag = (String)(retconfig.getFieldValue(0,BP_UNLIMITED_USERS));
				if (UnlimitedFlag != null){
				if (UnlimitedFlag.equals("Y")){
%>
					<input type="radio" name="UnlimitedUsers" value="Unlimited" checked onClick="disNumUsers()" >
<%
				}else{
%>
					<input type="radio" name="UnlimitedUsers" value="Unlimited" unchecked onClick="disNumUsers()" >
<%
				}
				}
%> Unlimited Users </Td>
          </Tr>
          <Tr>
            <Td colspan="2" class="labelcell">
<%
            String readOnlyFlag = "";
			UnlimitedFlag = (String)(retconfig.getFieldValue(0,BP_UNLIMITED_USERS));
			if (UnlimitedFlag.equals("Y")){
%>
			<input type="radio" name="UnlimitedUsers" value="Limited" unchecked onClick="disNumUsers()" >
<%

		}else{
%>
			<input type="radio" name="UnlimitedUsers" value="Limited" checked onClick="disNumUsers()">
<%
}
%> Number Of Users
<%
	String numofUsers = retconfig.getFieldValueString(0,BP_NUMBER_OF_USERS);
	//if (numofUsers.equals("0")) numofUsers = "";
%>
              <input type=text class = "InputBox" <%=readOnlyFlag%> name="NumUsers" value = "<%=numofUsers%>" size="15" maxlength="10">
            </Td>
          </Tr>
<%
String busIntPartner = (String)(retconfig.getFieldValue(0,BP_INTRANET_USER));
if ( busIntPartner != null && busIntPartner.equals("Y") )
{
    busIntPartner = "checked disabled";
}
else
{
    busIntPartner = "disabled";
}
%>
          <Tr>
            <Td colspan="2" class="labelcell">
              <input type="checkbox" name="busIntUser" value="Y" <%= busIntPartner %>>
              Intranet Business Partner</Td>
          </Tr>
          </Table>
<%
		int sysRows = retcatsys.getRowCount();
%>
		<input type="hidden" name="TotalCount" value=<%=sysRows%> >
        </Td>
        </Tr>
        </Table>
        	<br>
                 <center>
                 <input  type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update" onClick="checkAll();return document.returnValue;">
                 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

                 </center>
        <br>

<input type="hidden" name="BusPartner" value=<%=Bus_Partner%> >
<input type="hidden" name="Area" value=<%=Area%> >
<input type="hidden" name="WebSysKey" value=<%=websyskey%> >

</form>
<script language = "javascript">
	document.myForm.Company.focus();
	if ( document.myForm.UnlimitedUsers[0].checked )
	{
		document.myForm.NumUsers.disabled = true;
	}
	else
	{
		document.myForm.NumUsers.disabled = false;
	}
</script>
<%
}else{
%> <br>
<br>
<Table  width=60% align="center">
  <Tr align="center">
    <Td height="14" >There
      are no Business Partners in the System.</Td>
</Tr>
</Table>
<%
}//end if number of BPs > 0
%>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Partner Information updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>
