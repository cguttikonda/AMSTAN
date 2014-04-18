 <% 
int bpRows = ret.getRowCount();
String companyName = null;
	if ( bpRows > 0 ) {
        out.println("<select name=\"BusPartner\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < bpRows ; i++ ){		
		String val = (ret.getFieldValue(i,BP_NUMBER)).toString();
		companyName = (String)ret.getFieldValue(i,BP_COMPANY_NAME);
		if(Bus_Partner.equals(val.trim())){
	        out.println("<option selected value="+ret.getFieldValue(i,BP_NUMBER)+">"); 
			if (companyName != null){
				out.println(companyName);
			}
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+ret.getFieldValue(i,BP_NUMBER)+">"); 
			if (companyName != null){
				out.println(companyName);
			}
	        out.println("</option>"); 
		}
		}//End for
        out.println("</select>"); 
	}
%>