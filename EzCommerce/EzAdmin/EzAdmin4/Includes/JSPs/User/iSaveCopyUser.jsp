<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="BPManager" class="ezc.client.EzBussPartnerManager" scope="session"></jsp:useBean>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");
	
	String [] ERPCust = null;
	String [] SysKey = null;
	String[] chk=request.getParameterValues("CheckBox");

	String OldUser = request.getParameter("OldUser"); 

	String UserId = request.getParameter("UserID");
	String Password = request.getParameter("InitialPassword");
	String UserType = request.getParameter("UserType");
	String UserGroup = request.getParameter("UserGroup");
	String FirstName = request.getParameter("FirstName");
	String MiddleInit = request.getParameter("MidInit");
	String LastName = request.getParameter("LastName");
	String Email = request.getParameter("Email");
	String BusPartner = request.getParameter("BusPartner");
	String ValidToDate = "01/31/01";
	String CatalogNumber = request.getParameter("CatalogNumber");

   	String AdminUser = request.getParameter("Admin");
   	AdminUser = (AdminUser == null)?"N":"Y"; 
	if ( UserType.equals("3") )
   	{
   	    	AdminUser = "Y";
   	}
	if(chk != null)
	{	
		ERPCust=new String[chk.length];
		SysKey=new String[chk.length];
		java.util.StringTokenizer stk=null;
		for(int i=0;i<chk.length;i++)
		{
			stk=new java.util.StringTokenizer(chk[i],"#");
			ERPCust[i]=stk.nextToken();
			SysKey[i]=stk.nextToken();
		}
	}	
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
	in.setIsBuiltInUser(AdminUser);  

	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	ezcAddUserStructure.setERPCustomer(ERPCust);
	ezcAddUserStructure.setSysKey(SysKey);
	ezcAddUserStructure.setCatalogNumber(CatalogNumber);
	uparams.setObject(ezcAddUserStructure);
	Session.prepareParams(uparams);

	UserManager.addUsers(uparams);

	EzcUserParams uparamsNew = new EzcUserParams();
	EzcUserNKParams unkparamsNew = new EzcUserNKParams();
	uparamsNew.createContainer();
	unkparamsNew.setFrom_User(OldUser);
	unkparamsNew.setTo_User(UserId);
	unkparamsNew.setLanguage("EN");
	uparamsNew.setObject(unkparamsNew);
	Session.prepareParams(uparamsNew);
	UserManager.copyUserDefAndAuth(uparamsNew);
	response.sendRedirect("../User/ezListAllUsersBySysKey.jsp?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria);
%>