<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<%
	String syskey[]		= request.getParameterValues("soldSyskey");
	String subUser_Auth[]	= request.getParameterValues("subUserAuthDisp");

	String catnum		= request.getParameter("catnum");
	String soldToSU		= (String)Session.getUserId();
	String BusPartner 	= (String)session.getValue("BussPart");
	String UserGroup = "0", UserType = "3";

	String UserId 		= (request.getParameter("userId")).trim();
	String Password 	= request.getParameter("InitialPassword");
	String FirstName 	= (request.getParameter("userName")).trim();
	String MiddleInit 	= "";
	String LastName 	= (request.getParameter("lastName")).trim();
	String Email 		= (request.getParameter("email")).trim();
	String ValidToDate 	= "01/31/01";
	String subUserAuth 	= request.getParameter("subUserAuth");
	String repAgencyCode 	= request.getParameter("repAgencyCode");
	String exclMat 		= request.getParameter("exclMat");

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

	String ConnGroup = (String)session.getValue("Site");
	java.sql.Connection con=null;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=java.sql.DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);

	Hashtable userSysAuth = new Hashtable();
	Hashtable userIndAuth = new Hashtable();
	Hashtable userIndDefaults = new Hashtable();

	String userRole_A = "CU";

	if("Y".equals((String)session.getValue("REPAGENCY")))
		userRole_A = "RE";

	userIndDefaults.put("SUAUTH",subUserAuth);
	userIndDefaults.put("USERROLE",userRole_A);
	userIndDefaults.put("ISSUBUSER","Y");
	userIndDefaults.put("STATUS","A");

	if(repAgencyCode!=null && !"null".equalsIgnoreCase(repAgencyCode) && !"".equals(repAgencyCode))
		userIndDefaults.put("REPAGECODE",repAgencyCode);

	if(exclMat!=null && !"null".equalsIgnoreCase(exclMat) && !"".equals(exclMat))
		userIndDefaults.put("EXCLUSIVE_MAT",exclMat);

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
	}
	catch(Exception e){}

	mySynch.UserId = UserId.toUpperCase();
	mySynch.addUserSysAuth(userSysAuth);
	mySynch.addUserSysInAuth(userIndAuth);
	mySynch.addUserDefaults(userIndDefaults);

	boolean exeSuc = true;

	java.sql.Statement stmt= null;

	try
	{
		con.setAutoCommit(false);
		stmt= con.createStatement();
		stmt.addBatch("INSERT INTO EZC_USER_DEFAULTS VALUES ('"+UserId.toUpperCase()+"','999001','NULL','SOLDTOPARTY','0000000000','N','')");
		int[] updCnt = stmt.executeBatch();
		con.commit();
	}
	catch (java.sql.BatchUpdateException be)
	{
		//handle batch update exception
		int[] counts = be.getUpdateCounts();
		for (int i=0; i<counts.length; i++) {
			ezc.ezcommon.EzLog4j.log("Statement["+i+"] :"+counts[i],"D");
		}
		con.rollback();
		exeSuc = false;
	}
	catch (java.sql.SQLException e)
	{
		//handle SQL exception
		con.rollback();
		exeSuc = false;
		ezc.ezcommon.EzLog4j.log("handle SQL exception::::::::::::"+e,"I");
	}
	finally
	{
		if(stmt!=null)
		{
			stmt.close();
			con.close();
		}
	}

	String msg = "";
	if(exeSuc)
		msg = UserId.toUpperCase() + " created successfully with Password " + Password;
	else
		msg = "Error: Exception occurred while creating user";

	session.putValue("EzMsgL","ADD");
	session.putValue("EzMsg",msg);
	response.sendRedirect("../SelfService/ezOutMsg.jsp");
%>