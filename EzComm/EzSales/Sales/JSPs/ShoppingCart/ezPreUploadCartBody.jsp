
<Script src="../../Library/Script/jquery-1.7.2.min.js"></Script>
 <script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
 <link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
 <Script src="../../Library/Script/popup.js"></Script>
 
<script type="text/javascript">
$(document).ready( function()    
{		

$(function() {
 	
 	$( "#dialog-attach" ).dialog({
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
	
	$( "#dialog-browse" ).dialog({
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
	
}); // end of function()


} );

function funUpload()
{

	
	var path = document.myForm.path.value;	
	
	if(path=="")
	{
		//alert("Please Enter or Browse file to Attach.");
		$( "#dialog-browse" ).dialog('open');   
		return false;
	}
	else
	{
		
		var dotPos 	= path.lastIndexOf('.');
		var fileExt	= path.substring(dotPos+1,path.length);

		if(!(fileExt == "xls" || fileExt == "xlsx"))
		{
			//alert("Please attach only file of type Excel.");
			$( "#dialog-attach" ).dialog('open');   
			return;
		}
		
		Popup.showModal('modal');
		
		document.myForm.action="ezProcessFileByStatus.jsp"; 
		document.myForm.submit();
	}
}

function funDownload()
{								      
   document.myForm.action="ezDownLoadExcelOut.jsp"; 
   document.myForm.target="_self";
   document.myForm.submit();       
}
</Script>

<Body>
<div class="main-container col2-layout middle account-pages">
<div class="main" >
<div class="col-main1" style='width:743px;height:250px;'>
<div class="page-title">

<h2>Excel Upload to Cart</h2>


<br>

<Form name="myForm" ENCTYPE="multipart/form-data" method="post">
<div id="modal" style="border:0px solid black; background-color:white; padding:1px; font-size:10;width:40%;height:180px; text-align:center; display:none;">
	<ul>
		<li>&nbsp;</li>
		<li><img src="../../Library/images/loading.gif" width="100" height="100" alt=""></li>
		<li><font size=2><B>Your request is being processed. Please wait...</B></font></li>
	</ul>
</div>
<div style="display:none;">
<div id="dialog-attach" title="Attach File">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please attach only Excel files.</p>
</div> 
<div id="dialog-browse" title="Browse File">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please Browse a file to Attach.</p>
</div> 
</div>

<div id="attachment">
<ul class="form-list">

<table>

<tr>
<td>
	<h3>1.&nbsp;</h3>
</td>	
<td>
	<h3>Download Sample Template Header.</h3>
</td>	

<td>
	<input type="button" onClick="funDownload()" value="Sample Template"><Br><Br><Br>	
</td>
</tr>
<tr>
<td>
	<h3>2.&nbsp;</h3>
</td>	
<td>
	<h3>Choose an Excel File to Upload to Cart.&nbsp;&nbsp;&nbsp;</h3>
</td>	
<td>	
	<input name="path" class=inputbox type="file" style="width:100%"><Br><Br><Br>
</td>
</tr>
<tr>
<td>
	<h3>3.&nbsp;</h3>
</td>	
<td>
	<h3>Review the Items from Excel File.</h3>
</td>	
<td>	
	<input type="button" onClick="funUpload()" value='Review'><Br><Br><Br><Br>
	
</td>	
</tr>

</table>
	
</ul>
</div>

	
</div>

</Form>
</Body>
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->
