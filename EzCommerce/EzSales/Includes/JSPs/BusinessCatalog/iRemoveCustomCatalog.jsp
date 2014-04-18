<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%

 String ProductGroup = request.getParameter("ProductGroup");

 /** Commented by Venkat on 1/26/2001 
  if(sysType.equals("150")){
	int j=18-ProductGroup.length();
	for ( int i = 0 ; i < j; i++ ){
		ProductGroup = ProductGroup + " ";
		
	}
 }
 **/

// Remove Product Group from Custom Catalog
// Commented by Venkat on 1/26/2001
// SBObject.removeFromCustomCatalog(servlet, ProductGroup );

//Added the code below 1/26/2001

    EzCatalogParams ezcrparams = new EzCatalogParams();
    ezcrparams.setLanguage("EN");
    ezcrparams.setProductGroup(ProductGroup);
    Session.prepareParams(ezcrparams);
    EzCatalogManager.removeFromCustomCatalog(ezcrparams); 
    
    //Code change ends here
%>
