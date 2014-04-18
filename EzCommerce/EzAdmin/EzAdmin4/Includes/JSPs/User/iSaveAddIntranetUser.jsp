<%@ page import = "ezc.ezparam.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*" %>

<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session">
</jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>

<%
String CheckBox = null; 
String pCheckBox = null; 
String [] SysKey = null;

// Get Basic Info
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

EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();

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
	

SysKey=request.getParameterValues("CheckBox");
String[] areaFlag=request.getParameterValues("areaFlag");


	for ( int i = 0  ; i < SysKey.length; i++ )
	{
		EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
		ebptrow.setEbpaClient("200"); // TBD
		ebptrow.setEbpaSysKey(SysKey[i]);
		ebptrow.setEbpaAreaFlag(areaFlag[i]);
                ebptrow.setEbpaUserId(UserId);
		ebptrow.setEbpaBussPartner("");
		ebpt.appendRow(ebptrow);

	}



//Add User Call
EzcUserParams uparams = new EzcUserParams();
EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
ezcAddUserStructure.setEzUserStructure(in);
ezcAddUserStructure.setCatalogNumber(CatalogNumber);
uparams.setObject(ebpt);
uparams.setObject(ezcAddUserStructure);

Session.prepareParams(uparams);
UserManager.addIntranetUser(uparams);

response.sendRedirect("../User/ezAddUserAuth.jsp?BusUser=" + UserId);
%>