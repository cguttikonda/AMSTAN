<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ page import="ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="MiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"></jsp:useBean>
<%!
	public String nullCheck(String str)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret))
			ret = "";

		return ret;
	}
%>
<%
	String UserId 		= (request.getParameter("UserID")).trim();
	String FirstName 	= (request.getParameter("userName")).trim();
	String lastName 	= (request.getParameter("lastName")).trim();
	String Email 		= (request.getParameter("email")).trim();
	String ValidToDate 	= "01/31/01";
	String UserGroup = "0", UserType = "3";
	String CatalogNumber 	= (request.getParameter("catnum")).trim();
	String subUserAuth 	= request.getParameter("subUserAuth");

	ezc.ezcommon.EzLog4j.log("subUserAuth::::::::::::::"+subUserAuth,"I");

	String [] ERPCust 	= null;
	String [] SysKey 	= null;

	java.util.Vector myVector	= new java.util.Vector();
	java.util.Vector customers	= new java.util.Vector();
	java.util.Vector syskeys	= new java.util.Vector();

	EzUserStructure in = new EzUserStructure();
	in.setUserId(UserId.trim());
	in.setFirstName(FirstName);
	in.setMiddleName("");
	in.setLastName(lastName);
	in.setEmail(Email);
	in.setType(new Integer (UserType).intValue());
	in.setUserGroup(new Integer (UserGroup).intValue());
	in.setValidToDate(ValidToDate);
	in.setIsBuiltInUser("Y");


	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	//ezcAddUserStructure.setERPCustomer(ERPCust);
	//ezcAddUserStructure.setSysKey(SysKey);
	ezcAddUserStructure.setCatalogNumber(CatalogNumber);
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);
	Session.prepareParams(uparams);
	UserManager.updateUser(uparams);
	ezc.ezcommon.EzLog4j.log("UserManager::::::::::::::"+UserManager,"I");
	
	String repAgencyCode 	= request.getParameter("repAgencyCode");
	String exclMat	 	= request.getParameter("exclMat");

	if(repAgencyCode!=null && !"null".equalsIgnoreCase(repAgencyCode) && !"".equals(repAgencyCode))
	{
		EzKeyValueStructure in_UD = new EzKeyValueStructure();

		in_UD.setPKey(UserId.trim());
		in_UD.setKey("REPAGECODE");
		in_UD.setValue(repAgencyCode);

		EzcUserParams uparams_UD = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in_UD);
		userNKParams.setIsUserAKey("Y");
		uparams_UD.createContainer();
		uparams_UD.setObject(userNKParams);
		Session.prepareParams(uparams_UD);

		UserManager.setUserDefaults(uparams_UD);
	}
	if(exclMat!=null && !"null".equalsIgnoreCase(exclMat) && !"".equals(exclMat))
	{
		EzKeyValueStructure in_UD = new EzKeyValueStructure();

		in_UD.setPKey(UserId.trim());
		in_UD.setKey("EXCLUSIVE_MAT");
		in_UD.setValue(exclMat);

		EzcUserParams uparams_UD = new EzcUserParams();
		EzcUserNKParams userNKParams = new  EzcUserNKParams();
		userNKParams.setEzKeyValueStructure(in_UD);
		userNKParams.setIsUserAKey("Y");
		uparams_UD.createContainer();
		uparams_UD.setObject(userNKParams);
		Session.prepareParams(uparams_UD);

		UserManager.setUserDefaults(uparams_UD);
	}

	/******************* Update Authorizations *************************/

	String roleInd = null;
	String sysNo=null;
	String key=null;
	String val=null;

	String BusUser 	= UserId;
	String Area	= "C";
	String websyskey= (String)session.getValue("SalesAreaCode");

	Hashtable oldAuth=new Hashtable();

	String pSysNum[] = request.getParameterValues("SysNum");
	if(pSysNum!=null)
	{
		EzcParams subUserRolesParamsMisc = new EzcParams(false);
		ezc.ezmisc.params.EziMiscParams subUserRolesParams = new ezc.ezmisc.params.EziMiscParams();

		ReturnObjFromRetrieve subUserRolesRetObj = null;

		subUserRolesParams.setIdenKey("MISC_SELECT");

		String queryDWN="SELECT * from EZC_USER_AUTH WHERE EUA_USER_ID='"+BusUser+"' ORDER by EUA_AUTH_KEY";

		subUserRolesParams.setQuery(queryDWN);

		subUserRolesParamsMisc.setLocalStore("Y");
		subUserRolesParamsMisc.setObject(subUserRolesParams);
		Session.prepareParams(subUserRolesParamsMisc);	

		try
		{
			subUserRolesRetObj = (ReturnObjFromRetrieve)MiscManager.ezSelect(subUserRolesParamsMisc);
		}
		catch(Exception e){}	

		for ( int i = 0  ; i < pSysNum.length; i++ )
		{
			Hashtable myTable=new Hashtable();

			/*String AuthKey[]=request.getParameterValues("Stat"+pSysNum[i]);
			if(AuthKey!=null)
			{	
				for ( int j = 0  ; j < AuthKey.length; j++ )
				{
					StringTokenizer tokens=new StringTokenizer(AuthKey[j],"#");
					myTable.put(tokens.nextToken(),tokens.nextToken());
				}

			}*/

			if(subUserRolesRetObj!=null && subUserRolesRetObj.getRowCount()>0)
			{
				for(int rt=0;rt<subUserRolesRetObj.getRowCount();rt++)
				{
					if(!myTable.containsKey(subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_KEY")))
					{
						myTable.put(subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_KEY"),subUserRolesRetObj.getFieldValueString(rt,"EUA_AUTH_VALUE"));
					}
				}
			}

			oldAuth.put(pSysNum[i],myTable);
		 }

		 for ( int j = 0  ; j < pSysNum.length; j++ )
		 {


			//String checkBox[]=request.getParameterValues("Check"+pSysNum[j]);
			String checkBox[]=request.getParameterValues("subUserAuthDisp");

			if(checkBox!=null)
			{
				for ( int i = 0  ; i < checkBox.length; i++ )
				{
					Hashtable myTable=(Hashtable)oldAuth.get(pSysNum[j]);
					// Transfer Structure for the Descriptions
					EzKeyValueStructure in_E = new EzKeyValueStructure();
					StringTokenizer st=new StringTokenizer(checkBox[i],"#");
					String AuthKey=st.nextToken();

					if(myTable.containsKey(AuthKey))
					{
							myTable.remove(AuthKey);
							continue;
					}


					in_E.setPKey(BusUser.trim());
					in_E.setKey(AuthKey.trim());
					in_E.setValue((st.nextToken()).trim());
					in_E.setRoleIndicator(nullCheck(st.nextToken()) );

					EzcUserParams uparams_E= new EzcUserParams();
					EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
					ezcUserNKParams.setLanguage("EN");
					ezcUserNKParams.setEzKeyValueStructure(in_E);
					ezcUserNKParams.setSys_Number(pSysNum[j]);
					uparams_E.createContainer();
					boolean result_flag = uparams_E.setObject(ezcUserNKParams);
					Session.prepareParams(uparams_E);

					UserManager.setUserAuth(uparams_E);
				}
			}
		}
	}

	Enumeration enum1=oldAuth.keys();
	while(enum1.hasMoreElements())
	{
		String sysNum=(String)enum1.nextElement();
		Hashtable myTable=(Hashtable)oldAuth.get(sysNum);

		Enumeration enum11= myTable.keys();

		while(enum11.hasMoreElements())
		{
			String AuthKey1=(String)enum11.nextElement();
			EzKeyValueStructure in_E = new EzKeyValueStructure();
			in_E.setPKey(BusUser.trim());
			in_E.setKey(AuthKey1.trim());
			in_E.setValue((String)myTable.get(AuthKey1));
			in_E.setRoleIndicator(nullCheck( roleInd ));

			EzcUserParams uparams_E= new EzcUserParams();
			EzcUserNKParams ezcUserNKParams = new EzcUserNKParams();
			ezcUserNKParams.setLanguage("EN");
			ezcUserNKParams.setEzKeyValueStructure(in_E);
			ezcUserNKParams.setSys_Number(sysNum);
			uparams_E.createContainer();
			boolean result_flag = uparams_E.setObject(ezcUserNKParams);
			Session.prepareParams(uparams_E);
			UserManager.setUserAuth(uparams_E);
		}
	}
	/******************* Update Authorizations *************************/
%>
<%
	String msg = "User information updated successfully";
	/*if()
		msg = "User information updated successfully";
	else
		msg = "Error: Exception occurred while updating user information";*/

	session.putValue("EzMsgL","EDIT");
	session.putValue("EzMsg",msg);
	response.sendRedirect("../SelfService/ezOutMsg.jsp");
%>