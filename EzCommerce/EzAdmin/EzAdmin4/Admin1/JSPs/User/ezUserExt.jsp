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
	Hashtable bpSysAuth=new Hashtable();	  
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	
	bpSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	bpIndAuth.put("SALES_CUSTOMER","Sales Customer Role");


	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userIndAuth.put("SALES_CUSTOMER","Sales Customer Role");


	Connection 	con=null;
	String syskey="999636";//request.getParameter("syskey");
	String prop= "MULTI"; //request.getParameter("prop");
	String catnum="10040";//request.getParameter("catnum");
	String logFile="d:\\bea\\passwords.txt";

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
	java.util.ResourceBundle bpres = java.util.ResourceBundle.getBundle("BUSSPARTNERS");
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
 	
	from = 0;
	to = 4;

	Hashtable partnerDefaults= new Hashtable();
	partnerDefaults.put("COMPCODE","1000");
	
	Hashtable userDefaults = new Hashtable();
	userDefaults.put("USERROLE","CU");
	
	
	ezc.ezbasicutil.EzMassCustSynch mySynch= new ezc.ezbasicutil.EzMassCustSynch("999",catnum);
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
					Customers List is Not Avialable. Please Check Property File "<%=prop%>".
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
			   	//String bpnumber=mySynch.addBP();
			   	String bpnumber=bpres.getString(mySynch.ERPSOLDTO);
				if(bpnumber!=null && !"null".equals(bpnumber))
				{
					if(mySynch.ezAreas.indexOf("999636")==-1)
						continue;
					
					mySynch.ezAreas="999636";
					StringTokenizer areaTokens=new StringTokenizer(mySynch.ezAreas,"#####");
					int tokensCount=areaTokens.countTokens();
					
					for(int k=0;k<tokensCount;k++)
					{
						mySynch.SYSKEY=areaTokens.nextToken();
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
				    	
				}
			}
		}
		
	}
        else
       	{
		//out.println("Unabel to Open Log Writer11.................");
	}
%>