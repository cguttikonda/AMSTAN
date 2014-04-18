<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iBlockedPoLineItems_Labels.jsp"%>
<%@ page import ="java.math.*" %>
<%@ page import ="java.util.*" %> 
<%@ page import ="ezc.ezutil.*" %>
<%@ include file="../../../Includes/JSPs/Purorder/iBlockedPoLineItems.jsp"%>
<%FormatDate formatDate = new FormatDate();%>
<%
	boolean hasReleaseAuth = false;
	
	
	if(session.getValue("USERAUTHS") != null)
	{
		
		java.util.Vector authVector = (java.util.Vector)session.getValue("USERAUTHS");
		
		if(authVector.contains("RELEASE_PO"))
		{
			
			hasReleaseAuth = true;
		}
		else
		{
			hasReleaseAuth = false;
		}
	}	
	else
	{
		hasReleaseAuth = false;
	}
	
	
%>
<!DOCTYPE html>
<!--[if IE 8]>         <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Answerthink</title>
	<link rel="stylesheet" href="../../Mobile/css_old/normalize.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/bootstrap.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/bootstrap-responsive.css" />
	<link rel="stylesheet" href="../../../../../EzMobile/css/answerthink.css" />
<script>
	var releaseAuth = <%=hasReleaseAuth%>;
	function formEvents1(formEv)
	{
		window.open(formEv,"PoPrint","menubar=no,statusbars=no,toolbar=no,width=700,height=600,left=10,top=10");
	}

	function funSubmit(formEv)
	{
		if(releaseAuth)
		{
			document.myForm.action = formEv
			document.myForm.submit();
		}
		else
		{
			alert("You are not authorized for releasing the Purchase Order to the Vendor");
		}			
	}
	function formEvents(formEv)
	{
			document.myForm.action=formEv;
			document.myForm.submit();
		
	}
	

	function goToPlantAddr(plant)
	{
		window.open("ezPlantAddress.jsp?plant="+plant,"plantdet", "status=no,toolbar=no,menubar=no,location=no,left=250,top=200,width=300,height=320");
	}
	function goBack()
	{
	  window.history.go(-1)
 	 }
</script>

</head>
<body>
<form  name="myForm" method="post">
<div class="row-fluid">
	<div class="span12">
		<h2>Answerthink</h2>
	</div>
</div>

<div class="row">
    <div class="span12"><h4>PO Details</h4></div>
