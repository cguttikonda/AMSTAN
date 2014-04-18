<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.ezutil.*"%>
<%@ include file="../../../Includes/JSPs/Materials/iListMaterialResponses.jsp" %>
<%
String type = request.getParameter("Type");
%>
<Html>
<Head>
	<title>Difficult to Source Items</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
	<script src="../../Library/JavaScript/ezCheckFormFields.js">
	</script>

<script>

	function formEvents(evnt)
	{
	    document.myForm.action=evnt
   	    document.myForm.submit();

	}

	function funBack()
	{
		document.myForm.action="ezListMaterialsInternal.jsp";
		document.myForm.submit();
	}
</script>

<Script>
var tabHeadWidth=75
var tabHeight="20%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>


</Head>
<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
%>
<Body onLoad="scrollInit()" onResize="scrollInit()">
<Form name="myForm" method="post">

    <table width="35%" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  align="center">
    <Tr align="center">
    <Td class="displayheader">View Responses</Td>
    </Tr>
    </Table>

	<br>


        <Table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >

   	<Tr>
	<th align="left" width="14%">Material Description</th>
	<Td width="28%"><%=reqHeader.getFieldValueString(0,"MATERIALDESC")%></Td>
        </tr>

        <tr>
        <th align="left" >UOM</th>
	<Td width="14%"><%=reqHeader.getFieldValueString(0,"UOM")%></Td>
	</Tr>

	<Tr>
	<th align="left">Qty </th>
	<Td width="28%"><%=reqHeader.getFieldValueString(0,"REQUIREDQTY")%></Td>
	</Tr>
<%    if(type.equals("N"))
      {
	   	String reqDate=reqHeader.getFieldValueString(0,"EXT1");
		int mm=Integer.parseInt(reqDate.substring(3,5));
		int dd=Integer.parseInt(reqDate.substring(0,2));
		int yy=Integer.parseInt(reqDate.substring(6,10));
		GregorianCalendar DocDate=new GregorianCalendar(yy,mm-1,dd);

%>
	<Tr>
	<th align="left">Required Date </th>
	<Td width="28%"><%=FormatDate.getStringFromDate(DocDate.getTime(),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></Td>
	</Tr>


<%	} %>
        <tr>
 	 <th align="left">Delivery Terms</th>
	  <Td width="25%" colspan=3>Delivery at Factory</Td>
	</Tr>


	</Table>
	<br>



	<DIV id="theads">
	<Table id="tabHead" width="75%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
        <th width="10%" align=center>&nbsp; </th>
        <th width="50%" align=center>Vendor</th>
        <th width="20%" align="center">Date</th>
	<th width="20%" align="center">Price </th>
        </Tr>
 	</Table>
       	</DIV>

    <DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:75%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%
      int Count = resHeader.getRowCount();

      FormatDate fd = new FormatDate();
      String date="";
	
	  java.util.Vector vect = new java.util.Vector();	
	  
      for(int i=0;i<Count;i++)
      {
           date = fd.getStringFromDate((java.util.Date)resHeader.getFieldValue(i,"RESPONSEDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		   
		 if(!vect.contains(resHeader.getFieldValueString(i,"SOLDTO")))		   
		 {
%>

       	<Tr>
        <td width="10%" align=center>
        <%
	    if(i==0)
	    {
        %>   <input type="radio" checked name=chk1 value="<%=requestId%>#<%=resHeader.getFieldValueString(i,"SOLDTO")%>#<%=resHeader.getFieldValueString(i,"SYSKEY")%>#<%=refNum%>#<%=resHeader.getFieldValueString(i,"NAME")%>">
        <%   }else{ %>
	     <input type="radio" name=chk1 value="<%=requestId%>#<%=resHeader.getFieldValueString(i,"SOLDTO")%>#<%=resHeader.getFieldValueString(i,"SYSKEY")%>#<%=refNum%>#<%=resHeader.getFieldValueString(i,"NAME")%>">
        <%   } %>
	</td>
        <td width="50%" align=left><%=resHeader.getFieldValueString(i,"NAME")%>&nbsp;(<%=resHeader.getFieldValueString(i,"SOLDTO")%>)</td>
	<td width="20%" align="center"><%=date%></td>
	<td width="20%" align=center><%=myFormat.getCurrencyString(resHeader.getFieldValueString(i,"EXT1"))%></td>
	</Tr>


<%  	vect.addElement(resHeader.getFieldValueString(i,"SOLDTO"));	
	}

} %>
	</table>
	</div>

<div id="buttons" align=center style="position:absolute;top:87%;width:100%;visibility:visible">
<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand" border="none" onClick="javascript:funBack()">
<img src="../../Images/Buttons/<%=ButtonDir%>/view.gif" style="cursor:hand" border="none" onClick="formEvents('../Materials/ezViewMaterialResponse.jsp')">
</div>
<input type="hidden" name="Type" value="<%=type%>">


<input type="hidden" name="forback" value="<%=chk1%>" >

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>
