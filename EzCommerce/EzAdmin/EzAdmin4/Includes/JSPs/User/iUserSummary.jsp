<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%

    Vector v=new Vector();
    String temp="";
    
    try
    {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@user1:1521:ezcom1","ezcom","ezcom");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select ems_syskey,ems_key,count(*) mycount from ezc_massuser_synch group by ems_syskey,ems_key order by ems_syskey,ems_key");
        while(rs.next())
        {
            String sys=rs.getString("ems_syskey");
            String key=rs.getString("ems_key");
            String count= String.valueOf(rs.getInt("mycount"));
            v.addElement(sys+","+key+","+count);
        }
	temp="false";
    }
    catch(Exception e)
    {
	 temp="true";
    }
%>