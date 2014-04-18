<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retcatuser = null;
	ReturnObjFromRetrieve retsoldto = null;
	ReturnObjFromRetrieve retsoldtouser = null;

	String catalog_number = null;
	String new_user = request.getParameter("NewUser");

	String userParam = request.getParameter("BusUser");
	userParam = userParam.trim();

	StringTokenizer tokens = new StringTokenizer(userParam,";");
	String user_type = tokens.nextElement()+"";
	user_type=user_type.trim();
	String user_id = tokens.nextElement()+"";
	user_id = user_id.trim();

	if(user_type.equals("2")) 
	{
		String redirectString = "ezCopyIntranetUserData.jsp?UserID="+user_id+"&NewUserID="+new_user+"&Show=No";
		response.sendRedirect(redirectString);
	}
	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);

	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);

	EzcUserParams uparams= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
	ezcUserNKParams.setLanguage("EN");
	String[] partFunctions = {"AG","VN"};
	ezcUserNKParams.setPartnerFunctions(partFunctions);
	uparams.setUserId(user_id);
	uparams.createContainer();
	boolean result_flag = uparams.setObject(ezcUserNKParams);
	Session.prepareParams(uparams);

	ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams);

	retcatuser = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparams);
	if ( retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER) != null )
	{
		catalog_number = ((java.math.BigDecimal)(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER))).toString();
	}
	else
	{
		catalog_number = "0";
	}

	EzcUserParams uparams1= new EzcUserParams();
	EzcUserNKParams ezcUserNKParams1 = new EzcUserNKParams();
	ezcUserNKParams1.setLanguage("EN");
	ezcUserNKParams1.setCatalog_Number(catalog_number);
	String[] partFunctions1 = {"AG","VN"};
	ezcUserNKParams1.setPartnerFunctions(partFunctions1);
	uparams1.setUserId(user_id);
	uparams1.createContainer();
	boolean result_flag1 = uparams1.setObject(ezcUserNKParams1);
	Session.prepareParams(uparams1);

	retsoldto = (ReturnObjFromRetrieve)UserManager.getUserErpCustomers(uparams1);

	retsoldtouser = (ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams);
%>