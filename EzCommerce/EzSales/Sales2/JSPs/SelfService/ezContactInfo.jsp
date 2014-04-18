
<%@ include file="../../../Includes/JSPs/Lables/iContactInfo_Lables.jsp" %>

<html>
<head>
	<title><%=contactInfo_L%></title>
	
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script>
	function gotoHome()
	{
		document.location.href="../Misc/ezWelcome.jsp";
	}
	</script>
</head>
<body scroll=no>
<form name="sbuForm">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheader" align=center width="100%"><%=contactInfo_L%></td>
</tr>
</table>
<table align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0  width="90%">
<tr>
	<th valign="top" colspan =3 class="mainheadline">Locations</th>
</tr>
<tr>

<td valign="top">


	<table border="0" cellpadding="0" cellspacing="0" width="100%"  valign="top">
	<tr>
	<th valign="top" class="headline_orange" colspan="2">United States</th>
	</tr>
	<tr>
	<td valign="top" width="200" class="bodycopy">
	<b>Atlanta</b><br>
	1117 Perimeter Center West<br>
	Suite N-500<br>
	Atlanta, GA 30338-5451<br>
	(770) 225-3600 <i>Main</i><br>
	(770) 225-3650 <i>Fax</i><br>

	<br>

	<b>Miami</b><br>
	1001 Brickell Bay Drive<br>
	Suite 3000<br>
	Miami, Florida 33131<br>
	(305) 375-8005 <i>Main</i><br>
	(305) 379-8810 <i>Fax</i><br>

	</td>


	<td valign="top" width="200" class="bodycopy">
	<b>New York</b><br>
	One Penn Plaza<br>
	36th Floor<br>
	New York, NY 10119<br>
	(212) 896-3870 <i>Main</i><br>
	(212) 896-3871 <i>Fax</i><br>

	<br>

	<b>Philadelphia</b><br>
	225 Washington Street<br>
	Conshohocken, PA 19428<br>
	(610) 234-5500 <i>Main</i><br>
	(610) 234-5550 <i>Fax</i><br>
	<br>
	</td>
	</tr>
	</table>
</td>	
<td align=center  valign="top">

	<table border="0" cellpadding="0" cellspacing="0" width="100%"  valign="top">
	<tr>
	<th valign="top" class="headline_orange" colspan="2">Europe</th>
	</tr>
	<tr>
	<td valign="top" width="200" class="bodycopy">
	<b>London, United Kingdom</b><br>
	Aldermary House, 3rd Floor Rear<br>
	10-15 Queen Street<br>
	London EC4N 1TX<br>
	44-207-003-8150 <i>Main</i><br>
	44-207-003-8151 <i>Fax</i><br>
	</td>
	<td valign="top" width="200" class="bodycopy">
	<b>Frankfurt, Germany</b><br>
	Rathausplatz 12-14<br>
	D-65760 Eschborn, Germany<br>
	+49 (6196) 77726-0 <i>Main</i><br>
	+49 (6196) 77726-10 <i>Fax</i><br>
	</td>
	</tr>
	</table>
</td>	
<td align=center  valign="top">
	<table border="0" cellpadding="0" cellspacing="0" width="100%"  valign="top">
	<tr>
	<th valign="top">Asia</th>
	</tr>
	
	<tr>
	<td valign="top" width="200" class="bodycopy">
	<b>Hyderabad, India</b><br>
	8-2-120/112/88&89<br>
	1st Floor, Aparna Crest<br>
	Road # 2, Banjara Hills<br>
	Hyderabad 500034, India<br>
	+91 40  23551432 <i>Main</i><br>
	+91 40  23551433 <i>Fax</i><br>
	</td>
	</tr>
	</table> 
</td>
</tr>
</table>

<br><br><center>
<%	
 	 	buttonName = new java.util.ArrayList();
 	 	buttonMethod = new java.util.ArrayList();
 	 	buttonName.add("Back");
 	 	buttonMethod.add("gotoHome()");
 	 	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
