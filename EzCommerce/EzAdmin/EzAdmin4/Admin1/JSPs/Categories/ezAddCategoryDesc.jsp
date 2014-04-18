<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Categories/iCategoriesList.jsp"%>

<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/CheckFormFields.js" ></script>
<script src="../../Library/JavaScript/Catalog/ezCatalogName.js" ></script>
<Script>

	function funAddCategoryDesc()
	{
		var categoryId 	=  document.myForm.categoryId.value;
		var catLang 	=  document.myForm.catLang.value;
		var catDesc 	=  document.myForm.catDesc.value;
		
		if(categoryId=="")
		{
			alert("Please select Category");
			return false;
		}
		if(funTrim(catLang)=="")
		{
			alert("Please Enter Language");
			document.myForm.catLang.focus();
			return false;
		}
		if(funTrim(catDesc)=="")
		{
			alert("Please Enter Description");
			document.myForm.catDesc.focus();
			return false;
		}		
		document.myForm.action="ezSaveCategoryDesc.jsp";
		document.myForm.submit();		
	}
</Script>
</head>
<BODY >
<form name="myForm" method=post>

<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  <Tr align="center">
    <Td class="displayheader">Add Category</Td>
  </Tr>
</Table>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Select Category*</div>
      </Th>
      <Td width="55%">
        <select name="categoryId" style="width:100%" id=FullListBox >
	        <option value="">--Select Catalog--</option>
<%
		for(int i=0;i<cntRetCatgsList;i++)
		{
%>
			<option value="<%=retCatgsList.getFieldValueString(i,"EC_CODE")%>"><%=retCatgsList.getFieldValueString(i,"EC_CODE")%></option>	

<%
		}
%>
        </select>
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Language*</div>
      </Th>
      <Td width="55%">
	<Input type="text" name="catLang" class="inputbox" style="width:100%" maxlength="3">
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Description*</div>
      </Th>
      <Td width="55%">  
	<Input type="text" name="catDesc" class="inputbox" style="width:100%" maxlength="50">      
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Description 1</div>
      </Th>
      <Td width="55%">
	<Input type="text" name="catDesc1" class="inputbox" style="width:100%"> 
     </Td>
    </Tr>    
		
  		</Table>
  		<div align="center"><br>
  		  	<a href="JavaScript:funAddCategoryDesc()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none></a>	
  		 	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>  		
  		 </div>
		</form>

</body>
</html>