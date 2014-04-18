<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iAddVendorCatalog.jsp"%>
<Html>
<Head>
	<Title>Add Vendor Catalog</Title>
	<meta http-equiv="Content-Type" content=" text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	
<Script>
 
 function addVendor()
 {
 	if(document.myForm.SystemKey.value == 'sel'){
 		alert("Please select sales area");
 		return;
 	}
 	if(document.myForm.CatalogName.value == 'sel'){
		alert("Please enter catalog name");
		return;
 	}
 	
 	document.myForm.action="ezAddSaveVendorCatalog.jsp"; 
 	document.myForm.submit();
 	return;
 }
</Script>

</Head>
<Body bgcolor="#FFFFF7" onLoad='scrollInit()' onresize='scrollInit()' scroll="no">

<Form name=myForm method=post >

<br>
<%
	if(retObjCount > 0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Th width="40%" align="right" class="labelcell" bordercolor="#CCCCCC">Sales Area*</Th>
			<Td width="60%" bordercolor="#CCCCCC">
			<select name="SystemKey" id = "FullListBox" style="width:100%" >
			<option value="sel" >--Select Sales Area--</option>

<%
			String val=null,syskeyDesc=null;
			retsyskey.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
			for (int i = 0 ;i<retObjCount;i++ ){
				val = retsyskey.getFieldValueString(i,SYSTEM_KEY);
				syskeyDesc = retsyskey.getFieldValueString(i,SYSTEM_KEY_DESCRIPTION);
				val = val.toUpperCase();
				val = val.trim();
				
				if(val.equals(sys_key))
				{
%>
	  	  			<option selected value="<%=val%>"><%=syskeyDesc%> (<%=val%>)</option>
<%
	     			}else{
%>
	  	  			<option value="<%=val%>"><%=syskeyDesc%> (<%=val%>)</option>
<%  	     			}

			}
%>
			</select>
      			</Td>
		</Tr>
		</Table>
    
		<Table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0 width="60%">
		<Tr>
			<Th width="40%"  align="right" class="labelcell" bordercolor="#CCCCCC">
			<nobr>New Vendor Catalog Description*</nobr>
			</Th>
			<Td width="45%"  bordercolor="#CCCCCC">
			<input type=text class = "InputBox" name="CatalogName" style="width:100%" maxlength="120">
			</Td>
			<Td width="15%"  align="center" bordercolor="#CCCCCC">
			<img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" name="Submit" value="Add" onClick="addVendor();" border=0>
			</Td>
			
		</Tr>
		</Table>
		

		<div id="ButtonDiv" align="center" style="position:absolute;top:92%;width:100%">
			<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()"></a>
			
		</div>
		<script>
			document.forms[0].CatalogName.focus()
		</script>
<%
		if(retCatCount >0){
%>
			<br><br>
			<div id="theads" >
				<Table id="tabHead"   align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
		  		<Tr align="left">
		      			<Th width="21%" align = "center">Catalog</Th>
		      			<Th width="79%" align = "center">Description</Th>
		     		</Tr>
		 		</Table>
 			</div>
 			
 			<DIV id="InnerBox1Div">
			<Table id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

 <%
			retcat.sort(new String[]{CATALOG_DESC},true);
			for ( int i = 0 ; i < retCatCount; i++ )
			{

				String catNum  = retcat.getFieldValue(i,CATALOG_DESC_NUMBER).toString();
				String pChange = "N";
				String catalogName = (String)retcat.getFieldValue(i,CATALOG_DESC);

				catalogName = catalogName.replace('\u0020','+');

%>
				<Tr align="left">
				<Td width="21%">
<%
				if(pChange.equals("Y"))
				{
%>
			  		<a style="text-decoration:none" href = "ezSelChangeCatalog.jsp?catNum=<%=catNum%>" >
<%
				}else{
%>
					<a style="text-decoration:none" href = "ezShowCatalog.jsp?CatNumber=<%=catNum%>&catDesc=<%=catalogName%>" >
<%
				}
%>
				<%=catNum%>
				</a>
				</Td>
				<Td width="79%">
<%
				if(catalogName != null)
				{
%>
		       			<%= catalogName.replace('+','\u0020')%>
<%
				}

%>
		      		</Td>
				</Tr>
<%
			}//for close
%>


			</Table>
			</Div>
		
 			
<%
		
		}else{
%>
			<br><br><br><br>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
  			<Tr align="center">
    			<Th>There are No Catalogs </Th>
  			</Tr>
			</Table>
<%
		
		}

	}else{
%>		
		<BR><BR>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
		<Tr align="center">
			<Th>There are No Sales Areas Defined  Currently</Th>
		</Tr>
		</Table>
		<center>
			<br><a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</center>

<%
	}
%> 
</Form>
</Body>
</Html>
