<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "java.util.*"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>

<%

	String UserType=(String)session.getValue("UserType");

	ResourceBundle IncoT= ResourceBundle.getBundle("EzPurIncoTerms");
	ResourceBundle PayT= ResourceBundle.getBundle("EzPurPayTerms");
	Enumeration incoEnu =IncoT.getKeys();
	Enumeration payEnu =PayT.getKeys();
	
	java.util.TreeMap incoTM = new java.util.TreeMap();	
	java.util.TreeMap payTM = new java.util.TreeMap();	

	while(incoEnu.hasMoreElements())
	{
		String s=(String)incoEnu.nextElement();
		incoTM.put(s,IncoT.getString(s));
	}
	Iterator incoIterator = incoTM.keySet().iterator();
  	Object incoObj = new Object();


	while(payEnu.hasMoreElements())
	{
		String s1=(String)payEnu.nextElement();
		payTM.put(s1,PayT.getString(s1));
	}
	Iterator payIterator = payTM.keySet().iterator();
  	Object payObj = new Object();



	String poNum = request.getParameter("PurchaseOrder");

	String CDate = request.getParameter("EndDate");
		//CDate="28.11.2003";
	int mm=Integer.parseInt(CDate.substring(3,5));

	int dd=Integer.parseInt(CDate.substring(0,2));
	int yy=Integer.parseInt(CDate.substring(6,10));
	GregorianCalendar gc=new GregorianCalendar(yy,mm-1,dd,23,59,59);	//year-month-day-hour-min-sec
	Date closingDate=gc.getTime();

	Date today = new Date();

	EzPurchDtlXML dtlXML = null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);

	dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams);
	java.util.Date ordDate = (java.util.Date)dtlXML.getFieldValue(0,"ORDERDATE");
	String OrderDt = FormatDate.getStringFromDate(ordDate,(String)session.getValue("DATESEPERATOR"),Integer.parseInt((String)session.getValue("DATEFORMAT")));
	int Count = dtlXML.getRowCount();

	ReturnObjFromRetrieve retHead = (ReturnObjFromRetrieve)dtlXML.getObject("HEADER");
	
	
	
	String QuotNo="";
	if ( retHead.getRowCount() > 0)
		QuotNo= retHead.getFieldValueString(0,"QUOTATION");

	ReturnObjFromRetrieve retHeadText = (ReturnObjFromRetrieve)dtlXML.getObject("HEADERTEXT");


	Hashtable htexts=new Hashtable();
	if(retHeadText!=null)
	{
		for (int i=0; i < retHeadText.getRowCount() ; i++)
		{
			htexts.put(retHeadText.getFieldValueString(i,"PONO"),retHeadText.getFieldValueString(i,"TEXTLINE"));
		}
	}
	
	
	ezc.ezcommon.EzLog4j.log("**end iViewRFQDetails** dtlXML"+dtlXML.toEzcString(),"I");
	ezc.ezcommon.EzLog4j.log("**end iViewRFQDetails** retHead"+retHead.toEzcString(),"I");
	ezc.ezcommon.EzLog4j.log("**end iViewRFQDetails** retHeadText"+retHeadText.toEzcString(),"I");

%>
