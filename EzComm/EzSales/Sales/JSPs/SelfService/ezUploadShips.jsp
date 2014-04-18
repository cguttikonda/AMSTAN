<html>
<head>

<title>Attachments</title>
<%@ include file="../../../Includes/Lib/ezCommonHead.jsp"%>
<script src="../../Library/JavaScript/Misc/Trim.js"></script>
<script>
function uploadShips()
{
	var path 	= document.myForm.shiptoUpload.value;
	var dotPos 	= path.lastIndexOf('.');
	var fileExt	= path.substring(dotPos+1,path.length);
	if((fileExt == ""))
	{
		alert("Please attach a file ");
		return;
	}
	if(!(fileExt == "xls")||!(fileExt.toUpperCase()=="XLS"))
	{
		alert("Please attach only file of type Excel");
		return;
	}
	document.myForm.action="ezReadXLSProcess.jsp";
	document.myForm.target="_self";
	document.myForm.submit();
	//parent.$.fancybox.close();
}
function downloadShips()
{
	document.myForm.action="ezWriteXLS.jsp";
	document.myForm.target="_self";
	document.myForm.submit();
	//parent.$.fancybox.close();
}
</script>
</head>
<body scroll=no>
<Form name="myForm" ENCTYPE="multipart/form-data" method="POST" >
<div class="page">
<div id="attachment">
<ul class="form-list">
	<li><h2>1. Download existed ship codes.</h2></li>
	<li>
		<input type="button" name="done" value="Download" onClick="downloadShips()" style="width:20%">
	</li>
	<li><h2>2. Choose a file to attach.</h2></li>
	<li align="center">	
		<input type=file value="" name="shiptoUpload" style="width:100%"><br><br>
	</li>
	<li><h2>3. Upload File.</h2></li>
	<li>
		<input type="button" name="done" value="Upload" onClick="uploadShips()" style="width:20%">
	</li>
	<br>
	<br>
	<br>
</ul>
</div>
</div>
</form>
</body>
</html>
