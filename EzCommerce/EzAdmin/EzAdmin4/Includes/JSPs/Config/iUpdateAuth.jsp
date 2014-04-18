<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>

<jsp:useBean id="raparams" class="ezc.ezcommon.arms.params.EziRoleAuthParams" />
<jsp:useBean id="urparams" class="ezc.ezcommon.arms.params.EziUserRolesParams" />

<%@ include file="../../Lib/ArmsConfig.jsp" %>


<%
	EzcParams einParams = new EzcParams(false);
	Session.prepareParams( einParams );
	ReturnObjFromRetrieve retRoles = (ReturnObjFromRetrieve) ArmsManager.ezUserRoleList( einParams );
%>




<%
String[] DelCheck = null;
String[] AuthLang = null;
String[] AuthKey = null;
String[] AuthDesc = null;
String[] IsSysAuth = null;

String pDelCheck = null;
String pAuthLang = null;
String pAuthKey = null;
String pAuthDesc = null;
String pIsSysAuth = null;

String pFinalDel = "Y";

        DelCheck = request.getParameterValues("CheckBox");
	AuthLang = request.getParameterValues("AuthLang");
	AuthKey = request.getParameterValues("AuthKey");
	AuthDesc = request.getParameterValues("AuthDesc");
	IsSysAuth = request.getParameterValues("IsSysAuth");
	String TotalCount=request.getParameter("TotalCount");



for ( int i = 0 ; i <AuthDesc.length ; i++ )
{
	pFinalDel="Y";

	if(DelCheck!=null)
	{
		for(int j=0;j<DelCheck.length;j++)
		{
			StringTokenizer st=new StringTokenizer(DelCheck[j],"#");

			pAuthKey=st.nextToken();
			pAuthDesc=st.nextToken();
			pAuthLang=st.nextToken();


			if((AuthKey[i].trim()).equals(pAuthKey.trim()))
			{
				pFinalDel="N";
				break;
			}

		}
	}

	// Check For Selection


	 if(pFinalDel.equals("Y"))
	 {

		if ( AuthKey[i] != null && retRoles.find("ROLE_NR",AuthKey[i].trim() ) )
		{

			EzcParams ezcParams = new EzcParams(false);
			raparams.setRoleNo(AuthKey[i]);
			raparams.setSysKey("0");
			ezcParams.setObject( raparams );
			Session.prepareParams( ezcParams );

			ArmsManager.ezDeleteRoleAuth(ezcParams);

		} //end if

	}

	// Transfer Structure for the Descriptions
	EzDescStructure in = new EzDescStructure();

	// Set the Structer Values
	in.setKey(AuthKey[i]);
	in.setLang(AuthLang[i]);
	in.setDesc(AuthDesc[i]);

	// Update Auth
	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	snkparams.setEzDescStructure(in);
	snkparams.setDeleteFlag(pFinalDel);
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	sysManager.updateAuthDesc(sparams);


	in = null;

}// End For


response.sendRedirect("../Config/ezListAuth.jsp?saved=Y");
%>