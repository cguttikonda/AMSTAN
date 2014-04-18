<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>

<%

	String favGrp=request.getParameter("favGrp");
	EzCatalogParams ezcatparams = new EzCatalogParams();
	ezc.ezparam.EzWebCatalogSearchParams ezwebparams = new ezc.ezparam.EzWebCatalogSearchParams();
        EzcPersonalizationParams ezcparams = new EzcPersonalizationParams();
        EziPersonalizationParams iparams = new EziPersonalizationParams();
        iparams.setLanguage("EN");
        iparams.setProductGroup(favGrp);
        ezcparams.setObject(iparams);
        Session.prepareParams(ezcparams);
        EzcPersonalizationManager.removeFromProdFav(ezcparams);
              
%>

