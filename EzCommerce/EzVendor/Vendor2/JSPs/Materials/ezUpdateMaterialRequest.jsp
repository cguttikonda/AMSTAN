<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>


<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<%@ page import="ezc.ezutil.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<%


	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure struct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

        String chkValue = request.getParameter("chk1");
        String type = request.getParameter("Type");

        StringTokenizer st = new StringTokenizer(chkValue,"#");

	String requestId = st.nextToken();
	String status=st.nextToken();
        String activationDate=st.nextToken();
        String closingDate=st.nextToken();
	String refDoc=st.nextToken();

        if(closingDate.equals("-"))
	        closingDate = "";

        struct.setRequestId(requestId);
        Date d = new Date();
	FormatDate fd = new FormatDate();

	if(status.equals("A"))
        {
	    struct.setActivationDate(activationDate);
            struct.setClosingDate(fd.getStringFromDate(d,".",FormatDate.DDMMYYYY));
            struct.setCurrentStatus("S");
	    struct.setRefDocNo(refDoc);
        }
        else
        {
	    struct.setActivationDate(fd.getStringFromDate(d,".",FormatDate.DDMMYYYY));
            struct.setClosingDate(closingDate);
            struct.setCurrentStatus("A");
	    int refNum = Integer.parseInt(refDoc)+1;
	    struct.setRefDocNo(""+refNum);
        }


	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezUpdateMaterialRequest(mainParams);

	response.sendRedirect("../Materials/ezListMaterialsInternal.jsp?Type="+type);


%>
<Div id="MenuSol"></Div>
