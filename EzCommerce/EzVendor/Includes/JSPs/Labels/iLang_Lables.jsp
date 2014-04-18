
<jsp:useBean id="langLabels_Sales" class="ezc.multilang.EzMultiLangSupport_Sales" scope="application"/>

<%!

         java.util.ResourceBundle langBundle = null;
         public String getLabel(String LKey) {
              if(LKey != null && langBundle != null) 
                    return langBundle.getString(LKey);
               else
                    return "" ;
            }
 %>

<%
       String sales_userLang = (String)session.getValue("userLang");
       if(sales_userLang == null)
           sales_userLang = "ENGLISH" ; 

       langBundle = (java.util.ResourceBundle)langLabels_Sales.getUserLangLabels(sales_userLang);
      
%>
       
