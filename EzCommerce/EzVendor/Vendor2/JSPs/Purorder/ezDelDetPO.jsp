<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iDelDet_Labels.jsp"%>
<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<html>
<head>
<script>
function formEvents(formEv)
{	
	document.myForm.action=formEv;
	document.myForm.submit();
}
</script>

<jsp:useBean id="PcManager" class ="ezc.client.EzPurContractManager" scope="page">
</jsp:useBean>
<title>Purchase Order Delivery Schedule</title>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</head>
<body bgcolor="#FFFFF7">
<!-- <table width="40%" border="0" align="center">
  <tr align="center"> 
    <td class="displayheader">Delivery Schedule List</td>
  </tr>
</table> -->
<%String display_header =deSchList_L; %>
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<%
String orderType = request.getParameter("orderType");	
	final String lineNum="LINENUM";
	final String  order="CONTRACT";
	final String  material="MATERIAL";
	final String  description="MATDESC";
	final String  units="PURCHASEUNIT";
	final String  dlvdate="PLANNEDDELIVERYDATE";
	final String  qty="QUANTITY";
	Date ddate=null;

	FormatDate formatDate = new FormatDate();
	//EzPurchCtrDSched dsched = null;
	ReturnObjFromRetrieve dsched=null;
	EzPSIInputParameters ioparams = new EzPSIInputParameters();
ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
ezc.ezpurchase.params.EziPurOrderDetailsParams testParams=new ezc.ezpurchase.params.EziPurOrderDetailsParams();

// Vendor Number is hardcoded you can remove afterwards  
//ioparams.setVendorNumber("VENDOR1");

	String contractNum = request.getParameter("orderNum");
	String position = request.getParameter("line");
	 String punit = request.getParameter("units");
	String orderDate = request.getParameter("OrderDate");

String contractValue = request.getParameter("contractValue");
  
	ioparams.setOrderNumber(contractNum);
	ioparams.setPositionNum(position);
        	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(testParams);
	Session.prepareParams(newParams);

	String oqty="";
	dsched = (ReturnObjFromRetrieve)PcManager.ezPurchaseContractDeliverySchedule(newParams);

         
	int desc = dsched.getRowCount(); 
	if(desc != 0){
	for (int i = 0 ; i < desc; i++)	
	{
		oqty =dsched.getFieldValue(0, qty).toString();
		if(oqty.equals("null"))
		{
		oqty="";
			}

		ddate = (Date)dsched.getFieldValue(i, dlvdate);

		punit = (String)dsched.getFieldValue(i, units);


	}

	if(orderType == null)
		orderType="";
//out.println("orderType:"+orderType);
%>
<br>
<table width="75%" align="center" bgcolor="#FFFFF7" bordercolor="#660066" border="1">
      <tr> 
        <th  height="26" bordercolor="#FFFFF7" ><%=purchaseOrderNum_L%></th>
        <td  height="26" bordercolor="#FFFFF7" >
		<%try{
			out.println(Long.parseLong(contractNum));
		}catch(Exception numFmtEx)
		{
			out.println(contractNum);
		}
		%>
	</td>
        <th  height="26" bordercolor="#FFFFF7"><%=line_L%></th>
        <td  height="26" bordercolor="#FFFFF7"><%=position%></td>
      </tr>
      <tr> 
        <th  height="26" bordercolor="#FFFFF7" ><%=material_L%></th>
         <td  height="26" bordercolor="#FFFFF7" >
		<%
			String dsc = dsched.getFieldValueString(0, material);
			try{
				out.println(Long.parseLong(dsc));
			}catch(Exception numFmtEx)
			{
				out.println(dsc);
			}
		%>
	</td>
        <th  height="26" bordercolor="#FFFFF7"><%=description_L%></th>
        <td  height="26" bordercolor="#FFFFF7"><%=dsched.getFieldValueString(0, description)%></td>
      </tr>

    </table>
	<br>	
<table width="50%" align="center" bgcolor="#FFFFF7" bordercolor="#660066">
  <tr>
	        
    <th bordercolor="#FFFFF7" width="35%" ><%=requireDate_L%></th>
			        
    <th bordercolor="#FFFFF7" width="25%" ><%=uom_L%></th>
					        
    <th bordercolor="#FFFFF7" width="31%" ><%=orderQty_L%></th>
	
	</tr>

<% if(dsched.getRowCount() > 4 ){%>
</Table>
<div align="center" STYLE="overflow: auto;Position:Absolute;left:25%;  width:52%;height: 30%;">
<Table align="center" width="100%">
<%
} //// endof if for more than 4 rows ,scrollable table

 	for (int i = 0 ; i < dsched.getRowCount(); i++)	
	{
		oqty = dsched.getFieldValue(i, qty).toString();
		if(oqty.equals("null"))
		{
		oqty="";
			}
		//System.out.println("oqty number is  : " +oqty );
		ddate = (Date)dsched.getFieldValue(i, dlvdate);
		//System.out.println("ddate number is  : " +ddate );
		punit = (String)dsched.getFieldValue(i, units);
		//System.out.println("ddate number is  : " +punit);
//ddate
%>
	<tr>
	 
    <td  height="20%" bordercolor="#FFFFF7" width="35%" align="center"><%=formatDate.getStringFromDate(ddate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")))%></td>
	  
    <td  height="10%" bordercolor="#FFFFF7" width="25%" align="center">
      <%=punit%>
    </td>
	   
    <td  height="30%" bordercolor="#FFFFF7" width="31%" align="right"><%=oqty%></td>
	<tr>
<%
}
%>
</table>
<% if(dsched.getRowCount() > 4 ){ %>//if more than 4 rows scrollable table
</div>
<% } %>
<%

}
if (desc ==0)
{
%>

 <BR>
<!-- <p>
<table width="59%" border="0" align="center">
  <tr align="center"> 
    <td width="59%" height="21" class="displayheader">No Delivery Schedule for This Item 
</td>
  </tr>
</table>
</div>
</p> -->
<% String noDataStatement =noDeliverySchedule_L;%>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
}
else
{
 	for (int i = 0 ; i < dsched.getRowCount(); i++)	
	{
		oqty = dsched.getFieldValue(i, qty).toString();
		if(oqty.equals("null"))
		{
		oqty="";
			}
		//System.out.println("oqty number is  : " +oqty );
		ddate = (Date)dsched.getFieldValue(i, dlvdate);
		//System.out.println("ddate number is  : " +ddate );
		punit = (String)dsched.getFieldValue(i, units);
		//System.out.println("ddate number is  : " +punit);

}

}
%>

<form name=myForm>
<input type=hidden name=PurchaseOrder value="<%=contractNum%>">
<input type=hidden name=OrderValue value="<%=contractValue%>">
<input type=hidden name=POPrice value="<%=contractValue%>">
<input type=hidden name=baseValues value="<%=contractNum%>">
<input type=hidden name=orderCurrency value="INR">
<input type=hidden name=line value="<%=position%>">
<input type=hidden name=material value="<%=dsched.getFieldValueString(0, material)%>">
<input type=hidden name=base value="PContracts">
<input type=hidden name=OrderDate value="<%=orderDate%>">
<input type=hidden  name=orderType value="<%=orderType%>">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
