<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	String UserId = request.getParameter("UserID");
	String UserType = request.getParameter("UserType");
	String UserGroup = request.getParameter("UserGroup");
	String FirstName = request.getParameter("FirstName");
	String MiddleInit = request.getParameter("MidInit");
	String LastName = request.getParameter("LastName");
	String Email = request.getParameter("Email");
	String CatalogNumber = request.getParameter("CatalogNumber");
	String ValidToDate = "01/31/01";
	String Area=request.getParameter("Area");
	String websyskey=request.getParameter("WebSysKey");

	String fromListByRole=request.getParameter("fromListByRole");
	String roleVal=request.getParameter("roleVal");
	String sysVal=request.getParameter("sysVal");

	String[] chk=request.getParameterValues("CheckBox");

	String [] ERPCust = null;
	String [] SysKey = null;

	java.util.Vector myVector=new java.util.Vector();
	java.util.Vector customers=new java.util.Vector();
	java.util.Vector syskeys=new java.util.Vector();


	String [] selSoldTo=request.getParameterValues("SelSoldTo");
	String [] selSysKey=request.getParameterValues("SelSysKey");

   	String AdminUser = request.getParameter("Admin");
   	AdminUser = (AdminUser == null)?"N":"Y";
	if ( UserType.equals("3") )
   	{
       		AdminUser = "Y";
   	}
	if(chk!=null)
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
		ERPCust[i]=(String)customers.elementAt(i);
		SysKey[i]=(String)syskeys.elementAt(i);
	}

	EzUserStructure in = new EzUserStructure();
	in.setUserId(UserId.trim());
	in.setFirstName(FirstName);
	in.setMiddleName(MiddleInit);
	in.setLastName(LastName);
	in.setEmail(Email);
	in.setType(new Integer (UserType).intValue());
	in.setUserGroup(new Integer (UserGroup).intValue());
	in.setValidToDate(ValidToDate);
	in.setIsBuiltInUser(AdminUser);


	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	ezcAddUserStructure.setERPCustomer(ERPCust);
	ezcAddUserStructure.setSysKey(SysKey);
	ezcAddUserStructure.setCatalogNumber(CatalogNumber);
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);
	Session.prepareParams(uparams);

	UserManager.updateUser(uparams);
	if(!(fromListByRole == null || "null".equals(fromListByRole)))
	{
		response.sendRedirect("../User/ezListUsersByRole.jsp?role="+roleVal+"&sysKey="+sysVal+"&fromMod=Yes");
	}
	else
	{
		response.sendRedirect("../User/ezListAllUsersBySysKey.jsp?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria);
	}

%>
