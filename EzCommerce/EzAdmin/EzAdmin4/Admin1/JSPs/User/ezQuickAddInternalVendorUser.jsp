<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Qucik Add Vendor User</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String syskey[]=request.getParameterValues("syskey");
	String role=request.getParameter("role");
	String userId=request.getParameter("userId");
	String userName=request.getParameter("userName");
	String email=request.getParameter("email");

	String catnum="0";
	String busspartner=request.getParameter("busspartner");

	String ConnGroup = (String)session.getValue("ConnGroup");
	Connection 	con=null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	Hashtable userIndDefaults=new Hashtable();

	userIndAuth.put("VENDOR_SYS_IND","Vendor System Independent");
	
	userSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent");
	if("PP".equals(role))
		userSysAuth.put("PUR_PERSON","Purchase Person");
	else if("PH".equals(role))
		userSysAuth.put("PUR_HEAD","Purchase Head");
	else  if("VP".equals(role))
		userSysAuth.put("VICE_PRESIDENT","VICE_PRESIDENT");
	else
	{
%>
		<br><br><br><br>
		<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
		<Tr>
			<Th width="100%" align=center>
				Given role is not a vendor Role
			</Th>
		</Tr>
		</Table><br><center>
			<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
		</center>
<%
		return;
	}
	userIndDefaults.put("CURRENCY","USD");
	userIndDefaults.put("LANGUAGE","EN");
	userIndDefaults.put("STYLE","");
	userIndDefaults.put("USERROLE",role);
	
	ezc.ezbasicutil.EzMassInternalCustSynch mySynch= new ezc.ezbasicutil.EzMassInternalCustSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.SYSKEY=syskey[0];
	mySynch.company = userName;
	mySynch.email = email;
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
			mySynch.addInternalUser(bpnumber,"V");
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userIndDefaults);
	     	}
	}
	if(! error)
	{
%>
	<br><br><br><br>
       	<Table width="89%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr>
		<Th align=center>User "<%=userId.toUpperCase()%>" created sucessfully with Password "<%=mySynch.getPassword()%>".</Th>
	</Tr>
	</Table>	
	<br>
	<Center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
<%
}
%>
