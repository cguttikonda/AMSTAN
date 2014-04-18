<%@ page import = "ezc.ezcommon.*" %>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>
<jsp:useBean id="catalogObj" class="ezc.client.EzCatalogManager" scope="page"></jsp:useBean>
<%@ page import = "ezc.sales.client.*" %>
<%
	String sys_key = request.getParameter("SysKey");
	String TestRun = request.getParameter("TestRun");
	String pFinalFlag=null,pFinalImageFlag=null;

	//Get System Type from Catalog Area
	// not needed....
	int selCount = 0;
	String[] pCheckBox = request.getParameterValues("CheckBox");
	String[] pProductGroup = request.getParameterValues("ProductGroup");
	String[] pGroupLevel = request.getParameterValues("GroupLevel");
	String[] pShowAll = request.getParameterValues("ShowAll");
	String[] pImageFlag = request.getParameterValues("ImageFlag");
	String dummyGroup ="Y";
	String pgStr="'";
	for ( int i = 0 ; i < pProductGroup.length; i++ )
	{
		pgStr += pProductGroup[i].trim()+"','" ;
	}

	EzSalesOrderManager ezManager=new EzSalesOrderManager();
	EzcParams ezcParams=new EzcParams(false);
	EzCatalogParams catParams = new EzCatalogParams();
	catParams.setSysKey("'"+sys_key+"'");
	catParams.setProductGroup(pgStr.substring(0,pgStr.length()-2));
	ezcParams.setObject(catParams);
	Session.prepareParams(ezcParams);
	Object o = ezManager.ezDeleteMatSynch(ezcParams);

	boolean dummyFlag = false;
	if ( dummyGroup != null && dummyGroup.trim().equals("Y") ) dummyFlag = true;

	//Structure for Sync
	EzHierStructure[] in = new EzHierStructure[pCheckBox.length];
	// Get the Product Groups Selection from the 'ezGetSAPCatalog.jsp'
	selCount = 0;
		
	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j(); 

	String checkBoxStr = "",checkToken="",levelToken="";
	java.util.StringTokenizer st = null;
	
	for ( int i = 0 ; i < pCheckBox.length; i++ )
	{
		try
		{
			if (pShowAll[i]!=null)
				pFinalFlag = "Y";
		} catch(Exception e)
		{
			pFinalFlag = "N";
		}		
		try
		{
			if (pImageFlag[i]!=null)
				pFinalImageFlag = "Y";
		}catch(Exception e)
		{
		    pFinalImageFlag = "N";
		}
		
		checkBoxStr = pCheckBox[i];
		
		try
		{
			st = new java.util.StringTokenizer(checkBoxStr,"##");
		
			if(st!=null){
				checkToken = st.nextToken();
				levelToken = st.nextToken();
			}
		}
		catch(Exception e)
		{
			log4j.log("Exception occured while tokenizing string::"+e,"W");
		}
		
		in[i] = new EzHierStructure();
		in[i].setProductGroup(checkToken.substring(1,checkToken.length()-1));
		in[i].setGlobalViewFlag(pFinalFlag);
		in[i].setGifFlag(pFinalImageFlag);
		in[i].setLevel(levelToken);
		selCount++;

	}// End For

	// Sync Selcted Product Groups
	EzCatalogParams catalogParams = new EzCatalogParams();
	catalogParams.setSysKey(sys_key);
	Session.prepareParams(catalogParams);
	catalogParams.setSysKey(sys_key);
	catalogParams.setLanguage("EN");
	EzcHeirStructureParams hierParams = new EzcHeirStructureParams();
	hierParams.setHeirStructure(in);
	catalogParams.setObject(hierParams);

	//String syncInd = "M";
	//catalogParams.setObject( syncInd );
	//catalogParams.setConnectionType("IBM");
	catalogParams.setIndicator("G");
	
	catalogObj.synchronize(catalogParams);
	response.sendRedirect("../Catalog/ezPostSync.jsp?sysnum=" + sys_key);
%>

