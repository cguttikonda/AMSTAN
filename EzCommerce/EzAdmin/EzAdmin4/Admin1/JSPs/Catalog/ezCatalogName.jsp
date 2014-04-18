<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iCatalogName.jsp"%>

<html>
<head>
<Title>ezCatalogName</Title>
<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<script src="../../Library/JavaScript/CheckFormFields.js" ></script>
<script src="../../Library/JavaScript/Catalog/ezCatalogName.js" ></script>
</head>
<BODY onLoad="placeFocus(<%=numCat%>)">
<form name=myForm method=post action="ezSaveCatalogName.jsp" onSubmit="return checkAll()">

<br>
<%
if(numCat > 0)
{
%>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  <Tr align="center">
    <Td class="displayheader">Change Catalog Description</Td>
  </Tr>
</Table>
  <Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
    <Tr>
      <Th nowrap width="45%" class="labelcell">
        <div align="right">Catalog Description*</div>
      </Th>
      <Td width="55%">
        <select name="CatalogNumber" style="width:100%" id=FullListBox>
	        <option value="sel">--Select Catalog--</option>
<%
		retcat.sort(new String[]{CATALOG_DESC},true);
		for ( int i = 0 ; i < numCat ; i++ )
		{
		  catalog_description = (String)(retcat.getFieldValue(i,CATALOG_DESC));
		  if (retcat.getFieldValueString(i,CATALOG_DESC_NUMBER).equals(catalog_number))
		  {

%>
	    	    <option selected value=<%=(retcat.getFieldValue(i,CATALOG_DESC_NUMBER))%> >
	    	    <%=catalog_description%> (<%=retcat.getFieldValue(i,CATALOG_DESC_NUMBER)%>)
	    	    </option>
<%
		  }
		  else
		  {
%>
	    	    <option value=<%=(retcat.getFieldValue(i,CATALOG_DESC_NUMBER))%> >
	    	    <%=catalog_description%> (<%=retcat.getFieldValue(i,CATALOG_DESC_NUMBER)%>)
	    	    </option>
<%
		  }

	       }//for-i end
%>
        </select>
     </Td>
    </Tr>
  		<Tr>
    		  <Th nowrap width="45%" class="labelcell">
    		    <div align="right">New Description*</div>
    		  </Th>
    		  <Td width="55%">
    		    <input type=text class = "InputBox" name="NewCatDesc" style="width:100%" maxlength="128">
    		  </Td>
    		</Tr>
  		</Table>
  		<div align="center"><br>
  		  <input type="image" src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Update">
  		 <a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
</a>
  		</div>
		</form>
 <%
   }//if(numCat > 0)
   else
   {
%>
<br><br><br><br>
<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
  <Tr align="center">
    <Th>There are No Catalogs </Th>
  </Tr>
</Table>
 <center>
  <br><a href="javascript:void(0)"><img src = "../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none onClick="JavaScript:history.go(-1)"></a>
</center>
<%
  }//else close
%> </p>

<%
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Catalog description updated successfully');
		</script>
<%
	} //end if
%>

</body>
</html>