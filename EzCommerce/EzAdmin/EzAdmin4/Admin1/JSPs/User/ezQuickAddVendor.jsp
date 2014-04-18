<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/EzWorkFlowBean.jsp"%>
<jsp:useBean id="BussPartnerManager" class="ezc.client.CEzBussPartnerManager" scope="session"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<html>
<head>
	<Title>Quick Add Vendor</Title>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<%
	String syskey[] = request.getParameterValues("syskey");
	String payTo = request.getParameter("payTo");
	String userName = request.getParameter("userName");
	String userId = request.getParameter("userId");
	String email = request.getParameter("email");

	
	String ConnGroup = (String)session.getValue("ConnGroup");
	Connection con=null;

	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
	con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

	ezc.ezparam.EzcParams addMainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWorkGroupUsersTable addTable= new ezc.ezworkflow.params.EziWorkGroupUsersTable();
	ezc.ezworkflow.params.EziWorkGroupUsersTableRow addParams = null;

	Hashtable bpSysAuth=new Hashtable();
	Hashtable bpIndAuth=new Hashtable();
	Hashtable userSysAuth=new Hashtable();
	Hashtable userIndAuth=new Hashtable();

	bpSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent Role");
	bpIndAuth.put("VENDOR_SYS_IND","Vemdpr System Independant Role");

	userSysAuth.put("VENDOR_SYS_DEP","Vendor System Dependent Role");
	userIndAuth.put("VENDOR_SYS_IND","Vemdpr System Independant Role");

	ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch("999","0");
	mySynch.setSession(Session);
	mySynch.setConnection(con);

	mySynch.ERPSOLDTO=payTo;
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
			if(! mySynch.getVendorsFromErp())
			{
				ezc.ezparam.EzcParams myEzcParams = new ezc.ezparam.EzcParams(false);
				ezc.ezparam.EzcBussPartnerNKParams bussPartnerNKParams = new ezc.ezparam.EzcBussPartnerNKParams();
				bussPartnerNKParams.setPartnerNumber("'"+bpnumber+"'");
				myEzcParams.setObject(bussPartnerNKParams);
				Session.prepareParams(myEzcParams);
				ezc.ezcommon.EzLog4j.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Before11111 Delete Buss Partner","I");
				BussPartnerManager.deleteBussPartners(myEzcParams);
				ezc.ezcommon.EzLog4j.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> After22222 Delete Buss Partner","I");
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
			try{
			     Long.parseLong(mySynch.ERPSOLDTO);
			     mySynch.ERPSOLDTO="00000000000000".substring(0,10-mySynch.ERPSOLDTO.length())+mySynch.ERPSOLDTO;
			}
			catch(Exception er){
			
			}
			
			if(! mySynch.ezAddPayTo(bpnumber))
			{
			ezc.ezcommon.EzLog4j.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ezAddPayTo After Delete Buss Partner","I");
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
			ezc.ezcommon.EzLog4j.log(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>getBPCustomers After Delete Buss Partner","I");
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
			
			
			
			addParams= new ezc.ezworkflow.params.EziWorkGroupUsersTableRow();
			addParams.setEffectiveFrom("01/01/2000");	
			addParams.setEffectiveTo("01/01/2999");	
			addParams.setGroupId("VENDOR");
			addParams.setUserId(userId.toUpperCase());
			addParams.setSyskey(syskey[i]);
			addParams.setSoldTo(payTo);
			addTable.appendRow(addParams);
			
		}
		if(!error)
		{
			mySynch.UserId = userId.toUpperCase();
			mySynch.email  = email;
			mySynch.setPassword();
			mySynch.addUser(bpnumber);
			mySynch.addUserSysAuth(userSysAuth);
			mySynch.addUserSysInAuth(userIndAuth);
			
			addMainParams.setObject(addTable);
			Session.prepareParams(addMainParams);
			//EzWorkFlowManager.addWorkGroupUsers(addMainParams);
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