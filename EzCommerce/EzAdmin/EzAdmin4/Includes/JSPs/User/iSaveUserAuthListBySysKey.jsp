<%@ page import = "ezc.ezparam.*,java.util.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%

String roleInd = null;
String sysNo=null;
String key=null;
String val=null;

String BusUser = request.getParameter("BusUser");
String Area=request.getParameter("Area");
String websyskey=request.getParameter("WebSysKey");


Hashtable oldAuth=new Hashtable();

String pSysNum[] = request.getParameterValues("SysNum");
if(pSysNum!=null)
{
		
	for ( int i = 0  ; i < pSysNum.length; i++ )
	{
		Hashtable myTable=new Hashtable();
		String AuthKey[]=request.getParameterValues("Stat"+pSysNum[i]);
		if(AuthKey!=null)
		{	
			for ( int j = 0  ; j < AuthKey.length; j++ )
			{
				StringTokenizer tokens=new StringTokenizer(AuthKey[j],"#");
				myTable.put(tokens.nextToken(),tokens.nextToken());
			}

		}
		oldAuth.put(pSysNum[i],myTable);
	 }

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

				if(myTable.containsKey(AuthKey))
				{
						myTable.remove(AuthKey);
						continue;
				}


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



Enumeration enum=oldAuth.keys();
while(enum.hasMoreElements())
{
	String sysNum=(String)enum.nextElement();
	Hashtable myTable=(Hashtable)oldAuth.get(sysNum);
	
	Enumeration enum1= myTable.keys();
	
	while(enum1.hasMoreElements())
	{
		String AuthKey1=(String)enum1.nextElement();
		EzKeyValueStructure in = new EzKeyValueStructure();
		in.setPKey(BusUser.trim());
		in.setKey(AuthKey1.trim());
		in.setValue((String)myTable.get(AuthKey1));
		in.setRoleIndicator( roleInd );

		EzcUserParams uparams= new EzcUserParams();
		EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
		ezcUserNKParams.setLanguage("EN");
		ezcUserNKParams.setEzKeyValueStructure(in);
		ezcUserNKParams.setSys_Number(sysNum);
		uparams.createContainer();
		boolean result_flag = uparams.setObject(ezcUserNKParams);
		Session.prepareParams(uparams);
		UserManager.setUserAuth(uparams);
	}
}
response.sendRedirect("../User/ezUserAuthListBySysKey.jsp?saved=Y&BusUser=" + BusUser+"&Area="+Area+"&WebSysKey="+websyskey);


%>