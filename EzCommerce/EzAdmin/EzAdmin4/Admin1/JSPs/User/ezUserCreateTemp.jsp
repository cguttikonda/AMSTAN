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
	
	//String syskey=request.getParameter("syskey");
	//String prop=request.getParameter("prop");
	//String catnum=request.getParameter("catnum");
	
	String syskey="999609";//request.getParameter("syskey");
	String prop= "999609"; //request.getParameter("prop");
	String catnum="10040";//request.getParameter("catnum");


	String logFile="d:\\bea\\passwords.txt";

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));
	
	java.util.ResourceBundle custres = java.util.ResourceBundle.getBundle("CUSTOMERS");
		

	int from=0;
	int to=43;
	try
	{
		from=Integer.parseInt(request.getParameter("from"));
		to=Integer.parseInt(request.getParameter("to"));
	}
	catch(Exception e)
	{
	 	//out.println("Invalid From "  + from +  " and to  " + to);
 	}

	Hashtable partnerDefaults= new Hashtable();
	partnerDefaults.put("COMPCODE","1000");
	
	Hashtable userDefaults = new Hashtable();
	userDefaults.put("USERROLE","CU");
	
	
	ezc.ezbasicutil.EzMassCustSynch mySynch= new ezc.ezbasicutil.EzMassCustSynch("999",catnum);
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.SYSKEY=syskey;
	boolean error=false;
	//ERPSOLDTO="00000000000000".substring(0,10-ERPSOLDTO.length())+ERPSOLDTO;
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
			   	String tempSold = mySynch.ERPSOLDTO;
			   	String tempSoldTO=" ";

			   	try{
			   		tempSoldTO = custres.getString(tempSold);
			   		continue;
			   	}catch(Exception e)
			   	{
			   	
			   	}
			   	if(tempSold.length()==10)
			   	    continue;
			   	    
			   	out.println("<BR> ############# "+tempSold);
			   		
			   	
			   	


		   	
		   	
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
				    	if(!error)
				    	{
						mySynch.addUser(bpnumber);
						out.println("UserId" + mySynch.UserId);
						mySynch.addUserSysAuth(userSysAuth);
						mySynch.addUserSysInAuth(userIndAuth);
						mySynch.addUserDefaults(userDefaults);
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
		<br><br><br><br>
		<Table width="90%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
		<Tr>
			<Th align=center>Given Customers are synchronized sucessfully.</Th>
		</Tr>
		</Table>
		<br>
		<Center>
			<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
		</Center>
<%
	}
%>
