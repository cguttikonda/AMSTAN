<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String websyskey=request.getParameter("WebSysKey");
	String Area=request.getParameter("Area");

	String fromListByRole=request.getParameter("fromListByRole");
	String roleVal=request.getParameter("role");
	String sysVal=request.getParameter("sysKey");

	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retuser = null;
	ReturnObjFromRetrieve retbp = null;
	ReturnObjFromRetrieve retcat = null;
	ReturnObjFromRetrieve retcatuser = null;
	ReturnObjFromRetrieve retsoldto = null;
	ReturnObjFromRetrieve retsoldtouser = null;

String catalog_number = null;

	EzcBussPartnerParams bparams = new EzcBussPartnerParams();
	EzcBussPartnerNKParams bNKParams = new EzcBussPartnerNKParams();
	bNKParams.setLanguage("EN");
	bparams.createContainer();
	bparams.setObject(bNKParams);
	Session.prepareParams(bparams);


//Get Selected User Value

String user_id = request.getParameter("BusinessUser");

// Get Business Partners
	retbp = (ReturnObjFromRetrieve)BPManager.getBussPartners(bparams);
	retbp.check();
	ezc.ezcommon.EzLog4j.log("<<<****RETBP****>>>>>>>>"+retbp.toEzcString(),"I");

EzcUserParams uparams1= new EzcUserParams();
EzcUserNKParams ezcUserNKParams1 = new EzcUserNKParams();
//ezcUserNKParams.setLanguage("EN");
uparams1.setUserId(user_id);
uparams1.createContainer();
boolean result_flag1 = uparams1.setObject(ezcUserNKParams1);
Session.prepareParams(uparams1);

// Get Basic User Information
ret = (ReturnObjFromRetrieve)UserManager.getUserData(uparams1);
ret.check();
	ezc.ezcommon.EzLog4j.log("<<<****RET****>>>>>>>>"+ret.toEzcString(),"I");

EzcUserParams uparamsN= new EzcUserParams();
EzcUserNKParams ezcUserNKParamsN = new EzcUserNKParams();
ezcUserNKParamsN.setLanguage("EN");
uparamsN.setUserId(user_id);
uparamsN.createContainer();
uparamsN.setObject(ezcUserNKParamsN);
Session.prepareParams(uparamsN);

// Get User Catalog Number
	retcatuser = (ReturnObjFromRetrieve)UserManager.getUserCatalogs(uparamsN);
	retcatuser.check();

	ezc.ezcommon.EzLog4j.log("<<<****retcatuser****>>>>>>>>"+retcatuser.toEzcString(),"I");
	
	if(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER) != null)
	catalog_number = ((java.math.BigDecimal)(retcatuser.getFieldValue(0,CATALOG_DESC_NUMBER))).toString();

EzcUserParams uparams2= new EzcUserParams();
EzcUserNKParams ezcUserNKParams2 = new EzcUserNKParams();
ezcUserNKParams2.setCatalog_Number(catalog_number);
ezcUserNKParams2.setLanguage("EN");
//uparams2.setBussPartner();
uparams2.setUserId(user_id);
uparams2.createContainer();
uparams2.setObject(ezcUserNKParams2);
Session.prepareParams(uparams2);


// Get SoldTos for this Catalog Number
	retsoldto = (ReturnObjFromRetrieve)UserManager.getUserErpCustomers(uparams2);
	retsoldto.check();
	ezc.ezcommon.EzLog4j.log("<<<****retsoldto****>>>>>>>>"+retsoldto.toEzcString(),"I");
EzcUserParams uparams3= new EzcUserParams();
EzcUserNKParams ezcUserNKParams3 = new EzcUserNKParams();
ezcUserNKParams3.setCatalog_Number(catalog_number);
ezcUserNKParams3.setLanguage("EN");
//uparams2.setBussPartner();
uparams3.setUserId(user_id);
// filtering based on partner functions....
String[] partFunctions = {"AG","VN"};
ezcUserNKParams3.setPartnerFunctions(partFunctions);
uparams3.createContainer();
uparams3.setObject(ezcUserNKParams3);
Session.prepareParams(uparams3);

// Get SoldTos for the User
	retsoldtouser = (ReturnObjFromRetrieve)UserManager.getUserCustomers(uparams3);
	retsoldtouser.check();
ezc.ezcommon.EzLog4j.log("<<<****retsoldtouser****>>>>>>>>"+retsoldtouser.toEzcString(),"I");

//}//end if numUsers
%>