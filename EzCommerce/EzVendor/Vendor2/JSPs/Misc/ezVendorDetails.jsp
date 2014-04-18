<%@page import="java.sql.*" %>
<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%
		int id=Integer.parseInt(request.getParameter("id"));
		String statusStr = "";
		
		Connection con = null;
		java.sql.Statement stmt = null;
		java.sql.PreparedStatement prepareStmt = null;
		ResultSet rs = null;
		int PRItemCnt  = 0;
		try
		{
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			con 	= DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=ezlife;SelectMethod=cursor", "ezlife1", "ezlife1");
			stmt 	= con.createStatement();
			ezc.ezcommon.EzLog4j.log(":::ResultSet:ezListOfVendors::","I");
			
			rs = stmt.executeQuery("SELECT EVRD_ID,EVRD_CREATED_ON,EVRD_STATUS FROM EZC_VENDOR_REG_DETAILS");
			ezc.ezcommon.EzLog4j.log(":::ResultSet after:ezListOfVendors::"+rs.getRow(),"I");
			out.println("row count="+rs.getRow());
			out.println("id="+rs.getInt("EVRD_ID"));
			while(rs.next())
			{
				
			}	
		}
		catch(Exception e)
		{
		ezc.ezcommon.EzLog4j.log(":::ERROR"+e,"I");
		}
%>
<html>
<head>
<link rel="stylesheet" href="legendcss.css" type="text/css"/>   
<style>
td
{
font-size:13pt;
}
</style>

</head>
<%
//out.println("id=="+request.getParameter("id"));
out.println("SELECT * FROM EZC_VENDOR_REG_DETAILS WHERE EVRD_ID="+id);
TreeMap tm = new TreeMap();
	// Put elements to the map
	
	tm.put("AP", "Andhra Pradesh");
	tm.put("ARP", "Arunachal Pradesh");
	tm.put("AS", "Assam");
	tm.put("BH", "Bihar");
	tm.put("CH", "Chhattisgarh");
	tm.put("GOA", "Goa");
	tm.put("GJ", "Gujarat");
	tm.put("HY", "Haryana	");
	tm.put("HP", "Himachal Pradesh");
	tm.put("JK", "Jammu and Kashmir");
	tm.put("JH", "Jharkhand");
	tm.put("KA", "Karnataka");
	tm.put("KL", "Kerala");
	tm.put("MP", "Madhya Pradesh");
	tm.put("MH", "Maharashtra");
	tm.put("MN", "Manipur	");
	tm.put("MG", "Meghalaya");
	tm.put("MZ", "Mizoram	");
	tm.put("NG", "Nagaland");
	tm.put("OR", "Orissa");
	tm.put("PN", "Punjab");
	tm.put("RJ", "Rajasthan");
	tm.put("SK", "Sikkim");
	tm.put("TN", "Tamil Nadu");
	tm.put("TI", "Tripura");
	tm.put("UP", "Uttar Pradesh");
	tm.put("UT", "Uttarakhand");
	tm.put("WB", "West Bengal");
	// Get a set of the entries
	Set set = tm.entrySet();
	// Get an iterator
	Iterator it = set.iterator();
%>
<body>

<form name="myForm">

 <h1 align="center"><i>Vendor Registration</i></h1>
  <div id="tabs-1">
  <fieldset>
  <legend>Address:</legend>
  <table align="center">
   <Tr>
      	<Td>Title:</Td>
      	<Td><select name="title">
      	<option value="" selected>--select--</option>
     	<option value="MR">MR</option>
     	<option value="MS">MS</option>
     	<option value="MRS">MRS</option>
   
     	</select></Td>
  
   	<Td>Name:</Td>
   	<Td><input type="text" name="name"></Td>
   </Tr>
   <Tr>
      	<Td>Street/House No:</Td>
      	<Td><input type="text" name="shno"></Td>
  
      	<Td>Postal Code:</Td>
      	<Td><input type="text" name="pcode"></Td>
   </Tr>
   <Tr>
        	<Td>Country</Td>
        	<Td><select name="country"><option value="India" selected >India</option></select</Td>
  
        	<Td>Region:</Td>
        	<Td><select name="region">
        	<option value="">--select Region--</option>
        	
  <%
  while(it.hasNext()) 
  {
  	Map.Entry me = (Map.Entry)it.next();
  %>	
  	
  	<option value='<%=me.getKey()%>'><%=me.getValue()%></option>
  <%
  
  }
  
  %>
        	</Td>
   </Tr>
   
   
   <Tr>
      	<Td>Telephone No:</Td>
      	<Td><input type="text" name="teleno"></Td>
   <Td>Mobile No:</Td>
         <Td><input type="text" name="mobno"></Td>
   </Tr>
   <Tr>
      	<Td>Fax</Td>
      	<Td><input type="text" name="fax"></Td>
  
         <Td>E-mail</Td>
         <Td><input type="text" name="email"></Td>
   </Tr>
   
</fieldset>	    
  </table>
   
  </div>
  <br>
  <div id="tabs-2">
   <fieldset>
  <legend>Excise Details:</legend>
  <table align="center">
      <Tr>
         	<Td>Excise No:</Td>
         	<Td><input type="text" name="exciseno"></Td>
         
            	<Td>Excise Reg No:</Td>
            	<Td><input type="text" name="exciseregno"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Range:</Td>
            	<Td><input type="text" name="exciserange"></Td>
         	<Td>Excise Division :</Td>
            	<Td><input type="text" name="excisediv"></Td>
         </Tr>
         <Tr>
            	<Td>PAN No:</Td>
            	<Td><input type="text" name="PANno"></Td>
         </Tr>
   </table>
       
   </feildset>
  </div>
  <br>
  <div id="tabs-3">
     <fieldset>
  <legend>Control  Details:</legend>
  	<table align="center">
       <Tr>
               	<Td>VAT Reg No:</Td>
               	<Td><input type="text" name="VATRno"></Td>
         </Tr>
       </table>
   </feildset>
  </div>
  <br>
  <div id="tabs-4">
    <fieldset>
  <legend>Bank Details:</legend>
  <table align="center">
    <Tr>
               	<Td>Country</Td>
               	<Td><input type="text" name="bcountry"></Td>
            
               	<Td>Bank Key</Td>
               	<Td><input type="text" name="bankkey"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Account</Td>
               	<Td><input type="text" name="baccount"></Td>
            
               	<Td>A/C holder</Td>
               	<Td><input type="text" name="acholder"></Td>
         </Tr>
   </table>
   </feildset align="center">
  </div>
  <br>
  <div id="tabs-5">
       <fieldset>
  <legend>Personal Details:</legend>
  <table align="center">
         <Tr>
	               	<Td>First Name:</Td>
	               	<Td><input type="text" name="firstname"></Td>
	           
	               	<Td>Last Name:</Td>
	               	<Td><input type="text" name="lastname"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Telephone No:</Td>
	               	<Td><input type="text" name="tele"></Td>
         </Tr>  
  </table>       
   </feildset>
  </div>
</div>
<br>
 <div>
 <br>

 </div>
 </center>
 </form>
</body>
</html>