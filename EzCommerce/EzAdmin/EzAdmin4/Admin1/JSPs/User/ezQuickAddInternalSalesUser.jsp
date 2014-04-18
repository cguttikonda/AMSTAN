<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>

<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezmisc.params.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Quick Add Internal Sales User</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String syskey[]   =request.getParameterValues("syskey");
	String role       =request.getParameter("role");
	String userId     =request.getParameter("userId");
	String userName   =request.getParameter("userName");	
	String catnum	  =request.getParameter("catnum");
	String busspartner=request.getParameter("busspartner");
	String salesOffice=request.getParameter("salesOffice");
	String email      =request.getParameter("email");

	String ConnGroup = (String)session.getValue("ConnGroup");
	Connection con=null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	Hashtable userIndDefaults=new Hashtable();

	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userIndAuth.put("SALES_SYS_IND","Sales System Independant Role");
	
	if(role==null)
		userIndAuth.put("SALES_CUSTOMER","Sales Customer Role");
	else if("CM".equals(role))
		userIndAuth.put("SALES_CM","Sales Area Manager Role");
	else if("DM".equals(role))
		userIndAuth.put("SALES_DM","Sales District Manager  Role");
	else if("LF".equals(role))
		userIndAuth.put("SALES_LF","Sales Region Manager  Role");
	else 	if("SBU".equals(role))
		userIndAuth.put("SALES_FINANCE","Sales Finance  Role");
	else 	if("CUSR".equals(role))
		userIndAuth.put("CATALOG_USER","Catalog User Role");
	
	userIndDefaults.put("CURRENCY","USD");
	userIndDefaults.put("LANGUAGE","EN");
	userIndDefaults.put("STYLE","");
	userIndDefaults.put("USERROLE",role);
	userIndDefaults.put("SALESOFFICE","1000");
	userIndDefaults.put("SHOWIMAGES","Y");

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
			mySynch.email  = email;
			mySynch.setPassword();
			mySynch.addInternalUser(bpnumber,"C");
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userIndDefaults);
	     	}
	}
	if(! error)
	{
	
		/* To Insert User Auths :::START:::From Properties file */
		
			EzcParams mainParams= new EzcParams(false);
			EziMiscParams miscParams= new EziMiscParams();
			
			String userIdUC = userId.toUpperCase();
			String fileName = "ezQuickAddInternalSalesUser.jsp";
			String filePath = request.getRealPath(fileName);
			
			ezc.ezcommon.EzLog4j.log("fileName::"+fileName,"I");
			filePath = filePath.substring(0,filePath.indexOf(fileName));
			ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");
			filePath +="ezCustAuth.properties";
			ezc.ezcommon.EzLog4j.log("filePath::"+filePath,"I");

			Properties prop=new Properties();
			prop.load(new java.io.FileInputStream(filePath));
			
			String intAuthSplit = prop.getProperty("INTAUTH");
			String intAuthSplitArr[] = null;
			int intAuthSplitCnt=0;
			if(intAuthSplit!=null)
			{
				intAuthSplitArr = intAuthSplit.split("§");
				intAuthSplitCnt = intAuthSplitArr.length;
			}	
			
			for(int i=0;i<intAuthSplitCnt;i++)
			{
				
				String authKey   =  intAuthSplitArr[i].split("¥")[0];
				String authDesc  =  intAuthSplitArr[i].split("¥")[1];
				
				
				miscParams.setIdenKey("MISC_INSERT");
				String query="INSERT INTO EZC_USER_AUTH VALUES ('"+userIdUC+"','999','"+authKey+"','"+authDesc+"','R')";
				miscParams.setQuery(query);

				mainParams.setLocalStore("Y");
				mainParams.setObject(miscParams);
				Session.prepareParams(mainParams);	
				try
				{		
					ezMiscManager.ezAdd(mainParams);
				}
				catch(Exception e)
				{
					out.println("Exception in Getting Data"+e);
				}
			}
			
		/* To Insert User Auths :::END:::From Properties file */
		
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