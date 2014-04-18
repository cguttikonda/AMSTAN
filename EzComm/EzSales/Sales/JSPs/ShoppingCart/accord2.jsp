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
<style>
/* Data Table */
.data-table {
	width:100%;
}

.data-table th {
	padding:5px;
	border:1px solid #ddd;
	font-weight:bold;
	white-space:nowrap;
}

.data-table td {
	padding:5px;
	border:1px solid #ddd;
	font-size : 90%;
}

.data-table thead {
	background-color:#f2f2f2;
	font-size : 90%;
}

.data-table tbody {
}

.data-table tfoot {
}

.data-table tr.first {
}

.data-table tr.last {
}

.data-table tr.odd {
}

.data-table tr.even {
	background-color:#f6f6f6; 
}

.data-table tbody.odd {
}

.data-table tbody.odd td {
	border-width:0 1px;
}

.data-table tbody.even {
	background-color:#f6f6f6;
}

.data-table tbody.even td {
	border-width:0 1px;
}

.data-table tbody.odd tr.border td, .data-table tbody.even tr.border td {
	border-bottom-width:1px;
}

.data-table th .tax-flag {
	white-space:nowrap;
	font-weight:normal;
}

.data-table td.label, .data-table th.label {
	font-weight:bold;
	background-color:#f6f6f6;
}

