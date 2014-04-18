<HTML><HEAD><TITLE></TITLE>
<META content="text/html; charset=windows-1252" http-equiv=Content-Type>
<%@ include file="../../../Includes/JSPs/Lables/iDisclaimer_Lables.jsp" %>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%
	String siteAdd	    = "www.conres.com";
	String compNameDesc = "CRI";
%>
<style>
.control1
{
    COLOR: black;
    FONT-FAMILY: Verdana, Arial;
    FONT-SIZE: 11px;
    TEXT-DECORATION: none
}
</style>
<script>
function ezHref()
{
	var browserName=navigator.appName;
	document.location.href = "ezPutDisclaimerStamp.jsp?browser="+browserName

}
function quit(event)
{
	document.myForm.target = "_parent";
	document.myForm.action = event;
	document.myForm.submit();
}

</script>

</HEAD>

<BODY    topMargin=0 marginheight="0" scroll=no>
<form  method="post" name="myForm" target="_parent">
<input type="hidden" name="chkBrowser" value="" >

<Table align=center width="100%" topMargin=0 marginheight="0">
<Tr><Td align=center  height="35" bgcolor="#e6e6e6">
<font size=2 face=verdana><b>PLEASE READ THIS DISCLAIMER AND NOTICE</b></font></Td></Tr>
</Table>

<br>

<Table align=center leftMargin=5 topMargin=0 marginwidth="5" marginheight="0">
<Tr>
<Td align=center>
<textarea name="disclaimer" cols="110" rows="25" readonly="readonly" >

    
    YOU EXPRESSLY AGREE THAT THE USE OF THIS SITE IS AT YOUR OWN RISK. YOU (AND NOT ECOMMERCE 
    OPTIMIZATION) ASSUME THE ENTIRE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION. YOU 
    EXPRESSLY AGREE THAT NEITHER ECOMMERCE OPTIMIZATION, NOR ITS AFFILIATED OR RELATED ENTITIES, 
    NOR ANY OF THEIR RESPECTIVE EMPLOYEES, OR AGENTS, NOR ANY PERSON OR ENTITY INVOLVED IN THE 
    CREATION, PRODUCTION, AND DISTRIBUTION OF THIS WEB SITE ARE RESPONSIBLE OR LIABLE TO ANY 
    PERSON OR ENTITY WHATSOEVER FOR ANY LOSS, DAMAGE (WHETHER ACTUAL, CONSEQUENTIAL, PUNITIVE 
    OR OTHERWISE), INJURY, CLAIM, LIABILITY OR OTHER CAUSE OF ANY KIND OR CHARACTER WHATSOEVER 
    BASED UPON OR RESULTING FROM THE USE OF THIS SITE OR ANY OTHER ECOMMERCE OPTIMIZATION 
    OWNED SITE. ECOMMERCE OPTIMIZATION WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING 
    FROM THE USE OF THIS SITE, INCLUDING, BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, 
    AND CONSEQUENTIAL DAMAGES. YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT ECOMMERCE 
    OPTIMIZATION IS NOT LIABLE OR RESPONSIBLE FOR ANY DEFAMATORY, OFFENSIVE OR ILLEGAL CONDUCT 
    OF OTHER SUBSCRIBERS OR THIRD PARTIES.

    All Rights Reserved.     
     
</textarea> 
</td>
</tr>
</table>
<br>
<center>
<table border=0 cellspacing=3 cellpadding=5 class=buttonTable>
	<tr>
		<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,"TDCmdBtnDown")' onMouseUp='changeClass(this,"TDCmdBtnUp")' onMouseOver='changeClass(this,"TDCmdBtnUp")' onMouseOut='changeClass(this,"TDCmdBtnOff")' onClick='javascript:ezHref()' valign=top title = 'Click here to Agree To This Agreement'><b>&nbsp;&nbsp;&nbsp;&nbsp;Agree To This Agreement &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
		<td style="background:transparent" >&nbsp;</Td>
		<td nowrap class='TDCmdBtnOff' onMouseDown='changeClass(this,"TDCmdBtnDown")' onMouseUp='changeClass(this,"TDCmdBtnUp")' onMouseOver='changeClass(this,"TDCmdBtnUp")' onMouseOut='changeClass(this,"TDCmdBtnOff")' onClick='javascript:quit("ezLogout.jsp")' valign=top title = 'Click here to Do Not Agree'><b>&nbsp;&nbsp;&nbsp;&nbsp;Do Not Agree &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
	</tr>
</table>

<%--
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Agree To This Agreement");
	buttonMethod.add("ezHref(\"ezPutDisclaimerStamp.jsp\")");

	buttonName.add("Do Not Agree");
	buttonMethod.add("quit(\"ezLogout.jsp\")");
	out.println(getButtonStr(buttonName,buttonMethod));
--%>
</center>
</form>
<Div id="MenuSol"></Div>
</BODY></HTML>
