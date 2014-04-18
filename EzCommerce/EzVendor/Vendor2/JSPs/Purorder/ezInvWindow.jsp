<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<html>
<head>
<title>Invoice Processing &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
<script src="../../Library/JavaScript/ezTrim.js">
</script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
	aa=parent.dialogArguments;
	bb=aa.split("@@");
	document.write("<Table width=90% align=center><Tr><Td><font face=verdana size=2>");
	document.write("<b>If the processed amount is correct please enter your Invoice No. and date and click 'Submit' button.<br><br>The system will generate a number after accounting your Invoice, please note the number on your invoice and submit to our accounts department.</b><br><br><font color=red>Your invoice will be accounted for <b>Rs."+bb[1]+"</b></font></Td></Tr></Table>")
	document.write("<Table width='90%' align=center><Tr><Td><font face=verdana size=2 color=red><u>Invoice Particulars :</u></font></Td></Tr></Table>")
	document.write("<Table width='90%' align=center><Tr><Td><font face=verdana size=2 color=red>"+bb[0]+"</font></Td></Tr></Table>")
	document.write("<br><Table width=90% align=center><Tr><Td><font face=verdana size=2>If the above amount is not correct please click on 'Cancel' button and submit the invoice to our SCM department.");
	document.write("</font></Td></Tr></Table><Br>");

	function fun1()
	{
		if (funTrim(document.forms[0].retVal.value)==''){		
			alert("Please enter Invoice Number")
			document.forms[0].retVal.focus();
			return false
		}
		else if (document.forms[0].PosDate.value==''){
			alert("Please enter Invoice Date")
			return false
		}
		window.returnValue=document.forms[0].retVal.value+"||"+document.forms[0].PosDate.value
		window.close()
	}
	function fun2()
	{
		window.returnValue="Canceld~~"
		window.close()
	}
</script>
</head>
<body>
<form name="f1">

	<table align="center" width="90%">
	<tr>
	<td align="left" width="20%" nowrap> <font face=verdana size=2>Your Invoice No:</font></td>
	<td width="25%"><input type=text name="retVal" maxlength=18></td>
	<td align="right" width="10%"><font face=verdana size=2>Date:</font></td>
	<td width="25%"><input type=text name="PosDate" size=10 readonly>
	<img src="../../Images/Common/calender.gif" height="20" style="cursor:hand" onClick=showCal("document.f1.PosDate",75,50,"<%=cDate%>","<%=cMonth%>","<%=cYear%>")>
	</td>
	</Tr>
	</Table><br>
	<Table align=center><Tr>
	<td class="blankcell">
	<img src="../../Images/Buttons/<%=ButtonDir%>/submit.gif" border="none"  style="cursor:hand" onClick="fun1()">
	<img src="../../Images/Buttons/<%=ButtonDir%>/cancel.gif" border="none"  style="cursor:hand" onClick="fun2()">
	</td></tr>
	</table>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
