<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Quick Add Service Customer</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String syskey[]=request.getParameterValues("syskey");
	String catnum=request.getParameter("catnum");
	String soldTo = request.getParameter("soldTo");
	String userId = request.getParameter("userId");
	String userName = request.getParameter("userName");	

	Hashtable bpSysAuth=new Hashtable();	  
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	
	bpSysAuth.put("SERV_CUST_DEP","Service Customer Dependent");
	bpIndAuth.put("SERV_CUST_IND","Service Customer InDependent");
	
	userSysAuth.put("SERV_CUST_DEP","Service Customer Dependent");
	userIndAuth.put("SERV_CUST_IND","Service Customer InDependent");
	
	
	String ConnGroup = (String)session.getValue("ConnGroup");	
	Connection 	con=null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	Hashtable partnerDefaults= new Hashtable();
	partnerDefaults.put("COMPCODE","1000");
	
	Hashtable userDefaults = new Hashtable();
	userDefaults.put("USERROLE","CUSTOMER");
	
	
	ezc.ezbasicutil.EzMassCustSynch mySynch= new ezc.ezbasicutil.EzMassCustSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.ERPSOLDTO=soldTo;
	mySynch.company = userName;	
	mySynch.SYSKEY=syskey[0];
	boolean error=false;


	String mySyskey = syskey[0];
	for(int i=1;i<syskey.length;i++)
	{
		mySyskey += "#####"+syskey[i];
	}
	mySynch.ezAreas=mySyskey;

   	String bpnumber=mySynch.addBP();
	if(bpnumber!=null && !"null".equals(bpnumber))
	{
		mySynch.addBPSysAuth(bpnumber,bpSysAuth);
		mySynch.addBPSysInAuth(bpnumber,bpIndAuth);
					
		for(int i=0;i<syskey.length;i++)
		{
			mySynch.SYSKEY=syskey[i];
			if(! mySynch.getCustomersFromErp())
			{
%>
				<br><br><br><br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						Problem While getting Customers From ERP.
					</Th>
				</Tr>
				</Table><br><center>
					<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
				</center>
<%
				error=true;
				break;
			}
			mySynch.ERPSOLDTO="00000000000000".substring(0,10-mySynch.ERPSOLDTO.length())+mySynch.ERPSOLDTO;
			if(! mySynch.ezAddPayTo(bpnumber))
			{
%>
				<br><br><br><br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						Problem While getting Customers From ERP.
					</Th>
				</Tr>
				</Table><br><center>
					<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
				</center>
<%
				error=true;
				break;
			}
			if(! mySynch.getBPCustomers(bpnumber))
			{
%>
				<br><br><br><br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						Problem While getting Customers.
					</Th>
				</Tr>
				</Table><br><center>
					<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
				</center>
<%
				error=true;
				break;
			}
			if(! mySynch.ezAddFunctions(bpnumber))
			{
%>
				<br><br><br><br>
				<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
				<Tr>
					<Th width="100%" align=center>
						Problem While adding functions.
					</Th>
				</Tr>
				</Table><br><center>
					<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
				</center>
<%
				error=true;
				break;
			}
			mySynch.addBpSysCustDefaults(bpnumber,partnerDefaults);
		}
		if(!error)
		{
			mySynch.UserId = userId.toUpperCase();
			mySynch.setPassword();
			mySynch.addUser(bpnumber);
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userDefaults);
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
