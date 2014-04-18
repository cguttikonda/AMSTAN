<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%
	String catgID		= request.getParameter("catgID");
	String splitcatgID[]	= catgID.split("¥");
	out.println(splitcatgID[0]+"::"+splitcatgID[1]+"::"+splitcatgID[2]+":::"+splitcatgID[3]+"::"+splitcatgID[4]+"::"+splitcatgID[4]);
	
	String catgCode		= splitcatgID[0];
	String catgParent	= splitcatgID[1];
	String catgStatus	= splitcatgID[2];
	String catgVisible	= splitcatgID[3];
	String catgImage	= splitcatgID[4];
	String catgThumb	= splitcatgID[5];
	
	String selected="";
	
	if(catgStatus.equals("Active"))catgStatus="A";
	if(catgStatus.equals("Inactive"))catgStatus="I";
	if(catgStatus.equals("Deleted"))catgStatus="D";
	
	if(catgVisible.equals("Yes"))catgVisible="Y";
	if(catgVisible.equals("No"))catgVisible="N";	
	
%>
<%@ include file="../../../Includes/JSPs/Categories/iEditCategory.jsp"%>
<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/CheckFormFields.js" ></script>
<script src="../../Library/JavaScript/Catalog/ezCatalogName.js" ></script>
<Script>

	function funGetParentList()
	{
		var catgId =  document.myForm.categoryId.value;
		if (catgId=="")
		   {
		  
		   return false;
		   } 
		  //alert(catgId); 
		if (window.XMLHttpRequest)
		   {// code for IE7+, Firefox, Chrome, Opera, Safari
		   xmlhttp=new XMLHttpRequest();
		   }
		 else
		   {// code for IE6, IE5
		   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		   }
		 xmlhttp.onreadystatechange=function()
		   {
		   if (xmlhttp.readyState==4 && xmlhttp.status==200)
		     {//alert(xmlhttp.responseText)
		     document.getElementById("parentList").innerHTML=xmlhttp.responseText;
		     }
		   }
		 xmlhttp.open("GET","../../../Includes/JSPs/Categories/iGetCategoryParentList.jsp?catgId="+catgId,true);
		 xmlhttp.send();
	}
	function funEditCategory()
	{
		var catgId 	=  document.myForm.categoryId.value;
		
		if(catgId=="")
		{
			alert("Please select Category");
			return false;
		}
		
		document.myForm.action="ezSaveEditCategory.jsp";
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
        <div align="right">Category*</div>
      </Th>
      <Td width="55%">
		<Input type='text' class='tx' value='<%=catgCode%>' name='categoryId' readonly>
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Status*</div>
      </Th>
      <Td width="55%">
        <select name="catgStatus" style="width:100%" id=FullListBox1>
	        <option value="A" <% if(catgStatus.equals("A"))out.println("selected"); %>>Active</option>
	        <option value="I" <% if(catgStatus.equals("I"))out.println("selected"); %>>Inactive</option>
	        <option value="D" <% if(catgStatus.equals("D"))out.println("selected");%>>Deleted</option>
        </select>
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Parent</div>
      </Th>
      <Td width="55%"><Div id="parentList">
        <select name="catgParent" style="width:100%" id=FullListBox2>
	        <option value="sel">--Select Parent--</option>
<%
		for(int i=0;i<cntRetCatgsList;i++)
		{
			selected="";
			if(catgParent.equals(retCatgsList.getFieldValueString(i,"ECC_CATEGORY_ID")))selected="selected";
%>
			<option value="<%=retCatgsList.getFieldValueString(i,"ECC_CATEGORY_ID")%>" <%=selected%>><%=retCatgsList.getFieldValueString(i,"ECC_CATEGORY_ID")%></option>	

<%
			
		}
%>
        </select>
     </Div>   
     </Td>
    </Tr>
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Visibility*</div>
      </Th>
      <Td width="55%">
        <select name="catgVisible" style="width:100%" id=FullListBox3>
	        <option value="Y" <% if(catgVisible.equals("Y"))out.println("selected"); %> >Yes</option>
	        <option value="N" <% if(catgVisible.equals("N"))out.println("selected"); %>>No</option>
        </select>
     </Td>
    </Tr>    
	<Tr>
	  <Th nowrap width="45%" class="labelcell">
	    <div align="right">Image</div>
	  </Th>
	  <Td width="55%">
	    <input type=text class = "InputBox" name="catgImage" style="width:100%" maxlength="128">
	  </Td>
	</Tr>
	<Tr>
	  <Th nowrap width="45%" class="labelcell">
	    <div align="right">Thumbnail</div>
	  </Th>
	  <Td width="55%">
	    <input type=text class = "InputBox" name="catgThumb" style="width:100%" maxlength="128">
	  </Td>
	</Tr>	
  		</Table>
  		<div align="center"><br>
  		  <a href="JavaScript:funEditCategory()"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none></a>	
  		 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>  		</div>
		</form>

</body>
</html>