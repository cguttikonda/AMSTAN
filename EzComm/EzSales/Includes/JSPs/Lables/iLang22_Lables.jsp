<%!
	java.util.ResourceBundle langBundle2 = null;
	public String getLabel2(String LKey) {
		if(LKey != null && langBundle2 != null){
			return langBundle2.getString(LKey);
		}else{
			System.out.println("\n******************************\nERROR:Language Peroperty file not found******************************\n");
			return "" ;
		}
	}
%>
<%
	String sales_userLang2 = (String)session.getValue("userLang");
	String companyName2=(String)session.getValue("compName");
	if(companyName2!=null){
		companyName2 = companyName2.trim().toUpperCase();
	}else{
		companyName2="EZC";
	}
	if(sales_userLang2 == null)
		sales_userLang2 = "ENGLISH" ;
	String propFileName2="EzSalesLang_"+companyName2+"_"+sales_userLang2;
	langBundle2 = java.util.ResourceBundle.getBundle(propFileName2);
%>

