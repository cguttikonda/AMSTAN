<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<HTML>
<HEAD>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
	var searchKeyObj=parent.document.myForm.searcKey;
	var addProductObj  =parent.document.myForm.addProduct;
	var FavGroup=parent.document.myForm.FavGroup.value;
	var GroupDesc=parent.document.myForm.GroupDesc.value;
	
	var addProduct="";
	
	if(addProductObj!=null) 
	    addProduct=addProductObj.value;
	
	var searchKey;
	
	if(searchKeyObj!=null)
		searchKey=searchKeyObj.value;
	
	
	function searchOptions()
	{
	    var selVal=document.myForm.base.value
	    
	    if(selVal=="VC")
	    {
	         parent.document.getElementById("options").src="ezVendorDrillDownTree.jsp";

	    }
	    else if(selVal=="CNET")
	    {
	    	//top.display.location.href="../Cnet/ezListCnetCategories.jsp"
	    	parent.document.getElementById("options").src="ezCnetDrillDownTree.jsp";
	    }
	    else
	    {
	         parent.document.getElementById("options").src="ezSearchOptions.jsp?selOpt="+selVal+"&addProduct="+addProduct+"&FavGroup="+FavGroup+"&GroupDesc="+GroupDesc;
	    }
	     
	}
	
	function doOnLoad()
	{
           var sel = document.myForm.base
           var len = document.myForm.base.options.length 
                     
          if(searchKeyObj!=null)
          {
              for(i=0;i<len;i++)
              {
              	if(sel.options[i].value == searchKey)	
              	sel.options[i].selected = true;
              	searchOptions();
              }
          }
                    
        }
</script> 
</Head>

<Body onLoad="doOnLoad();" scroll=NO >
<Form name="myForm" method="post">   


<Div id='inputDiv' style='position:relative;align:center;top:25%;width:100%;'>
<Table width="90%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'DDEEFF'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'DDEEFF'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
		<tr><td VALIGN=TOP colspan=2 align=center><b>Search Criteria</b><td></tr>
		<Tr>
			<Td style='background:#DDEEFF;font-size=11px;color:#00355D;font-weight:bold;' width='100%' align=center valign=center>
				<select name="base" style="width:80%" id="ListBoxDiv1" onChange="searchOptions()">
				<option value="VC">Manufacturer Catalog</option>
				<option value="CNET" selected>All Categories</option>
				<option value="IN">Product ID</option>
				<!--<option value="ID">Item Description</option>-->
				<!--<option value="BN">Brand Name</option>-->
				<option value="AS">Advanced Search</option>
				</select>
			</Td>
		</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'DDEEFF'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'DDEEFF'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>

</form>
<Div id="MenuSol"></Div>
</Body>
</Html>