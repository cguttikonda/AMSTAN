<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.ezparam.ReturnObjFromRetrieve" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@include file="../../../Includes/Lib/AddButtonDir.jsp"%>
<%@page import="ezc.ezcommon.*"%>
<jsp:useBean id="ShManager" class="ezc.ezshipment.client.EzShipmentManager" scope="session" />

<% 
 
    String qcfNum = request.getParameter("qcfNumber");
    ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(true);
    EziPrintParams params= new EziPrintParams();
    params.setObjectType("QCF");
    params.setObjectNo(qcfNum);
    params.setDocType("TEXT");
    //params.setCustomer("3000");
    mainParams.setObject(params);
    Session.prepareParams(mainParams);

    ezc.ezsap.V46B.generated.SoliTable myTable=null;
    ezc.ezsap.V46B.generated.SoliTableRow myTableRow=null;

    myTable=(ezc.ezsap.V46B.generated.SoliTable)ShManager.ezGetPrintVersion(mainParams);
    int rowCount=myTable.getRowCount();

    String data="";
    for(int i=0;i<rowCount;i++)
    {
	myTableRow=myTable.getRow(i);
	data = data+myTableRow.getLine()+"<br>";
    }


%>
	
<html>
<head>
	<title>Quotation Comparision Form for Collective RFQ No : <%=qcfNum%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</title>
</head>
<body>
<form name="myForm" method="post">
	<table width="90%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=0 cellSpacing=0 >
	<tr>
	<td width="100%" align=center>
	<%
	    if(rowCount>1)
	    {
	%>	    
		<pre><font size="2"><%=data%></font></pre>
	<%  }else{ %>
		<font size="2">Document Number <%=qcfNum%> does not exist.</font><
	<%  } %>
	</td>
	<tr>
	</Table><br>

	<center>
	<img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none onClick="window.close()">
	</center>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
