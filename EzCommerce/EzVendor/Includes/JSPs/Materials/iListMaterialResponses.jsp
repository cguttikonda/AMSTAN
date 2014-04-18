<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" scope="session"></jsp:useBean>

<%

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
   	ezc.ezvendorapp.params.EzMaterialRequestStructure reqStruct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();

   	ezc.ezvendorapp.params.EzMaterialResponseStructure resStruct =  new ezc.ezvendorapp.params.EzMaterialResponseStructure();

	String requestId="";
	String status="";
	String activationDate="";
	String requiredDate="";
	String refNum="";

	String chk1=request.getParameter("chk1");
	StringTokenizer st = new StringTokenizer(chk1,"#");
	//System.out.println("********************request IN iList Material**********"+request.getParameter("chk1"));
	requestId = st.nextToken();
	status = st.nextToken();
	activationDate = st.nextToken();
        requiredDate = st.nextToken();
	refNum=st.nextToken();

	reqStruct.setRequestId(requestId);

	resStruct.setRequestId(requestId);
	resStruct.setExt2(refNum);

	mainParams.setObject(reqStruct);
	mainParams.setObject(resStruct);

	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	ezc.ezparam.ReturnObjFromRetrieve ret= (ezc.ezparam.ReturnObjFromRetrieve)AppManager.ezGetAllMaterialResponses(mainParams);

        ezc.ezparam.ReturnObjFromRetrieve reqHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"REQHEADER");
        ezc.ezparam.ReturnObjFromRetrieve resHeader =  (ezc.ezparam.ReturnObjFromRetrieve)ret.getFieldValue(0,"RESPONSES");


	int resCount = resHeader.getRowCount();


%>
