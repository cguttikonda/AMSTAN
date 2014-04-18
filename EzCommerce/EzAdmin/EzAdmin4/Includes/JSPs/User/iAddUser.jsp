<%@ page import = "ezc.ezparam.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
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
ezcAddUserStructure.setERPCustomer(erpCusts);
ezcAddUserStructure.setSysKey(syskeys);
ezcAddUserStructure.setCatalogNumber(CatalogNumber);
uparams.createContainer();
uparams.setObject(ezcAddUserStructure);


Session.prepareParams(uparams);
UserManager.addUsers(uparams);

response.sendRedirect("../User/ezAddUserAuth.jsp?BusUser=" + UserId + "&BusinessPartner=" + BusPartner);
%>