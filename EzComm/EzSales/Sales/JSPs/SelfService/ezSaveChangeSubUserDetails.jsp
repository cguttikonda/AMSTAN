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

	String[] checks		= request.getParameterValues("CheckBox");
	String[] subUserSysKeys	= request.getParameterValues("subUserSysKeys");

	String [] ERPCust 	= null;
	String [] SysKey 	= null;

	java.util.Vector myVector	= new java.util.Vector();
	java.util.Vector customers	= new java.util.Vector();
	java.util.Vector syskeys	= new java.util.Vector();

	String [] selSoldTo	= request.getParameterValues("SelSoldTo");
	String [] selSysKey	= request.getParameterValues("SelSysKey");
	String [] ShipCount 	= request.getParameterValues("hiddenShip");
	String [] shipTo 	= request.getParameterValues("hiddenShip");

	/*if(chk!=null)
	{
		for(int i=0;i<chk.length;i++)
		{
			java.util.StringTokenizer stk=new java.util.StringTokenizer(chk[i],"#");
			String token1=stk.nextToken();
			String token2=stk.nextToken();
			customers.addElement(token1);
			syskeys.addElement(token2);
			myVector.addElement(token1+"[[[]]]" + token2);
		}
	}
	if(selSoldTo!=null)
	{
		for(int i=0;i<selSoldTo.length;i++)
		{
			if(myVector.contains(selSoldTo[i] +"[[[]]]" + selSysKey[i]))
			{
				customers.removeElement(selSoldTo[i]);
				syskeys.removeElement(selSysKey[i]);
				continue;
			}
			customers.addElement(selSoldTo[i]);
			syskeys.addElement(selSysKey[i]);
		}
	}
	
	ERPCust= new String[customers.size()];
	SysKey=new String[syskeys.size()];
	for(int i=0;i<customers.size();i++)
	{
		ERPCust[i]=((String)customers.elementAt(i)).trim();
		SysKey[i]=((String)syskeys.elementAt(i)).trim();
		
	}*/

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
	
	/******************** Update Sub User Auth - Start **********************/
	
	/*if(subUserAuth!=null && !"null".equals(subUserAuth) && !"".equals(subUserAuth))
	{
		miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);
		ezc.ezcommon.EzLog4j.log("subUserAuth:::::::IN IF:::::::"+subUserAuth,"I");

		miscParams.setIdenKey("MISC_UPDATE");
		miscParams.setQuery("UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+subUserAuth.trim()+"' WHERE EUD_USER_ID='"+UserId.trim()+"' AND EUD_KEY='SUAUTH'");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		ezc.ezcommon.EzLog4j.log("miscParams:::::::IN IF:::::::"+miscParams.getQuery(),"I");
		MiscManager.ezUpdate(miscMainParams);
	}*/

	/******************** Update Sub User Auth - End **********************/

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

	/******************* Update Ship Tos - Start *************************/
	String ConnGroup = (String)session.getValue("Site");
	java.sql.Connection con=null;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=java.sql.DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));	
	
	if(ShipCount.length>0)	
	{
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		EzcParams miscMainParams = new EzcParams(true);
		ezc.ezcommon.EzLog4j.log("subUserAuth:::::::IN IF:::::::"+subUserAuth,"I");

		miscParams.setIdenKey("MISC_DELETE");
		miscParams.setQuery("DELETE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+UserId.toUpperCase()+"' AND EUD_KEY IN('SOLDTOPARTY','SHIPTOPARTY')");
		miscMainParams.setObject(miscParams);
		miscMainParams.setLocalStore("Y");

		Session.prepareParams(miscMainParams);
		ezc.ezcommon.EzLog4j.log("miscParams:::::::IN IF:::::::"+miscParams.getQuery(),"I");
		MiscManager.ezDelete(miscMainParams);		
				
		
		String [] shipSys = null;
		String [] sysKeys = null;
		String [] soldSys = null;
		String [] soldKeys = null;		

		java.sql.Statement stmt= null;
		java.sql.Statement stmt1= null;
		try{
			con.setAutoCommit(false);
			stmt= con.createStatement();
			stmt1= con.createStatement();
		}
		catch(Exception e){
			ezc.ezcommon.EzLog4j.log("Ezception::::::::::::::"+e,"I");
		}
		
		for(int i=0;i<ShipCount.length;i++)
		{
			if(!"".equals(shipTo[i]))
			{		
				shipSys = shipTo[i].split("¥");
				sysKeys = shipSys[1].split("¤¤");
				//out.println("shipSys::::::::::::"+shipSys.length);
				for(int k=0;k<sysKeys.length;k++)
				{
					//out.println("shipSys::::::::::::"+shipSys[0].split("##")[2]+"::::::shipSys[0].split(\"##\")[0]:::::"+shipSys[0].split("##")[0]+"::::::loop:::"+k+"<br>");
					//out.println("sysKeys::::::::::::"+sysKeys[k]+"loop:::"+k+"<br>");
					try{
						//ezc.ezcommon.EzLog4j.log("INSERT INTO EZC_ERP_CUSTOMER_DEFAULTS VALUES ('"+shipSys[0].split("##")[2]+"','SHIPTO','"+shipSys[0].split("##")[0]+"','"+sysKeys[k]+"','"+UserId.toUpperCase()+"')","I");
						//stmt.addBatch("INSERT INTO EZC_ERP_CUSTOMER_DEFAULTS VALUES ('"+shipSys[0].split("##")[2]+"','SHIPTO','"+shipSys[0].split("##")[0]+"','"+sysKeys[k]+"','"+UserId.toUpperCase()+"')");
						ezc.ezcommon.EzLog4j.log("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+shipSys[0].split("##")[2]+"','SHIPTO','"+shipSys[0].split("##")[0]+"','"+sysKeys[k]+"','"+UserId.toUpperCase()+"')","I");
						stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+UserId.toUpperCase()+"','"+sysKeys[k]+"','NULL','SHIPTOPARTY','"+shipSys[0].split("##")[0]+"','N','')");
					}
					catch(Exception e){
						ezc.ezcommon.EzLog4j.log("Exception in Batch Query::IF:::::::::::"+e,"I");	
					}					
					
				}
			}
		}
		for(int i=0;i<checks.length;i++)
		{
			if(!"".equals(checks[i]))
			{		

				soldSys = checks[i].split("¥");
				soldKeys = soldSys[1].split("¤¤");
				//out.println("shipSys::::::::::::"+soldKeys.length);
				for(int k=0;k<soldKeys.length;k++)
				{
					//out.println("soldSys::::::::::::"+soldSys[0]+"::::::loop:::"+k+"<br>");
					//out.println("soldKeys::::::::::::"+soldKeys[k]+"loop:::"+k+"<br>");
					try{
						ezc.ezcommon.EzLog4j.log("INSERT INTO EZC_USER_DEFAULTS VALUES  ('"+Session.getUserId()+"','"+soldKeys[k]+"','NULL','SOLDTOPARTY','"+soldSys[0]+"','N','NULL')","I");
						stmt1.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES  ('"+UserId.toUpperCase()+"','"+soldKeys[k]+"','NULL','SOLDTOPARTY','"+soldSys[0]+"','N','')");
					}
					catch(Exception e){
						ezc.ezcommon.EzLog4j.log("Exception in Batch Query::IF:::::::::::"+e,"I");	
					}					

				}
			}
		}		
		try{
			int[] updCnt = stmt.executeBatch();
			int[] updCnt1 = stmt1.executeBatch();
			con.commit();
			ezc.ezcommon.EzLog4j.log("updCnt::::::::::::"+updCnt.length,"D");
			ezc.ezcommon.EzLog4j.log("updCnt1::::::::::::"+updCnt1.length,"D");
		}
		catch (java.sql.BatchUpdateException be)
		{
			ezc.ezcommon.EzLog4j.log("BatchUpdateException::::::::::::"+be,"I");
			//handle batch update exception
			int[] counts = be.getUpdateCounts();
			for (int i=0; i<counts.length; i++) {
					ezc.ezcommon.EzLog4j.log("Statement["+i+"] :"+counts[i],"D");
			}
			con.rollback();
		}
		catch (java.sql.SQLException e) {

				//handle SQL exception
				con.rollback();
				ezc.ezcommon.EzLog4j.log("handle SQL exception::::::::::::"+e,"I");
		}
		finally
		{
			if(stmt!=null  || stmt1!=null)
			{
				stmt.close();
				stmt1.close();
				con.close();
			}
		}
	}	
	
	
	/******************* Update Ship Tos - End *************************/

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

	String msg = "User information updated successfully";
	/*if()
		msg = "User information updated successfully";
	else
		msg = "Error: Exception occurred while updating user information";*/

	session.putValue("EzMsgL","EDIT");
	session.putValue("EzMsg",msg);
	response.sendRedirect("../SelfService/ezOutMsg.jsp");
%>