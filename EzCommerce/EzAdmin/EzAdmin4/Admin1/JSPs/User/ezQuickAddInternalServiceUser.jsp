<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Quick Add Internal Service User</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String syskey[]=request.getParameterValues("syskey");
	String role=request.getParameter("role");
	String userId=request.getParameter("userId");
	String userName=request.getParameter("userName");	
	String catnum=request.getParameter("catnum");
	String busspartner=request.getParameter("busspartner");

	String ConnGroup = (String)session.getValue("ConnGroup");
	Connection con=null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	Hashtable userIndDefaults=new Hashtable();

	if("ENGINEER".equals(role))
	{
		userSysAuth.put("SERV_ENG_DEP","Service Engineer Dependent");
		userIndAuth.put("SERV_ENG_IND","Service Engineer InDependent");
	}
	else if("REGIONALENGINEER".equals(role))
	{
		userSysAuth.put("SERV_RENG_DEP","Service Regional Eng Dep");
		userIndAuth.put("SERV_RENG_IND","Service Regional Eng InD");
	}
	else if("REGIONAL_BUSINESS_MANAGER".equals(role))
	{
		userSysAuth.put("SREG_BUS_MGR_DEP","SRegional Bus Manager Dep");
		userIndAuth.put("SREG_BUS_MGR_IND","SRegional Bus Manager Ind");
	}
	else 
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				Not a valid role.
			</Th>
		</Tr>
		</Table><br><center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
		</center>
<%
		return;
	}
	
	userIndDefaults.put("CURRENCY","INR");
	userIndDefaults.put("LANGUAGE","EN");
	userIndDefaults.put("STYLE","");
	userIndDefaults.put("USERROLE",role);

	ezc.ezbasicutil.EzMassInternalCustSynch mySynch= new ezc.ezbasicutil.EzMassInternalCustSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.SYSKEY=syskey[0];
	mySynch.SYSKEY=catnum;
	mySynch.company = userName;
	boolean error=false;
	
	String mySyskey = syskey[0];
	for(int i=1;i<syskey.length;i++)
	{
		mySyskey += "#####"+syskey[i];
	}
	mySynch.ezAreas=mySyskey;
	String bpnumber=busspartner;
	if(bpnumber!=null && !"null".equals(bpnumber))
	{
		for(int i=0;i<syskey.length;i++)
		{
			mySynch.SYSKEY=syskey[i];
	    	}
	    	if(!error)
		{
			mySynch.UserId = userId.toUpperCase();
			mySynch.setPassword();
			mySynch.addInternalUser(bpnumber,"C");
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userIndDefaults);
	     	}
	}
	if(! error)
	{
%>
	<br><br><br><br>
	<Table width="90%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>	
	<Tr>
		<Th align=center>User "<%=userId.toUpperCase()%>" created successfully with Password "<%=mySynch.getPassword()%>".</Th>
	</Tr>
	</Table>	
	<br>
	<Center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
<%
}	
%>
