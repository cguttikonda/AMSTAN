<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>


<%!

final String AUTH_KEY = "EUAD_AUTH_KEY";
final String AUTH_LANG = "EUAD_LANG";
final String AUTH_DESC = "EUAD_AUTH_DESC";
final String AUTH_DEL_FLAG = "EUAD_DELETION_FLAG";
final String WF_ENABLED = "EUAD_IS_WF_ENABLED";
final String TRANS_TYPE = "EUAD_TYPE_OF_TRANS";

%>

<%
	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams1 = new EzcSysConfigParams();
	//sparams1.setLocalStore("Y");
	EzcSysConfigNKParams snkparams1 = new EzcSysConfigNKParams();
	snkparams1.setLanguage("EN");
	sparams1.setObject(snkparams1);
	Session.prepareParams(sparams1);
	ret = (ReturnObjFromRetrieve)sysManager.getAllAuthDesc(sparams1);

	for(int i=ret.getRowCount()-1;i>=0;i--)
	{
		if("N".equals(ret.getFieldValueString(i,WF_ENABLED)))
			ret.deleteRow(i);
	}
%>