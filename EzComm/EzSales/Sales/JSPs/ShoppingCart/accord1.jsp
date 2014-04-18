
<!doctype html>
<html class="no-js" lang="en">
	<head>
		<link rel="stylesheet" href="../../Library/Styles/accord.css" />

		<script>
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
						fileExt = fileExt.toLowerCase();
					
						if(!(fileExt == "xls"))
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
		</script>
	</head>
	<body>
	<form name=myForm ENCTYPE="multipart/form-data" method=post>

		<div class="accordion vertical">
		  <section id="vertabout">
		      <h2><a href="#vertabout">Sample Header</a></h2>

		      <input type="button" value="Download Sample Header" />

		  </section>
		  <section id="vertservices">
		      <h2><a href="#vertservices">Attach a File</a></h2>
		      <p>Please choose a file  <BR>

		       <input name="path" class=inputbox type="file" style="width:100%"></p>
		       
		       		        <a href="accord1.jsp#vertblog" onClick="funUpload()"> 
		        <input type="button" value='Review'></a>
		  </section>
		  <section id="vertblog">
		      <h2><a href="#vertblog">Review</a></h2>
		      <h2>Please Choose a File and Review</a></h2>
		  </section>
		  <section id="vertportfolio">
		      <h2><a href="#vertportfolio">Close</a></h2>
		     
		  </section>
		 
		</div>
	</form>
	</body>
</html>
