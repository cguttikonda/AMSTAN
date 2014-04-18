<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<html>
<head>
<Title>Untitled Document</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name=myForm method=post action="">

<% String sysNo = request.getParameter("SystemNumber");
  String grpId=request.getParameter("GrpId");	

%>
  <input type="hidden" name="SystNumber" value="<%=sysNo%>">
  <input type="hidden" name="GroupId" value="<%=grpId%>">	
</form>

<script language="JavaScript">
var sys = document.myForm.SystNumber.value;
var grp =document.myForm.GroupId.value;
alert("Connection Succesful for System: "+ sys );
	location.href="../CParam/ezUpdateConnectParam.jsp?SystemNumber=" + sys + "&GrpId=" + grp;
</script>
</body>
</html>
