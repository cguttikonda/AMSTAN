<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezvendinvoice.csb.*" %>

<jsp:useBean id="VendInvManager" class ="ezc.client.EzVendorInvManager" scope="page">
</jsp:useBean>


<%
final String feild1 = "PURCHASEORDER";
final String feild2 = "POSITIONNUMBER";
final String feild3 = "SEQUENCENUMBERPO";
final String feild4 = "SUPPLIER";
final String feild5 = "NAME";
final String feild6 = "ITEM";
final String feild7 = "QUANTITYONPACKINGSLIP";
final String feild8 = "RECEIPTDATE";
final String feild9 = "DELIVEREDQTY";
final String feild10 = "BACKORDERQTY";
final String feild11 = "PURCHASEUNIT";
final String feild12 = "AMOUNT";
final String feild13 = "INVOICEDAMOUNT";
final String feild14 = "INVOICEDATE";
final String feild15 = "INVOICENUMBER";
final String feild16 = "INVOICEDQUANTITY";
final String feild17 = "ORDERLINEDISCOUNTAMOUNT";
final String feild18 = "RECORDSTATUS";
final String feild19 = "DESCRIPTION";
final String field20="INVOICECURRENCY";
final String field21="PAYMENTDATE";
final String field22="PAIDAMOUNT";
final String field23="CHEQUENUMBER";
final String field24="BANKNAME";
final String field25="BANKADDRESS";
final String field26="BANKCOUNTRY";
final String field27="RECEIPTNUMBER";

String orno = "";
String pono = "";
String seqn = "";
String supp = "";
String name = "";
String item = "";
String desc = "";
String qty = "";
String rdate = "";
String ddate = "";
String bqty = "";
String punit = "";
String amnt = "";
String iamnt = "";
Date idate = null;
String inum = "";
String iqty = "";
String odis = "";
String rStatus="";
String description="";
String invCurr="";
String paydate="";
String pAmount="";
String chequeNumber="";
String bName="";
String bCountry=""; 
String bAddress="";
String grNum="";

String invnum = null;
String invDate = null;
String compCode = null;
String invAmount = null;
String invCur = null;
String postDate = null;
String docType = null;
String poNum = null;

String fromDate	=request.getParameter("FromDate");
String toDate	=request.getParameter("ToDate");
String listBack	=request.getParameter("listBack");
String InvStat	=request.getParameter("InvStat");
String searchField=request.getParameter("searchField");
String frmPage	=request.getParameter("frmpagereq");



EzInvoice SeqInv1 = new EzInvoice();
EzVendorParams ioparams = new EzVendorParams();
ezc.ezparam.EzcVendorParams newParams = new ezc.ezparam.EzcVendorParams();

newParams.createContainer();
newParams.setObject(ioparams);

Session.prepareParams(newParams);

String base = request.getParameter("base");
if(base != null && base.equals("ListInvOB") )
{
	StringTokenizer st =  new StringTokenizer(request.getParameter("InvDtls"),"|");

	invnum = st.nextToken();
	invDate = st.nextToken();
	invAmount = st.nextToken();
	compCode = st.nextToken();
	invCur = st.nextToken();
	postDate = st.nextToken();
	docType = st.nextToken();
	try{
		poNum = st.nextToken();
	}catch(Exception e)
	{poNum = "Not Available";}
}
else
{
	invnum = request.getParameter("invnum");
	invDate=request.getParameter("invDate");
	compCode=request.getParameter("compCode");
	invCur=request.getParameter("invCur");
	invAmount = request.getParameter("invAmount");
	try{
	invAmount = invAmount.replaceAll(",","");
	if(Double.parseDouble(invAmount) == 0)
		invAmount = request.getParameter("invAmount1");
	}catch(Exception e){ }	
	postDate = request.getParameter("PostDate");
	docType = request.getParameter("docType");
	poNum =  request.getParameter("purNum");
}

String invNo = invnum;


if (invnum.length()!=10)
{
	int len=invnum.length();
	int i=10-len;
	for (int k=0;k<i;k++)
		invnum="0"+invnum;
}
	
	Date invoiceDt = new Date(invDate);
	
	Date dt = new Date();
	dt.setMonth(invoiceDt.getMonth());
	dt.setDate(invoiceDt.getDate());
	dt.setYear(invoiceDt.getYear());
	

	Date ptDate = new Date();

	String fromGRDTL = request.getParameter("fromGRDTL");
	if("Y".equals(fromGRDTL))
	{
		ptDate.setDate(Integer.parseInt(postDate.substring(3,5)));
		ptDate.setMonth(Integer.parseInt(postDate.substring(0,2))-1);
		ptDate.setYear(Integer.parseInt(postDate.substring(6,10))-1900);
	}
	else
	{
		ptDate.setDate(Integer.parseInt(postDate.substring(0,2)));
		ptDate.setMonth(Integer.parseInt(postDate.substring(3,5))-1);
		ptDate.setYear(Integer.parseInt(postDate.substring(6,10))-1900);
	}

	ioparams.setVendInvoiceNo(invnum);
	ioparams.setCompCode(compCode);
	ioparams.setToDate(ptDate);
	SeqInv1 = (EzInvoice)VendInvManager.getInvoiceDetails(newParams);
	
	
	EzInvoice SeqInv = (EzInvoice)SeqInv1.getObject("ItemData");
	EzInvoice SeqInv2 = (EzInvoice)SeqInv1.getObject("PaymentInfo");
	
	//ezc.ezcommon.EzLog4j.log("MY CJHCKKLJHASHFDJFSHFSHFSKJHFD"+SeqInv.toEzcString(),"I");
	ezc.ezcommon.EzLog4j.log("MY  2323CHKINVINVINVVALUE2222>>>>>>>>"+SeqInv2.toEzcString(),"I");
%>
