<%@ include file="../Misc/iBlockControl.jsp"%>  
<%@ page import ="ezc.ezparam.*" %>
<%@ page import ="ezc.customer.invoice.params.*" %>
<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.client.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="CustInvManager" class ="ezc.customer.invoice.client.EzCustomerInvoiceManager" scope="page" />
<%
	ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);

	//String soldto=(String) session.getValue("AgentCode");
	String soldto		= (String) session.getValue("docSoldTo");
	String syskey		= (String) session.getValue("SalesAreaCode");
	String defPartnNum 	= UtilManager.getUserDefErpSoldTo();
	
	if(!soldto.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),soldto);

	String custInvNo 	= request.getParameter("custInvNo");
	String salesDocNo 	= request.getParameter("salesDocNo");

	EzcCustomerInvoiceParams ecparams = new EzcCustomerInvoiceParams();
	EziCustomerInvoiceParams eiParams = new EziCustomerInvoiceParams();

	eiParams.setCustInvoiceNo(custInvNo);
	eiParams.setSalesDocNum(salesDocNo);
	eiParams.setSelection("D");  //H or S or D

	ecparams.setObject( eiParams );
	Session.prepareParams(ecparams);

	ReturnObjFromRetrieve retObj = (ReturnObjFromRetrieve)CustInvManager.getCustomerInvoiceDetails(ecparams);

	ReturnObjFromRetrieve billHeaders = (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_HEADERS_OUT");
	ReturnObjFromRetrieve billItems = (ReturnObjFromRetrieve)retObj.getFieldValue("BILLING_ITEMS_OUT");
	
	String s=billItems.getFieldValueString(0,"DelDoc;"); 
	/*
	String delStat=request.getParameter("Stat");
	if ((delStat==null)||("".equals(delStat.trim())))
		delStat="'R','D'";
	else
		delStat="'"+delStat+"'";
	
	ReturnObjFromRetrieve retList=null;

	EzDispatchInfoManager manager=new EzDispatchInfoManager();
	EzcParams params=new EzcParams(true);
	params.setLocalStore("Y");

	EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
	
	inParams.setSoNum(salesDocNo);
	inParams.setStatus(delStat);
	inParams.setSoldTo(soldto);
	inParams.setSysKey(syskey);

	params.setObject(inParams);
	Session.prepareParams(params);
	retList=(ReturnObjFromRetrieve)manager.ezGetAllHeaders(params);
	Vector LocDels=new Vector();
	
	for (int i=0;i<retList.getRowCount();i++){
		LocDels.addElement(retList.getFieldValueString(i,"DELIVERYNO"));		
	}*/
	if(!soldto.equals(defPartnNum))
		UtilManager.setSysKeyAndSoldTo(UtilManager.getCurrSysKey(),defPartnNum);

	ArrayList LocDels=new ArrayList();
%>