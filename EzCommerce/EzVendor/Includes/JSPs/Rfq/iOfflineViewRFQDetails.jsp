<%@ page import ="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<%@ page import = "java.util.*"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<jsp:useBean id="StockManager" class="ezc.ezstock.client.EzStockInfoManager" />
<%@ page import="ezc.ezstock.params.*" %>
<%
	
	String poNum = request.getParameter("PurchaseOrder");
	String CDate = request.getParameter("EndDate");
	
	if("Y".equals((String)session.getValue("OFFLINE"))){
		java.util.Hashtable reqsyshash=(java.util.Hashtable)session.getValue("RFQSYSHASH");
		if(reqsyshash!=null){
			String dySys=(String)reqsyshash.get(poNum);
			if(dySys!=null){
			
				session.putValue("SYSKEY",dySys);
				ezc.client.EzcPurchaseUtilManager PurManager = new ezc.client.EzcPurchaseUtilManager(Session);
				PurManager.setPurAreaAndVendor(dySys,(String)session.getValue("SOLDTO"));
				
			}
		}
	}
	
	String valuationTypes[] = {"01","02","A/L (SFG)","A/L FOR RM","C1","C2","C3","DOM. (SFG)","DOM.FOR RM","EIGEN","FREMD","LAND 1","LAND 2","MFD (FG)","MFD (SFG)","OGL (SFG)","OGL FOR RM","PROC (FG)","RAKTION","RM MOHALI","RM TOANSA","RNORMAL"};
	
	String UserType = (String)session.getValue("UserType");
	String userRole = (String)session.getValue("USERROLE");
	
	
	
	
	//out.println(poNum+":"+CDate);


	ResourceBundle IncoT	= ResourceBundle.getBundle("EzPurIncoTerms");
	ResourceBundle PayT	= ResourceBundle.getBundle("EzPurPayTerms");
	ResourceBundle TaxC 	= ResourceBundle.getBundle("EzTaxCodes");
	Enumeration incoEnu 	= IncoT.getKeys();
	Enumeration payEnu 	= PayT.getKeys();
	Enumeration taxEnu 	= TaxC.getKeys();
	
	
	java.util.TreeMap incoTM= new java.util.TreeMap();	
	java.util.TreeMap payTM = new java.util.TreeMap();	
	java.util.TreeMap taxTM = new java.util.TreeMap();	

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
  	
  	
  	
  	while(taxEnu.hasMoreElements())
	{
		String s2=(String)taxEnu.nextElement();
		taxTM.put(s2,TaxC.getString(s2));
	}
	Iterator taxIterator = taxTM.keySet().iterator();
  	Object taxObj = new Object();
  	

	String rfqVend=request.getParameter("rfqVendor");
	int mm=Integer.parseInt(CDate.substring(3,5));
	int dd=Integer.parseInt(CDate.substring(0,2));
	int yy=Integer.parseInt(CDate.substring(6,10));
	GregorianCalendar gc=new GregorianCalendar(yy,mm-1,dd,23,59,59);	//year-month-day-hour-min-sec
	Date closingDate=gc.getTime();

	Date today = new Date();

	EzPurchDtlXML dtlXML = null;
	EzPSIInputParameters iparams = new EzPSIInputParameters();
	iparams.setOrderNumber(poNum);
	if(rfqVend!=null && !"null".equals(rfqVend)&& !"".equals(rfqVend)){
		iparams.setCostCenter(rfqVend);
	}
	ezc.ezparam.EzcPurchaseParams newParams = new ezc.ezparam.EzcPurchaseParams();
	ezc.ezpurchase.params.EziPurOrderDetailsParams testparams = new ezc.ezpurchase.params.EziPurOrderDetailsParams();
	newParams.createContainer();
	newParams.setObject(iparams);
	newParams.setObject(testparams);
	Session.prepareParams(newParams);


	dtlXML =  (EzPurchDtlXML)PoManager.ezPurchaseOrderStatus(newParams);
	java.util.Date ordDate = (java.util.Date)dtlXML.getFieldValue(0,"ORDERDATE");

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
			htexts.put(retHeadText.getFieldValueString(i,"PONO").trim(),retHeadText.getFieldValueString(i,"TEXTLINE"));
		}
	}

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager 	  = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams ezcparams				   		  = new ezc.ezparam.EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQHeaderParams ezirfqheaderparams 	  = new ezc.ezpreprocurement.params.EziRFQHeaderParams();
	ezirfqheaderparams.setRFQNo(poNum);
	ezirfqheaderparams.setSysKey((String)session.getValue("SYSKEY"));
	ezcparams.setObject(ezirfqheaderparams);
	ezcparams.setLocalStore("Y");
	Session.prepareParams(ezcparams);
	ezc.ezpreprocurement.params.EzoRFQHeaderParams ezorfqheaderparams = (ezc.ezpreprocurement.params.EzoRFQHeaderParams)ezrfqmanager.ezGetRFQDetails(ezcparams);
	
	ezc.ezparam.ReturnObjFromRetrieve rfqHeader  = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQHeader();
	ezc.ezparam.ReturnObjFromRetrieve rfqDetails = (ezc.ezparam.ReturnObjFromRetrieve)ezorfqheaderparams.getRFQDetails();
	
	String ExpireDt = "";
	String Remarks = "";
	if(rfqHeader!=null && rfqHeader.getRowCount()>0)
	{
		java.util.Date ExpireDtObj = (java.util.Date)rfqHeader.getFieldValue(0,"PRICE_VALID_DATE");
		if(ExpireDtObj!=null)
			ExpireDt = FormatDate.getStringFromDate(ExpireDtObj,".",FormatDate.DDMMYYYY);
	}	
	if(rfqDetails!=null && rfqDetails.getRowCount()>0)
	{
		if(rfqDetails.getFieldValueString("REMARKS")!=null)
			Remarks = rfqDetails.getFieldValueString("REMARKS");
	}
	
	EzcParams ezcparamsnew=new EzcParams(false);
	ezc.ezpreprocurement.params.EziRFQConditionsTable ezirfconditiontable 	     = new ezc.ezpreprocurement.params.EziRFQConditionsTable();
	ezc.ezpreprocurement.params.EziRFQConditionsTableRow ezirfconditiontablerow   = null;//new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();

	ezirfconditiontablerow = new ezc.ezpreprocurement.params.EziRFQConditionsTableRow();

	ezirfconditiontablerow.setRFQNo(poNum);

	ezirfconditiontable.appendRow(ezirfconditiontablerow);
	
	ezcparamsnew.setObject(ezirfconditiontable);
	ezcparamsnew.setLocalStore("Y");
	Session.prepareParams(ezcparamsnew);
	ReturnObjFromRetrieve retCond =(ReturnObjFromRetrieve)ezrfqmanager.ezGetRFQConditions(ezcparamsnew);
%>
