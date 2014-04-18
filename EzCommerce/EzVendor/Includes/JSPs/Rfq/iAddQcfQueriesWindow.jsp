<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page  import ="java.util.*"%>

<%
	int qcsCount = 0;
	String colectiveNo = request.getParameter("COLNO");
	String DOCTYPE = request.getParameter("DOCTYPE");
	String VENDOR = request.getParameter("Vendor");
	
	ezc.ezparam.ReturnObjFromRetrieve globalRet = null;
	ezc.ezparam.ReturnObjFromRetrieve qcsRet = null;
	ezc.ezpreprocurement.client.EzPreProcurementManager qcfManager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	mainParams.setLocalStore("Y");
	ezc.ezpreprocurement.params.EziQcfCommentParams qcfParams= new ezc.ezpreprocurement.params.EziQcfCommentParams();
	qcfParams.setQcfExt1("$$");
	qcfParams.setQcfCode(colectiveNo);
	qcfParams.setQcfType("QUERY','REPLY");
	mainParams.setObject(qcfParams);
	Session.prepareParams(mainParams);
	qcsRet = (ezc.ezparam.ReturnObjFromRetrieve)qcfManager.getQcfCommentList(mainParams);
	if(qcsRet != null)
	{
		qcsCount = qcsRet.getRowCount();
		
		Vector types = new Vector();
		types.addElement("date");
		EzGlobal.setColTypes(types);
		EzGlobal.setDateFormat("dd.MM.yyyy hh:mm:ss");

		Vector colNames = new Vector();
		colNames.addElement("QCF_DATE");
		EzGlobal.setColNames(colNames);
		globalRet = EzGlobal.getGlobal(qcsRet);
	}
%>