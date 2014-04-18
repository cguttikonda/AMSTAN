
<%@ include file="../../Lib/iEzMain1.jsp" %>
<%
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	EziComponentsParams ezicomponenentsparams= new EziComponentsParams();
	ReturnObjFromRetrieve retComponentDetails=null;
        String compId = request.getParameter("chk1");

	    ezicomponenentsparams.setCode(compId);
	    mainParams.setObject(ezicomponenentsparams);
	    Session.prepareParams(mainParams);
	    retComponentDetails=(ezc.ezparam.ReturnObjFromRetrieve)cmanager.getComponentsDetails(mainParams);

%>
