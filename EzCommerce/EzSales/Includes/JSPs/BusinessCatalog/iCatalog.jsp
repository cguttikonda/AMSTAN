<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.client.*" %>
<%@ page import = "ezc.session.*" %>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>


<%

	/** Added by Venkat on 6/5/2001 - For hiding catalogs in favorites for non-sync areas **/

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

	//Code changes end here

%>
