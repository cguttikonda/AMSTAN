<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iPoReceiptDetails_Labels.jsp"%>
<%
	String base 			= request.getParameter("base");
	String ponum			= request.getParameter("PurchaseOrder");
	String polin 			= request.getParameter("line");
	String desc 			= request.getParameter("material");
	String materialDescFromCtr 	= request.getParameter("materialDescFromCtr");
	String netOrderAmount 		= request.getParameter("OrderValue");
	String orderCurrency 		= request.getParameter("orderCurrency");
	String vendorNo 		= request.getParameter("vendorNo");
	String orderDate		= request.getParameter("OrderDate");
	
	String mySysKeyTemp		=(String)session.getValue("SYSKEY");
	String mySoldToTemp		=(String)session.getValue("SOLDTO");	

	String queryString = "base="+base+"&PurchaseOrder="+ponum+"&line="+polin+"&material="+desc+"&materialDescFromCtr="+materialDescFromCtr;
	queryString += "&OrderValue="+netOrderAmount+"&orderCurrency="+orderCurrency+"&vendorNo="+vendorNo+"&OrderDate="+orderDate;

	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	
	String display_header 	= poReceipt_L;
	String noDataStatement 	= noReceiptPo_L;
	String label1 	= "Purchase Order";
	
	if(base.equals("PContracts")){
		display_header 	= "Schedule Agreement Receipts";
		noDataStatement = "No Receipts present for Schedule Agreement";
		label1 	= "Schedule Agreement";
		
	}
	
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script>
	function doOnLoad()
	{
		
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		mygrid.setHeader('<%=status_L+","+matDesc_L+","+dnNo_L+","+grNum_L+","+grDate_L+","+delivQuant_L+","+approveQuant_L+","+rejectQuant_L%>');
		mygrid.setNoHeader(false)
		mygrid.setInitWidthsP("15,14,13,12,10,13,12,11")
		mygrid.setColAlign("left,left,center,center,center,right,right,right")
		mygrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro");
		mygrid.setColSorting("str,str,str,str,date,int,int,int")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezPoReceiptDetailsGrid.jsp?<%=queryString%>");

	}	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>
</head>
<body method="post" scroll=no onLoad="doOnLoad()">
<%@ include file="../Misc/ezDisplayHeader.jsp" %>
<Div id='inputDiv' style='position:relative;align:center;top:1%;width:100%;'>
<Table width="80%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
<Tr>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
	<Td style="background-color:'F3F3F3'" valign=middle>
		<Table border="0" align="center" valign=middle width="100%" class=welcomecell>
			<Tr>
				<Td style="background-color:'F3F3F3';" align='left'>
					<font size=2><B><%=label1%>&nbsp;:&nbsp;</B><%=Long.parseLong(ponum)%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='center'>
					<font size=2><B><%=orderDate_L%>&nbsp;:&nbsp;</B><%=orderDate%></font>
				</Td>
				<Td style="background-color:'F3F3F3';" align='right'>
					<font size=2><B><%=value_L%>[<%=orderCurrency%>]&nbsp;:&nbsp;</B><%=netOrderAmount%></font>
				</Td>
			</Tr>
		</Table>
	</Td>
	<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
</Tr>
<Tr>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
	<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
	<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
</Tr>
</Table>
</Div>


<%@ include file="../Misc/ezDisplayGrid.jsp" %>

<Div id="ButtonCheck" style="position:absolute;top:90%;width:100%;visibility:visible">
<Center>
<%
buttonName = new java.util.ArrayList();
buttonMethod = new java.util.ArrayList();

buttonName.add("Back");
buttonMethod.add("history.go(-1)");

out.println(getButtonStr(buttonName,buttonMethod));
%>
</Center>
</Div>
<Div id="ButtonDiv" style="position:absolute;top:95%;width:100%;visibility:hidden">
	<center><font color='blue' size="-1"><%=rejQtyHyp_L%></font></center>
</Div>
<input type="hidden" name="frmpagereq" value="porecps" >
</form>
<Div id="MenuSol"></Div>
</body>
</html>
