<html>
<title>User blocked </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../EzSales/Includes/Lib/ezAddButtonDir.jsp"%></head>

<body bgcolor="#FFFFF7" onContextMenu='return false;' scroll=no>
<form name="myForm">
<br><br><br><br><br><br><br>
<table align = 'center' width="80%"  border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td align="center"><font face="Trebuchet MS" size="5" color="#990000"><font face="Rockwell">Your User Id has been blocked, please contact your administrator</font></font></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>

  </table>
      <div id="ButtonDiv"  style="position:absolute;left:0%;width:100%;top:40%">
      <center>
<%  
 	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Close");
	buttonMethod.add("window.close()");	
	out.println(getButtonStr(buttonName,buttonMethod));
%>  
</Center>
</Div>
</form>
</body>
</html>

