<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "java.sql.*" %>
<%
    String value="";
    String data="";
    Vector v1=new Vector();
    ResultSet rs=null;
    String temps="";
    String mess="";
    try
    {
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@user1:1521:ezcom1","ezcom","ezcom");
        Statement st=con.createStatement();
        String[] values=request.getParameterValues("syskey");
        value="'"+values[0]+"'";
        for(int m=1;m<values.length;m++)
	{
             value=value+",'"+values[m]+"'";          
	}
         String temp=request.getParameter("type");
        if(temp.equals("user"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='SUC-USERCREATED'");
	}
        else if(temp.equals("pay"))
        {

          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-PAYTO'");
        }
        else if(temp.equals("fun"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-FUNCTIONS'");
        }
        else if(temp.equals("bpsysauth"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-BPSYSAUTH'");
        }
        else if(temp.equals("bpsysinauth"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-BPSYSINAUTH'");
        }
        else if(temp.equals("usersysauth"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-USERSYSAUTH'");
        }
        else if(temp.equals("usersysinauth"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-USERSYSINAUTH'");
        }
        else if(temp.equals("vendor"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-VNDORS'");
        }
         else if(temp.equals("cust"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-CUST'");
        }
        else if(temp.equals("nocust"))
        {
          rs=st.executeQuery("select * from ezc_massuser_synch where ems_syskey in ("+value+") and ems_key='EXP-NOCUST'");
        }
          while(rs.next())
	  {
            v1.addElement(rs.getString("ems_id")+","+rs.getString("ems_value"));
	  }
        data="nodata";
	temps="false";
    }
    catch(Exception e)
    {
	System.out.println("the exception is :"+e.getMessage());
	 temps="true";
	 
    }
%>