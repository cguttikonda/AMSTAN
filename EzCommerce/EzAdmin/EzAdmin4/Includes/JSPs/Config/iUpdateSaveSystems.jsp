<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%

String System = null;
String SystemDesc = null;
String SystemLang = null;

EzDescStructure in = new EzDescStructure();

String pCheckBox[] = request.getParameterValues("chk");

if(pCheckBox!=null)
{
	for ( int i = 0 ; i < pCheckBox.length; i++ ) {

		StringTokenizer st=new StringTokenizer(pCheckBox[i],"#");
		System=(String)st.nextToken();
		SystemLang=(String)st.nextToken();
		SystemDesc=(String)st.nextToken();
		in.setKey(System);
		in.setLang(SystemLang);
		in.setDesc(SystemDesc);

		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	    snkparams.setLanguage("EN");
	  	snkparams.setEzDescStructure(in);
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		sysManager.updateSystemDesc(sparams);
	}// End For
}

response.sendRedirect("../Config/ezUpdateSystems.jsp?saved=Y");
%>