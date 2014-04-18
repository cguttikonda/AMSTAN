<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezCatalog.jsp"%>
<%

	ezc.ezcommon.EzLog4j log = new ezc.ezcommon.EzLog4j(); 
	
	log.log("11111111111111111111111111111111111111@@@@@@@","W");
	
	String UserRole 	= (String)session.getValue("UserRole");
	String prodDesc 	= request.getParameter("ProdDesc");
	String prodFrom 	= request.getParameter("ProdFrom");
	String prodTo 		= request.getParameter("ProdTo");
	String prodSpecs 	= request.getParameter("ProdSpec");
	String searchType 	= request.getParameter("SearchType");
	String catalogCode 	= (String)session.getValue("CatalogCode");
	boolean ADDCART		= true;
	String retVal	 	= request.getParameter("retVal");
	String sType	 	= request.getParameter("sType");
	
	
	java.util.StringTokenizer st 	= null; 
	java.util.ArrayList prdList	= new java.util.ArrayList();
	
	if(retVal!=null)	
	{
		st = new StringTokenizer(retVal,"@@@");
		
		if(st!=null)
		{
			while(st.hasMoreElements())
			{
				prdList.add(((String)st.nextElement()).trim());
			}
		}
		
	}

	ReturnObjFromRetrieve retProducts 	= null;
	ReturnObjFromRetrieve retprodfav 	= null;
	
	String[] cols	= {"MATNO","MATDESC","UOM","UPCNO","GROUP_ID"};
	ReturnObjFromRetrieve remainPrds = new ReturnObjFromRetrieve(cols);;


	int prodCount	= 0,remainCount = 0;
	ArrayList mat 	= new ArrayList();
	ArrayList Desc 	= new ArrayList();
	ArrayList Uom 	= new ArrayList();
	
	HashMap prodHash = new HashMap();
	
	log.log("searchTypesearchType@@@@@@@"+searchType,"W");
	
	if(searchType!=null && !"null".equals(searchType) && !"".equals(searchType))
	{

		if(prodDesc!=null)
			prodDesc=prodDesc.replace('*','%');
		
		EzcPersonalizationParams ezget = new EzcPersonalizationParams();
		EziPersonalizationParams izget = new EziPersonalizationParams();
		izget.setLanguage("EN");
		izget.setProductFavGroupDesc(prodDesc);
		ezget.setObject(izget);
		Session.prepareParams(ezget);
		retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
		int groupRows = retprodfav.getRowCount();

		String matCode = request.getParameter("MatNo");

		if(matCode!=null)
			matCode=matCode.replace('*','%');
			
		String skey=(String) session.getValue("SalesAreaCode");

		String query="EMM_NO";
		
		if("DESC".equals(searchType))
			query = "EMD_DESC";

		ezc.ezprojections.client.EzProjectionsManager ProjManager = new ezc.ezprojections.client.EzProjectionsManager();
		ezc.ezparam.EzcParams ezcpparams = new ezc.ezparam.EzcParams(true);

		ezc.ezprojections.params.EziProjectionHeaderParams inparamsProj=new ezc.ezprojections.params.EziProjectionHeaderParams();
		//inparamsProj.setSystemKey(skey+"') AND ECG_CATALOG_NO ='"+catalogCode+"' AND EMM_NO LIKE ('"+prodDesc);
		
		inparamsProj.setSystemKey(skey+"') AND ECG_CATALOG_NO ='"+catalogCode+"' AND "+query+" LIKE ('"+prodDesc);
		ezcpparams.setObject(inparamsProj);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		ezc.ezparam.ReturnObjFromRetrieve retpro = (ezc.ezparam.ReturnObjFromRetrieve)ProjManager.ezGetMaterialsByCountry(ezcpparams);

		String prodCode = "";
		int index = 0;
		for(int i=0;i<retpro.getRowCount();i++)
		{
			prodCode = retpro.getFieldValueString(i,"MATNO").trim();
			
			if(prdList.contains(prodCode))
				continue;
			remainPrds.addRow();
			remainPrds.setFieldValueAt("MATNO",prodCode,index);
			remainPrds.setFieldValueAt("MATDESC",retpro.getFieldValueString(i,"MATDESC"),index);
			remainPrds.setFieldValueAt("UOM",retpro.getFieldValueString(i,"UOM"),index);
			remainPrds.setFieldValueAt("UPCNO",retpro.getFieldValueString(i,"UPC_NO"),index);
			remainPrds.setFieldValueAt("GROUP_ID",retpro.getFieldValueString(i,"GROUP_ID"),index);
			
			index++;
		}	

		
		if(remainPrds!=null)
			remainCount = remainPrds.getRowCount();
		
	}
	
	log.log("222222222222222222222222222222222222222222@@@@@@@","W");
%>