<%//@ page language="java" errorPage="../Misc/ezErrorDisplay.jsp"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="BussPartnerManager" class="ezc.client.CEzBussPartnerManager" scope="session" />

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<Title>Quick Add Customer</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>

<%
	String syskey[]	=request.getParameterValues("syskey");
	String catnum	=request.getParameter("catnum");
	String soldTo 	=request.getParameter("soldTo");
	String userId 	=request.getParameter("userId");
	String userName =request.getParameter("userName");	
	String plant 	="1000";	
	String email 	=request.getParameter("email");	
	
	
	

	String ConnGroup = (String)session.getValue("ConnGroup");	
	
	try
	{
		userId 	= (Long.parseLong(userId))+"";
	}
	catch(Exception e)
	{
		userId 	= userId;
	}
	
	System.out.println("catnumcatnum::"+catnum);
	System.out.println("soldTosoldTo::"+soldTo);
	System.out.println("userIduserId::"+userId);
	System.out.println("userNameuserName::"+userName);
	System.out.println("plantplant::"+plant);
	System.out.println("ConnGroupConnGroup::"+ConnGroup);
	
	ConnGroup ="243";
	Hashtable bpSysAuth=new Hashtable();	  
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();
	
	bpSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	bpIndAuth.put("SALES_SYS_IND","Sales System Independent Role");
	//bpIndAuth.put("SALES_CUSTOMER","Sales Customer Role");

	userSysAuth.put("SALES_SYS_DEP","Sales System Dependent Role");
	userIndAuth.put("SALES_SYS_IND","Sales System Independent Role");
	//userIndAuth.put("SALES_CUSTOMER","Sales Customer Role");
	
	Connection con=null;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	Hashtable partnerDefaults= new Hashtable();
	partnerDefaults.put("COMPCODE","1000");
	partnerDefaults.put("PLANT",plant);
	
	Hashtable userDefaults = new Hashtable();
	userDefaults.put("USERROLE","CU");
	
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
   	
   	System.out.println("bpnumberbpnumber::"+bpnumber);
   	
   	
	if(bpnumber!=null && !"null".equals(bpnumber))
	{
		mySynch.addBPSysAuth(bpnumber,bpSysAuth);
		mySynch.addBPSysInAuth(bpnumber,bpIndAuth);

		for(int i=0;i<syskey.length;i++)
		{
			mySynch.SYSKEY=syskey[i];
			if(! mySynch.getCustomersFromErp())
			{
				ezc.ezparam.EzcParams myEzcParams = new ezc.ezparam.EzcParams(false);
				ezc.ezparam.EzcBussPartnerNKParams bussPartnerNKParams = new ezc.ezparam.EzcBussPartnerNKParams();
				bussPartnerNKParams.setPartnerNumber("'"+bpnumber+"'");
				myEzcParams.setObject(bussPartnerNKParams);
				Session.prepareParams(myEzcParams);
				BussPartnerManager.deleteBussPartners(myEzcParams);



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
			
			System.out.println("After getting customers from ERP::");
			
			try
			{
				Long.parseLong(mySynch.ERPSOLDTO);
				mySynch.ERPSOLDTO="00000000000000".substring(0,10-mySynch.ERPSOLDTO.length())+mySynch.ERPSOLDTO;				
			}
			catch(Exception e)
			{}
			
			
			if(! mySynch.ezAddPayTo(bpnumber))
			{
%>
				<br><br><br>
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
			
			System.out.println("After adding ezAddPayTO::");
			
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
			
			System.out.println("After adding getBPCustomers::");
			
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
			
			System.out.println("After adding ezAddFunctions::");
			
			mySynch.addBpSysCustDefaults(bpnumber,partnerDefaults);
			
			System.out.println("After adding addBpSysCustDefaults::");
	    	}
	    	if(!error)
	    	{
			mySynch.UserId = userId.toUpperCase();
			mySynch.email = email;
			mySynch.setPassword();	    
			mySynch.addUser(bpnumber);
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			mySynch.addUserDefaults(userDefaults);
	    	}
	    	
	    	System.out.println("Finalllyyyyyyy::");
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
