<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Categories/iAttributeSetList.jsp"%>

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
		var attrSetId 	=  document.myForm.attrSetId.value;
		var attrID 	=  document.myForm.attrID.value;
		
		if(attrSetId=="")
		{
			alert("Please select Attribute Set");
			return false;
		}
		if(funTrim(attrID)=="")
		{
			alert("Please Enter Attribute ID");
			document.myForm.catLang.focus();
			return false;
		}
		document.myForm.action="ezSaveAttrInAtrrSet.jsp";
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
        <div align="right">Attribute Set*</div>
      </Th>
      <Td width="55%">
        <select name="attrSetId" style="width:100%" id=FullListBox >
	        <option value="">--Select Catalog--</option>
<%
		for(int i=0;i<cntretAttribueList;i++)
		{
%>
			<option value="<%=retAttribueList.getFieldValueString(i,"EAS_ID")%>"><%=retAttribueList.getFieldValueString(i,"EAS_ID")%></option>	

<%
		}
%>
        </select>
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Attribute Id*</div>
      </Th>
      <Td width="55%">
	<Input type="text" name="attrID" class="inputbox" style="width:100%" >
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