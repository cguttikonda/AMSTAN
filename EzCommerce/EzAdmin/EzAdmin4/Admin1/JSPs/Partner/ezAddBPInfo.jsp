
<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Partner/iAddBPInfo.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>

<%
String statePrev = "";
String country = request.getParameter("Country");
if (country == null) country = "IND";
String state = request.getParameter("State");
if (state == null) state = "";
String company = request.getParameter("Company");
if (company == null) company="";
String BPDescription = request.getParameter("BPDescription");
if (BPDescription == null) BPDescription="";
String ContactName = request.getParameter("ContactName");
if (ContactName == null) ContactName="";
String Email = request.getParameter("Email");
if (Email == null) Email="";
String WebAddress = request.getParameter("WebAddress");
if (WebAddress == null) WebAddress="";
String Address1 = request.getParameter("Address1");
if (Address1 == null) Address1="Hyderabad";
String Address2 = request.getParameter("*Address2");
if (Address2 == null) Address2="";
String City = request.getParameter("City");
if (City == null) City="Hyderabad";
String Zip = request.getParameter("Zip");
if (Zip == null) Zip="";
String Phone11 = request.getParameter("Phone11");
if (Phone11 == null) Phone11="091";
String Phone12 = request.getParameter("Phone12");
if (Phone12 == null) Phone12="040";
String Phone13 = request.getParameter("Phone13");
if (Phone13 == null) Phone13="";
String Phone21 = request.getParameter("*Phone21");
if (Phone21 == null) Phone21="";
String Phone22 = request.getParameter("*Phone22");
if (Phone22 == null) Phone22="";
String Phone23 = request.getParameter("*Phone23");
if (Phone23 == null) Phone23="";
String Fax1 = request.getParameter("Fax1");
if (Fax1 == null) Fax1="091";
String Fax2 = request.getParameter("Fax2");
if (Fax2 == null) Fax2="040";
String Fax3 = request.getParameter("Fax3");
if (Fax3 == null) Fax3="";
String UnlimitedUsers = request.getParameter("UnlimitedUsers");
String unlchk="";
String lchk="";
if (UnlimitedUsers == null) UnlimitedUsers="Unlimited";
if (UnlimitedUsers.equalsIgnoreCase("Unlimited")) {
	unlchk=" checked";
	lchk = "";
} else {
	lchk=" checked";
	unlchk = "";
}
String NumUsers = request.getParameter("NumUsers");
if (NumUsers == null) NumUsers="";
String busintuser = request.getParameter("busintuser");
String biuser = "";
if (busintuser == null) biuser=" unchecked";
else biuser=" checked";
String CatalogNumber = request.getParameter("CatalogNumber");
if (CatalogNumber == null) CatalogNumber="";
String sel="";
%>

<html>
<head>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>
<script src="../../Library/JavaScript/Partner/ezAddBPInfo.js">
</script>

<Title>Get Business Partner Information</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body onLoad="document.myForm.Company.focus()">
<form name=myForm method=post action="ezAddBPSystems.jsp">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Add Business Partner</Td>
  </Tr>
</Table>

  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%" height="135">
    <Tr>

      <Th colspan="2"> Please enter the following information for the business
        partner:</Th>
          </Tr>
          <Tr class="blankcell">

      <Td valign="top" align="left" width="60%" >
        
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
                <Tr>

            <Td width="55%" height="16" class="labelcell" align="right">Company Name<font size="2">*</font>:</Td>

            <Td width="45%" height="16" >
              <input type=text class = "InputBox" name="Company"  size="30" maxlength="64" value="<%=company%>" onchange="ezCopyCName()">
                  </Td>
                </Tr>
                <Tr>

            <Td width="55%" height="35" class="labelcell" align="right"> Description <font size="2">*</font>:</Td>

            <Td height="35" width="45%"  >
              <input type=text class = "InputBox" name="BPDescription" size="30" maxlength="40" value="<%=BPDescription%>">
                  </Td>
                </Tr>
                <Tr>

            <Td width="55%" height="35" class="labelcell" align="right">Catalog:</Td>

            <Td height="35" width="45%">

<%
				int catRows = retcat.getRowCount();
%>
			      <select name="CatalogNumber" id=ListBoxDiv>
			      <option value="0">No Catalogs Selected</option>
<%
			      if ( catRows > 0 )
			      {
			      	   retcat.sort(new String[]{CATALOG_DESC},true);
				   String option;
				   for ( int i = 0 ; i < catRows ; i++ )
				   {
					  option = retcat.getFieldValueString(i,CATALOG_DESC_NUMBER);
	   				  if (option.equals(CatalogNumber)) sel= " Selected" ;else sel="";
%>
					  <option value=<%=option+sel%> >
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
            </Td>

      <Td valign="top" width="40%" align="center" >
        	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
                <Tr>
                  <Td width="100%" colspan="2" class="labelcell">
                    <input type="radio" name="UnlimitedUsers" value="Unlimited" <%=unlchk%> onClick="funReadOnly()">
                    Unlimited Users</Td>
                </Tr>
                <Tr>
                  <Td width="100%" colspan="2" class="labelcell">
                    <input type="radio" name="UnlimitedUsers" value="Limited" <%=lchk%> onClick="funReadOnly()">
                    Number Of Users
                              <input type=text class = "InputBox" name="NumUsers" size="12" maxlength="10" onFocus = "setFocus();return document.returnValue"
							 onBlur = "VerifyNumUsers();return document.returnValue" value="<%=NumUsers%>" readOnly>
                  </Td>
                </Tr>

			<Tr>
		<label for="cb_<%=0%>">	
			
                  <Td width="100%" colspan="2" class="labelcell">
                    <input type="checkbox" id="cb_<%=0%>" name="busintuser" <%=biuser%>>
                    Intranet Business Partner</Td>
                </label>
                </Tr>

              </Table>
			<input type="hidden" name="ContactName"  value="EzCommerce">
			<input type="hidden" name="Email"   value="email@email.com">
						<input type="hidden" name="WebAddress" value="1-1-39 ">
			<input type="hidden" name="Address1" value="7hills ">
			<input type="hidden" name="Address2" value="secunderabad ">
			<input type="hidden" name="City" value="Hyderabad">
			<input type="hidden" name="Country" value="Ind" >
			<input type="hidden" name="State" value="AP">
			<input type="hidden" name="Zip" value="111111">
			<input type="hidden" name="Phone11" value="091">
			<input type="hidden" name="Phone12" value="040">
			<input type="hidden" name="Phone13" value="666">
			<input type="hidden" name="Phone21" value="091">
			<input type="hidden" name="Phone22" value="040">
			<input type="hidden" name="Phone23" value="666">
			<input type="hidden" name="Fax1" value="091">
			<input type="hidden" name="Fax2" value="040">
			<input type="hidden" name="Fax3" value="666">

			    </Td>
			  </Tr>
	</Table>
<br>
<center>
<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/continue.gif"  name="Submit" value="Continue..." onClick = "checkAll();return document.returnValue">
<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
</center>
<script language = "javascript">
	document.myForm.Company.focus();
</script>
      </form>
</body>
</html>
