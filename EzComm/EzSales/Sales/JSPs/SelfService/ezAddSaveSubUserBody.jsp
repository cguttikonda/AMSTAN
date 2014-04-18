<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
	<Title>Quick Add Customer</Title>

</head>

<%
	//String syskey[]	=request.getParameterValues("CheckBox");
	String syskey[]	=request.getParameterValues("soldSyskey");
	String ShipCount[] = request.getParameterValues("hiddenShip");
	String [] shipTo = request.getParameterValues("hiddenShip");

	String subUser_Auth[]	=request.getParameterValues("subUserAuthDisp");

	Hashtable shipHash =  new Hashtable();
	Vector chkShip = new Vector();
	String [] splitShip =null;
	String selSold = "";
	String selectedSys = "";
		
	for(int i=0;i<ShipCount.length;i++)
	{
		if(!"".equals(shipTo[i]))
		{
			splitShip = shipTo[i].split("¥");
			if((chkShip.contains(splitShip[0].split("##")[2])))
			{
				String getShip = (String)shipHash.get(splitShip[0].split("##")[2]);
				getShip = getShip+"$$"+shipTo[i];	
				shipHash.put(splitShip[0].split("##")[2],getShip);
			}
			else
			{
				
				shipHash.put(splitShip[0].split("##")[2],shipTo[i]);	
				chkShip.add(splitShip[0].split("##")[2]);
			}
		}	
	}
	
	String catnum	=request.getParameter("catnum");
	String soldToSU	=(String)Session.getUserId();
	//out.println("shipHash::::::::::::::"+shipHash);
		
	//String[] checks = request.getParameterValues("CheckBox");
	String[] checks   = request.getParameterValues("CheckBox");
	//String[] chekedVal= request.getParameterValues("CheckBox");
	
	
	java.util.StringTokenizer stk=null;
	java.util.StringTokenizer stk1=null;

	String[] syskeys=null;
	String[] erpCusts=null;
	if(checks!=null)
	{
		syskeys=new String[checks.length];
		erpCusts=new String[checks.length];

		for(int i=0;i<checks.length;i++)
		{
			//out.println("checks[i]:::::::"+checks[i]);
			stk=new StringTokenizer(checks[i],"¥");
			erpCusts[i]=stk.nextToken(); 
			syskeys[i] =stk.nextToken();
		}
		
	}
		

//out.println("syskeys::::::::::::::"+tempSys.length);
	String BusPartner = (String)session.getValue("BussPart");
	String UserGroup = "0", UserType = "3";

	String UserId = (request.getParameter("userId")).trim();
	String Password = request.getParameter("InitialPassword");
	String FirstName = (request.getParameter("userName")).trim();
	String MiddleInit = "";
	String LastName = (request.getParameter("lastName")).trim();
	String Email = (request.getParameter("email")).trim();
	String ValidToDate = "01/31/01";
	String subUserAuth = request.getParameter("subUserAuth");
	String repAgencyCode = request.getParameter("repAgencyCode");
	
	ezc.ezcommon.EzLog4j.log("subUserAuth::::::::::::::"+subUserAuth,"I");

	EzUserStructure in = new EzUserStructure();

	in.setUserId(UserId);
	in.setPassword(Password);
	in.setFirstName(FirstName);
	in.setMiddleName(MiddleInit);
	in.setLastName(LastName);
	in.setEmail(Email);
	in.setBussPartner(BusPartner);
	in.setType(new Integer(UserType).intValue());
	in.setUserGroup(new Integer(UserGroup).intValue());
	in.setValidToDate(ValidToDate);
	in.setIsBuiltInUser("Y");


	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	//ezcAddUserStructure.setERPCustomer(erpCusts);
	//ezcAddUserStructure.setSysKey(syskeys);
	ezcAddUserStructure.setCatalogNumber(catnum);
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);

	Session.prepareParams(uparams);
	UserManager.addUsers(uparams);

	String payTo = erpCusts[0];
	String	subSysKey = syskeys[0].split("¤¤")[0];
	
	String ConnGroup = (String)session.getValue("Site");
	java.sql.Connection con=null;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=java.sql.DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);

	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();

	Hashtable userIndDefaults=new Hashtable();

	userIndDefaults.put("SUAUTH",subUserAuth);
	userIndDefaults.put("USERROLE","CU");
	userIndDefaults.put("ISSUBUSER","Y");
	userIndDefaults.put("STATUS","A");
	
	if(repAgencyCode!=null && !"null".equalsIgnoreCase(repAgencyCode) && !"".equals(repAgencyCode))
		userIndDefaults.put("REPAGECODE",repAgencyCode);

	String defShipTo = (String)shipHash.get(payTo);
	//out.println("defShipTo::::::::::::::"+defShipTo);
	
	userIndDefaults.put("C_ERPSHIPTO",defShipTo.split("##")[0]);
	userIndDefaults.put("C_ERPSOLDTO",payTo);
	userIndDefaults.put("C_USERSYSTEMKEY",subSysKey);

	for(int i=0;i<subUser_Auth.length;i++)
	{
		if(subUser_Auth[i]!=null && !"null".equalsIgnoreCase(subUser_Auth[i]) && !"".equals(subUser_Auth[i]))
			userSysAuth.put(subUser_Auth[i],"Super Admin Insert");
	}

	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userIndAuth.put("SALES_SYS_IND","Sales System Independant Role");

	ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.ERPSOLDTO=soldToSU.trim();
	mySynch.company = FirstName;
	mySynch.SYSKEY=syskey[0];
	
	try
	{
		Long.parseLong(mySynch.ERPSOLDTO);
		mySynch.ERPSOLDTO="00000000000000".substring(0,10-mySynch.ERPSOLDTO.length())+mySynch.ERPSOLDTO;				
	}catch(Exception e){}
	
	
	mySynch.UserId = UserId.toUpperCase();
	mySynch.addUserSysAuth(userSysAuth);
	mySynch.addUserSysInAuth(userIndAuth);
	mySynch.addUserDefaults(userIndDefaults);
	
	boolean exeSuc = true;
	if(shipHash.size()>0 )	
	{
		ezc.ezcommon.EzLog4j.log("shipHash::::::::::::::"+shipHash.size(),"I");
		java.util.StringTokenizer shipToken = null;
		String soldCode="";
		String selSysKey="";
		String selShip = "";
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
			exeSuc = false;
		}
		catch (java.sql.SQLException e) {

				//handle SQL exception
				con.rollback();
				exeSuc = false;
				ezc.ezcommon.EzLog4j.log("handle SQL exception::::::::::::"+e,"I");
		}
		finally
		{
			if(stmt!=null || stmt1!=null)
			{
				stmt.close();
				stmt1.close();
				con.close();
			}
		}
	}
%>

<html>
<head>
<Title>Add User</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onContextMenu="return false"> 
<form name="myForm">
<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
<%
	String noDataStatement_SU = "";
	if(exeSuc)
		noDataStatement_SU = UserId.toUpperCase() + " created successfully with Password " + Password;
	else
		noDataStatement_SU = "Exception occurred while creating user";

%>

	<div class="page-title">
			<h2> <%=noDataStatement_SU%></h2>
	</div>	

	<br>
	
</form>
</body>
</div>
</div>
</div>
</html>
