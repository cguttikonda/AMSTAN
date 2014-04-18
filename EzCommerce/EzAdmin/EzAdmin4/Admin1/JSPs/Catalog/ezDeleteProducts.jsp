<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iDeleteProducts.jsp" %>
<html>
<head>
	<Script>
			
		var tabHeadWidth="80";
		var tabHeight="55%";
	</script>
	<Script src="../../Library/JavaScript/Catalog/ezProcessFile.js"></Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	
	<Script>
	function funGetProducts()
	{
	   
	   	document.myForm.action="ezDeleteProducts.jsp"
           	document.myForm.submit();
           
		
	}
	function deleteProducts()
	{
		 var chkObj 	= document.myForm.chk1;
		 var chkAllObj 	= document.myForm.chk;
		 var chkLen	= chkObj.length;
		 var chkValue	= "";
		 var count	= 0;

                if(chkAllObj.checked)
                   document.myForm.type.value="A";
                else
                   document.myForm.type.value="S";
                
                
                
		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				if(chkObj[i].checked)
				{
					count++;				
				}
			} 
		}
		else
		{
			if(chkObj.checked)
			{
				count = 1;
			}
		}

		if(count == 0)
		{
			alert("Please select atleast one product to delete");
			return;
		}

			document.myForm.action = "ezDeleteProducts.jsp";
			document.myForm.submit();
		
	}
		
	function checkAll()
	{
		var chkObj 	= document.myForm.chk;
		var chkObj1 	= document.myForm.chk1;
		var chkLen	= chkObj1.length;
		var chkValue	= "";
		var count	= 0;
	
		if(chkObj.checked)
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = true;
				}
			}
			else
			{
				chkObj1.checked = true;
			}
		}
		else
		{
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj1[i].checked = false;
				}
			}
			else
			{
				chkObj1.checked = false;
			}
		}
	}

	function editProducts()
	{
	   	document.myForm.action="../Products/ezProductDetails.jsp"
           	document.myForm.submit();
	}
	
	</Script>
	
</head>

<Body scroll=no onLoad="scrollInit()" onresize="scrollInit()">
<Form name="myForm" method="post">
<Div id="MenuSol_R"></Div> 
<input type="hidden" name="type">



<br>
<%
	if(retCatCount==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Vendor Catalogs exist.
			</Th>
		</Tr>
		</Table><br>
		<center>
				<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
		</center>
<%
	}
%>

<%
	if(retCatCount > 0)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
		<Tr>
			<Th width="40%" align="right" class="labelcell">Vendor Catalog&nbsp;</Th>
			<Td width="60%">
			<select name="catalog" id = "FullListBox" style="width:100%" onChange="funGetProducts()">
			<option value="sel" >--Select Catalog--</option>
<%
			String catNum="",catalogName="";
			retcat.sort(new String[]{CATALOG_DESC},true);
			for (int i = 0 ;i<retCatCount;i++ ){
				
				catNum      = retcat.getFieldValue(i,CATALOG_DESC_NUMBER).toString();
				catalogName = (String)retcat.getFieldValue(i,CATALOG_DESC);
				//catalogName = catalogName.replace('\u0020',' ');
                               
								
				if(catNum.equals(cat_num))
				{
%>
	  	  			<option selected value="<%=catNum%>"><%=catalogName%> (<%=catNum%>)</option>
<%
	     			}else{
%>
	  	  			<option value="<%=catNum%>"><%=catalogName%> (<%=catNum%>)</option>
<%  	     			}

			}
%>
			</select>
      			</Td>
		</Tr>
		</Table>
	
<%
       }
	if(retCount==0)
	{
%>
		<br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
			No Products exist.
			</Th>
		</Tr>
		</Table><br>
		<center>
				<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
		</center>
<%
     }
    if(retCount>0)
    {
%>
		<Br>
		
		
		<Div id="theads" >
		<Table width="80%" id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>

			<Th width="5%" align="center"><input type="checkbox" name="chk" value='All' onClick="checkAll()"></th>
			<Th width="20%" align="left">Product Code</Th>
			<Th width="35%" align="left">Description</th>
			<Th width="20%" align="left">Brand</th>
			<Th width="10%" align="left">List Price</th>
			<Th width="10%" align="left">UOM</th>   
		</Tr>
		</Table>
		</Div>
		
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:55%;left:10%">
		<Table width="100%" id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%
                        String MatNo="";   
                        String mat_id = "";
			for (int i=0;i<retCount;i++)
			{
				MatNo 	   = ret.getFieldValueString(i,"EMM_NO");
				mat_id     = ret.getFieldValueString(i,"EMM_ID");
				
%>
				
				<Tr>
				<Td width="5%" align="center"><input type="checkbox" name="chk1" value='<%=mat_id%>'></Td>
				<Td width="20%" align="left"><%=MatNo%></Td> 
				<Td width="35%" align="left"><%=ret.getFieldValueString(i,"EMD_DESC")%></Td>
				<Td width="20%" align="left"><%=ret.getFieldValueString(i,"EMM_MANUFACTURER")%></Td>
				<Td width="10%" align="right"><%=ret.getFieldValueString(i,"EMM_UNIT_PRICE")%></Td>
				<Td width="10%" align="center"><%=ret.getFieldValueString(i,"EMM_UNIT_OF_MEASURE")%></Td>
				</tr>
<%
                       }
%>
				
		</Table>
		</Div>
		
		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>

			<span id="EzButtonsSpan">
			<center>
				<img src="../../Images/Buttons/<%=ButtonDir%>/delete.gif" border="none" valign=bottom style="cursor:hand" onclick="deleteProducts()"> 
				<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
				<img src="../../Images/Buttons/<%=ButtonDir%>/edit.gif" border="none" valign=bottom style="cursor:hand" onClick="editProducts()"> 
			</center>
			</span>
			<span id="EzButtonsMsgSpan" style="display:none">
				<Table align=center>
					<Tr>
						<Td class="labelcell">Your request is being processed... Please wait</Td>
					</Tr>
				</Table>
			</span>
		</Div>
		
<%
   }
%>

<Div id="MenuSol"></Div>
</form>
<script>

<%
   if(venCatalog!=null)
   {
%>
   document.myForm.catalog.value="<%=venCatalog%>"
   
<% } %>

</script>
</body>
</html>

