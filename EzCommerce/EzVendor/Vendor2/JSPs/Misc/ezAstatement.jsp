<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ page import="java.util.*" %>
<%@ include file="../../../Includes/JSPs/Labels/iAstatement_Labels.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>
<%
	ezc.ezutil.FormatDate formatDate = new ezc.ezutil.FormatDate();
	String ShowData = request.getParameter("ShowData");
	if(ShowData == null)
		ShowData = "N";
	else
		ShowData = "Y";
	ShowData = "Y";	
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	String base 	= request.getParameter("FromForm");
	String fd 	= request.getParameter("FromDate");
	String td 	= request.getParameter("ToDate");
	
	
	if(fd == null || td == null)
	{
		Date toDate 	= new Date();
		int today 	= toDate.getDate();
		int thismonth  	= toDate.getMonth()+1;
		int thisyear 	= toDate.getYear()+1900;

		Date fromDate =  new Date();
		fromDate.setDate((toDate.getDate()-120));
		int prevdate =  1;
		int prevmonth = fromDate.getMonth()+1;
		int prevyear =  fromDate.getYear()+1900;

		String todayStr 	= "";
		String prevdateStr 	= "";
		String thismonthStr 	= "";
		String prevmonthStr 	= "";

		if(today < 10)
			todayStr = "0"+today;
		else
			todayStr = ""+today;

		if(prevdate < 10)
			prevdateStr = "0"+prevdate;
		else
			prevdateStr = ""+prevdate;

		if(thismonth < 10)
			thismonthStr = "0" + thismonth;
		else
			thismonthStr = "" + thismonth;

		if(prevmonth < 10)
			prevmonthStr = "0" + prevmonth;	
		else	
			prevmonthStr = "" + prevmonth;

		fd = prevmonthStr+(String)session.getValue("DATESEPERATOR")+prevdateStr+(String)session.getValue("DATESEPERATOR")+prevyear;
		td = thismonthStr+(String)session.getValue("DATESEPERATOR")+todayStr+(String)session.getValue("DATESEPERATOR")+thisyear;
		
	}		
	
	
	int dataCount = 0;
	ezc.ezparam.EzInvoice SeqInv = new ezc.ezparam.EzInvoice();
	
	Date balDate = null;
	
	Date fromDateObj = null;
	Date toDateObj = null;
	double invBal = 0;
	if(fd != null && td != null)
	{
		//fd = dateConvertion(fd,(String)session.getValue("DATEFORMAT"));
		//td = dateConvertion(td,(String)session.getValue("DATEFORMAT"));
		
		GregorianCalendar gc=new GregorianCalendar(Integer.parseInt(fd.substring(6,10)),Integer.parseInt(fd.substring(0,2))-1,Integer.parseInt(fd.substring(3,5)));
		fromDateObj = gc.getTime();
		gc.add(Calendar.DATE,-1);
		balDate = gc.getTime();

		gc=new GregorianCalendar(Integer.parseInt(td.substring(6,10)),Integer.parseInt(td.substring(0,2))-1,Integer.parseInt(td.substring(3,5)));
		toDateObj = gc.getTime();
		
		
		
		

		//---------TO GET LIST OF ALL INVOICES OF INVFLAG 'D'

		ezc.client.EzVendorInvManager VendInvManager = new ezc.client.EzVendorInvManager();


		ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();
		ezc.ezparam.EzVendorParams ioparams = new ezc.ezparam.EzVendorParams();
		ezc.ezvendor.params.EziVendorInvoiceInputParams eviip = new ezc.ezvendor.params.EziVendorInvoiceInputParams();

		eviip.setInvoiceFlag("B");
		ioparams.setToDate(toDateObj);		//fromDateObj
		ioparams.setFromDate(fromDateObj);

		newParams.createContainer();
		newParams.setObject(ioparams);
		newParams.setObject(eviip);
		Session.prepareParams(newParams);
		SeqInv = (ezc.ezparam.EzInvoice)VendInvManager.getListOfInvoicesAndDocuments(newParams);


		ezc.ezparam.EzVendorParams ioparams1 = new ezc.ezparam.EzVendorParams();
		ezc.ezparam.EzcVendorParams newParams1 = new ezc.ezparam.EzcVendorParams();
		ezc.ezvendor.params.EziVendorInvoiceInputParams eviip1 = new ezc.ezvendor.params.EziVendorInvoiceInputParams();

		ioparams1.setToDate(balDate);//fromDateObj);
		ioparams1.setFromDate(balDate);//fromDateObj);

		eviip1.setInvoiceFlag("B");
		newParams1.createContainer();
		newParams1.setObject(ioparams1);
		Session.prepareParams(newParams1);

		ezc.ezvendor.client.EzVendorManager VendManager = new ezc.ezvendor.client.EzVendorManager();
		ezc.ezparam.EzSupplBalance supplbal = (ezc.ezparam.EzSupplBalance)VendManager.getVendorBalance(newParams1);

		for(int i=0;i<supplbal.getRowCount();i++)
		{
			if (!"O".equalsIgnoreCase(supplbal.getFieldValueString(i,"SPGLIND")))
			{
				try
				{
					invBal +=Double.parseDouble(supplbal.getFieldValueString(i,"LCBAL"));
				}
				catch(Exception e)
				{
					invBal += 0;
				}
			}
		}
		invBal *=-1;
		dataCount = SeqInv.getRowCount();
	}	
