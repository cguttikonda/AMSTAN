<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/CheckFormFields.js" ></script>
<script src="../../Library/JavaScript/Catalog/ezCatalogName.js" ></script>
<Script>

	function funAdd()
	{
		var attrId 	=  document.myForm.attrId.value;
		var attrStatus 	=  document.myForm.attrStatus.value;
		var attrDesc 	=  document.myForm.attrDesc.value;
		
		if(funTrim(attrId)=="")
		{
			alert("Please Enter Attribute Id");
			document.myForm.attrId.focus();
			return false;
		}
		if(funTrim(attrStatus)=="")
		{
			alert("Please Select Attribute Status");
			document.myForm.attrStatus.focus();
			return false;
		}
		if(funTrim(attrDesc)=="")
		{
			alert("Please Enter Description");
			document.myForm.attrDesc.focus();
			return false;
		}		
		document.myForm.action="ezSaveAttributeSet.jsp";
		document.myForm.submit();		
	}
</Script>
</head>
<BODY >
<form name="myForm" method=post>

<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  <Tr align="center">
    <Td class="displayheader">Add Attribute Set</Td>
  </Tr>
</Table>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Attribute Id*</div>
      </Th>
      <Td width="55%">
	<Input type="text" name="attrId" class="inputbox" style="width:100%">	
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Status*</div>
      </Th>
      <Td width="55%">
	<select name="attrStatus" style="width:100%" id=FullListBox1>
		<option value="A" selected>Active</option>
		<option value="I">Inactive</option>
		<option value="D">Deleted</option>
        </select>
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Description*</div>
      </Th>
      <Td width="55%">  
	<Input type="text" name="attrDesc" class="inputbox" style="width:100%">      
     </Td>
    </Tr>
   	
 </Table>
	<div align="center"><br>
		<a href="JavaScript:funAdd()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none></a>	
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>  		
	 </div>
	</form>

</body>
</html>