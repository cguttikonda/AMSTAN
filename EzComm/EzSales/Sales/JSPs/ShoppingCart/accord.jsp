
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<link rel="stylesheet" href="../../Library/Styles/accord.css" />
		<Script src="../../Library/Script/jquery-1.7.2.min.js"></Script>
		 <script type="text/javascript" src="../../Library/Script/TimeOut/jquery-ui-1.8.23.custom.min.js"></script>
		 <link rel="stylesheet" type="text/css" href="../../Library/Styles/jquery-ui-1.8.23.custom.css">
		 <Script src="../../Library/Script/popup.js"></Script>
		 
		 <!--Stylesheets-->
		 <link rel="stylesheet" type="text/css" href="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.min.css" />
		 
		 <!--JavaScript - Might want to move these to the footer of the page to prevent blocking-->
		 <script type="text/javascript" src="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.min.js"></script>
		 
		 <script type="text/javascript">
		 $(document).ready(function()
		 {
		 	
		 	$('a[title]').qtip();
			
		
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
		function fileClick()
		{
		var path = document.myForm.path.value;
					
			if(path!="")
			{

				//alert("hii")
				return false;
			}
		
		
		}

		function funUpload()
		{
		
			
			var path = document.myForm.path.value;
			
			if(path=="")
			{
				
				$( "#dialog-browse" ).dialog('open');   
				return false;
			}
			else
			{
				
				var dotPos 	= path.lastIndexOf('.');
				var fileExt	= path.substring(dotPos+1,path.length);
				fileExt	= fileExt.toLowerCase();
		
				if(!(fileExt == "xls"))// || fileExt == "xlsx"))
				{
					
					$( "#dialog-attach" ).dialog('open');   
					return;
				}
				
				Popup.showModal('modal');
				
				document.myForm.action="accord2.jsp#vertblog"; 
				document.myForm.submit();
			}
		}
		function funDownload()
		{	
		   
		   document.myForm.action="ezDownLoadExcelOut.jsp"; 
		   document.myForm.target="_self";
		   document.myForm.submit(); 
		}
		</script>
		
		<style>
		button, button.button, p.back-link, .buttons-set .back-link, .pager ol li, .back-to-top .to-top, a.button, button.restock-addtocart { border: none; border-radius: 0; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; box-shadow: 0 0 0 #000; height: 30px; color: #fff  background: #6b6e6e;  background: -moz-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #6b6e6e), color-stop(100%, #5b5e5e)); background: -webkit-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  background: -o-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); background: -ms-linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6b6e6e', endColorstr='#5b5e5e', GradientType=0 );
		background: linear-gradient(top, #6b6e6e 0%, #5b5e5e 100%); float:left; font-weight: 400; line-height: 30px; text-shadow: 0px 1px 1px #202020; -moz-text-shadow: 0px 1px 1px #202020; -webkit-text-shadow: 0px 1px 1px #202020; text-transform: uppercase; text-align: center; padding: 0 15px; font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; }
		button:hover, button.button:hover, button:active, button.button:active, button.button.button:active, p.back-link:hover, .buttons-set .back-link:hover, p.back-link:active, .buttons-set .back-link:active, .pager ol li:hover, .pager ol li:active, .back-to-top:hover .to-top, .back-to-top:active .to-top, a.button:hover, a.button:active { background: #5b5e5e;  background: -moz-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #5b5e5e), color-stop(100%, #6b6e6e)); background: -webkit-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -o-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); background: -ms-linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%);  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5b5e5e', endColorstr='#6b6e6e', GradientType=0 ); background: linear-gradient(top, #5b5e5e 0%, #6b6e6e 100%); font-family: proxima-nova, "Helvetica Neue", Arial, Helvetica, Geneva, sans-serif; border: none !important; box-shadow: 0 0 0 #000; -moz-box-shadow: 0 0 0 #000; -webkit-box-shadow: 0 0 0 #000; }
		
		
		</style>
	</head>
	<body>
	<form name=myForm ENCTYPE="multipart/form-data" method=post>

		<div class="accordion vertical">
		  <section id="vertabout">
		      <h2><a href="#vertabout">1: Download Template</a></h2>

		      <a href="#vertservices" onClick="funDownload()" title="Download the Sample Template which contains the header."> 
		        <button type="button" class='button' value='Sample Header'><span><font color=white>Download Template</font> </span></button></a>

		  </section>
		  <section id="vertservices">
		      <h2><a href="#vertservices">2: Choose File to Upload</a></h2>
		      <p>Please choose a file (Upload upto <b>150</b> products). <font color=red><strong>UPLOAD .xls files only</strong></font>
		      <input name="path" type="file" style="width:100%"></p>  
		       
			<br><br>
		        
		       <button type="button" class='button' value='Review' onClick="funUpload()"><span><font color=white>Review</font> </span></button></a>
		        
		       <div id="modal" style="z-index:100;position:absolute;left:280px; top:140px; border:1px solid #EEEDE7; border-radius:7px; background-color:#ffffff; padding:1px; font-size:10;width:330px;height:150px; text-align:center; display:none;">
		       					       				
				<img src="../../Library/images/loading.gif" width="80" height="80" alt="">
				<br><br>
				<font size=2><B>Your request is being processed. Please wait...</B></font>
		       			
			</div>
			<div style="display:none;">
			<div id="dialog-attach" title="Attach File">
				<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please attach only Excel files with .xls extension.</p>
			</div> 
			<div id="dialog-browse" title="Browse File">
				<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;display:none;"></span>Please Browse a file to Attach.</p>
			</div> 
			</div>
		  </section>
		  <section id="vertblog">
		      <h2><a href="#vertblog">3: Review Info and Save to Cart</a></h2>
		      
		      <h2>Choose a File and Review</a></h2>
		      
		  </section>
		  <section id="vertportfolio">
		      <h2><a href="#vertportfolio">4: Close Upload Wizard</a></h2>
		      
		      <h2>Review the file and Save to Cart</a></h2>
		      
		  </section>
		 
		</div>
	</form>
	</body>
</html>
