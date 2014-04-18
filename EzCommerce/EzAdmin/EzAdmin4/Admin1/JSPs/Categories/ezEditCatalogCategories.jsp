<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String catID		= request.getParameter("catID");
	String splitcatID[]	= catID.split("¥");
	//out.println(splitcatID[0]+"::"+splitcatID[1]+"::"+splitcatID[2]);
%>
<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<Script>

	function funSave()
	{
		var newCatgDesc  = document.myForm.newCatgDesc.value;
		newCatgDesc 	 = newCatgDesc.replace(/^\s+|\s+$/g,""); //to trim spaces
		
		if(newCatgDesc=="")
		{
			alert("Please Enter Category Description");
			return false;
		}
		else
		{
			document.myForm.action="ezSaveEditCatalogCategories.jsp";
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
    <Td class="displayheader">Update Category</Td>
  </Tr>
</Table>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Catalog Type</div>
      </Th>
      <Td width="55%">
	<Input type=text value="<%=splitcatID[2]%>" class="tx" readonly>
	 <input type=hidden name="oldCatgDesc" value="<%=splitcatID[0]%>">
	 <input type=hidden name="catalogId" value="<%=splitcatID[1]%>">
     </Td>
    </Tr>
  		<Tr>
    		  <Th nowrap width="45%" class="labelcell">
    		    <div align="right">Category Description*</div>
    		  </Th>
    		  <Td width="55%">
    		    <input type=text class = "InputBox" name="newCatgDesc" value="<%=splitcatID[0]%>" style="width:100%" maxlength="128">
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