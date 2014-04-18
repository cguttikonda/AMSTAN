<%@ page import = "ezc.ezparam.EzDescStructure" %>
<%@ include file="../../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="esManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<%
String pCheckBox[] = request.getParameterValues("CheckBox"); 

String pKeys[]= request.getParameterValues("DefKey");
String pDefDesc[] = request.getParameterValues("DefDesc"); 
String pDefType[] = request.getParameterValues("DefType"); 
String pDefLang[] = request.getParameterValues("DefLang"); 

String syskey = request.getParameter("SystemKey");

// Transfer Structure for the Descriptions
EzDescStructure in = new EzDescStructure();
for ( int i = 0 ; i < pCheckBox.length; i++ ) 
	{
	// Check For Selection
	if ( pCheckBox[i] != null )
		{
		int c=-1;
		for(int j=0;j<pKeys.length;j++)
			{
			if(pCheckBox[i].equals(pKeys[j]))
				{
				c=j;
				break;
				}
			}
		// Set the Structure Values
		in.setKey(pCheckBox[i].trim());
		in.setDesc(pDefDesc[c].trim());
		in.setLang(pDefLang[c]);
		// System Configuration Class
		EzcSysConfigParams sparams = new EzcSysConfigParams();
		EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
		snkparams.setLanguage("EN");
		snkparams.setEzDescStructure(in);
		snkparams.setSystemKey(syskey);
		snkparams.setUserFlag(pDefType[c]);
		sparams.setObject(snkparams);
		Session.prepareParams(sparams);
		esManager.updateDefaultsDesc(sparams);
		}
	}// End For
response.sendRedirect("ezModifySiteDefaults.jsp?saved=Y");
%>