<%
int langRows = retlang.getRowCount();
	if ( langRows > 0 ) {
        out.println("<select name=\"Lang\" id=ListBoxDiv>"); 
		for ( int i = 0 ; i < langRows ; i++ ){		
		String val = ((String)retlang.getFieldValue(i,LANG_ISO));
		if(val.equals("EN")){
	        out.println("<option selected value="+(retlang.getFieldValue(i,LANG_ISO))+">"); 
	        out.println(retlang.getFieldValue(i,LANG_DESC)); 
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+(retlang.getFieldValue(i,LANG_ISO))+">"); 
	        out.println(retlang.getFieldValue(i,LANG_DESC)); 
	        out.println("</option>"); 
		}// End if
		}//End for
        out.println("</select>"); 
	}
%> 