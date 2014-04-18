<%@ include file="../../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../../Includes/JSPs/Config/Defaults/iAddSystemDefaults.jsp"%>

<html>
<head>
<Script src="../../../Library/JavaScript/CheckFormFields.js"></Script>
<script src="../../../Library/JavaScript/Config/Defaults/ezAddSystemDefaults.js">
</script>
<Script>
function funFocus()
{
	if(document.myForm.SysKey!=null)
	{
		document.myForm.SysKey.focus()
	}
}
</Script>

<Title>Add Defaults</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../../Includes/Lib/AddButtonDir1.jsp"%></head>
<body OnLoad="funFocus()">
<form name=myForm method=post action="ezSaveDefaultsDesc.jsp">
<br>
<%
if(numCatArea > 0){
%>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Td class="displayheader">Add New Master Defaults</Td>
  </Tr>
</Table>


  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
    <Tr>
      <Th width="100%" colspan="2" height="12">
        <div align="center">For adding a new master default enter the following
          information</div>
      </Th>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell" align="right">Business Area :*</Td>
           
      <Td width="57%">
	       	<select name="SysKey" id=ListBoxDiv>
		  	<option value="sel" >--Select Bussiness Area--</option>
<%
		retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for ( int i = 0 ; i < numCatArea; i++ )
		{
		String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
		String areaDesc = (String)retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION);
		String areaKey = retsyskey.getFieldValueString(i,SYSTEM_KEY);
%>
	   <option value=<%=areaKey%> ><%=areaDesc%> (<%=areaKey%>)</option>
<%
		}
%>
        </select>


      </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell" align="right">Default Level:*</Td>
          
      <Td width="57%">
<%
		retdeftype.sort(new String[]{DEFAULT_TYPE_DESC},true);
		int typeRows = retdeftype.getRowCount();
		if ( typeRows > 0 )
		{
%>
      		<select name="DefType" id=ListBoxDiv>
        	<option value="sel">--Select Default Level--</option>
 <%
  		for ( int i = 0 ; i < typeRows ; i++ )
  		{
 %>
	       <option  value=<%=retdeftype.getFieldValue(i,DEFAULT_TYPE)%> >
	        <%=retdeftype.getFieldValue(i,DEFAULT_TYPE_DESC)%>
	        </option>
<%
		}//End for
%>
		</select>
<%
	}
%>
      </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell" align=right>Language:*</Td>
           
      <Td width="57%">
        <%@ include file="../../../../Includes/Lib/ListBox/LBLanguage.jsp"%>
      </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell" align="right">Default:*</Td>
              
      <Td width="57%"> 
        <input type=text class = "InputBox" name=key size="30" maxlength="16" >
        </Td>
    </Tr>
    <Tr>
      <Td width="43%" class="labelcell" align="right">Description:*</Td>
              
      <Td width="57%"> 
        <input type=text class = "InputBox" name=Desc style="width:100%" maxlength="100" >
        </Td>
    </Tr>
  </Table>
  <br>
  <div align="center">
	<input type="image" src="../../../Images/Buttons/<%= ButtonDir%>/add.gif" onClick="CheckValue();return document.returnValue">
	<a href="javascript:void(0)"><img src="../../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
	<a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>


  </div>
  <%
}else{
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  <Tr align="center">
    <Th>There are No Business Areas Currently</Th>
  </Tr>
</Table>
<br>
<center><a href="JavaScript:history.go(-1)"><img src="../../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</center>

    <%
}//end if
%>
</form>
</body>
</html>
