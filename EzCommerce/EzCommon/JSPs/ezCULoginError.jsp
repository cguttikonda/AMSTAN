<%@ page language="java" errorPage="../../EzSales/Sales2/JSPs/Misc/ezErrorDisplay.jsp"%>
<%@ include file="../../EzSales/Includes/JSPs/Misc/iBlockControl.jsp" %>

<html>
<head>
<title>Welcome to EzCommerce Suite</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../EzSales/Includes/Lib/ezAddButtonDir.jsp"%></head>
<script>
	function keySubmit()
	{
		if(event.keyCode == 13)
		{
				location.href='/CRI/ezCatUserLogin.jsp'
		}
}
</script>
</head>
<body>



<Div id='inputDiv' style='position:relative;align:center;top:10%;width:100%;height:100%'>
<Table width="60%" height="50%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr height=250px>
	<Td width="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr> 
		    <td align="center"><font face="Trebuchet MS" size="5" color="#990000"><u><font face="Rockwell">LOGON 
		      FAILED</font></u></font></td>
		  </tr>
		  <tr> 
		    <td>&nbsp;</td>
		  </tr>
		  <tr> 
		    <td align="center"><font face="Trebuchet MS" size="2" >Your logon attempt failed, due to one 
		      of the following reasons:<br>
		      </font></td>
		  </tr>
		  <tr> 
		    <td align="center"> 
		      <ul>
		        <li><font face="Trebuchet MS" size="2">Mistyped User ID or Password</font></li>
		      </ul>
		    </td>
		  </tr>
		  <tr> 
		    <td align="center"> 
		      <ul>
		        <li><font face="Trebuchet MS" size="2">User ID and Password are case sensitive</font></li>
		      </ul>
		    </td>
		  </tr>
		  <tr> 
		    <td align="center"> 
		      <ul>
		        <li><font face="Trebuchet MS" size="2">Your User ID is not registered .</font></li>
		      </ul>
		    </td>
		  </tr>
		  <tr> 
		    <td>&nbsp;</td>
		  </tr>
		  <tr> 
		    <td align="center"><font face="Trebuchet MS" size="2">Please RETRY</font></td>
		  </tr>
		  <tr> 
		    <td>&nbsp;</td>
		  </tr>
		  <tr> 
		    <td>&nbsp;</td>
		  </tr>
		</table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>













<Div id="MenuSol"></Div>
</body>
</html>
