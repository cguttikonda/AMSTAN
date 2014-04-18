<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@include file="../../../Includes/JSPs/Rfq/iViewRFQDetails.jsp"%>
<%@page import="ezc.ezutil.*,java.util.*"%>

<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script>
var tabHeadWidth=90
var tabHeight="35%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script>
	function funOpen()
	{
		window.open("../Misc/ezViewAllConditions.htm","AllConditions","menubar=no,statusbars=no,toolbar=no,width=700,height=500,left=10,top=10");
	}
	function goBack(){
		document.forms[0].action = "ezViewRFQDetails.jsp"
		document.forms[0].submit();
	}
	function displayList(){
		document.forms[0].action = "ezListRFQs.jsp?type=List"
		document.forms[0].submit();
	}
</script>

<%
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));

%>
<body onLoad="scrollInit()" onResize="scrollInit()">
<form name="myForm" method="post">
	<input type="hidden" name="EndDate" value="<%=CDate%>">
	<input type="hidden" name="OrderDate" value="<%=OrderDt%>">
	<input type="hidden" name="PurchaseOrder" value="<%=poNum%>">
<%
	String reqFrom =request.getParameter("type");
	String display_header	= "Quotation";
%>
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	<input type="hidden" name="type" value="<%=reqFrom%>">
	<br><br>
<%
 	if ((QuotNo!=null)&&(QuotNo.trim().length() > 0))
	{
%>

	<Table align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="90%">
	<tr>
	<th align="left" width="25%">RFQ Ref. No</th>
      	<td valign="middle" align="left" width="25%"><%=poNum%></td>
	<th align="left" width="25%">RFQ Date</th>
      	<td valign="middle" align="left" width="25%"><%=OrderDt%></td>
	</tr>
	<tr>
	<th align="left" width="25%">Qtn. Ref. No</th>
      	<td valign="middle" align="left" width="25%"><%=retHead.getFieldValue(0,"QUOTATION")%>&nbsp;</td>
	<th align="left" width="25%">Qtn. Date</th>
      	<td valign="middle" align="left" width="25%">
	<%if (retHead.getFieldValue(0,"QUOTDATE")!=null)
		out.println(FormatDate.getStringFromDate((Date)retHead.getFieldValue(0,"QUOTDATE"),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT"))));
	%>
	&nbsp;</td>
	</tr>
	<!--	<tr>
	<th align="left" width="25%">All Conditions</th>
	<td width="75%"><a href='javascript:funOpen()'>Click</a></td>
	</tr>	-->
	<tr>
	<th align="left" width="25%">Payment Terms</th>
	<td width="75%" colspan=3>
	<%
		try{
			out.println(retHead.getFieldValueString(0,"PMNTTERM")+"-->"+PayT.getString(retHead.getFieldValueString(0,"PMNTTERM")));
		}catch(Exception e){
			out.println("&nbsp;");
		}
	%></td>
	</tr>
	<tr>
	<th align="left" width="25%">Inco Terms</th>
	<td width="75%" colspan=3>
	<%
		try{
			out.println(retHead.getFieldValueString(0,"INCOTERM1")+"-->"+IncoT.getString(retHead.getFieldValueString(0,"INCOTERM1")));
		}catch(Exception e){
			out.println("&nbsp;");  
		}
	%></td>
	</Tr>
	<Tr>
	<Th align="left" width="25%">Remarks</th>
	<td width="75%" colspan=3><!--<textarea name="Remarks" readonly rows=2 style="width:100%;overflow:auto">-->
	<%
	try{
		if (htexts.get(poNum)!=null)
			out.println(htexts.get(poNum));
	}catch(Exception ex){
	}%>
	<!--</textarea>-->&nbsp;</td>
	</Tr>
	</Table>
	<br>

  	<DIV id="theads">
  	<table id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0  width="90%">
    	<tr align="center" valign="middle">
      	<th width="15%">Material</th>
      	<th width="40%">Description</th>
      	<th width="7%">UOM</th>
      	<th width="14%">Qty</th>
      	<th width="14%">Price</th>
      	<th width="8%">Curr.</th>
    	</tr>
	</table>
	</Div>


	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;left:2%">
	<TABLE id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
 	<%
 	double tt1,tt2;
 	java.math.BigDecimal finalQty=null;
 	//out.println(dtlXML.toEzcString());
 	
      	for(int i=0;i<Count;i++)
      	{
		String curr = dtlXML.getFieldValueString(i,"AMOUNT");
		String net  = dtlXML.getFieldValueString(i,"NET_VALUE");
		
		String amt = curr;
		
		Double ddde=new Double(Double.parseDouble(curr));
		tt2=ddde.doubleValue()*100.0;
		
		amt = tt2+"";
		
		try
		{
			amt  = new java.math.BigDecimal(amt).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}catch(Exception e){}
      		
      		String myQty = dtlXML.getFieldValueString(i,"ORDEREDQUANTITY");
		
		try
		{
			myQty  = new java.math.BigDecimal(myQty).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}catch(Exception e){}
		
		
		/*ezc.ezcommon.EzLog4j.log("curr"+curr+"  "+net,"I");
		double myQty = 0.0;
		tt1=0;tt2=0;
		try
		{
			Double dddd=new Double(Double.parseDouble(net));
			tt1=dddd.doubleValue()*100.0;
			Double ddde=new Double(Double.parseDouble(curr));
			tt2=ddde.doubleValue()*100.0;
			
			ezc.ezcommon.EzLog4j.log("curr >>"+tt1+"  "+tt2,"I");
			myQty = tt1/tt2;
			finalQty=new java.math.BigDecimal(myQty);
			myQty =finalQty.setScale(3,java.math.BigDecimal.ROUND_HALF_UP).doubleValue();
			
		}
		catch(Exception e){ 
			myQty = 00.0; 
		}*/
	%>
        	<tr>
	  	<td width="15%">
		<%try{
			out.println(Long.parseLong(dtlXML.getFieldValueString(i,"ITEM")));
		}catch(Exception e){
			out.println(dtlXML.getFieldValueString(i,"ITEM"));
		}%>
		</Td>
		
			<td width="40%"><%=dtlXML.getFieldValueString(i,"ITEMDESCRIPTION")%></td>
			<td width="7%"><%=dtlXML.getFieldValueString(i,"UOMPURCHASE")%></td>
			<td width="14%" align="right"><%=myQty%></td>
			<!--<td width="14%" align="right"><%=myQty%></td>-->
			<td width="14%" align="right"><%=myFormat.getCurrencyString(amt+"")%>&nbsp;</td>
		<%if((curr!=null)&&(Double.parseDouble(curr)!=0.0)){%>
	      	<td width="8%"><%=dtlXML.getFieldValueString(i,"CURRENCY")%>&nbsp;</td>
		<%}else{%>
			<td width="8%">&nbsp;</td>
		<%}%>
      		</tr>
	<%}%>
	</table>
 	</div>

<%	}
	else
	{
%>
	<br><br><br><br>
	<Table width=60% align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
	<Tr><Th>Quotation has not been submitted for RFQ No : <%=poNum%></Th></Tr>
	</Table>
	<br><br>
<%}
%>

	<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
	<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		String userType = (String)session.getValue("UserType");	
 	   	if(userType.equals("2")){
		buttonMethod.add("goBack()");
		}else if("List".equalsIgnoreCase(reqFrom)){
		buttonMethod.add("displayList()");
		}else{
		buttonMethod.add("goBack()");
		}
		
		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</center>
	</div>
	<%@ include file="../Misc/AddMessage.jsp" %>
	
</form>
<Div id="MenuSol"></Div>
</body>
</html>
