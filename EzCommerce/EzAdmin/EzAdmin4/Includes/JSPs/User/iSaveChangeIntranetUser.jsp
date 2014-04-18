<%@ page import="java.util.*" %>
<%@ page import="ezc.ezadmin.busspartner.params.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminUser.jsp"%>
<jsp:useBean id="UserManager" class="ezc.client.EzUserAdminManager" scope="session"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	String myUserType = (String)session.getValue("myUserType");
	String myWebSyskey = (String)session.getValue("myWebSyskey");
	String myAreaFlag = (String)session.getValue("myAreaFlag");
	String mySearchCriteria = (String)session.getValue("mySearchCriteria");

	String BusPartner = request.getParameter("BusPartner");
	String CatalogNumber = request.getParameter("CatalogNumber");
	String FirstName = request.getParameter("FirstName");
	String MiddleInit = request.getParameter("MidInit");
	String LastName = request.getParameter("LastName");
	String Email = request.getParameter("Email");
	String UserId = request.getParameter("UserID");
	String UserType = request.getParameter("UserType");
	String UserGroup = request.getParameter("UserGroup");
	String ValidToDate = "01/31/01";
	String AdminUser = request.getParameter("Admin");
	AdminUser = (AdminUser == null)?"N":"Y";

	String fromListByRole=request.getParameter("fromListByRole");
	String roleVal=request.getParameter("roleVal");
	String sysVal=request.getParameter("sysVal");

	EzBussPartnerAreaTable ebpt = new EzBussPartnerAreaTable();
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


	String[] bpRows=request.getParameterValues("CheckBox");
	String bps="";
	String[] allareakeys=request.getParameterValues("allareakeys");
	String[] allareaflags=request.getParameterValues("allareaflags");

	Vector myVector=new Vector();
	Vector areakeys=new Vector();
	Vector areaflag=new Vector();

	if(bpRows != null)
	{
		for ( int i = 0  ; i < bpRows.length; i++ )
		{
			java.util.StringTokenizer stk=new java.util.StringTokenizer(bpRows[i],"#");
			String aKey=stk.nextToken();
			String aFlag=stk.nextToken();
			areakeys.addElement(aKey);
			areaflag.addElement(aFlag);
			myVector.addElement(aKey+"##"+aFlag);
		}
	}

	if(allareakeys!=null)
	{
		for(int i=0;i<allareakeys.length;i++)
		{
			if(myVector.contains(allareakeys[i]+"##"+allareaflags[i]))
			{
				areakeys.removeElement(allareakeys[i]);
				areaflag.removeElement(allareaflags[i]);
				continue;
			}
			areakeys.addElement(allareakeys[i]);
			areaflag.addElement(allareaflags[i]);
		}
	}

	for(int j=0;j<areakeys.size();j++)
	{
		EzBussPartnerAreaTableRow ebptrow = new EzBussPartnerAreaTableRow();
		ebptrow.setEbpaClient("200");
		ebptrow.setEbpaSysKey((String)areakeys.elementAt(j));
		ebptrow.setEbpaAreaFlag((String)areaflag.elementAt(j));
		ebptrow.setEbpaUserId(UserId);
		ebptrow.setEbpaBussPartner("");
		ebpt.appendRow(ebptrow);
	}

	String[] initArr = new String[0];
	EzcUserParams uparams = new EzcUserParams();
	EzcAddUserStructure ezcAddUserStructure = new EzcAddUserStructure();
	ezcAddUserStructure.setEzUserStructure(in);
	ezcAddUserStructure.setCatalogNumber(CatalogNumber);
	ezcAddUserStructure.setERPCustomer(initArr);  //call needs ERPCustomers - we are setting blank array for intranet users
	uparams.createContainer();
	uparams.setObject(ezcAddUserStructure);
	uparams.setObject(ebpt);
	Session.prepareParams(uparams);

	UserManager.updateUser(uparams);
	UserManager.setInranetUserAreas(uparams);

	if(!(fromListByRole == null || "null".equals(fromListByRole)))
	{
		response.sendRedirect("ezListUsersByRole.jsp?role="+roleVal+"&sysKey="+sysVal+"&fromMod=Yes");
	}
	else
	{
		response.sendRedirect("../User/ezListAllUsersBySysKey.jsp?WebSysKey="+myWebSyskey+"&Area="+myAreaFlag+"&myUserType="+myUserType+"&searchcriteria="+mySearchCriteria);
	}
%>
