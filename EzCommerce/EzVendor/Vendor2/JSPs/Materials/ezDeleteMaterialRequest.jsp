<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>

<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<%


	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure struct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

	StringTokenizer st = new StringTokenizer(request.getParameter("chk1"),"#");

	String requestId = st.nextToken();	
        String type = request.getParameter("Type");

	struct.setRequestId(requestId);
	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezDeleteMaterialRequest(mainParams);

	response.sendRedirect("../Materials/ezListMaterialsInternal.jsp?Type="+type);


%>
<Div id="MenuSol"></Div>
