<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<Html>
<Head>
<Title>Search Materials</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script src = "../../Library/JavaScript/ezTrim.js"></Script>
<Script>
function funCheck(opt)
{
	if(opt ==1)
	{
		document.myForm.searchBy[0].checked= "true";
		for(i=0;i<5;i++)
		{
			document.myForm.searchPattern[i].checked = false;
		}
		document.myForm.searchPattern[0].disabled = true;
		document.myForm.searchPattern[1].disabled = true;
		document.myForm.searchPattern[2].disabled = true;		
		document.myForm.searchPattern[3].disabled = true;
		document.myForm.searchPattern[4].disabled = true;		
		document.myForm.searchPattern[5].disabled = true;				
		document.myForm.searchCriteria.focus();
	}
	else if(opt ==2)
	{
		document.myForm.searchPattern[0].checked = true;
		document.myForm.searchPattern[0].disabled = false;
		document.myForm.searchPattern[1].disabled = false;
		document.myForm.searchPattern[3].disabled = false;		
		document.myForm.searchPattern[5].disabled = false;
		document.myForm.searchPattern[2].disabled = true;
		document.myForm.searchPattern[4].disabled = true;
		document.myForm.searchCriteria.focus();
	}
	else
	{
		document.myForm.searchPattern[2].checked = true;
		document.myForm.searchPattern[0].disabled = true;
		document.myForm.searchPattern[1].disabled = true;
		document.myForm.searchPattern[3].disabled = true;		
		document.myForm.searchPattern[5].disabled = true;
		document.myForm.searchPattern[2].disabled = false;
		document.myForm.searchPattern[4].disabled = false;
		document.myForm.searchCriteria.focus();
	}
}
function funSearch()
{
	if(funTrim(document.myForm.searchCriteria.value) == "")
	{
		alert("Please Enter Search Criteria.")
		document.myForm.searchCriteria.focus();
	}
	else
	{
		document.myForm.action = "ezMaterialSearch.jsp";
		document.myForm.submit();
	}
}
</Script>
</Head>
<Body onLoad = "document.myForm.searchCriteria.focus();funCheck('1')">
<form name=myForm method=post onSubmit="">
<br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
<Tr>
	<Th>Search Materials</Th>
</Tr>
</Table>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
<Tr>
	<label for = "cb_0">
	<Th align = "left"><input type = "radio" id = "cb_0" name = "searchBy" value = "matDesc" checked OnClick = "funCheck('1')">By Material Description</Th>
	</label>
	<label for = "cb_1">
	<Th align = "left"><input type = "radio" id = "cb_1" name = "searchBy" value = "matCode" OnClick = "funCheck('2')">By Material Code</Th>
	</label>
	<label for = "cb_2">
	<Th align = "left"><input type = "radio" id = "cb_2" name = "searchBy" value = "matGrp" OnClick = "funCheck('3')">By Material Group</Th>	
	</label>
</Tr>
<Tr>
	<Td>&nbsp;</Td>
	<label for = "cb_3">
	<Td><input type = "radio" id = "cb_3" name = "searchPattern" value = "M">For Material Codes and Description</Td>
	</label>
	<Td>&nbsp;</Td>
</Tr>
<Tr>
	<Td>&nbsp;</Td>
	<label for = "cb_4">
	<Td><input type = "radio" id = "cb_4" name = "searchPattern" value = "G">For Material Groups</Td>
	</label>
	<label for = "cb_5">
	<Td><input type = "radio" id = "cb_5" name = "searchPattern" value = "S">For Sales Areas</Td>	
	</label>
</Tr>
<Tr>
	<Td>&nbsp;</Td>
	<label for = "cb_6">
	<Td><input type = "radio" id = "cb_6" name = "searchPattern" value = "GS">For Material Groups and Sales Areas</Td>
	</label>
	<label for = "cb_7">
	<Td><input type = "radio" id = "cb_7" name = "searchPattern" value = "C">For Catalogs</Td>	
	</label>
</Tr>
<Tr>
	<Td>&nbsp;</Td>
	<label for = "cb_8">
	<Td><input type = "radio" id = "cb_8" name = "searchPattern" value = "GSC">For Material Groups and Sales Areas and Catalogs</Td>
	</label>
	<Td>&nbsp;</Td>	
</Tr>
<Tr>
	<Th align = "right">Search Criteria</Th>	
	<Td colspan = 2><input type = "text" class  = "InputBox" name = "searchCriteria" value = "" Style = "width:100%"></Td>	
</Tr>
</Table>
<br>
<Center>
	<a href="javascript:funSearch()"><img src = "../../Images/Buttons/<%= ButtonDir%>/search.gif" style = "Cursor:hand" border = "none"></a>
	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</Center>

</Body>
</Html>


