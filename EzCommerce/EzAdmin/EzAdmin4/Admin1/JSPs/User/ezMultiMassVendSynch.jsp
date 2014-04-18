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
	
	String [] chk1=request.getParameterValues("chk1");
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection 	con=DriverManager.getConnection("jdbc:oracle:thin:@user1:1521:ezcom1","ezcom","ezcom");
	out.println("Got Connection " + con);
	

	ezc.ezbasicutil.EzMassVendSynch mySynch= new ezc.ezbasicutil.EzMassVendSynch();
	mySynch.setSession(Session);
	mySynch.setConnection(con);
	boolean error=false;

	
	for(int i=0;i<chk1.length;i++)
	{
		out.println(chk1[i]);
		boolean VENDOR_LIST_READY=false;
		mySynch.SYSKEY=chk1[i];
		mySynch.SYSTEMNO="999";
	
		try
		{
			mySynch.vendors=java.util.ResourceBundle.getBundle(chk1[i]);
			VENDOR_LIST_READY=true;
		}
		catch(Exception e)
		{
			VENDOR_LIST_READY=false;
			error=true;
			out.println("VENDOR LIST is Not Avilable. Pls Check Property File......." +chk1[i]);
		}

		
		if(VENDOR_LIST_READY)
		{
								
			Enumeration enum=mySynch.vendors.getKeys();
			int  k=0;
			while(enum.hasMoreElements())
			{
				out.println(enum.nextElement());
				mySynch.getValues(k);
				k++;
				String bpnumber=mySynch.addBP();
				if(bpnumber!=null && !"null".equals(bpnumber))
				{
					mySynch.addBPSysAuth(bpnumber);
					mySynch.addBPSysInAuth(bpnumber);

					if(! mySynch.getVendorsFromErp())
					{

						error=true;
						continue;
					}
					if(! mySynch.ezAddPayTo(bpnumber))
					{

						error=true;
						continue;
					}	
					if(! mySynch.getBPCustomers(bpnumber))
					{

						error=true;
						continue;

					}

					if(! mySynch.ezAddFunctions(bpnumber))
					{		

						error=true;	
						continue;
					}

					mySynch.addUser(bpnumber);
					mySynch.addUserSysAuth();		
					mySynch.addUserSysInAuth();		
					//mySynch.addUserDefaults();
					//mySynch.addToWorkFlow( mySynch.SYSKEY,"100","1","2",String.valueOf(Long.parseLong(mySynch.ERPSOLDTO)),"");
				}

			}
			

		}
}
try{
	out.println(mySynch.PSMT);
	mySynch.PSMT.close();
	con.close();
}catch(Exception e) { out.println(e.getMessage());}

%>