%>
<html>
<head>
<Script>
	var tabHeadWidth=96
	var tabHeight="50%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<script src="../../Library/JavaScript/ezConvertDates.js"></Script>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<%@ include file="../../../../EzCommon/Includes/iShowCal.jsp"%>
<script>

	var plzSelFDate_A = '<%=plzSelFDate_A%>';
	var plzSelTDate_A = '<%=plzSelTDate_A%>';
	var fDateLessTDate_A = '<%=fDateLessTDate_A%>';
	function chkDates()
	{
		var fd = document.ACStatementForm.FromDate.value;
		var td = document.ACStatementForm.ToDate.value;

		if(fd=="")
		{
			alert(plzSelFDate_A);
			return false;
		}
		
		if(td=="")
		{
			alert(plzSelTDate_A);
			return false;
		}	
		
		fd = ConvertDate(fd,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')
		td = ConvertDate(td,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>')

		fd1 = new Date();
		td1 = new Date();
		a = fd.split(".");
		var a1 = parseInt(a[1],10)-1
		fd1 = new Date(a[2],a1,a[0])
		b = td.split(".");
		var b1 = parseInt(b[1],10)-1
		td1 = new Date(b[2],b1,b[0])

		if(fd1 > td1)
		{
			alert(fDateLessTDate_A);
			document.ACStatementForm.FromDate.focus();
			return false;
		}
		return true;
	}

	function getDefaultsFromTo()
	{
<%
		if(fd != null && td != null)
		{
%>
			document.ACStatementForm.ToDate.value = "<%=td%>"
			document.ACStatementForm.FromDate.value = "<%=fd%>"
<%
		}
		else
		{
%>
			toDateObj = new Date();
			today 		= toDateObj.getDate();
			thismonth 	= toDateObj.getMonth()+1;
			thisyear 	= toDateObj.getYear();
			if(!document.all)
			{
				thisyear = thisyear+1900;
			}
			if(today < 10)
				today = "0"+today;
			if(thismonth < 10)
				thismonth = "0" + thismonth;

			document.ACStatementForm.ToDate.value = ConvertDateFormat(today+'.'+thismonth+'.'+thisyear,'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
			if(thismonth < 4)
				document.ACStatementForm.FromDate.value = ConvertDateFormat('01.04.'+(thisyear-1),'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
			else
				document.ACStatementForm.FromDate.value = ConvertDateFormat('01.04.'+(thisyear),'<%=Integer.parseInt((String)session.getValue("DATEFORMAT"))%>','<%=(String)session.getValue("DATESEPERATOR")%>');
<%
		}
%>
	}

	function ezSubmit()
	{
		y=chkDates();
		if(y)
		{
			document.forms[0].method="post"
			document.forms[0].ShowData.value='Y';
			document.forms[0].submit();
		}
	}
	</script>
</head>


<body onLoad = "getDefaultsFromTo();scrollInit()" onResize="scrollInit()" scroll=no>
<form  method="post" name="ACStatementForm"  action="ezAstatementWait.jsp">
<input type="hidden" name="InvStat" value="D">
<input type="hidden" name="FromForm" value="ACStatement">
<input type="hidden" name="ShowData">
<% 
	String display_header = stAccEntBooks_L; 
	String clickString = "onclick='ezSubmit()'";
	String fromDate = "";
	String toDate 	= "";
	
%> 
	<%@ include file="../Misc/ezDisplayHeader.jsp" %>
	
	<%@ include file="../Misc/ezSelectDate.jsp"%>
<%
	if("Y".equals(ShowData))
	{
		if(dataCount == 0)
		{
			String noDataStatement = noTransPeriod_L;
%>
			<%@ include file="../Misc/ezDisplayNoData.jsp" %>
			<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
			<Center>
			<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
			
				buttonName.add("Back");
				buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
			
				out.println(getButtonStr(buttonName,buttonMethod));
			%>
			</Center>
			</Div>
<%
		}
		else
		{
%>
			<BR>
			<div id="theads">
			<Table id="tabHead" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
			<Tr>
				<th width="16%" rowspan="2"><%=transDate_L%></th>
				<th width="16%" rowspan="2"><%=particulars_L%></th>
				<th width="16%" rowspan="2"><%=docNo_L%></th>
				<th colspan="2"><%=transAmount_L%></th>
				<th width="16%" rowspan="2"><%=bal_L%></th>
			</Tr>
			<Tr>
				<th width="16%" ><%=debit_L%></th>
				<th width="16%" ><%=credit_L%></th>
			</Tr>
			</table>
			</div>

			<div id="InnerBox1Div" STYLE='overflow:auto;Position:Absolute;width:96%;Left=2%;height:50%' align="center">
			<table id="InnerBox1Tab" width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%			
			String invDt = null;
			Date dt1 = null;
			int items = 0;
			String fontColor = null;
			String tdBGColor = null;
			String tdClass = null;
			String acType = null;
			double totAmount = 0;
			double balance = 0;
			double invAmt = 0;
			String str[]={"INVOICEDATE"};
			boolean b=SeqInv.sort(str,true);

			String dbcrIndicator = new String();
			for(int i=0;i<dataCount;i++)
			{
				dt1= (Date)SeqInv.getFieldValue(i,"POSTINGDATE"); // ADDED BY MUKESH
				invDt = formatDate.getStringFromDate(dt1,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));

				if((fromDateObj.compareTo(dt1) <= 0) && (toDateObj.compareTo(dt1) >=0))
				{
					items += 1;
					try{
						invAmt = Double.parseDouble(SeqInv.getFieldValueString(i,"AMOUNT"));
					}catch(Exception numFmtEx)
					{
						invAmt = 0;
					}
					totAmount += invAmt;
					if(SeqInv.getFieldValueString(i,"DBCRINDICATOR").equals("H"))
					{
						fontColor = "black";
						acType = "Credit";
						tdClass = "credit";
						balance = invBal + invAmt;
						dbcrIndicator = "";
					}
					else
					{
						fontColor = "red";
						acType = "Debit";
						tdClass = "debit";
						balance = invBal - invAmt;
						dbcrIndicator = "-";
					}
					if (SeqInv.getFieldValueString(i,"DOCTYPE").equals("KZ"))
					{
						acType="Payment";
					}
					if (SeqInv.getFieldValueString(i,"DOCTYPE").equals("RE"))
					{
						acType="Invoice";
					}
					if (SeqInv.getFieldValueString(i,"DOCTYPE").equals("AB"))
					{
						acType="A/c Adjustments";
					}
					if (SeqInv.getFieldValueString(i,"DOCTYPE").equals("OV"))
					{
						acType="Carry Forward";
					}
%>		
					<tr>
						<td width="16%" align="center" style="color:black"><%=invDt%></td>
						<td width="16%" ><%=acType%>&nbsp;</td>
						<td width="16%"><%=SeqInv.getFieldValueString(i,"REFDOC")%>&nbsp;</td>
<%
						if (dbcrIndicator.equals("-")) 
						{	
%>	
							<td width='16%' align='right' class='<%=tdClass%>'><%=myFormat.getCurrencyString(SeqInv.getFieldValueString(i,"AMOUNT"))%>&nbsp;</td>
<%	
						}
%>
						<td align="right" width="16%" class="<%=tdClass%>">&nbsp;</td>
<%
						if (dbcrIndicator.equals("")) 
						{
							out.println("<td width=\"16%\" align=\"right\">"+" "+myFormat.getCurrencyString(SeqInv.getFieldValueString(i,"AMOUNT"))+"&nbsp;</td>");
						}
						if(balance<0)
						{
%>						
							<td width="16%" align="right" style="color:red">
								<%=myFormat.getCurrencyString(balance)%>&nbsp;
<%
						}
						else
						{
%>		
							<td width="16%" align="right">
<%		
							out.println(myFormat.getCurrencyString(balance));
						}
%>
						&nbsp;
						</td>
						</font>
					</tr>
<%		
					invBal = balance;
				}
			}
%>			
			</table>
			</div>
<%
		}
%>
		<Div id="ButtonDiv" style="position:absolute;top:90%;width:100%;visibility:visible">
		<Center>
		<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
		
			buttonName.add("Back");
			buttonMethod.add("navigateBack(\"../Misc/ezSBUWelcome.jsp\")");
		
			out.println(getButtonStr(buttonName,buttonMethod));
		%>
		</Center>
		</Div>
<%
	}	
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
