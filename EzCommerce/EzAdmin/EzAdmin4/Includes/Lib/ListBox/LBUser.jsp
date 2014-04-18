<% 
int userRows = retuser.getRowCount();
String userName = null;
	if ( userRows > 0 ) {
        out.println("<select name=\"BusUser\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < userRows ; i++ ){		
		String val = (retuser.getFieldValue(i,USER_ID)).toString();		

		if((bus_user.trim()).equals(val.trim())){
	        out.println("<option selected value="+retuser.getFieldValue(i,USER_ID)+">"); 

			userName = (String)retuser.getFieldValue(i,USER_ID);
			if (userName != null){
				out.println(userName);
			}else{
				out.println(" ");
			}
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+retuser.getFieldValue(i,USER_ID)+">"); 
			userName = (String)retuser.getFieldValue(i,USER_ID);
			if (userName != null){
				out.println(userName);
			}else{
				out.println(" ");
			}
	        out.println("</option>"); 
		}
		}//End for
        out.println("</select>"); 
	}
%> 
