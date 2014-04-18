<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
	// Get the input parameters
	String pDefKey = null;
	String pDefValue = null;
	String pFinalFlag = "N";

	pDefKey = request.getParameter("DefKey");
	pDefValue = request.getParameter("DefValue");
	String DefLanguage= request.getParameter("Deflanguage");
	DefLanguage=(DefLanguage==null)?(String)session.getValue("userLang"):DefLanguage;
	session.putValue("userLang", DefLanguage);

	//pDefValue = pDefValue.toUpperCase();

	// Transfer Structure for the Descriptions
	EzKeyValueStructure in = new EzKeyValueStructure();

	// Set the Structure Values
	in.setKey(pDefKey.trim());
	in.setValue(pDefValue.trim());
	in.setPKey(Session.getUserId());

	EzcUserParams uparams = new EzcUserParams();
	EzcUserNKParams userNKParams = new  EzcUserNKParams();
	userNKParams.setEzKeyValueStructure(in);
	userNKParams.setIsUserAKey(pFinalFlag);
	uparams.createContainer();
	uparams.setObject(userNKParams);
	Session.prepareParams(uparams);

	// Add User Defaults
	UserManager.setUserDefaults(uparams);
	session.putValue("userStyle",pDefValue.trim());


	//System.out.println("*************pDefValue*******"+pDefValue.trim());
	response.sendRedirect("../Misc/ezMenuframeset.jsp");
%>
