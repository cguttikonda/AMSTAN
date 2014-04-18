<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iProcessPriceFile.jsp" %>
<html>
<head>
	<Script>
	  var tabHeadWidth=80
	  var tabHeight="60%"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<Script>
	function selectMat()
	{
		var chkObj 	= document.myForm.chk1;
		var chkLen	= chkObj.length;
		var chkValue	= "";
		var count	= 0;
		
		
	        
	        var sel         = document.myForm.catalog;
	       
	        
	       
	        
	        if(sel.value=="sel")
	        {
			alert("Please select Vendor Catalog");
			return;
	        }
	        
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
	
		if(count == 0){
			alert("Please select atleast one product to save");
			return;
		}
		
		
		buttonsSpan	  = document.getElementById("EzButtonsSpan")
		buttonsMsgSpan	  = document.getElementById("EzButtonsMsgSpan")
		if(buttonsSpan!=null)
		{
		     buttonsSpan.style.display		= "none"
		     buttonsMsgSpan.style.display	= "block"
		}
	
		document.myForm.action = "ezMaintainProduct.jsp";
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

	</Script>
	
	<script>
		function funDownload()
		{
		   document.myForm.from.value="MAINTAIN";
		   document.myForm.action="ezDownLoadExcel.jsp"; 
		   document.myForm.target="_self";
		   document.myForm.submit();

		}
	</script> 
	
</head>

<Body onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<Form name="myForm" method="post">
<input type="hidden" name="from"> 
<br>
<%
	if(retCatCount > 0 && flag && dataObjCount>1)
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="40%">
		<Tr>
			<Th width="40%" align="right" class="labelcell">Vendor Catalog&nbsp;</Th>
			<Td width="60%">
			<select name="catalog" id = "FullListBox" style="width:100%" >
			<option value="sel" >--Select Catalog--</option>

<%
			String catNum="",catalogName="";
			retcat.sort(new String[]{CATALOG_DESC},true);
			for (int i = 0 ;i<retCatCount;i++ ){
				
				catNum      = retcat.getFieldValue(i,CATALOG_DESC_NUMBER).toString();
				catalogName = (String)retcat.getFieldValue(i,CATALOG_DESC);
				//catalogName = catalogName.replace('\u0020','+');
                                //out.println("cat_num>>>"+cat_num);
								
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
       if(flag && dataObjCount>1)
       {
%>
		<Br>
		<Div id="theads">
			<Table id="tabHead" width="80%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr>
				<Th width="5%"><input type="checkbox" name="chk" value='' onClick="checkAll()"></th>
				<Th width=10%>Product</Th>
				<Th width=10%>List Price </Th>
				<Th width=15%>Image Path</Th>
				<Th width=15%>Spec 1</Th>
				<Th width=15%>Spec 2</Th>
				<Th width=15%>Spec 3</Th>
				<Th width=15%>Spec 4</Th>				
				
			</Tr>					
			</Table>
		</Div>
	
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;left:10%">
		   <Table  id="InnerBox1Tab" width="100%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%	
			String MatNo = "",listPrice="",imagePath="";
			String spec1 ="",spec2 ="",spec3 ="",spec4 ="";
			String tempItemStr ="";
			
			
			for(int row=1;row<dataObjCount;row++)
			{
				MatNo 	   = dataObj.getFieldValueString(row,"Product Code");
				
				listPrice  =  dataObj.getFieldValueString(row,"List Price");
				imagePath  =  dataObj.getFieldValueString(row,"Image Path");
				spec1  =  dataObj.getFieldValueString(row,"Spec 1");
				spec2  =  dataObj.getFieldValueString(row,"Spec 2");
				spec3  =  dataObj.getFieldValueString(row,"Spec 3");
				spec4  =  dataObj.getFieldValueString(row,"Spec 4");
				
				tempItemStr = MatNo+"$$"+listPrice+"$$"+imagePath+"$$"+spec1+"$$"+spec2+"$$"+spec3+"$$"+spec4;
				
				listPrice=(listPrice==null || "null".equals(listPrice))?"":listPrice;
				imagePath=(imagePath==null || "null".equals(imagePath))?"":imagePath;
				spec1=(spec1==null || "null".equals(spec1))?"":spec1;
				spec2=(spec2==null || "null".equals(spec2))?"":spec2;
				spec3=(spec3==null || "null".equals(spec3))?"":spec3;
				spec4=(spec4==null || "null".equals(spec4))?"":spec4;
				
				
%>	
				<Tr>
					<Td width="5%"><input type="checkbox" name="chk1" value='<%=tempItemStr%>'></Td>
					<Td width=10%><%=dataObj.getFieldValueString(row,"Product Code")%>&nbsp</Td>	
					<Td width=10%><%=listPrice%>&nbsp</Td>
					<Td width=15%><%=imagePath%>&nbsp</Td>
					<Td width=15%><%=spec1%>&nbsp</Td>
					<Td width=15%><%=spec2%>&nbsp</Td>
					<Td width=15%><%=spec3%>&nbsp</Td>
					<Td width=15%><%=spec4%>&nbsp</Td>
				</Tr>
<%
			}
%>
		   </Table>
		</Div>
		
		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:88%'>

		<span id="EzButtonsSpan">
		<center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/save.gif" border="none" valign=bottom style="cursor:hand" onclick="selectMat()"> 
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
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
	else
	{
%>
		<Div align="center" style="overflow:auto;position:absolute;width:80%;left:8%;Top:40%">
			<Table  id="InnerBox1Tab" width="50%" align=center  border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
			<Tr>
<%
			if(!flag)
			{
%>
				<Th>Please upload valid file(size should be less than 3MB).</Th>	
<%
			}
%>

<%
			if(dataObjCount<2 && flag)
			{
%>
				<Th>No Data Found In Excel.</Th>	
<%
			}
%>

			</Tr>
			</Table>
		</Div>
		
		<Div id="image" style='Position:Absolute;visibility:visible;Left:10%;WIDTH:80%;height:70%;Top:80%'>
			<center>
				<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" border="none" valign=bottom style="cursor:hand" onClick="javascript:history.go(-1)"> 
			</center>
		</Div>
<%
	}
	if(errObjCount>0 && flag)
	{
%>
		<div style="position:absolute;top:92%;left:5%;visibility:visible">
		<Table>
		   <Tr>
			<Td><a href="JavaScript:funDownload()"><b>Down load error data</b></a></Td>
		   </Tr>
		</Table>
		</div>
<%
	}
%>



<Div id="MenuSol"></Div>
</form>
</body>
</html>

