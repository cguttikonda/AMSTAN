<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.sql.*" %>
<%
    String value="";
    Vector v2=new Vector();
    try
    {


        String[] values=request.getParameterValues("syskey");
          value="'"+values[0]+"'";
        for(int m=1;m<values.length;m++)
	{
             value=value+",'"+values[m]+"'";          
	}
       // value=value.substring(0,value.length()-1);
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@user1:1521:ezcom1","ezcom","ezcom");
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery("select * from ezc_massuser_synch where ems_key='exp_payto' and ems_syskey in("+value+")");
      
        while(rs.next())
	{
            v2.addElement(rs.getString("ems_id")+","+rs.getString("ems_key")+","+rs.getString("ems_value"));
	}
    }
    catch(Exception e)
    {
	System.out.println("the exception is :"+e.getMessage());
    }
%>