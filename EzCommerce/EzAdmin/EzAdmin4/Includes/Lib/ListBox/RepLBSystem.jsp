<% 
int sysRows = retsys.getRowCount();

String sysName = null;

	if ( sysRows > 0 ) {
        out.println("<select name=\"SysNum\" onChange=\"myalert()\">"); 
		for ( int i = 0 ; i < sysRows ; i++ ){	
if(((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("100") || ((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("110") || ((retsys.getFieldValue(i,"ESD_SYS_TYPE").toString())).equals("111"))
		{	

		String val = (retsys.getFieldValue(i,SYSTEM_NO)).toString();		
		sysName = (String)retsys.getFieldValue(i,SYSTEM_NO_DESCRIPTION);		
		if(sys_num.equals(val.trim())){
	        out.println("<option selected value="+val+">"); 
			out.println(val + " (" + sysName + ")");
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+val+">"); 
			out.println(val + " (" + sysName + ")");
	        out.println("</option>"); 
		}//End If
		
      
	}
  
}
out.println("</select>"); 
}

%> 