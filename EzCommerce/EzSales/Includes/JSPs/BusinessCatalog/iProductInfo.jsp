<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%
	// Key Variables
	ReturnObjFromRetrieve ret = null;
	ReturnObjFromRetrieve retprodfav = null;

	// Received Product Number as Parameter
	String pProductNumber = request.getParameter("ProductNumber");

	
	EzCatalogParams ezcmat = new EzCatalogParams();
        ezcmat.setLanguage("EN");
        ezcmat.setMaterial(pProductNumber);
        Session.prepareParams(ezcmat);
        ret = (ReturnObjFromRetrieve) EzCatalogManager.readMaterialInfo(ezcmat);
	//Get Product Favorites Group
        EzcPersonalizationParams ezpmat = new EzcPersonalizationParams();
        EziPersonalizationParams izpmat = new EziPersonalizationParams();
        izpmat.setLanguage("EN");
        ezpmat.setObject(izpmat);
        Session.prepareParams(ezpmat);
        retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezpmat);
%>
