<%@ include file="../../../Includes/JSPs/ShoppingCart/iProcessFileByStatus.jsp" %> 

<%@ page import="ezc.ezutil.*" %>
<%@ page import="ezc.shopping.cart.params.*" %>
<%@ page import="ezc.shopping.cart.client.*" %>
<%@ page import="ezc.shopping.cart.common.*" %>
<%	

	EzShoppingCartManager SCManager = new EzShoppingCartManager(Session);

	EzcShoppingCartParams params 	= new EzcShoppingCartParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	EzShoppingCart Cart = null;
	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);

	try
	{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}
	catch(Exception err){}
	
	int cartRows = 0;
	String catType_C = "";

	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();
		catType_C = Cart.getType(0);
	}
	
	//out.println("catType_C:::"+catType_C);
%>

<head>
	
	<Script src="../../Library/JavaScript/Catalog/ezProcessFileByStatus.js"></Script>   
	<Script src="../../Library/Script/jquery-1.7.2.min.js"></Script>
	<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
	<Script src="../../Library/Script/popup.js"></Script>
	 
	<script type="text/javascript">
	$(document).ready( function()    
	{		
	
	$(function() {
	 	
	 	$( "#dialog-save" ).dialog({
			autoOpen: false,
			resizable: true,
			height:150,
			width:400,
			modal: true,
			buttons: {
				"Ok": function() {
					$( this ).dialog( "close" ); 
				}
			}
		});
		
		$( "#dialog-products" ).dialog({
				autoOpen: false,
				resizable: true,
				height:150,
				width:400,
				modal: true,
				buttons: {
					"Ok": function() {
						$( this ).dialog( "close" ); 
					}
				}
		});
		
		$( "#dialog-confirm" ).dialog({
				autoOpen: false,
				resizable: true,
				height:150,
				width:400,
				modal: true,
				buttons: {
					"Ok": function() {
					$( this ).dialog( "close" );

					Popup.showModal('modal');
					document.myForm.action = "ezSaveProductByStatus.jsp";
					document.myForm.submit();

					},
					"Cancel": function() {
					$( this ).dialog( "close" );
					}
				}
		});


			
		
	}); // end of function()
	
	
	} );
	
	
	function selectMat()
	{
		var errCount ='<%=errObjCount%>'
		var cartType ='<%=catType_C%>'
		var y=false;
		
		var chkObj 	= document.myForm.chk1;
		var chkLen	= chkObj.length;
		var chkValue	= "";
		var count	= 0;
		
	       
		if(!isNaN(chkLen))
		{	
		
			var dv='N';
			var qs='N';
			var bool=true;
			for(i=0;i<chkLen;i++)
			{
				if(chkObj[i].checked)
				{
					count++;
					
					var uploadChk = chkObj[i].value
					
					pt = uploadChk.split('¥')[3]

					if(pt=='Disp' || pt=='VIP')
						dv='Y';
					else if(pt=='QS')
						qs='Y';					
									
				}
			}
			
			if(dv=='Y' && qs=='Y')
			{
				alert("Quick Ship and Display/Vip Items cannot be in same order.\nPlease remove the either or and continue.");
				return;
			}
			
			if(dv=='Y' && qs=='N' && cartType=='QS')
			{
				alert("Cart Items are related to Quick Ship. Please add only Quick Ship Items.");
				return;
			}
			if(qs=='Y' && dv=='N' && cartType=='PT')
			{
				alert("Cart Items are related to Display/VIP. Please add only Display/VIP Items.");
				return;
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
			//alert("Please select atleast one product to save");
			$( "#dialog-save" ).dialog('open'); 
			return;
		}
		if(count > 50)
		{
			//alert("Please select not more than 50 products");
			$( "#dialog-products" ).dialog('open'); 
			return;
		}
		
	        if(errCount>0)
	        {
		   
		  // y=confirm("Some of products has errors in the uploaded file.\nDo you want to continue with remaining data ?")
		   $( "#dialog-confirm" ).dialog('open'); 
		}
		else
		{
			Popup.showModal('modal');
			document.myForm.action = "ezSaveProductByStatus.jsp";
			document.myForm.submit();
		
		}
		
	}
		
	function funDownload()
	{
	   
	   document.myForm.action="ezDownLoadExcel.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();  
	  
	}
	function backPre()
	{								      
	   document.myForm.action="ezPreUploadCart.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();       
	}
	
	
	</Script>
	
</head>

<Body> 
<div class="col-main1" style='width:750px;height:400px;'>
<div class="page-title">
<form name=myForm ENCTYPE="multipart/form-data" method=post>
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div style="display:none;">
<div id="dialog-save" title="Select Products">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select atleast one product to save.</p>
</div> 
<div id="dialog-products" title="Select Products">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select not more than 50 products.</p>
</div> 
<div id="dialog-confirm" title="Confirm Products">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Some of products has errors in the uploaded file.<br>Do you want to continue with remaining data ?</p>
</div>
</div>
<%if(dataObjCount>1)
{
%>
	<h2>Choose Items from your <font color=green><%=filename%></font> file and Save to Cart.</h2> 	
<%}
else if(dataObjCount<2 && flag)
{%>

<br><br><br><br>
	<h2>No Data Found In Uploaded Excel</h2> 	
<%}%>
</div>
	<div style="position:relative;">
	<ul class="checkout-types">
	<li>
	
<% 	if(errObjCount>0 && flag)
	{
%>
		<input type="button" onClick="funDownload()" value="Failed Items">
<%
	}
	if(flag && dataObjCount>1)  
	{
%>							
		<input type="button" onClick="selectMat()" value="Save to Cart">
		<input type="button" onClick="backPre()" value="Back">						
<%	}
	else
	{
%>					
		<input type="button" onClick="backPre()" value="Back">		
<%	}
%>
	</li>
	</ul>	
	</div>	


<%

	session.setMaxInactiveInterval(-1); 
	
	if(flag && dataObjCount>1)  
	{	       
%>
		<Br>
		<div style="overflow:auto;height:272px">
		<table class="data-table" style="width:100%;!important;overflow:visible;">
		<thead>
		<tr>
			<Td width="3%"   align="center"><input type="checkbox" name="chk" value='' onClick="checkAll()" checked></td>				

			<td width="15%"  align="left">Product Code</td>
			<td width="5%"  align="left">Quantity</td>
			<!--<td width="10%"  align="left">Desired Date</td>
			<td width="7%"   align="right">Program Type</td>-->  
			<td width="10%"   align="left">My PO Line</td>         
			<td width="10%"   align="left">My SKU</td>
			<td width="10%"   align="left">Quote No</td>
			<td width="10%"   align="left">Quote Line</td>
		</tr>
		</thead>

		<tbody>		
<%

		String MatNo = "",qty="",desiredDate="",programType="",myPO="",mySKU="",quoteNo="",quoteLine="";
		String tempItemStr ="";
		String tempCellVal ="";
		String [] retCols={"EFCTV_DATE"};
		ReturnObjFromRetrieve dataObj_new = new ReturnObjFromRetrieve(retCols);


		for (int i=1;i<dataObjCount;i++)
		{
			MatNo 	     =  nullCheck(dataObj.getFieldValueString(i,"Product Code"));
			if("".equals(MatNo))
				continue;
			qty  	     =  eliminateDecimals(nullCheck(dataObj.getFieldValueString(i,"Quantity")));				
			//desiredDate  =  nullCheckDate(dataObj.getFieldValueString(i,"Desired Date"));				
			//programType  =  nullCheck(dataObj.getFieldValueString(i,"Program Type"));
			myPO  	     =  nullCheck(dataObj.getFieldValueString(i,"My PO Line"));
			mySKU  	     =  nullCheck(dataObj.getFieldValueString(i,"My SKU"));
			quoteNo      =  nullCheck(dataObj.getFieldValueString(i,"Quote No"));
			quoteLine    =  nullCheck(dataObj.getFieldValueString(i,"Quote Line"));
			
			dataObj_new.setFieldValue("EFCTV_DATE",desiredDate);
			dataObj_new.addRow();
			
			
			
			//tempItemStr = MatNo+"¥"+qty+"¥"+desiredDate+"¥"+programType+"¥"+myPO+"¥"+mySKU;
			tempItemStr = MatNo+"¥"+qty+"¥"+myPO+"¥"+mySKU+"¥"+quoteNo+"¥"+quoteLine;
			//out.println("tempItemStr:::"+tempItemStr);
			desiredDate  =  nullCheck(dataObj.getFieldValueString(i,"Desired Date"));
			
			if(myPO.equals("N/A"))  myPO = "";
			if(mySKU.equals("N/A")) mySKU= "";
			if(quoteNo.equals("N/A")) quoteNo= "";
			if(quoteLine.equals("N/A")) quoteLine= "";
%>		
			<Tr> 

			<!--<td width="3%"  align="center"><input type="checkbox" name="chk1" id="chk1" value='<%=tempItemStr%>'></td>					
			<td width=15%> <input type="text" name="updmat_<%=i%>" class="input-text" value='<%=MatNo%>' /></td>
			<td width=5%> <input  size=5 type="text" name="updqty_<%=i%>" class="input-text" value='<%=qty%>' /> </td>
			<td width=10%> <input size=8 type="text" name="upddesdate_<%=i%>" class="input-text" value='<%=desiredDate%>' /> </td>
			<td width=7%> <input  size=8 type="text" name="updptype_<%=i%>" class="input-text" value='<%=programType%>' /> </td>
			<td width=10%> <input type="text" name="updmypo_<%=i%>" class="input-text" value='<%=myPO%>' /> </td>	
			<td width=10%> <input type="text" name="updmysku_<%=i%>" class="input-text" value='<%=mySKU%>' /> </td>-->

			<td width="3%"  align="center"><input type="checkbox" name="chk1" value='<%=tempItemStr%>' checked></td>					
			<td width=20%> <%=MatNo%></td>
			<td width=5% align=center> <%=qty%></td>
			<!--<td width=10%> <%=desiredDate%></td>
			<td width=7%> <%=programType%></td>-->
			<td width=10%><%=myPO%></td>	
			<td width=10%> <%=mySKU%></td>
			<td width=10%><%=quoteNo%></td>
			<td width=10%><%=quoteLine%></td>

			</Tr>       			    
<%
		}

		if(dataObj_new!=null){
		//dataObjCount = dataObj.getRowCount();
		dataObj_new.sort(new String[]{"EFCTV_DATE"},true);
		}

		//out.println("dataObj_new::"+dataObj_new.toEzcString());
%>

		<!--<tr>
		<td colspan=7>
				
			</td>
		</tr>-->
		</tbody>
		</table>
		</div>
		<br>
		
		<div style="position:relative;">
						<ul class="checkout-types">
						<li>
						
					<% 	if(errObjCount>0 && flag)
						{
					%>
							<input type="button" onClick="funDownload()" value="Failed Items">
					<%
						}
						if(flag && dataObjCount>1)  
						{
					%>							
							<input type="button" onClick="selectMat()" value="Save to Cart">
							<input type="button" onClick="backPre()" value="Back">						
					<%	}
						else
						{
					%>					
							<input type="button" onClick="backPre()" value="Back">		
					<%	}
					%>
						</li>
						</ul>	
			</div>
	
<%
	}
	else 
	{

			if(!flag)           
			{
%>
				<br><br><br><h3>Please upload valid file(size should be less than 3MB)</h3>
<%
			} 
%>

<%
			

	}       
%>

			

</Form>
</Body>
</div> <!-- col-main -->


<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";

		return ret;
	}
	public String nullCheckDate(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "N/A";

		return ret;
	}
	
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
%>

