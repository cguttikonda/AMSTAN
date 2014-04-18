<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page">
</jsp:useBean>

<%

	//ezc.drl.util.EzCurrencyFormat myFormat = new ezc.drl.util.EzCurrencyFormat("Rs",false,false);
	ezc.ezbasicutil.EzCurrencyFormat myFormat= new ezc.ezbasicutil.EzCurrencyFormat();
	myFormat.setLocale((java.util.Locale)session.getValue("LOCALE"));
	myFormat.setNeedSybmol(((Boolean)session.getValue("SREQUIRED")).booleanValue());
	myFormat.isPre(((Boolean)session.getValue("CPOSITION")).booleanValue());
	myFormat.setSymbol((String)session.getValue("CURRENCY"));
	FormatDate formatDate = new FormatDate();
	final String order = "PURCHASEORDER";
	final String pos = "POSITIONNUMBER";
	final String seqn = "SEQUENCENUMBERPO";
	final String recno = "RECEIPTNUMBER";
	final String recdt = "RECEIPTDATE";
	final String delqty = "DELIVEREDQTY";
	final String backqty = "BACKORDERQTY";
	final String matl = "ITEM";
	final String puom = "PURCHASEUNIT";
	final String rrej = "REASONFORREJECTION";
	final String rqty = "REJECTEDQUANTITY";
	final String aqty = "APPROVEDQUANTITY";
	final String deldt = "CURRENTPLANNEDDELIVERYDATE";
	final String rdesc  = "REASONFORREJECTIONDESCRIPTION";
	final String rdescText="PURCHASESTATUSCODE";


	String vorder = "";
	String vpos = "";
	String vseqn = "";
	String vrecno = "";
	Date vrecdt = null;
	String vdelqty = "";
	String vbackqty = "";
	String vmatl = "";
	String vpuom = "";
	String vrrej = "";
	String vrqty = "";
	String vaqty = "";
	Date vdeldt = null;
	String vrdesc = "";
	String vrdescText ="";
	String recStatus = "";

	Hashtable ht= (Hashtable)session.getAttribute("materialDesc");
	Hashtable ht1= (Hashtable)session.getAttribute("materialNos");
	String base = request.getParameter("base");
	String ponum = request.getParameter("PurchaseOrder");  
	String polin = request.getParameter("line"); 
	String desc = request.getParameter("material"); 
	String materialDescFromCtr = request.getParameter("materialDescFromCtr");
	String netOrderAmount = request.getParameter("OrderValue");
	String orderCurrency = request.getParameter("orderCurrency");

	EzPSIInputParameters iparams = new EzPSIInputParameters();
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	Session.prepareParams(newParams);

	EzPurchaseReceipts retobj = new EzPurchaseReceipts();

	iparams.setOrderNumber(ponum);
	iparams.setPositionNum(polin);

	iparams.setOrderNumber(ponum);
	if (base.equals("PContracts")){
		iparams.setPositionNum(polin);
	}
	else{
		iparams.setPositionNum("00");
	}

	retobj =  (EzPurchaseReceipts)PoManager.ezPurchaseOrderReceipts(newParams);


	
	EzPurchaseReceipts ret1=new EzPurchaseReceipts();

	ret1 =  (EzPurchaseReceipts)PoManager.ezPOGoodsReceipts(newParams);
	
	vrecdt =(Date)retobj.getFieldValue(0, recdt);
	String orderDate=request.getParameter("OrderDate");

%>

<html>
<head>
	<title>Purchase Order Receipts</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>

<Script>
var tabHeadWidth=85
var tabHeight="65%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>

</head>

<body bgcolor="#FFFFF7" onLoad="scrollInit()" onResize="scrollInit()" scroll=no>
<TABLE width="55%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr align="center"> 
	<Td class="displayheader"><% if(!"PContracts".equals(base)){%>Purchase Order<%}else{%>Schedule Agreement<%}%> Receipts</td>
	</Tr>	
	</Table>
	<br>
	<Table width="90%" bordercolor="#660066" border="1" align="center">
	<Tr align="center" valign="middle"> 
     		<Th width="20%" bordercolor="#FFFFFF"><% if(!"PContracts".equals(base)){%> PO No<%}else{%>Agreement No<%}%></th>
      	<Td width="15%" bordercolor="#FFFFFF"><%=Long.parseLong(ponum)%></td>
     		<Th width="15%" bordercolor="#FFFFFF"> Date</th>
		<Td width="15%" bordercolor="#FFFFFF"><%=orderDate%></td>
  		<Th width="20%" bordercolor="#FFFFFF">Net Value[<%=orderCurrency%>]</th>
	      <Td width="15%" bordercolor="#FFFFFF" align="right"> <%=myFormat.getCurrencyString(netOrderAmount) %></td>
	</Tr>
	</Table>
	<br>
      <%
