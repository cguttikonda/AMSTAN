<% 
int bpRows = retbp.getRowCount();
String companyName = null;
	if ( bpRows > 0 ) {
        out.println("<div id = listBoxDiv3><select name=\"BusPartner\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < bpRows ; i++ ){		
		String val = (retbp.getFieldValue(i,BP_NUMBER)).toString();	
		if(Bus_Partner.equals(val.trim())){
	        out.println("<option selected value="+retbp.getFieldValue(i,BP_NUMBER)+">"); 
			companyName = (String)retbp.getFieldValue(i,BP_COMPANY_NAME);
			if (companyName != null){
				out.println(companyName);
			}
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+retbp.getFieldValue(i,BP_NUMBER)+">"); 
			companyName = (String)retbp.getFieldValue(i,BP_COMPANY_NAME);
			if (companyName != null){
				out.println(companyName);
			}
	        out.println("</option>"); 
		}
		}//End for
        out.println("</select></div>"); 
	}
%>