.data-table td.value {
}
table#wishlist-table.data-table h2.product-name a { font-size: 14px !important; line-height: 18px !important; display: block; letter-spacing: 0; text-decoration:none !important; color:#202020 !important; }
table#wishlist-table.data-table h2.product-name a:hover { color:#5d87a1 !important; }
</style>
	
	<Script src="../../Library/JavaScript/Catalog/ezProcessFileByStatus.js"></Script>   
			<link rel="stylesheet" href="../../Library/Styles/accord.css" />

	<Script src="../../Library/JavaScript/Catalog/ezProcessFileByStatus.js"></Script>   
	<Script src="../../Library/Script/jquery-1.7.2.min.js"></Script>
	<script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
	<Script src="../../Library/Script/popup.js"></Script>
	
	 <!--Stylesheets-->
	 <link rel="stylesheet" type="text/css" href="../../Library/Script/jquery.qtip.css" />

	 <!--JavaScript - Might want to move these to the footer of the page to prevent blocking-->
	 <script type="text/javascript" src="../../Library/Script/jquery.qtip.js"></script>
	 
	<script type="text/javascript">
	$(document).ready( function()    
	{
	
	$('a[title]').qtip();
	
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
					document.myForm.action = "accord3.jsp#vertportfolio";
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
		if(count > 150)
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
			document.myForm.action = "accord3.jsp#vertportfolio";
			document.myForm.submit();
		
		}
		
	}
		
	function funDownloadFail()
	{
	   
	   document.myForm.action="ezDownLoadExcel.jsp"; 
	   document.myForm.target="_self";
	   document.myForm.submit();  
	  
	}
	function funDownload()
	{	

	   document.myForm.action="ezDownLoadExcelOut.jsp"; 
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
	
	<style>
		button, button.button, p.back-link, .buttons-set .back-link, .pager ol li, .back-to-top .to-top, a.button, button.restock-addtocart { border: none; border-radius: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; height: 30px; color: #fff  background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
		background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
		button:hover, button.button:hover, button:active, button.button:active, button.button.button:active, p.back-link:hover, .buttons-set .back-link:hover, p.back-link:active, .buttons-set .back-link:active, .pager ol li:hover, .pager ol li:active, .back-to-top:hover .to-top, .back-to-top:active .to-top, a.button:hover, a.button:active { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; border: none !important; box-shadow: 0 0 0 #000; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; }


	</style>
	
</head>

<Body> 
<form name=myForm method=post>

	<div class="accordion vertical">
	  <section id="vertabout">
	      <h2><a href="#vertabout">1: Download Template</a></h2>

	      <a href="#vertservices" onClick="funDownload()"> 
		<button type="button" class='button' value='Sample Header'><span><font color=white>Download Template</font> </span></button></a>

	  </section>
	  <section id="vertservices">
	      <h2><a href="accord.jsp#vertservices">2: Choose File to Upload</a></h2>

		<input name="path" class=inputbox type="file" style="width:100%"></p>
		<br><br>


		<button type="button" class='button' value='Review' onClick="funUpload()"><span><font color=white>Review</font> </span></button></a>

	  </section>
	  <section id="vertblog">
	      <h2><a href="#vertblog">3: Review Info and Save to Cart</a></h2>
				      
		<%if(dataObjCount>1)
		{
		%>
			<h2 style="margin-bottom:0">Choose Items from your <font color=green><%=filename%></font> file and Save to Cart.</h2> 	
		<%}
		else if(dataObjCount<2 && flag)
		{%>

		<br>
			<h2>No Data Found In Uploaded Excel</h2> 	
		<%}%>
			     
				      
		<%if(dataObjCount>1)
		{%>
		<div style="overflow:auto;height:55%">
		<table class="data-table"  style="width:100%;!important;overflow:visible;">
		<thead >
		<tr>
			<Td width="3%"   align="center"><input type="checkbox" name="chk" value='' onClick="checkAll()" checked></td>				

			<td width="15%"  align="left">Product Code</td>
			<td width="5%"  align="left">Quantity</td>
			<td width="10%"   align="left">My PO Line</td>         
			<td width="10%"   align="left">My SKU</td>
			<td width="10%"   align="left">Job Quote</td>
			<td width="10%"   align="left">Job Quote Line</td>
		</tr>
		</thead>

		<tbody >		
<%

		String MatNo = "",qty="",desiredDate="",programType="",myPO="",mySKU="",quoteNo="",quoteLine="";
		String tempItemStr ="";
		String tempCellVal ="";
		String [] retCols={"EFCTV_DATE"};
		ReturnObjFromRetrieve dataObj_new = new ReturnObjFromRetrieve(retCols);


		for (int i=1;i<dataObjCount;i++)
		{
			MatNo 	     =  nullCheck(dataObj.getFieldValueString(i,"Product Code"));
			MatNo = MatNo.trim();
			if("".equals(MatNo))
				continue;
			qty  	     =  eliminateDecimals(nullCheck(dataObj.getFieldValueString(i,"Quantity")));				
			myPO  	     =  nullCheck(dataObj.getFieldValueString(i,"My PO Line"));
			mySKU  	     =  nullCheck(dataObj.getFieldValueString(i,"My SKU"));
			quoteNo      =  nullCheck(dataObj.getFieldValueString(i,"Job Quote"));
			quoteLine    =  nullCheck(dataObj.getFieldValueString(i,"Job Quote Line"));
			
			dataObj_new.setFieldValue("EFCTV_DATE",desiredDate);
			dataObj_new.addRow();
			
			if("N/A".equals(quoteLine) && !"N/A".equals(quoteNo))
			{
				quoteNo = "N/A";			
			}
			
			if("N/A".equals(quoteNo) && !"N/A".equals(quoteLine))
			{
				quoteLine = "N/A";			
			}
			
			if("N/A".equals(qty))
				qty = "0";
			
			
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


			<td width="3%"  align="center"><input type="checkbox" name="chk1" value='<%=tempItemStr%>' checked></td>					
			<td width=20%> <%=MatNo%></td>
			<td width=5% align=center> <%=qty%></td>
			
			<td width=10%><%=myPO%>&nbsp;</td>	
			<td width=10%> <%=mySKU%>&nbsp;</td>
			<td width=10%><%=quoteNo%>&nbsp;</td>
			<td width=10%><%=quoteLine%>&nbsp;</td>

			</Tr>       			    
<%
		}

		if(dataObj_new!=null){
		//dataObjCount = dataObj.getRowCount();
		dataObj_new.sort(new String[]{"EFCTV_DATE"},true);
		}

%>

		
		</tbody>
		</table>
		</div>
		
		<div style="position:relative;">
			
			
			
		<% 	if(errObjCount>0 && flag)
			{
		%>
				<button type="button" class='button' value='Failed Items' onClick="funDownloadFail()"><span><font color=white>Failed Items</font> </span></button></a>
		<%
			}
			if(flag && dataObjCount>1)  
			{
		%>							
				<button type="button" class='button' value='Save to Cart' onClick="selectMat()"><span><font color=white>Save to Cart</font> </span></button></a>
		<%	}
			
		%>
			

		</div>
		<%
		}%>
		
		<div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
				       					       				
			<img src="../../Library/images/loading.gif" width="80" height="80" alt="">
			<br><br>
			<font size=2><B>Your request is being processed. Please wait...</B></font>
				       			
		</div>
		<div style="display:none;">
		<div id="dialog-save" title="Select Products">
			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select atleast one product to save.</p>
		</div> 
		<div id="dialog-products" title="Select Products">
			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please select not more than 150 products.</p>
		</div> 
		<div id="dialog-confirm" title="Confirm Products">
			<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Some of products has errors in the uploaded file.<br>Do you want to continue with remaining data ?</p>
		</div>
		</div>
						      
				      
	  </section>
	  <section id="vertportfolio">
	      <h2><a href="#vertportfolio">4: Close Upload Wizard </a></h2>
	      <h2>Review the file and Save to Cart</a></h2>

	  </section>
				 
	</div>

</Form>
</Body>



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

