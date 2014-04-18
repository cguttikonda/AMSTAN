<%!
	java.util.ResourceBundle langBundle = null;
	public String getLabel(String LKey) {
		if(LKey != null && langBundle != null){
			return langBundle.getString(LKey);
		}else{
			System.out.println("\n******************************\nERROR:Language Peroperty file not found******************************\n");
			return "Lable-N/A";

		}
	}
%>
<%
	String sales_userLang = (String)session.getValue("userLang");
	String companyNameLable=(String)session.getValue("compName");
	
	if(companyNameLable!=null){
		companyNameLable = companyNameLable.trim().toUpperCase();
	}else{
		companyNameLable="EZC";
	}
	if(sales_userLang == null)
		sales_userLang = "ENGLISH" ;
	String propFileName="EzSalesLang_"+companyNameLable+"_"+sales_userLang;
	langBundle = java.util.ResourceBundle.getBundle(propFileName);
	
%>