</div>
<%
	int polines = dtlXML.getRowCount();
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	if (polines ==0)
	{
		String noDataStatement = noOrdLiPres_L;
%>		
		<%@ include file="../Misc/ezDisplayNoData.jsp" %>
<%
	}
	else
	{

		String netOrderAmount = dtlXML.getFieldValueString(0,"NET_VALUE");
		netOrderAmount = netCalcAmt+""; 
		String currency = dtlXML.getFieldValueString(0,"CURRENCY");
		String poNumberx="";
		try
		{
			poNumberx=Long.parseLong(poNum)+"";
		}
		catch(Exception e)
		{
			poNumberx=poNum;;
		}
		String poDate = formatDate.getStringFromDate((Date)dtlXML.getFieldValue(0,ORDDATE),(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
		String poVal  = myFormat.getCurrencyString(netOrderAmount);
		
%>
		<section class="span4 offset4" id="no-more-tables">
			<table class="table-bordered table-striped table-condensed cf">
				<Tr>
					<th class="numeric"><%=poNo_L%></th><td class="numeric" data-title=<%=poNo_L%>><%=poNumberx%></td>
					<th class="numeric"><%=orderDate_L%></th><td class="numeric" data-title=<%=orderDate_L%>><%=poDate%></td>
					<th class="numeric"><%=netValue_L%>[<%=currency%>]</th><td class="numeric" data-title=<%=netValue_L%>><%=poVal%></td>
				</Tr>
			</table>
			<br>
			<br>
			
			<table class="table-bordered table-striped table-condensed cf">
				<thead>
					<Tr>
						<th  class="numeric" width="5%" ><%=line_L%></th>
						<th  class="numeric" width="12%"><%=mat_L%></th>
						<th  class="numeric" width="25%"> <%=desc_L%></th>
						<th  class="numeric" width="6%"><%=uom_L%></th>
						<th  class="numeric" width="11%"><%=qty_L%></th>
						<th  class="numeric" width="11%"><%=price_L%></th>
						<th  class="numeric" width="14%"><%=value_L%></th>
						<th  class="numeric" width="6%"><%=plant_L%></th>
						<th  class="numeric" width="10%"><%=edDate_L%></th>
					</Tr>
				</thead>
				<tbody>
<%

		for(int i=0; i<polines; i++)
		{
			String lineNum = (String)dtlXML.getFieldValue(i, LINENO);
			String matNum = (String)dtlXML.getFieldValue(i, MATERIAL);
			matNum = matNum.trim();
			String matDesc = (String)dtlXML.getFieldValue(i, MATDESC);
			matDesc = matDesc.trim();
			String uom = (String)dtlXML.getFieldValue(i, UOM);
			String qty = dtlXML.getFieldValueString(i, ORDQTY);
			String plant = dtlXML.getFieldValueString(i, "PLANT");

			java.math.BigDecimal price1 = (java.math.BigDecimal)dtlXML.getFieldValue(i, PRICE);
			String price = dtlXML.getFieldValueString(i, AMOUNT);
			price = (Double.parseDouble(price)*100)+"";
			double amnt = 0.0;
			try{
				amnt = Double.parseDouble(dtlXML.getFieldValueString(i, "NET_VALUE"))*100;
			}catch(Exception e){}
			BigDecimal BD = new BigDecimal(amnt);
			String netAmount =dtlXML.getFieldValueString(i, AMOUNT);


			Date eDDate =(Date)dtlXML.getFieldValue(i, DDATE);
			String edDate = formatDate.getStringFromDate(eDDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
%>
    			<tr align="center">
				<td width=5%" class="numeric" data-title=<%=line_L%>><%if(lineNum != null)out.println(lineNum); %></td>
				<td width="12%" align=left class="numeric" data-title=<%=mat_L%>>
<%			try{
				matNum=String.valueOf(Long.parseLong(matNum));
			}catch(Exception nfe){	}

%>
			<%= matNum %>&nbsp;</td>
    			<td width="25%" align=left title="<%=matDesc%>" class="numeric" data-title=<%=desc_L%>><%=matDesc%></td>
			<td width="6%" class="numeric" data-title=<%=uom_L%>><%=uom %>&nbsp;</td>
			<td width="11%" align="right" class="numeric" data-title=<%=qty_L%>><%=qty%>&nbsp</td>
			<td width="11%" align="right" class="numeric" data-title=<%=price_L%>><%=myFormat.getCurrencyString(price)%>&nbsp</td>
			<td width="14%" align="right" class="numeric" data-title=<%=value_L%>>
<%
				String bd = BD.toString();
				out.println( myFormat.getCurrencyString(bd));
%>

			<input type="hidden" name="POPrice" value="<%=BD%>">&nbsp</td>
			<td width="6%"  class="numeric" data-title=<%=plant_L%>><a href="Javascript:void(0)" onClick="goToPlantAddr('<%=plant%>')"  onMouseover="window.status='<%=viwPltAdd_L%>'; return true" onMouseout="window.status=' '; return true"><%=plant%></a>&nbsp</td>
    			<td width="10%" align="center"  class="numeric" data-title=<%=edDate_L%>>
<%
			if(edDate.length() == 10)
			{
				if(dtlXML.getFieldValueString(i,"INDICATOR").equalsIgnoreCase("X"))
				{
%>
					<a href="ezDelDetPO.jsp?orderNum=<%=dtlXML.getFieldValue(0,ORDER)%>&line=<%=lineNum%>&OrderDate=<%=dtlXML.getFieldValue(0,ORDDATE)%>"><%=edDate%></a>
<%				}
				else
				{
%>
					<%=edDate%>
<%				}
			}
%>				&nbsp
			</td>
	  		</tr>
<%
		}
%>
			</tbody>
		</table>
		</section>
		<br>
	<input type=hidden name="poData" value="<%=poNum%>¥<%=vendor%>¥<%=request.getParameter("type")%>¥<%=sysKey%>">
	<input type=hidden name="PurchaseOrder" value="<%=poNum%>">
	<input type=hidden name="vendorNo" value="<%=vendor%>">  
	<input type="hidden" name="OrderDate" value="<%=poDate%>">
	<input type="hidden" name="OrderType" value='<%=request.getParameter("type")%>'>

<%
	}
%>
<div class="row">
	<div class="large-3 large-centered columns">
		<table>
			<tr>
<%
			if("PURPERSON".equals(Session.getUserId()) || "PURHEAD".equals(Session.getUserId()))
			{
%>
			    <td>
				<button onclick='funSubmit("ezReleaseOrderM.jsp")' class="btn btn-primary">Release Order</button>
			    </td>
<%	
			}
%>
			</tr>
		</table>
	</div>
</div>

</form>
</body>
</html>
