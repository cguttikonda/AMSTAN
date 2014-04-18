
<%@ page import = "ezc.ezparam.*,java.util.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>


<%

String BusUser = request.getParameter("BusUser");	
//String[] checks=request.getParameterValues("Check");

//out.println(checks);

java.util.Hashtable oldAuth=new java.util.Hashtable();

String pSysNum[] = request.getParameterValues("SysNum");
if(pSysNum!=null)
{
		
	

	 for ( int j = 0  ; j < pSysNum.length; j++ )
	 {


		String checkBox[]=request.getParameterValues("Check"+pSysNum[j]);

		if(checkBox!=null)
		{
			for ( int i = 0  ; i < checkBox.length; i++ )
			{
				Hashtable myTable=(Hashtable)oldAuth.get(pSysNum[j]);
				// Transfer Structure for the Descriptions
				EzKeyValueStructure in = new EzKeyValueStructure();
				StringTokenizer st=new StringTokenizer(checkBox[i],"#");
				String AuthKey=st.nextToken();

				

				in.setPKey(BusUser.trim());
				in.setKey(AuthKey.trim());
				in.setValue((st.nextToken()).trim());
				in.setRoleIndicator( st.nextToken() );
				
				

				EzcUserParams uparams= new EzcUserParams();
				EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
				ezcUserNKParams.setLanguage("EN");
				ezcUserNKParams.setEzKeyValueStructure(in);
				ezcUserNKParams.setSys_Number(pSysNum[j]);
				uparams.createContainer();
				boolean result_flag = uparams.setObject(ezcUserNKParams);
				Session.prepareParams(uparams);

				UserManager.setUserAuth(uparams);
			}
		}
	}
}

response.sendRedirect("../User/ezUserEzcAuth.jsp?BusUser=" + BusUser + "&FromAdd=Yes");
%>