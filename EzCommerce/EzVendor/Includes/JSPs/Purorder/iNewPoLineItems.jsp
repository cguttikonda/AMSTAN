<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ page import = "java.util.*"%>
<%@ include file="../../Lib/DateFunctions.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page">
</jsp:useBean>


<%

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
final String DDATE = "CONFIRMDELIVERYDATE";
final String INDICATOR = "INDICATOR";
String poNum=request.getParameter("PurchaseOrder");
String vendor=request.getParameter("vendor");
String userRole	= (String) session.getValue("USERROLE");
String purGrp 	= "";
String cCode  	= "";
String sysKey 	= request.getParameter("poSysKey");
String show 	= request.getParameter("show");


if(poNum.length()<10)
{
	if(poNum.length()==8)
	{
		poNum="00"+poNum;
	}
	else if(poNum.length()==9)
	{
		poNum="0"+poNum;
	}
}


EzPurchDtlXML dtlXML = null;
EzPSIInputParameters iparams = new EzPSIInputParameters();
iparams.setOrderNumber(poNum);
iparams.setCostCenter(vendor);

if("PH".equals(userRole) && "ALL".equals(show))
{
	java.util.Hashtable  purGroupsHash = (Hashtable) session.getValue("PURGRPSHASH");//REFFROM: iloginbanner.jsp
	java.util.Hashtable  ccHash	   = (Hashtable) session.getValue("CCODEHASH");  //REFFROM: iloginbanner.jsp

	purGrp = (String)purGroupsHash.get(sysKey);
	cCode  = (String)ccHash.get(sysKey) ;

	iparams.setWithDefaults("N");
	iparams.setpurchaseGroup(purGrp);
	iparams.setCompanyCode(cCode);
}	



ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
newParams.createContainer();
newParams.setObject(iparams);
newParams.setObject(testparams);
Session.prepareParams(newParams);

dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams);

String OrderType=request.getParameter("orderType");

Date ordDate = (Date)dtlXML.getFieldValue(0, ORDDATE); 


sysKey=request.getParameter("sysKey");
String soldTo = request.getParameter("soldTo");

ezc.ezcommon.EzLog4j.log(sysKey+"::::"+soldTo,"I");


double netCalcAmt = 0;
if(dtlXML != null)
{
	for(int i=0; i<dtlXML.getRowCount(); i++)
	{
		netCalcAmt += Double.parseDouble(dtlXML.getFieldValueString(i,"NET_VALUE"));
	}
}
netCalcAmt*=100.0;

%>
