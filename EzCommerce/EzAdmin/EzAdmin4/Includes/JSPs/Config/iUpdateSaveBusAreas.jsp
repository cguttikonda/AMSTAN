<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%

String areaFlag = request.getParameter("Area");

String checkbox = null;
String SysKey = null;
String SysKeyDesc = null;
String SysKeyLang = null;


String pSysKey = null;
String pSysKeyDesc = null;
String pSysKeyLang = null;
// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();
String	pCheckBox[] = request.getParameterValues("chk1");
if(pCheckBox!=null)
{
	for ( int i = 0 ; i < pCheckBox.length; i++ ) {
	StringTokenizer st=new StringTokenizer(pCheckBox[i],"#");
	SysKey=(String)st.nextToken();
	SysKeyLang=(String)st.nextToken();
	SysKeyDesc=(String)st.nextToken();
	// Check For Selection



		// Set the Structure Values
		in.setKey(SysKey);
		in.setLang(SysKeyLang);
		in.setDesc(SysKeyDesc);

		// System Configuration Class
            EzcSysConfigParams sparams = new EzcSysConfigParams();
			EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
			snkparams.setLanguage("EN");
			snkparams.setEzDescStructure(in);
			sparams.setObject(snkparams);
			Session.prepareParams(sparams);
			sysManager.updateSystemKeyDesc(sparams);

	}// End For
}
in = null;



response.sendRedirect("../Config/ezUpdateBusAreas.jsp?saved=Y&Area="+areaFlag);
%>