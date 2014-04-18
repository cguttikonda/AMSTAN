<%//@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<%@ page import = "ezc.ezparam.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Quick Add Customer</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>

<%
	String syskey[]	=request.getParameterValues("CheckBox");
	String catnum	=request.getParameter("catnum");
	String soldTo 	=(String)Session.getUserId();
		
		
	String[] checks=request.getParameterValues("CheckBox");
	java.util.StringTokenizer stk=null;

	String[] syskeys=null;
	String[] erpCusts=null;
	if(checks!=null)
	{
		syskeys=new String[checks.length];
		erpCusts=new String[checks.length];

		for(int i=0;i<checks.length;i++)
		{
			stk=new StringTokenizer(checks[i],"#");
			erpCusts[i]=stk.nextToken(); 
			syskeys[i]=stk.nextToken();

		}
	}

	String BusPartner = (String)session.getValue("BussPart");
	String UserGroup = "0", UserType = "3";

	String UserId = (request.getParameter("userId")).trim();
	String Password = request.getParameter("InitialPassword");
	String FirstName = (request.getParameter("userName")).trim();
	String MiddleInit = "";
	String LastName = "";
	String Email = (request.getParameter("email")).trim();
	String ValidToDate = "01/31/01";
	String subUserAuth = request.getParameter("subUserAuth");
	
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
	ezcAddUserStructure.setERPCustomer(erpCusts);
	ezcAddUserStructure.setSysKey(syskeys);
	ezcAddUserStructure.setCatalogNumber(catnum);
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);

	Session.prepareParams(uparams);
	UserManager.addUsers(uparams);


	String payTo = erpCusts[0];
	
	

	String ConnGroup = "200";//(String)session.getValue("ConnGroup");
	Connection con=null;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);

	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();

	Hashtable userIndDefaults=new Hashtable();

	userIndDefaults.put("SUAUTH",subUserAuth);
	userIndDefaults.put("USERROLE","CU");
	userIndDefaults.put("ISSUBUSER","Y");
	userIndDefaults.put("STATUS","A");


	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userIndAuth.put("SALES_SYS_IND","Sales System Independant Role");

	ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.ERPSOLDTO=soldTo.trim();
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
%>

<html>
<head>
<Title>Add User</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
	function navigateBack(obj)
	{
		document.myForm.action=obj;
		document.myForm.submit();
	}
</script>
</head>
<body onContextMenu='return false;'>
<form name="myForm">
	<br><br><br><br>
<%
	String noDataStatement = UserId.toUpperCase() + " created successfully with Password " + Password;

%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
	<!--
	<Table width="40%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center>User  "<%=UserId.toUpperCase()%>" created successfully with Password "<%=Password%>".</Th>
	</Tr>
	</Table>	
	-->

	<Div id="ButtonDiv" style="position:absolute;top:60%;width:100%" align="center">
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Ok");
		buttonMethod.add("navigateBack(\"../Misc/ezAddSubUser.jsp\")");

		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Div>
</form>
	<Div id="MenuSol"></Div>
</body>
</html>
