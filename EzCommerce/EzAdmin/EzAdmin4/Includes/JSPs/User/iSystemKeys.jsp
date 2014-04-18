<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.sql.*" %>
<%
    Vector v=new Vector();
    try
    {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@user1:1521:ezcom1","ezcom","ezcom");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select distinct(ems_syskey) from ezc_massuser_synch");
        while(rs.next())
	{
	   v.addElement(rs.getString("ems_syskey"));
	}
    }
    catch(Exception e)
    {
	System.out.println("the exception is :"+e.getMessage());
    }
%>