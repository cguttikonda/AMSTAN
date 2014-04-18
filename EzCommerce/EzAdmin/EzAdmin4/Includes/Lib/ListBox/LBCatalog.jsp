<% 
int catRows = retcat.getRowCount();
	if ( catRows > 0 ) {
        out.println("<div id = listBoxDiv3><select name=\"CatalogNumber\" onChange= \"myalert()\">"); 
		for ( int i = 0 ; i < catRows ; i++ ){		
		String catalogDesc = (String)retcat.getFieldValue(i,CATALOG_DESC);
		if(catalog_number.equals((retcat.getFieldValue(i,CATALOG_DESC_NUMBER)).toString())){
	        out.println("<option selected value="+(retcat.getFieldValue(i,CATALOG_DESC_NUMBER))+">"); 
	        out.println(catalogDesc); 
	        out.println("</option>"); 
		}else{
	        out.println("<option value="+(retcat.getFieldValue(i,CATALOG_DESC_NUMBER))+">"); 
	        out.println(catalogDesc); 
	        out.println("</option>"); 
		}
		}
        out.println("</select></div>"); 
	}
%>
