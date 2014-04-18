<%@ include file="../Misc/iBlockControl.jsp"%>
<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.ezparam.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
ezc.client.EzcUtilManager UtilManager = new ezc.client.EzcUtilManager(Session);

	String delNum=request.getParameter("dispNo");
	EzDispatchInfoManager manager=new EzDispatchInfoManager();
	EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
	EzcParams params=new EzcParams(true);
	params.setLocalStore("Y");
	inParams.setDelvNo(delNum);
	params.setObject(inParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve retHeadDetails=(ReturnObjFromRetrieve)manager.ezGetDispInfoHeader(params);


	EziDispInfoLinesInputParams inParams1 = new EziDispInfoLinesInputParams();
	inParams1.setDelvNo(delNum);
	params.setObject(inParams1);
	Session.prepareParams(params);
	ReturnObjFromRetrieve retLineDetails=(ReturnObjFromRetrieve)manager.ezGetDispInfoLines(params);
	
	//out.println("retHeadDetails"+retHeadDetails.toEzcString());
	//out.println("retLineDetails"+retLineDetails.toEzcString());
	
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		
		names.addElement("SO_DATE");
		names.addElement("DC_DATE");
		names.addElement("SHIPMENT_DATE");
		
		names.addElement("EXP_ARIVAL_TIME");
		names.addElement("GOODS_RECEIVED");
		EzGlobal.setColNames(names);
		ReturnObjFromRetrieve retHeadDetailsGlobal = EzGlobal.getGlobal(retHeadDetails);

String catalog_area = (String)session.getValue("SalesAreaCode");
ReturnObjFromRetrieve retCustList = (ReturnObjFromRetrieve)UtilManager.getUserCustomers(catalog_area);
%> 

