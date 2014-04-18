<%@ page import="java.sql.*" %>
<%
	String areaFlag = request.getParameter("Area");
	String bussArea = "Sales Area";
	if(areaFlag.equals("V"))
		bussArea = "Purchase Area";
	ResultSet rs1=null;
	ResultSet rs2=null;
	java.util.Vector v1=new java.util.Vector();
	java.util.Vector v2=new java.util.Vector();
	java.util.Vector v3=new java.util.Vector();
	Connection con=null;
	
	String ConnGroup = (String)session.getValue("ConnGroup");
	String sysKey=request.getParameter("syskey");
	String massKey=request.getParameter("masskey");
	String allWebSysKeys = "";
	String allMassKeys = "";
	
	try
	{
		Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		java.util.ResourceBundle mySite= java.util.ResourceBundle.getBundle("Site");
		con=DriverManager.getConnection(mySite.getString("ConnectString_"+ConnGroup),mySite.getString("UserId_"+ConnGroup),mySite.getString("Password_"+ConnGroup));

		Statement stmt=con.createStatement();
		Statement stmt1=con.createStatement();
		String sql1="SELECT EMS_SYSKEY SYSKEY,ESKD_SYS_KEY_DESC SYSKEYDESC,EMS_KEY MASSKEY FROM EZC_MASSUSER_SYNCH,EZC_SYSTEM_KEY_DESC WHERE EMS_SYSKEY = ESKD_SYS_KEY AND ESKD_SUPP_CUST_FLAG = '"+areaFlag+"' ORDER BY ESKD_SYS_KEY_DESC";
		rs1=stmt.executeQuery(sql1);

		if(rs1 != null)
		{
			String s="";
			String m="";
			String sDesc = "";

			while(rs1.next())
			{

				m=rs1.getString("MASSKEY");
				s=rs1.getString("SYSKEY");
				sDesc=rs1.getString("SYSKEYDESC");
				if(!v1.contains(s))
					v1.addElement(s);	
				if(!v2.contains(m))
					v2.addElement(m);
				if(!v3.contains(sDesc))
					v3.addElement(sDesc);
			}
			rs1.close();
		}

		if(sysKey.equals("All"))
		{
			int myRetCount=v1.size();
			allWebSysKeys="";
			if(myRetCount==0)
				allWebSysKeys="NONE";	
			else
				allWebSysKeys=(String)v1.elementAt(0);
			for(int k=1;k<myRetCount;k++)
			{
				allWebSysKeys += "','"+(String)v1.elementAt(k);
			}
		}
		else
		{
			allWebSysKeys = sysKey;
		}

		if(massKey.equals("All"))
		{
			int count=v2.size();
			if(count==0)
				allMassKeys="NONE";	
			else
				allMassKeys=(String)v2.elementAt(0);
			for(int k=1;k<count;k++)
			{
				allMassKeys+= "','"+(String)v2.elementAt(k);
			}
		}
		else
		{
			allMassKeys = massKey;
		}
		String sql2= "SELECT * FROM EZC_MASSUSER_SYNCH WHERE EMS_SYSKEY IN('"+allWebSysKeys+"') AND EMS_KEY IN('"+allMassKeys+"')";

		if(sysKey != null && massKey != null)
			rs2=stmt1.executeQuery(sql2);

	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>