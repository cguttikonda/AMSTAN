<%//@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iProcessFile.jsp" %>


<html>
<head>



	<Script>
			
		var tabHeadWidth="90"; 
		var tabHeight="55%";
	</script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	
	<Script src="../../Library/JavaScript/Catalog/ezProcessFile.js"></Script>
	<Script>
		
	
	function scrollValue() 
	{
	   var headerDivObj = document.getElementById("div3");
	   var itemsDivObj  = document.getElementById("div4");
	   headerDivObj.scrollLeft= itemsDivObj.scrollLeft
	}
		
	function funDownload()
	{
	   document.myForm.action="ezDownLoadExcel.jsp";
	   document.myForm.target="_self";
	   document.myForm.submit();   
	}
	
	</Script>
	
</head>

<Body scroll=no>
<Form name="myForm" method="post"> 
<Div id="MenuSol_R"></Div> 
<br>
<%
	session.setMaxInactiveInterval(-1);
	if(retCatCount > 0 && flag && dataObjCount>1)   
	{
%>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="60%">
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
%>  
      

<%
	if(flag && dataObjCount>1)  
	{
	       
%>
		<Br>
		<Div id="div3" align="center" style="overflow:hidden;position:absolute;left:9%;width:80%;height:6%;top:15%">
		<Table border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 align=center width="2035">
		<Tr class="tr">
			<Th width="3%"   align="center"><input type="checkbox" name="chk" value='' onClick="checkAll()"></th>
			<Th width="7%"  align="left">Product Code</Th>
			<Th width="13%"  align="left">Description</th>
			<Th width="10%"  align="left">Brand</th>
			<Th width="7%"   align="right">List Price</th>  
			<Th width="7%"   align="left">Image Path</th>         
			<Th width="5%"   align="left">Status</th>
			<Th width="5%"   align="left">Family</th>
			<Th width="3%"   align="left">UPC</th>
			<Th width="4%"   align="left">Type</th>
			<Th width="4%"   align="left">Color</th>
			<Th width="3%"   align="left">Size</th>
			<Th width="3%"   align="left">Length</th>
			<Th width="3%"   align="left">Width</th>
			<Th width="3%"   align="center">UOM</th>
			<Th width="4%"   align="left">Finish</th>
			<Th width="4%"   align="left">Spec1</Th>
			<Th width="4%"   align="left">Spec2</Th>
			<Th width="4%"   align="left">Spec3</Th>
			<Th width="4%"   align="left">Spec4</Th>
		</Tr>
		</Table>
		</Div>

		<%
			java.util.ArrayList dispColumns	= new ArrayList();
			java.util.ArrayList dispSizes  	= new java.util.ArrayList();
			java.util.ArrayList dispAlign  	= new java.util.ArrayList();
		
			dispSizes.add("'7%'");  dispAlign.add("left");
			dispSizes.add("'13%'");  dispAlign.add("left");
			dispSizes.add("'10%'");	 dispAlign.add("left");
			dispSizes.add("'7%'");	 dispAlign.add("right");
			dispSizes.add("'7%'");	 dispAlign.add("left");
			dispSizes.add("'5%'");	 dispAlign.add("left");
			dispSizes.add("'5%'");	 dispAlign.add("left");
			dispSizes.add("'3%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'3%'");	 dispAlign.add("left");
			dispSizes.add("'3%'");	 dispAlign.add("left");
			dispSizes.add("'3%'");	 dispAlign.add("left");
			dispSizes.add("'3%'");	 dispAlign.add("center");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
			dispSizes.add("'4%'");	 dispAlign.add("left");
		
		%>	  
		
		<%
			String divHeight="",divWidth="";
			
			
			if(dataObjCount==2)
				divWidth="80%";
			else
				divWidth="81.5%";
				
			if(dataObjCount>10)
				divHeight="50%";
			else
				divHeight= (dataObjCount*5)+"%";
		%>
		
		<Div id="div4" align="center" style="overflow:auto;position:absolute;left:9%;width:'<%=divWidth%>';height:'<%=divHeight%>';top:21%" onScroll="scrollValue()">
			<Table border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 align=center width="2035">
		
		<%
		       
		        String MatNo = "",matdesc="",manuFact="",listPrice="",imagePath="",status="",family="",upc="",type="",color="",size="",len="",width="",uom="",finish="",spec1="",spec2="",spec3="",spec4="";
			String tempItemStr ="";
			String tempCellVal ="";
			//String checkedTemp="";
						
			for (int i=1;i<dataObjCount;i++)
			{
				//checkedTemp="";
				MatNo 	   =  dataObj.getFieldValueString(i,"Product Code");
				matdesc    =  dataObj.getFieldValueString(i,"Product Description");
				manuFact   =  dataObj.getFieldValueString(i,"Manufacturer");
				listPrice  =  dataObj.getFieldValueString(i,"List Price");
				listPrice  =  listPrice.replaceAll(",",""); 
				imagePath  =  dataObj.getFieldValueString(i,"Image Path");
				status 	   =  dataObj.getFieldValueString(i,"Status");
				family 	   =  dataObj.getFieldValueString(i,"Family");
				upc 	   =  dataObj.getFieldValueString(i,"UPC");
				type 	   =  dataObj.getFieldValueString(i,"Type");
				color 	   =  dataObj.getFieldValueString(i,"Color");
				size 	   =  dataObj.getFieldValueString(i,"Size");
				len 	   =  dataObj.getFieldValueString(i,"Length");
				width 	   =  dataObj.getFieldValueString(i,"Width");
				uom 	   =  dataObj.getFieldValueString(i,"UOM");
				finish 	   =  dataObj.getFieldValueString(i,"Finish");
				spec1 	   =  dataObj.getFieldValueString(i,"Specification1");
				spec2 	   =  dataObj.getFieldValueString(i,"Specification2");
				spec3 	   =  dataObj.getFieldValueString(i,"Specification3");
				spec4 	   =  dataObj.getFieldValueString(i,"Specification4"); 
				
				if(matdesc!=null){
					matdesc = matdesc.replaceAll("'","`");
					/*if(matdesc.indexOf('`')!= -1){
						checkedTemp="checked";
					}else{
						checkedTemp="";
					}*/
				}

				tempItemStr = MatNo+"¥"+matdesc+"¥"+manuFact+"¥"+listPrice+"¥"+imagePath+"¥"+status+"¥"+family+"¥"+upc+"¥"+type+"¥"+color+"¥"+size+"¥"+len+"¥"+width+"¥"+uom+"¥"+finish+"¥"+spec1+"¥"+spec2+"¥"+spec3+"¥"+spec4;

		%>
		
			     <Tr> 
			     
			     <Td width="3%"  align="center"><input type="checkbox"  name="chk1" value='<%=tempItemStr%>'></Td>
		<%
				
				for(int k=0;k<dispSizes.size();k++)    
				{
				        tempCellVal = dataObj.getFieldValueString(i,k);
				        
				        if(tempCellVal==null || "null".equals(tempCellVal))
				        	tempCellVal="";
				        
					out.print("<Td  width=" + dispSizes.get(k) + " align=" + dispAlign.get(k) + ">&nbsp;" + tempCellVal + "</Td>");
				}
		%>
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
				<Th>Please upload valid file(size should be less than 3MB)</Th>	
<%
			}
%>

<%
			if(dataObjCount<2 && flag)
			{
%>
				<Th>No Data Found In Excel</Th>	
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

