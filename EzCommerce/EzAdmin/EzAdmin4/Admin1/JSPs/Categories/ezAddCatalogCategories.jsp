<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Categories/iGetProductCatalog.jsp"%>

<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>

	function funSave()
	{
		var catCode  = document.myForm.catCode.value;
		var catgDesc  = document.myForm.catgDesc.value;
		catgDesc 	 = catgDesc.replace(/^\s+|\s+$/g,""); //to trim spaces

		if(catCode=="")
		{
			alert("Please Select Catalog Type");
			return false;
		}		
		if(catgDesc=="")
		{
			alert("Please Enter Category Description");
			return false;
		}
		else
		{
			document.myForm.action="ezSaveCatalogCategories.jsp";
			document.myForm.submit();
		}
	
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
        <div align="right">Catalog Type</div>
      </Th>
      <Td width="55%">
      <Select name="catCode">
      <Option value="">Select Catalog</Option>
<%
	for(int i=0;i<cntretProdCat;i++)
	{
%> 
		<Option value="<%=retProdCat.getFieldValueString(i,"EPC_NO")%>"><%=retProdCat.getFieldValueString(i,"EPC_NAME")%></Option>
<%
	}
%>
      </Select>

     </Td>
    </Tr>
  		<Tr>
    		  <Th nowrap width="45%" class="labelcell">
    		    <div align="right">Category Description*</div>
    		  </Th>
    		  <Td width="55%">
    		   
    		   <Input type="text" name="catgDesc" class="inputbox">
    		   
    		  </Td>
    		</Tr>
  		</Table>
  		<div align="center"><br>
  		 <a href="JavaScript:funSave()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none></a>	
  		 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</a>
  		</div>
		</form>
</body>
</html>