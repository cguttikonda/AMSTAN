<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.*" %>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<%
	
	EzcUtilManager eum 		= new EzcUtilManager(Session);
	ReturnObjFromRetrieve retC 	= (ReturnObjFromRetrieve) eum.getUserCatalogAreas();
	String user_catarea 		= (String) eum.getCurrSysKey();

	int rId = 0;
	String syncFlag = "";
	if ( retC.find("ESKD_SYS_KEY",user_catarea) )
	{
		rId = retC.getRowId("ESKD_SYS_KEY",user_catarea);
		syncFlag = retC.getFieldValueString(rId,"ESKD_SYNC_FLAG");	
	}

	/** Changes end here **/

	// Key Variables
	ReturnObjFromRetrieve ret = null;


	// Read Custom Catalog
	//Commented by Venkat on 1/26/2001
	//ret = SBObject.getCustomCatalog (servlet);

	/**Venkat added if and else block for hiding favorites for non-sync areas **/
	if ( syncFlag.equals("Y") )
	{
		EzCatalogParams ezcpparams = new EzCatalogParams();
		ezcpparams.setLanguage("EN");
		Session.prepareParams(ezcpparams);
		ezc.ezutil.EzSystem.out.println(">>>Before calling getCustomCatalog<<<");
		ret = (ReturnObjFromRetrieve) EzCatalogManager.getCustomCatalog(ezcpparams);
		ezc.ezutil.EzSystem.out.println(">>>Before calling getCustomCatalog****<<<");
	}
	else
	{
		ret = new ReturnObjFromRetrieve();
	}
	
	
	ReturnObjFromRetrieve retprodfav = null;
	EzcPersonalizationParams ezget = new EzcPersonalizationParams();
	EziPersonalizationParams izget = new EziPersonalizationParams();
	izget.setLanguage("EN");
	ezget.setObject(izget);
	Session.prepareParams(ezget);
	retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
	//out.println(""+retprodfav.toEzcString());
	int retprodfavCount=retprodfav.getRowCount();

	String From=request.getParameter("From");
	String pGroupNumber = request.getParameter("grpNum");
	if(pGroupNumber!=null)
		pGroupNumber = pGroupNumber.trim();
	
	int cnt = ret.getRowCount(); 
	if("Cart".equals(From) && Cart!=null && Cart.getRowCount()>0)
		pGroupNumber = request.getParameter("ProductGroup");
		
	
	
	ReturnObjFromRetrieve retSO = null;
	int retCount = 0;
	//out.println("pGroupNumberpGroupNumberpGroupNumber	"+pGroupNumber);
	if( pGroupNumber!=null && pGroupNumber!="")
	{
			EzCatalogParams ezread = new EzCatalogParams();
			ezread.setLanguage("EN");
			ezread.setProductGroup(pGroupNumber);
			Session.prepareParams(ezread);
			retSO = (ReturnObjFromRetrieve) EzCatalogManager.readCatalogDetails(ezread);
			retCount = retSO.getRowCount();
	}
	
%>