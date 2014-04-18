<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>

<%@ page import="java.util.*,ezc.ezvendorapp.params.*,ezc.ezpurchase.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate,ezc.ezparam.*"%>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>


<%
	String OrderDate 	= request.getParameter("OrderDate");
	String NetAmount 	= request.getParameter("NetAmount");
	String sysKey		= (String)session.getValue("SYSKEY");
	String soldTo 		= (String)session.getValue("SOLDTO");
	String po 		= request.getParameter("poNum");	
	String[] lines 		= request.getParameterValues("line");
	String[] material 	= request.getParameterValues("material");
	String[] materialDesc 	= request.getParameterValues("materialDesc");
	String[] uom 		= request.getParameterValues("uom");
	String[] requiredQty 	= request.getParameterValues("requiredQty");
	String[] comittedQty 	= request.getParameterValues("comittedQty");
	String[] date 		= request.getParameterValues("date");	
	String[] scheduleLines 	= request.getParameterValues("scheduleLine");	
	int Count 		= Integer.parseInt(request.getParameter("RCount"));
	String cdate="";


	EzPODeliveryScheduleTable table =  new EzPODeliveryScheduleTable();
	EzPODeliveryScheduleTableRow tableRow = null; 

   
	EzBapiekkocStructure header= new EzBapiekkocStructure();
	header.setDocType("F");
	header.setPoNumber(po);

	EzBapieketTable shTable= new EzBapieketTable();
	EzBapieketTableRow shTableRow= null ;
	
	int rCount = 0;	
	for(int i=0;i<Count;i++)
	{
		cdate = request.getParameter("committedDate_"+i);
		if(!"".equals(cdate))
		{
			tableRow = new ezc.ezvendorapp.params.EzPODeliveryScheduleTableRow();
			tableRow.setDocNo(po);    
			tableRow.setDocItemNo(lines[i]);    
			tableRow.setScheduleLine(scheduleLines[i]);    
			tableRow.setMaterial(material[i]);    
			tableRow.setMaterialDesc(materialDesc[i]);    
			tableRow.setUom(uom[i]);    
			tableRow.setRequiredQty(requiredQty[i]);    
			tableRow.setComittedQty(comittedQty[i]);    
			tableRow.setRequiredDate(dateConvertion(date[i],(String)session.getValue("DATEFORMAT")));    
			tableRow.setComittedDate(dateConvertion(cdate,(String)session.getValue("DATEFORMAT")));    
			tableRow.setSysKey(sysKey);    
			tableRow.setSoldTo(soldTo);    
			tableRow.setExt1("");    
			tableRow.setExt2("");    
			tableRow.setExt3("");    
			table.insertRow(rCount,tableRow);

			int mm=Integer.parseInt(cdate.substring(3,5));
			int dd=Integer.parseInt(cdate.substring(0,2));
			int yy=Integer.parseInt(cdate.substring(6,10));
			GregorianCalendar g=new GregorianCalendar(yy,mm-1,dd);
			Date fromDate=g.getTime();

			shTableRow= new EzBapieketTableRow();
			shTableRow.setDelivDate(fromDate);
			shTableRow.setPoItem(new java.math.BigInteger(lines[i]));
			shTableRow.setSerialNo(new java.math.BigInteger(scheduleLines[i]));
			shTable.insertRow(rCount,shTableRow);

			rCount++;
		}
	}

	EzcParams params2=new EzcParams(false);
	params2.setObject(header);
	params2.setObject(shTable);
	Session.prepareParams(params2);
	ReturnObjFromRetrieve retObj	= null;
	String retMsg = null;

	/***
	try	
	{
		
		retObj = (ReturnObjFromRetrieve) AppManager.ezPostPODeliveryDates(params2);
		for(int i=0;i<retObj.getRowCount();i++)
		{
			String Msg = retObj.getFieldValueString(i,"MSG");
			String Type = retObj.getFieldValueString(i,"TYPE");
			if ("E".equalsIgnoreCase(Type.trim()))
			{
				retMsg= "ERROR : "+Msg;
				break;
			}
			else if ("S".equalsIgnoreCase(Type.trim()))
			{
				retMsg= Msg;
				break;
			}
		}
	}
	catch (Exception ex)
	{
		ezc.ezcommon.EzLog4j.log("Exception in executing PostPoDeliveryDates  to R/3","I");
		retObj = null;
	}
	***/

	//if((retObj!=null) && (retMsg!=null))
	//{	
		EzcParams mainParams1 = new EzcParams(true);
		mainParams1.setLocalStore("Y");	    
		mainParams1.setObject(table);	
		Session.prepareParams(mainParams1);
		ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezAddPODeliverySchedule(mainParams1);

		ezc.ezparam.EzcParams poMainParams = new ezc.ezparam.EzcParams(true);
		poMainParams.setLocalStore("Y");	    

		ezc.ezvendorapp.params.EzPOAcknowledgementTable poTable =  new ezc.ezvendorapp.params.EzPOAcknowledgementTable();
		ezc.ezvendorapp.params.EzPOAcknowledgementTableRow poTableRow = null;
		String podate = request.getParameter("OrderDate");	

		java.util.Date d = new java.util.Date();	
		FormatDate formatDate = new FormatDate();
		String date1=formatDate.getStringFromDate(d,".",FormatDate.DDMMYYYY);

		String ordType = request.getParameter("orderType");
		
		poTableRow =  new ezc.ezvendorapp.params.EzPOAcknowledgementTableRow();

		poTableRow.setDocNo(po);

		String status = "X";	
		poTableRow.setDocStatus(status);

		poTableRow.setModifiedOn(date1);
		poTable.appendRow(poTableRow);	

		poMainParams.setObject(poTable);	
		Session.prepareParams(poMainParams);
		AppManager.ezUpdatePOAcknowledgement(poMainParams);
		
		Hashtable mailData = new Hashtable();
		String temp = "";
		String msgType = "POACK";
		boolean sendToExt = true ;  
		boolean isVendor  = true;	
		
		mailData.put(soldTo,"<b>PO:</b> "+po+"&nbsp;&nbsp;<b>PO Date:</b> "+OrderDate+"&nbsp;&nbsp;<b>Net Amount[USD]:</b>"+NetAmount);
		

		//String msgSubject = "PO : "+po+" Accepted";
		//String msgText= "Purchase Order has been Accepted. Details : \nVendor Code : "+session.getValue("Vendor")+"\nPurchase Area :"+session.getValue("Catalog")+"\nPO : "+po+"   PO Date :"+podate;
		////String sendToUser = request.getParameter("toUser");
		//out.println("sendToUsersendToUsersendToUser>>"+sendToUser);
		
