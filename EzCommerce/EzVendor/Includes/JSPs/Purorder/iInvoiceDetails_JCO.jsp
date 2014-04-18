<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@page  import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezparam.*,ezc.ezcommon.*"%>
<%
	String site = (String)session.getValue("Site");
	if(site==null || "null".equals(site))
	site="641~999";
	else
	site=site.trim()+"~999";
	
	com.sap.mw.jco.JCO.Function function = EzSAPHandler.getFunction("Z_EZ_GET_INVOICE_DTL",site);
	com.sap.mw.jco.JCO.ParameterList parameterlist 	= function.getImportParameterList();
	JCO.Client client = null;
	

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

String vendor = null;
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
Date dt = new Date(invDate);
Date invdt = new Date();

vendor	=((String)session.getValue("SOLDTO")).trim();


if (invnum.length()!=10)
{
	int len=invnum.length();
	int i=10-len;
	for (int k=0;k<i;k++)
		invnum="0"+invnum;
}
ezc.ezcommon.EzLog4j.log("MY  invnum>"+invnum,"I");
ezc.ezcommon.EzLog4j.log("MY  vendor>"+vendor,"I");
ezc.ezcommon.EzLog4j.log("MY  compCode>"+compCode,"I");
ezc.ezcommon.EzLog4j.log("MY  INVDATE>"+dt,"I");


	parameterlist.setValue(invnum,"INVOICEDOCNUMBER");
	parameterlist.setValue(vendor,"VENDOR");
	parameterlist.setValue(compCode,"COMPANYCODE");
	parameterlist.setValue(dt,"INVDATE");

	try{
		client = EzSAPHandler.getSAPConnection(site);
		client.execute(function);
	}
	catch(Exception err)
	{
		System.out.println("=====>"+err);
	}
	


	EzInvoice itemData = new EzInvoice();
	EzInvoice paymentInfo = new EzInvoice();
	EzInvoice finalInvoice = new EzInvoice();

	
	try {

		/* Structure/Table for populating Item Data Information */
		
		JCO.ParameterList expParam = function.getExportParameterList();
		JCO.Structure invHeader =(JCO.Structure)expParam.getStructure("HEADERDATA");
		JCO.Table sapInvTable = function.getTableParameterList().getTable("ITEMDATA");
		
		int invCount = sapInvTable.getNumRows();
		
		if(invCount>0){
			do{
				//Set Invoice Number
				itemData.setFieldValue("INVOICENUMBER", invHeader.getValue("INV_DOC_NO"));
				//Set Invoice Date
				itemData.setFieldValue("INVOICEDATE", invHeader.getValue("DOC_DATE"));
				//Set Purchase Order
				itemData.setFieldValue("PURCHASEORDER", sapInvTable.getValue("PO_NUMBER"));
				//Set Line Number
				itemData.setFieldValue("POSITIONNUMBER", sapInvTable.getValue("PO_ITEM"));
				//set Purchase Unit
				itemData.setFieldValue("PURCHASEUNIT", sapInvTable.getValue("PO_UNIT"));
				//set Invoiced Quantity
				itemData.setFieldValue("INVOICEDQUANTITY", sapInvTable.getValue("QUANTITY")); // Added 07/25/2001
				//Set Item
				itemData.setFieldValue("ITEM", sapInvTable.getValue("MATERIAL"));
				//Set Item Description
				itemData.setFieldValue("DESCRIPTION", sapInvTable.getValue("SHORT_TEXT"));
				//Set Net Amount
				itemData.setFieldValue("INVOICEDAMOUNT", sapInvTable.getValue("ITEM_AMOUNT"));
				itemData.setFieldValue("INVOICECURRENCY", invHeader.getValue("CURRENCY"));
				itemData.setFieldValue("RECEIPTNUMBER", sapInvTable.getValue("REF_DOC"));
				itemData.setFieldValue("DBCRINDICATOR", sapInvTable.getValue("DE_CRE_IND"));
				// 1. <<<< 07/21/2001 ... Change for GR Number, Ext1, Ext2
				itemData.setFieldValue("GRNUMBER", sapInvTable.getValue("MAT_DOC"));
				//itemData.setFieldValue("EXT1", sapInvTable.getValue("EXT1"));
				itemData.setFieldValue("EXT2", sapInvTable.getValue("EXT2"));
				// 1. >>>> 07/21/2001
				itemData.addRow();
			}while(sapInvTable.nextRow());
		}
		
		/* Structure/Table for populating bank details */
		JCO.Table bankDetailsTable = function.getTableParameterList().getTable("BANKDETAILS");   
		int payCount = bankDetailsTable.getNumRows();
		
		if(payCount>0){
			do{
				
				ezc.ezcommon.EzLog4j.log(bankDetailsTable.getValue("DOC_NO")+"INVINVVALUE222COLCHGSSS2>>>>>>>>"+bankDetailsTable.getValue("COLL_CHARG"),"I");
				if(invnum.equals(bankDetailsTable.getValue("DOC_NO"))){
				paymentInfo.setFieldValue("INVOICENUMBER", bankDetailsTable.getValue("DOC_NO"));
				paymentInfo.setFieldValue("INVOICECURRENCY", bankDetailsTable.getValue("T_CURRENCY"));
				paymentInfo.setFieldValue("PAIDAMOUNT", bankDetailsTable.getValue("NET_AMOUNT"));
				paymentInfo.setFieldValue("PAYMENTDATE", bankDetailsTable.getValue("BLINE_DATE"));

	 		    	paymentInfo.setFieldValue("CHEQUENUMBER", bankDetailsTable.getValue("CHEQUE_NO")); // Changed for cheque no mapping 07/19/2001
				paymentInfo.setFieldValue("BANKNAME", bankDetailsTable.getValue("NAME"));
				String bankaddress = "";
				if (bankDetailsTable.getValue("STREET") != null) {
					bankaddress += bankDetailsTable.getValue("STREET");
				}
				if (bankDetailsTable.getValue("CITY") != null) {
					if (bankDetailsTable.getValue("STREET") != null) {
						bankaddress += ", ";
					}
					bankaddress += bankDetailsTable.getValue("CITY");
				}
				paymentInfo.setFieldValue("BANKADDRESS", bankaddress);
				paymentInfo.setFieldValue("BANKCOUNTRY", bankDetailsTable.getValue("COUNTRY"));
				paymentInfo.setFieldValue("DBCRINDICATOR", bankDetailsTable.getValue("DB_CR_IND"));
				
				paymentInfo.setFieldValue("REFDOC", bankDetailsTable.getValue("CLR_DOC_NO"));
				paymentInfo.setFieldValue("EXT1", bankDetailsTable.getValue("DSC_AMT_LC"));
				
				paymentInfo.addRow();
				}
			}while(bankDetailsTable.nextRow());
		}
		
		finalInvoice.addObject("ItemData", itemData);  //Adding Item Data Information
		finalInvoice.addObject("PaymentInfo", paymentInfo); //Adding Bank Payment Information
	} catch (Exception e) {
		
	}
	
	EzInvoice SeqInv = (EzInvoice)finalInvoice.getObject("ItemData");
	EzInvoice SeqInv2 = (EzInvoice)finalInvoice.getObject("PaymentInfo");
	ezc.ezcommon.EzLog4j.log("MY  2323CHKINVINVINVVALUE2222>>>>>>>>"+SeqInv2.toEzcString(),"I");
%>