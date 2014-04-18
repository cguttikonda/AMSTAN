<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%
	String ProductGroup = request.getParameter("ProductGroup");

	// Add the Product Group to the Custom Catalog
	//Commented by Venkat on 1/26/2001
	//SBObject.addCustomCatalog ( servlet , ProductGroup );

	//Added the code below 1/26/2001

	    EzCatalogParams ezccparams = new EzCatalogParams();
	    ezccparams.setLanguage("EN");
	    ezccparams.setProductGroup(ProductGroup);
	    Session.prepareParams(ezccparams);
	    EzCatalogManager.addCustomCatalog(ezccparams);

	//Code change ends here

%>
