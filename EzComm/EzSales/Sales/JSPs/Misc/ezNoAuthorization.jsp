<!DOCTYPE html>
 <html lang="en">
 <head>
 
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Authorization Error</title>
</head> 

<body class=" customer-account-index">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1 roundedCorners">
<div class="page-title">
<% String authKey = (String) request.getAttribute("authKey");
	if (authKey == null){
		authKey = "";
	}
%>
<h2> Authorization Check Failed </h2>
<p> You are not authorized to view requested information. <br>
Please contact your ASB Administrator or ASB Customer Service if you believe you have received this in error.
<br> <strong>Information for Administrator : Auth Key Code checked </strong><%=authKey%></p>
<br>
<div id="divAction" style="display:block">
	<button type="button" title="Back" class="button btn-update" onclick="javascript:history.go(-1)"><span>Back</span></button>
</div>
</div>
</div>
</div>
</div>
</body>
</html>