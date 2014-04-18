<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.ezutil.*,java.util.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iViewMaterialResponse.jsp" %>


<Html>
<Head>
	<title>Difficult to Source Items</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script src="../../Library/JavaScript/ezCheckFormFields.js">
	</script>
<script>

var newWindow4;

function openFileWindow(file)
{
	newWindow4 = window.open(file+"?requestId=<%=requestId%>&sysKey=<%=sysKey%>&soldTo=<%=soldTo%>&refNum=<%=refNum%>","MyNewtest","center=yes,height=300,left=200,top=100,width=450,titlebar=no,status=no,resizable=no,scrollbars")

}

function funUnLoad()
{
	if(newWindow4!=null && newWindow4.open)
	{
	   newWindow4.close();
	}
}

function funBack()
{
	document.myForm.action="ezListMaterialResponses.jsp"
	document.myForm.submit();
}

</script>

</Head>
<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
%>
<Body onUnLoad="funUnLoad()" scroll="yes">
<Form name="myForm" method="post">

    <table width="35%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
    <Tr align="center">
    <Td class="displayheader">View Response Details</Td>
    </Tr>
    </Table>

	<br>

        <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
   	<Tr>
	<th align="left" width="25%">Material Description</th>
	<Td width="25%" colspan=3><%=reqHeader.getFieldValueString(0,"MATERIALDESC")%></Td>
        </tr>

        <tr>
        <th align="left" >UOM</th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"UOM")%></Td>

	<th align="left">Qty</th>
	<Td width="25%"><%=reqHeader.getFieldValueString(0,"REQUIREDQTY")%></Td>
	</Tr>

<%	if(type.equals("N"))
        {
        	String reqDate=reqHeader.getFieldValueString(0,"EXT1");
        	int mm=Integer.parseInt(reqDate.substring(3,5));
		int dd=Integer.parseInt(reqDate.substring(0,2));
		int yy=Integer.parseInt(reqDate.substring(6,10));
		GregorianCalendar DocDate=new GregorianCalendar(yy,mm-1,dd);

%>
	<Tr>
	<th align="left">Required Date</th>
	<Td width="25%" colspan=3><%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
	</Tr>
<%	} %>

       <tr>
       <th align="left">Delivery Terms</th>
       <Td width="25%" colspan=3>Delivery at Factory</Td>
       </Tr>


	</Table><br>

        <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
   	<Tr>
	<th align="left" width="25%">Vendor</th>
	<Td width="75%"><%=name%></Td>
        </tr>

        <tr>
        <th align="left" width="25%">Response Date</th>
	<%
	FormatDate fd = new FormatDate();
	%>
	<Td width="75%"><%=fd.getStringFromDate((java.util.Date)resHeader.getFieldValue(0,"RESPONSEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
	</Tr>

<%	//if(type.equals("N"))
        //{
%>
        <tr>
        <th align="left" width="25%" >Price</th>
	<Td width="75%"><%= myFormat.getCurrencyString(resHeader.getFieldValueString(0,"EXT1")) %></Td>
	</Tr>
<%	//}  %>
        </Table><br>

        <Table width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr><th align="left">Additional Details</th></tr>
	<tr><Td width="100%">
	
	<% ezc.drl.util.Replace rep = new ezc.drl.util.Replace(); %>
	
	<%=rep.setNewLine(resHeader.getFieldValueString(0,"RESPONSEDESC"))%>&nbsp;
	<!--<textarea rows=3 style="width:100%;overflow:auto" readonly class=inputbox><%//resHeader.getFieldValueString(0,"RESPONSEDESC")%></textarea></Td></Tr>-->
	</Table><br>

<center>
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none" onClick="javascript:funBack()">
<%
    if(request.getParameter("Type").equals("N"))
    {
%>
	<img src="../../Images/Buttons/<%=ButtonDir%>/viewdocuments.gif" style="cursor:hand" border=none onClick="openFileWindow('ezViewResponseFiles.jsp')">
<% } %>
<img src="../../Images/Buttons/<%=ButtonDir%>/print.gif" style="cursor:hand" border="none" onClick="window.print()">
</center>

<input type="hidden" name="chk1" value="<%=forback%>" >
<input type="hidden" name="Type" value="<%=type%>" >
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