%>
		<%@include file="ezSendMailCounter.jsp"%>


<%
	//}	
	//String poDetailsStr = "¥Click <a href='ezOpenPoLineitems.jsp?orderType=Open&status=X&PurchaseOrder="+po+"' >here</a> to view PO details";
	//response.sendRedirect("../Shipment/ezMessage.jsp?Msg=Thank you for entering the Committed Dates¥A Mail has been sent to selected users informing about your acceptance"+poDetailsStr);
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<script>
function ezHref(param)
{
	document.myForm.action=param;
	document.myForm.submit();
}
	
</script>
</head>
<body bgcolor="#FFFFF7" scroll=no>
<form name="myForm">
<%
	String noDataStatement = "Thank you for entering the Committed Dates<BR>A Mail has been sent to selected users informing about your acceptance";
	noDataStatement = noDataStatement + "<BR>Click <a href='ezOpenPoLineitems.jsp?orderType=Open&status=X&PurchaseOrder="+po+"&fromListAck=Y'>here</a> to view PO details";
	
%>
<%@ include file="../Misc/ezDisplayNoData.jsp" %>

<br><br>
<div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
<center><!--<a href="../Misc/ezSBUWelcome.jsp"><img src="../../Images/Buttons/<%=ButtonDir%>/ok.gif" style="cursor:hand" border=none> -->
<%
		
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		
		buttonName.add("Ok");
		buttonMethod.add("ezHref(\"../Misc/ezSBUWelcome.jsp\")");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
