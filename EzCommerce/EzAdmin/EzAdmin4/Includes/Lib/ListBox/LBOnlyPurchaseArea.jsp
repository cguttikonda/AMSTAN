<% 
sys_key = sys_key.toUpperCase();
int sysRows = retsyskey.getRowCount();
	if ( sysRows > 0 ) {

        out.println("<select name=\"SystemKey\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < sysRows ; i++ ){		
		String val = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY));
		String checkFlag = (String)retsyskey.getFieldValue(i,"ESKD_SUPP_CUST_FLAG");
		String syskeyDesc = (String)(retsyskey.getFieldValue(i,SYSTEM_KEY_DESCRIPTION));
		if(checkFlag.equals("V")){
			val = val.toUpperCase();
			val = val.trim();
			if(sys_key.equals(val)){
		        out.println("<option selected value="+val+">"); 
		        out.println(val + " (" + syskeyDesc + ")"); 
	      	  out.println("</option>"); 
			}else{
		        out.println("<option value="+val+">"); 
	      	  out.println(val + " (" + syskeyDesc + ")"); 
		        out.println("</option>"); 
			}
		}//end if checkFlag
		}
        out.println("</select>"); 
	}
%>