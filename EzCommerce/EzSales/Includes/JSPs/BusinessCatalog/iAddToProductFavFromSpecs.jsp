<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
// actual parameters
String pProductNumber = null; 
String [] products = null;

String prodfavgroup =  request.getParameter("FavGroups");

products = new String[1];
pProductNumber = request.getParameter("ProdNum");
products[0] = new String(pProductNumber);

//Add product to favourites group
//Commented by Venkat on 1/29/2001
//SBObject.addUserProdFavMat(servlet, products, prodfavgroup);

//Venkat Added the following code on 1/29/2001
    EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
    EziPersonalizationParams iparams = new EziPersonalizationParams();
    iparams.setLanguage("EN");
    iparams.setObject(products);
    iparams.setProductFavGroup(prodfavgroup);
    ezcparams.setObject(iparams);
    Session.prepareParams(ezcparams);
    EzcPersonalizationManager.addUserProdFavMat(ezcparams);
//Code changes end here

%>
