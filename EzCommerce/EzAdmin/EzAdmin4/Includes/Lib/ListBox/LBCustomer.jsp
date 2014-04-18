<% 
//*************CUSTOMER********************************************
int custRows = retcust.getRowCount();
String custvalue = null;
	if ( custRows > 0 ) {
        out.println("<select name=\"SoldTo\" onChange= \"soldtochange()\">"); 
		for ( int i = 0 ; i < custRows ; i++ ){		
		String val = ((String)retcust.getFieldValue(i,ERP_CUST_NO)).toUpperCase();		

		if(Sold_To.equals(val.trim())){
	        out.println("<option selected value=\""+(retcust.getFieldValue(i,ERP_CUST_NO))+"\">"); 
			custvalue = (String)retcust.getFieldValue(i,ERP_CUST_NAME);
			if (custvalue != null){
				out.println(custvalue + "(" + val + ")");
			}
	        out.println("</option>"); 
		}else{
	        out.println("<option value=\""+(retcust.getFieldValue(i,ERP_CUST_NO))+"\">"); 
			custvalue = (String)retcust.getFieldValue(i,ERP_CUST_NAME);
			if (custvalue != null){
				out.println(custvalue + "(" + val + ")");
			}
	        out.println("</option>"); 
		}
		}//End for
        out.println("</select>"); 
	}
%>