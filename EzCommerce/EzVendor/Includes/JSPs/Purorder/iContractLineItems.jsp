<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import="ezc.ezpurchase.csb.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurContractManager" scope="page">
</jsp:useBean>

<%
//String Jndi_Name = "EzcPurchaseObjectHome";
//EzcPurchaseObject purObj = (EzcPurchaseObject)Session.ezcFind(Jndi_Name);

final String ORDER = "ORDER";
final String LINENO = "POSITION";
final String UOM = "UOMPURCHASE";
final String PRICE = "PRICE";
final String MATERIAL = "ITEM";
final String MATDESC = "ITEMDESCRIPTION";
final String AMOUNT = "AMOUNT";
final String DELDATE = "PLANNEDDELIVERYDATE";
final String ORDDATE = "ORDERDATE";
final String ORDQTY = "ORDEREDQUANTITY";
final String DISCOUNT = "ORDERLINEDISCOUNT1";

String poNum = request.getParameter("ContractNumber"); 
//String ordDate = request.getParameter("OrderDate"); 
EzPurchDtlXML dtlXML = null;
EzPSIInputParameters iparams = new EzPSIInputParameters();
iparams.setOrderNumber(poNum);
ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
newParams.createContainer();
newParams.setObject(iparams);
Session.prepareParams(newParams);

// Vendor Number is hardcoded you can remove afterwards  
//iparams.setVendorNumber("VENDOR1");
//iparams.setVendorNumber("147");

//dtlXML =  (EzPurchDtlXML)purObj.ezPurchaseOrderStatus(iparams);
dtlXML =  (EzPurchDtlXML)PoManager.getPurchaseContractStatus(newParams);
 dtlXML.toEzcString();

Date ordDate = (Date)dtlXML.getFieldValue(0, ORDDATE); 
%>
