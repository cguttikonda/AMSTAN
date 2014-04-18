

<%!
	java.util.ResourceBundle langBundle = null;
	String lang_rbVal="";
	public String getLabel(String LKey){
		lang_rbVal="";
		if(LKey != null && langBundle != null){
			try{
				lang_rbVal = langBundle.getString(LKey);
			}catch(Exception e){ }
		}      
		
		return 	lang_rbVal;
	}
%>
<%
      String bundle = "";
      String vendor_lang =(String)session.getValue("userLang");
      
      if(vendor_lang == null || "null".equals(vendor_lang))
          vendor_lang = "ENGLISH" ;
      else
      	  vendor_lang = (vendor_lang.toUpperCase()).trim() ;	
          	   
      bundle = "EzVendorLabels_"+vendor_lang;	   
      try{
      		langBundle = ResourceBundle.getBundle(bundle);
      }catch(Exception e){ }
%>
       
