<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>


<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session">
</jsp:useBean>


<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>



<script language = "javascript">
function setChecked(val) {
	dml=document.forms[0];
	len = dml.elements.length;
	var i=0;
	for( i=0 ; i<len ; i++) {
		dml.elements[i].checked=val;
	}
}
</script>



<%
// Key Variables
ReturnObjFromRetrieve retuser = null;
ReturnObjFromRetrieve retFinal = null;

//Get All Users
EzcUserParams uparams = new EzcUserParams();

EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
ezcUserNKParams.setLanguage("EN");
uparams.createContainer();
uparams.setObject(ezcUserNKParams);
Session.prepareParams(uparams);

//retuser = AdminObject.getAllUsers(servlet,"EN");
retuser = (ReturnObjFromRetrieve)UserManager.getAllUsers(uparams);
retuser.check();

//Get Selected User Value
String bus_user = request.getParameter("BusinessUser");


if (bus_user == null)
{
	bus_user = (retuser.getFieldValue(0,USER_ID)).toString();
}
bus_user = bus_user.toUpperCase();

String Bus_Partner = request.getParameter("BusinessPartner");


/******************************************/
String pf[] = {"AG","VN"};
EzcUserParams uparamsUA = new EzcUserParams();
EzcUserNKParams ezcUserNKParamsUA = new EzcUserNKParams();
ezcUserNKParamsUA.setLanguage("EN");
ezcUserNKParamsUA.setPartnerFunctions(pf);
uparamsUA.setUserId(bus_user.trim());
uparamsUA.setBussPartner(Bus_Partner.trim());
uparamsUA.setObject(ezcUserNKParamsUA);
Session.prepareParams(uparamsUA);
retFinal = (ReturnObjFromRetrieve) UserManager.getUserAllowedAuthorizations(uparamsUA);

/******************************************/

%>
