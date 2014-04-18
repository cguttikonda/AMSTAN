
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
* {
	margin:0;
	padding:0;
	list-style:none;
}

#basic-accordian{
	
	padding:5px;
	width:750px;
	height:600px;
	position:absolute;
	
	
}

.accordion_headings{
	padding:5px;
	background:#99CC00;
	color:#FFFFFF;
	border:1px solid #FFF;
	cursor:pointer;
	font-weight:bold;
}

.accordion_headings:hover{
	background:#00CCFF;
}

.accordion_child{
	padding:15px;
	background:#EEE;
}

.header_highlight{
	background:#00CCFF;
}

</style>
<script type="text/javascript" src="../../Library/Script/accordian.pack.js"></script>
</head>
<body onload="new Accordian(&#39;basic-accordian&#39;,5,&#39;header_highlight&#39;);">
<form name=myForm>


<div id="basic-accordian"><!--Parent of the Accordion-->


<div style="width:125px; float:left; margin-right:5px;">
  <div id="test1-header" class="accordion_headings header_highlight">Home</div>
  <div id="test2-header" class="accordion_headings">REVIEW</div>
  <div id="test3-header" class="accordion_headings">UPLOAD</div>
   <div id="test4-header" class="accordion_headings">DOWNLOAD</div>
</div>

<div style="width:770px;">
  <div id="test1-content" style="overflow:auto !important;height:250px;">
	<div class="accordion_child">
    	<%@ include file="ezPreUploadCartBody.jsp"%>
    	
    	
    </div>
  </div>

  <div id="test2-content" style="overflow:auto;">
	<div class="accordion_child">
    	<%//@ include file="ezProcessFileByStatusBody.jsp"%>
    </div>
  </div>

  <div id="test3-content" style="overflow:auto;">
	<div class="accordion_child">
    	<%//@ include file="ezSaveProductByStatusBody.jsp"%>
    </div>
  </div>
   <div id="test4-content" style="overflow:auto;">
  	<div class="accordion_child">
      	and... this is the download section<br><br>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc sapien nibh, ultrices vitae, convallis eu, semper ut, leo. Cras nec pede.
      </div>
  </div>
</div>



</div><!--End of accordion parent-->






</form>
</body></html>