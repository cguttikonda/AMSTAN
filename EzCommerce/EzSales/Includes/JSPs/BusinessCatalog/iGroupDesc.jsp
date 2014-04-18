<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%
 // Key Variables
 ReturnObjFromRetrieve retprodfav = null;

 //Get Product Favorites Group
 //Commented by Venkat on 1/29/2001
 //retprodfav = SBObject.getProdFavDesc(servlet);

    EzcPersonalizationParams ezget = new EzcPersonalizationParams();
    EziPersonalizationParams izget = new EziPersonalizationParams();
    izget.setLanguage("EN");
    ezget.setObject(izget);
    Session.prepareParams(ezget);
    retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
    int retprodfavCount=retprodfav.getRowCount();

%>
