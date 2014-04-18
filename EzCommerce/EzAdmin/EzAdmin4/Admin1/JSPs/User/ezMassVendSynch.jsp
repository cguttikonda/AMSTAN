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
	String logFile="d:\\bea\\passwords.txt";

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	int from=999999999;
	int to=999999999;

	Hashtable bpSysAuth=new Hashtable();	  
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();

	bpSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent Role");
	bpIndAuth.put("VENDOR_SYS_IND","Vemdpr System Independant Role");

	userSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent Role");
	userIndAuth.put("VENDOR_SYS_IND","Vemdpr System Independant Role");
	
	try
	{
		from=Integer.parseInt(request.getParameter("from"));
		to=Integer.parseInt(request.getParameter("to"));
	}
	catch(Exception e)
	{
	 	//out.println("Invalid From "  + from +  " and to  " + to);
 	}
	ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch("999","0");
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
			<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
			<Tr>
				<Th width="100%" align=center>
					Vendors List is Not Avialable. Please Check Property File "<%=prop%>".
				</Th>
			</Tr>
			</Table><br><center>
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
			   	String bpnumber=mySynch.addBP();

				if(bpnumber!=null && !"null".equals(bpnumber))
				{
					mySynch.addBPSysAuth(bpnumber,bpSysAuth);
					mySynch.addBPSysInAuth(bpnumber,bpIndAuth);

					StringTokenizer areaTokens=new StringTokenizer(mySynch.ezAreas,"#####");
					int tokensCount=areaTokens.countTokens();

					for(int k=0;k<tokensCount;k++)
					{
						mySynch.SYSKEY=areaTokens.nextToken();
						if(! mySynch.getVendorsFromErp())
						{
%>
							<br><br><br><br>
							<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
							<Tr>
								<Th width="100%" align=center>
									Problem While getting Vendors From ERP.
								</Th>
							</Tr>
							</Table><br><center>
								<img src="../../Images/Buttons/<%=ButtonDir%>/back.gif" style="cursor:hand"  alt="Click Here To Back" border=no onClick="JavaScript:history.go(-1)">
							</center>
<%						
							error=true;
							break;
						}
						if(! mySynch.ezAddPayTo(bpnumber))
						{
%>
							<br><br><br><br>
							<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 width="70%">
							<Tr>
								<Th width="100%" align=center>
									Problem While getting Vendors From ERP.
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
									Problem While getting Vendors.
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
				    	}	
				    	if(!error)
				    	{
						mySynch.addUser(bpnumber);
						mySynch.addUserSysAuth(userSysAuth);
						mySynch.addUserSysInAuth(userIndAuth);
						//mySynch.addUserDefaults();
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
		<form method=post action="ezPreMassVendSynch.jsp">
		<input type=hidden name=syskey value="<%=syskey%>">
		<input type=hidden name=prop value="<%=prop%>">
		<input type=hidden name=logFile value="<%=logFile%>">
		<input type=hidden name=from value="<%=from%>">
		<input type=hidden name=to value="<%=to%>">
		<br><br><br><br>
		<Table width="90%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
		<Tr>
			<Th align=center>Given Vendors are synchronized sucessfully.</Th>
		</Tr>
		</Table>
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%
	}
%>