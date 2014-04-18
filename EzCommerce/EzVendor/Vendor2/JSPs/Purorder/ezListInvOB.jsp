<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Labels/iListInvOB_Labels.jsp"%>
<%
	int totInv = 0;
	String invoiceFlag 	= request.getParameter("InvStat");
	String invCur 		= request.getParameter("invCur");
	String invBal 		= request.getParameter("invBal");
	String display_header 	= invoiceList_L; 
	String noDataStatement = noInvEx_L;
	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
%>
<html>
<head>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<link rel="STYLESHEET" type="text/css" href="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.css">
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXCommon.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGrid.js"></Script>
<Script src="../../../../EzCommon/JavaScript/Grid/dhtmlXGridCell.js"></Script>
<Script>
	var radioData = ""
	var mygrid;
	function doOnCheck(rowId,cellInd,state)
	{
		radioData = rowId;		
	}
	function doOnLoad()
	{
		mygrid = new dhtmlXGridObject('gridbox');
		mygrid.imgURL = "../../../../EzCommon/Images/Grid/";
		//mygrid.setHeader("&nbsp;,<%=vendInvNum_L%>,<%=sapInvNum_L%>,<%=invoiceDate_L%>,<%=invoiceVal_L+"["+invCur+"]"%>,<%="Appr. Amount"+"["+invCur+"]"%>,<%=paidAmt_L+"["+invCur+"]"%>");
		mygrid.setHeader("&nbsp;,<%=vendInvNum_L%>,<%=sapInvNum_L%>,<%=invoiceDate_L%>,<%=invoiceVal_L+"["+invCur+"]"%>,<%="Appr. Amount"+"["+invCur+"]"%>");
		mygrid.setNoHeader(false)
		//mygrid.setInitWidthsP("6,16,14,16,16,16,16")
		//mygrid.setColAlign("center,left,center,center,right,right,right")
		//mygrid.setColTypes("ra,ro,ro,ro,ro,ro,ro");
		//mygrid.setColSorting("str,str,int,int,str,str,int")
		mygrid.setInitWidthsP("6,18,16,20,20,20")
		mygrid.setColAlign("center,left,center,center,right,right")
		mygrid.setColTypes("ra,ro,ro,ro,ro,ro")
		mygrid.setColSorting("str,str,int,int,str,str")
		mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
		mygrid.setOnCheckHandler(doOnCheck);
		mygrid.enableBuffering(50);
		mygrid.init();
		mygrid.loadXML("ezListInvOBGrid.jsp?invBal=<%=invBal%>&invCur=<%=invCur%>&InvStat=<%=invoiceFlag%>");
	}	
	
	function doOnUnLoad()
	{
		if(mygrid)
			mygrid=mygrid.destructor();
	}	
</Script>
<script>
	var noInvToShow_L = '<%=noInvToShow_L%>';
	function submitForm()
	{
		if(radioData != null && radioData != "")
		{
			document.myForm.InvDtls.value=radioData;
			setMessageVisible()
			document.myForm.action="ezInvPaymentDetails.jsp";
			document.myForm.submit();
		}
		else
		{
			alert("Select the Invoce you would like to view the details");
		}
	}
</script>
</head>
<body method="post" scroll=no onLoad="doOnLoad()">
<%@ include file="../Misc/ezDisplayHeader.jsp" %>

<Div id='inputDiv' style='position:absolute;align:center;top:8%;width:100%;'>
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
				<Td style="background-color:'F3F3F3';" align='right'>
					<font size=2><B>Total Balance&nbsp;[<%=invCur%>]&nbsp;:&nbsp;</B><%=myFormat.getCurrencyString(invBal)%></font>
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

<form method="post" name="myForm">
<%@ include file="../Misc/ezDisplayGrid.jsp" %>
<Div id="ButtonDiv" style="position:absolute;top:90%;visibility:hidden;width:100%">
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Back");
	buttonMethod.add("history.go(-1)");
	
	buttonName.add("Payment Details");
	buttonMethod.add("submitForm()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
</div>
<%@ include file="../Misc/AddMessage.jsp" %>
<input type="hidden" name="chkField">
<input type="hidden" name="base" value="ListInvOB">
<input type="hidden" name="InvDtls">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