if(retobj!=null)
{
	int noofrows = retobj.getRowCount(); 
	if (noofrows ==0)
	{
		%>
		<table id="Table1" width="96%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
     			 <Tr align="center"> 
	             <Td colspan="10" width="70%" >No Receipts present for Purchase Order.</td>
    			 </Tr>
		</table>
		<%
	}	 
	else 
	{	
	%>
		<DIV id="theads">
		<table id="tabHead" width="85%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<Tr align="center" valign="middle"> 
		<Th width="20%">Status</th>
    		<Th width="40%">Material Description</th>
    		<Th width="20%">DC No.</th>
    		<Th width="20%">Del. Qty</th>
		</Tr>
		</Table>
		</DIV>

		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:85%;height:60%;left:2%">
		<TABLE width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
		<%
		for (int i=0; i < noofrows ; i++)
		{
			vorder = "";
			vpuom = retobj.getFieldValueString(i, "PURCHASEORDER");
			vpos = retobj.getFieldValueString(i, pos);
			vseqn = retobj.getFieldValueString(i, "REFDOCNO");
			vrecno = retobj.getFieldValueString(i, recno);
			vrecdt =(Date)retobj.getFieldValue(i, recdt);
			recStatus = retobj.getFieldValueString(i, "STATUSTEXT");
			recStatus=("".equals(recStatus))? "Received":recStatus; 
	
			vdelqty = retobj.getFieldValueString(i, delqty);
			vmatl = retobj.getFieldValueString(i, matl);
			
			String lineNum = new Integer(Integer.parseInt(retobj.getFieldValueString(i, "RESERVED"))).toString();
			String matNoTitle="";
			try{
				desc=(String)ht.get(lineNum);
				if(desc==null)
				{
					desc=" ";		
				}
				matNoTitle=(String)ht1.get(lineNum);
			}
			catch(Exception e)
			{
				out.println("In Catch"+e.getMessage());
			}	
			vrqty = retobj.getFieldValueString(i, rqty);
			vaqty =retobj.getFieldValueString(i, aqty);

			vrdesc =retobj.getFieldValueString(i, "REASONFORREJECTIONDESCRIPTION");
			vrdescText =retobj.getFieldValueString(i, rdescText);

			if   ("None".equals(vrdescText)) 	
				vrdescText=vrdesc;
			%>

			<Tr align="center"> 
		    	<Td width="20%">
			<%
			if(recStatus.equals("Invoiced")||recStatus.equals("Partly Invoiced"))
			{
			%>	<a href="../Purorder/ezWaitPOInvoices.jsp?PurchaseOrder=<%=ponum%>&base=<%=base%>&OrderValue=<%=netOrderAmount%>&orderCurrency=<%=orderCurrency%>&GRNo=<%=vrecno%>"   onMouseover="window.status='Click to view Invoice Details. '; return true" onMouseout="window.status=' '; return true">
				<%=recStatus%></a>
			<%}
			else
			{
				out.println(recStatus);
			} 
			%>
			</td>
			<% if (materialDescFromCtr != null)
			{ %>	
    				<td width="40%" align="left"><%=desc%></td>
			<% } else { %>
				<td width="40%" align="left"><%=desc%></td>
			<% } %>
	
    			<td width="20%"><%=vseqn%>&nbsp;</td>
			<td  width="20%" align="right"><%=vdelqty%></td>
     			</tr>
			<%
		}
	} // end if nrofrows  = 0
	%>
	</Table>
	</div>

	<div id="back" style="position:absolute;top:90%;left:43%">
	<a href='javascript:history.go(-1)' onMouseover="window.status=' back'; return true" onMouseout="window.status=' '; return true"><img src="../../Images/Buttons/<%=ButtonDir%>/back.gif"  border="none" valign=bottom ></a>
	</div>
<%
 } //end if retObj !=null 
%>

</form>
<Div id="MenuSol"></Div>
</body>
</html>
