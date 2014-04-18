<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%System.out.println("11111111111111111");	%>

<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%System.out.println("222222222222222");	%>
<%@ page import ="ezc.ezparam.*" %>
<%System.out.println("3333333333333333");	%>
<%@ page import="ezc.customer.invoice.params.*" %>
<%System.out.println("4444444444444444");	%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%System.out.println("55555555555555555555");	%>
<jsp:useBean id="SalesInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<%System.out.println("666666666666666666");	%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%System.out.println("77777777777777777777");	%>
<%@ include file="../../../Includes/JSPs/Lables/iInvoiceDetails_Lables.jsp" %>
<%System.out.println("8888888888888888888888888");	%>
<%
	int invcount = 0;
	ReturnObjFromRetrieve lineItems =null;
	ReturnObjFromRetrieve dlineItems =null;

	FormatDate formatDate = new FormatDate();

	ReturnObjFromRetrieve SeqInv = null;
	EzCustomerParams ioparams = new EzCustomerParams();


	ezc.customer.invoice.params.EzcCustomerInvoiceParams newParams=new ezc.customer.invoice.params.EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams ecip = new EziCustomerInvoiceParams();

	ecip.setKeyDate(new Date());
	ecip.setInvFlag("O");
	ecip.setSelection(billto);//payer

	newParams.createContainer();
	newParams.setObject(ioparams);
	newParams.setObject(ecip);
	Session.prepareParams(newParams);

	
	SeqInv = (ReturnObjFromRetrieve) SalesInvManager.getCustomerInvoices(newParams);
	lineItems = (ReturnObjFromRetrieve)SeqInv.getFieldValue("LINEITEMS");
	
	
System.out.println("lineItemslineItemslineItemslineItems");	
lineItems.toEzcString();	
System.out.println("lineItemslineItemslineItemslineItems");	
	
	try{
		lineItems.sort(new String[]{"postingDate"},true);
	}catch(Exception e){}


	if (lineItems!=null)
	{
		int rowno = lineItems.getRowCount();
		for (int i= 0; i<rowno ; i++)
		{
			if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
					invcount++;
		}

	if (invcount > 0)
	{
	
	dlineItems=new ReturnObjFromRetrieve();
	String objColumns[]={"BILLINGDOCUMENTNO","SAPINVOICENO","DELIVERYDOCUMENTNO","INVOICEDATE","DUEDATE","INVOICEVALUE"};						
	dlineItems.addColumns(objColumns);

%>

	int LrowCount=orderList.getRowCount();
	System.out.println("<?xml version=\"1.0\"?>");
	System.out.println("<rows>");
	int p = 0;
	for(int i=0;i<rowno;i++)
	{

		if("RV".equals(lineItems.getFieldValueString(i,"DocType")) )
		{
			Date postingDate=(Date)lineItems.getFieldValue(i,"PstngDate");
			Date blineDate=(Date)lineItems.getFieldValue(i,"BlineDate");
			invNum = lineItems.getFieldValueString(i,"DocNo");
			//custInvNum = lineItems.getFieldValueString(i,"AllocNmbr").trim();
			custbillNum =  lineItems.getFieldValueString(i,"RefDoc").trim();
			delDocNo =lineItems.getFieldValueString(i,"RefKey1").trim();

			invAm = lineItems.getFieldValueString(i,"Amount");

			String  formatkey=(String)session.getValue("formatKey");

			dlineItems.setFieldValue("BILLINGDOCUMENTNO",custbillNum);
			dlineItems.setFieldValue("SAPINVOICENO",invNum);
			dlineItems.setFieldValue("DELIVERYDOCUMENTNO",delDocNo);
			dlineItems.setFieldValue("INVOICEDATE",FormatDate.getStringFromDate(postingDate,formatkey,FormatDate.MMDDYYYY));
			dlineItems.setFieldValue("DUEDATE",formatDate.getStringFromDate(blineDate,formatkey,FormatDate.MMDDYYYY));
			dlineItems.setFieldValue("INVOICEVALUE",invAm);
			dlineItems.addRow();

			System.out.println("<row id='"+custbillNum+"'><cell><![CDATA[<nobr><a href='../Sales/ezBackWaitSalesDisplay.jsp"+invNum+delDocNo+"</a></nobr>]]></cell><cell>"+delDocNo+"</cell><cell>N/A</cell><cell>"+delDocNo+"</cell><cell>"+delDocNo+"</cell></row>");

		}
	}	
	System.out.println("</rows>");
%>
<Div id="MenuSol"></Div>