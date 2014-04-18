<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Mass Vendor Synchronization</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String ConnGroup = (String)session.getValue("ConnGroup");
	Connection 	con=null;
	String syskey=request.getParameter("syskey");
	String prop=request.getParameter("prop");
	String role=request.getParameter("role");

	String catnum="0";
	String busspartner=request.getParameter("busspartner");
	String logFile="d:\\bea\\passwords.txt";

	Hashtable bpSysAuth=new Hashtable();
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	Hashtable userIndDefaults=new Hashtable();

	bpSysAuth.put("PUR_HEAD","Purchase Head");
	bpSysAuth.put("PUR_PERSON","Purchase Person");
	bpSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent");
	bpSysAuth.put("VICE_PRESIDENT","VICE_PRESIDENT");
	
	bpIndAuth.put("VENDOR_SYS_IND","Vendor System Independent");
	
	userIndAuth.put("VENDOR_SYS_IND","Vendor System Independent");
	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userSysAuth.put("SALES_SYS_IND","Sales System Independant Role");
	
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
	userIndDefaults.put("CURRENCY","INR");
	userIndDefaults.put("LANGUAGE","EN");
	userIndDefaults.put("STYLE","");
	userIndDefaults.put("USERROLE",role);
	
	
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
	
	int from=999999999;
	int to=999999999;
	try
	{
		from=Integer.parseInt(request.getParameter("from"));
		to=Integer.parseInt(request.getParameter("to"));
	}
	catch(Exception e)
	{
	 	//out.println("Invalid From "  + from +  " and to  " + to);

	}
	ezc.ezbasicutil.EzMassInternalCustSynch mySynch= new ezc.ezbasicutil.EzMassInternalCustSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.SYSKEY=syskey;
	boolean error=false;
	if(from!=999999999 && to!=999999999 )
	{
		boolean VENDOR_LIST_READY=false;
		try
		{
			mySynch.usersList=java.util.ResourceBundle.getBundle(prop);
			VENDOR_LIST_READY=true;
		}
		catch(Exception e)
		{
			VENDOR_LIST_READY=false;
			error=true;
%>
			<br><br><br><br>
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="90%">
			<Tr>
				<Th width="100%" align=center>
					Vendors List is Not Avilable. Please Check Property File "<%=prop%>".
				</Th>
			</Tr>
			</Table>
			<br>
			<center>
				<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
			</center>
	<%
		 }
 		 if(VENDOR_LIST_READY)
		 {
			for(int i=from;i<=to;i++)
			{
			   	error=false;
			   	mySynch.getValues(i);
			   	String bpnumber=busspartner;
				if(bpnumber!=null && !"null".equals(bpnumber))
				{
					StringTokenizer areaTokens=new StringTokenizer(mySynch.ezAreas,"#####");
					int tokensCount=areaTokens.countTokens();
					for(int k=0;k<tokensCount;k++)
					{

						mySynch.SYSKEY=areaTokens.nextToken();
				    	}
				    	if(!error)
				    	{
						mySynch.addInternalUser(bpnumber,"V");
						mySynch.addUserSysAuth(userSysAuth);
						mySynch.addUserSysInAuth(userIndAuth);
						mySynch.addUserDefaults(userIndDefaults);
						//mySynch.addToWorkFlow( mySynch.SYSKEY,"100","1","2",String.valueOf(Long.parseLong(mySynch.ERPSOLDTO)),"");
				     	}
				}
			}
		}
	}
        else
       	{
		//out.println("Unabel to Open Log Writer11.................");
	}
	if(! error)
	{
%>
		<form method=post action="ezPreMassCustSynch.jsp">
		<input type=hidden name=syskey value="<%=syskey%>">
		<input type=hidden name=prop value="<%=prop%>">
		<input type=hidden name=logFile value="<%=logFile%>">
		<input type=hidden name=from value="<%=from%>">
		<input type=hidden name=to value="<%=to%>">
		<input type=hidden name=busspartner value="<%=busspartner%>" >
		<br><br><br><br>
		<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="90%">
		<Tr>
			<Th align=center>Given Internal Users are synchronized sucessfully.</Th>
		</Tr>
		</Table>
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%
	}
%>
