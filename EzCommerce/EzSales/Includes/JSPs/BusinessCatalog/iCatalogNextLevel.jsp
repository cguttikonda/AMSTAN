<%@ page import = "java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>

<%
// Key Variables
	ReturnObjFromRetrieve ret 	= null;
	String CatalogDescription	= request.getParameter("CatalogDescription");
	String groupDesc		= request.getParameter("GroupDesc");

	if(CatalogDescription==null || CatalogDescription=="") CatalogDescription="My Catalog";


	String pGroupNumber 	= request.getParameter("ProductGroup");
	String pLevel 		= request.getParameter("GroupLevel");
	int retCount		= 0;
	Integer test 		= new Integer(pLevel);
	int iLevel 		= test.intValue() + 1;

	char pcLevel 		= ' ';
	pcLevel 		= pLevel.charAt(0); 
	pcLevel 		= (char) (pcLevel + 1); // Next Level

	EzCatalogParams ezcnparams = new EzCatalogParams();
	ezcnparams.setLanguage("EN");
	ezcnparams.setHeirarchyLevel(iLevel);
	ezcnparams.setProductGroup(pGroupNumber);
	Session.prepareParams(ezcnparams);
	ret = (ReturnObjFromRetrieve) EzCatalogManager.readCatalog(ezcnparams);
	
	if(ret!=null) retCount = ret.getRowCount();
	
//Code change ends here
%>
