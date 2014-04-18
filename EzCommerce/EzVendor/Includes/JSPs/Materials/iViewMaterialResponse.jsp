<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<%

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure reqStruct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

   	ezc.ezvendorapp.params.EzMaterialResponseStructure resStruct =  new ezc.ezvendorapp.params.EzMaterialResponseStructure();

	String requestId="";
	String soldTo="";
	String sysKey="";
	String refNum="";
	String name="";

	String forback=request.getParameter("forback");
	String type=request.getParameter("Type");

	String chk1=request.getParameter("chk1");
	StringTokenizer st = new StringTokenizer(chk1,"#");
	System.out.println("*********iView Material*********"+chk1);
	requestId = st.nextToken();
	soldTo = st.nextToken();
	sysKey = st.nextToken();
	refNum = st.nextToken();
	name = st.nextToken();

	reqStruct.setRequestId(requestId);
	
	resStruct.setRequestId(requestId+refNum);
	resStruct.setSysKey(sysKey);
	resStruct.setSoldTo(soldTo);


	mainParams.setObject(reqStruct);
	mainParams.setObject(resStruct);

	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetMaterialResponse(mainParams);

        ezc.ezparam.ReturnObjFromRetrieve reqHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"REQHEADER");
        ezc.ezparam.ReturnObjFromRetrieve resHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"RESPONSES");



%>
