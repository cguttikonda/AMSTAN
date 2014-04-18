<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%
	// Key Variables
	ReturnObjFromRetrieve retprodfav = null;

	//Get Product Favorites Group
	//Commented by Venkat on 1/29/2001
	//retprodfav = SBObject.getProdFavDesc(servlet);

	//Venkat Added the following code on 1/29/2001
	    EzCatalogParams ezcparams = new EzCatalogParams();
	    ezcparams.setLanguage("EN");
	    Session.prepareParams(ezcparams);
	    retprodfav = (ReturnObjFromRetrieve) EzCatalogManager.getProdFavDesc(ezcparams);
	    int retprodfavCount =retprodfav.getRowCount();
	//Code changes end here
%>
