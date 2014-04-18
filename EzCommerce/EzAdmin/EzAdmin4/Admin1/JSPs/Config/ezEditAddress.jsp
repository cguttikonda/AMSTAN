<%@ include file="../../../Includes/Lib/Countries.jsp" %>

<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iAddSystemDesc.jsp"%>
<%@ include file="../../../Includes/JSPs/Config/iListAddress.jsp"%>

<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/AdminVal.js"></script>
	<script  src="../../Library/JavaScript/Config/ezAddAddress.js"></script>
<script>
function funSelect()
{
<%
	String type = ret.getFieldValueString(0,"TYPE");
%>
	if('<%=type%>'=="C")
		document.myForm.type.selectedIndex=1;
	else 	if('<%=type%>'=="I")
		document.myForm.type.selectedIndex=2;
	else 	
		document.myForm.type.selectedIndex=3;
}
</script>
</head>
<body onLoad="document.myForm.Lang.focus();funSelect()">
<form name=myForm method=post action="ezEditSaveAddress.jsp" onSubmit="return chk()">
<center>
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  		<Tr align="center">
    			<Td class="displayheader">Edit User Address for "<%=ret.getFieldValue(0,"NUM")%>"</Td>
    			<input type="hidden" name="addrNumber" value="<%=ret.getFieldValue(0,"NUM")%>">
  		</Tr>
	</Table>

    <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
      <Tr>
        <Td class="labelcell" width="17%">
          <div align="right"> Language:</div>
        </Td>
        <Td width="23%"><%@ include file="../../../Includes/Lib/ListBox/LBLanguage.jsp"%></Td>
	<Td class="labelcell" width="17%">
          <div align="right">Company Name :</div>
        </Td>
         <Td width="23%">
	          <input type=textbox class = "InputBox" style = "width:100%" name="companyName" value="<%=ret.getFieldValue(0,"COMPANYNAME")%>" maxlength="40">
        </Td>
        </Tr>
     	<Tr>
		<Td class="labelcell" width="17%">
		  <div align="right"> URL:</div>
		</Td>
		<Td width="23%">
		  <input type=textbox class = "InputBox" style = "width:100%" name="url" value="<%=ret.getFieldValue(0,"URL")%>" maxlength="40">
		</Td>
		<Td class="labelcell" width="17%">
		  <div align="right">Email :</div>
		</Td>
		 <Td width="23%">
			  <input type=textbox class = "InputBox" style = "width:100%" name="email" value="<%=ret.getFieldValue(0,"EMAIL")%>" maxlength="40">
		</Td>
	</Tr>
		<Tr>
			<Td class="labelcell" width="17%">
			  <div align="right"> Address 1:</div>
			</Td>
			<Td width="23%">
			  <input type=textbox class = "InputBox" style = "width:100%" name="address1" value="<%=ret.getFieldValue(0,"ADDRESS1")%>" maxlength="40">
			</Td>
			<Td class="labelcell" width="17%">
			  <div align="right">Address 2 :</div>
			</Td>
			 <Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="address2" value="<%=ret.getFieldValue(0,"ADDRESS2")%>" maxlength="40">
			</Td>
		</Tr>
		<Tr>
			<Td class="labelcell" width="17%">
			  <div align="right"> City:</div>
			</Td>
			<Td width="23%">
			  <input type=textbox class = "InputBox" style = "width:100%" name="city" value="<%=ret.getFieldValue(0,"CITY")%>" maxlength="40">
			</Td>
			<Td class="labelcell" width="17%">
			  <div align="right">District :</div>
			</Td>
			 <Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="district" value="<%=ret.getFieldValue(0,"DISTRICT")%>" maxlength="40">
			</Td>
		</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> State:</div>
				</Td>
				<Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="state" value="<%=ret.getFieldValue(0,"STATE")%>" maxlength="40">
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Country :</div>
				</Td>
				 <Td width="23%">
				 <select class = "control" name="country"  id = "FullListBox"  style = "width:100%">

					<%
						String country=ret.getFieldValueString(0,"COUNTRY");
						  for(int i=0;i<countryList.length;i++)
						  {
						    if(country.equals(countryList[i][1])){
						     %>
							<option  value="<%=countryList[i][1]%>" selected><%=countryList[i][0]%></option>
					<%
						   }else{
					%>
							<option  value="<%=countryList[i][1]%>" ><%=countryList[i][0]%></option>
					<%	    }
						  }    
					%>
					      </select>
			</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> Zipcode:</div>
				</Td>
				<Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="zipcode" value="<%=ret.getFieldValue(0,"ZIPCODE")%>" maxlength="10">
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Phone 1 :</div>
				</Td>
				 <Td width="23%">
					  <input type=textbox class = "InputBox" style = "width:100%" name="phone1" value="<%=ret.getFieldValue(0,"PHONE1")%>" maxlength="20">
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right"> Phone 2:</div>
				</Td>
				<Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="phone2" value="<%=ret.getFieldValue(0,"PHONE2")%>" maxlength="20">
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Mobile :</div>
				</Td>
				 <Td width="23%">
					  <input type=textbox class = "InputBox" style = "width:100%" name="mobile" value="<%=ret.getFieldValue(0,"MOBILE")%>" maxlength="20">
				</Td>
			</Tr>
			<Tr>
				<Td class="labelcell" width="17%">
				  <div align="right">Bus Domain:</div>
				</Td>
				<Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="busDomain" value="<%=ret.getFieldValue(0,"BUSDOMAIN")%>" maxlength="20">
				</Td>
				<Td class="labelcell" width="17%">
				  <div align="right">Fax :</div>
				</Td>
				<Td width="23%">
				  <input type=textbox class = "InputBox" style = "width:100%" name="fax" value="<%=ret.getFieldValue(0,"FAX")%>" maxlength="20">
				</Td>
			</Tr>
			<Tr>
				
				
				<Td class="labelcell" width="17%">
				  <div align="right">Type :</div>
				</Td>
				 <Td width="23%" colspan = 3>
					    <select name=type id = "FullListBox"  style = "width:100%">
						<option value="">---Select Type---</option>
					      <option value="C">Customer Address</option>
					      <option value="I">Internal Address </option>
					      <option value="S">Stockist Addresses</option>
					    </select>
				</Td>

				
			</Tr>
			
       		
    </Table>
	<br>
	<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif" value="CONTINUE" >
	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
        <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</center>
</form>
</body>
</html>
