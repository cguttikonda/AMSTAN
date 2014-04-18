<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<%@ include file="../../../Includes/Lib/Language.jsp"%>

<%
// Key Variables
ReturnObjFromRetrieve retlang = null;

// System Configuration Class
EzSystemConfig ezsc = new EzSystemConfig();

//Get All Languages
retlang = ezc.getAllLangKeys();
retlang.check();
%>

<html>
<head>

<script language = "javascript">
function CheckValue() {
	Language = document.forms[0].Lang.value;
	Key = document.forms[0].Code.value;
	Desc = document.forms[0].Desc.value;

	if((Language == "")||(Key == "")||(Desc == "")){
		alert("Please Enter Language, Key and Description to Continue");
		document.returnValue = false;
	}else{
		document.returnValue = true;
	}
}
</script>

<Title>Add error code</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7">
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Adding Error Codes</Td>
  </Tr>
</Table>
<form name=myForm method=post action="../Misc/ezSaveErrorCode.jsp">

  <Table  width="60%" border="1" cellpadding="5" cellspacing="1" align="center">
    <Tr> 
      <Th width="100%" colspan="2">Please enter the following Error Code information: 
      </Th>
    </Tr>
    <Tr> 
      <Td width="43%" class="labelcell">Language:</Td>
      <Td width="57%"> <%@ include file="../../../Includes/Lib/ListBox/LBLanguage.jsp"%></Td>
    </Tr>
    <Tr> 
      <Td width="43%" class="labelcell">Error Code:</Td>
      <Td width="57%"> 
        <input type=text class = "InputBox" name=Code >
      </Td>
    </Tr>
    <Tr> 
      <Td width="43%" class="labelcell">Error Description:</Td>
      <Td width="57%"> 
        <input type=text class = "InputBox" name=Desc >
      </Td>
    </Tr>
  </Table>
  <div align="center"><br>
    <input type="submit" name="Submit" value="Add Error Code" onClick="CheckValue();return document.returnValue">
    </div>
</form>
</body>
</html>
