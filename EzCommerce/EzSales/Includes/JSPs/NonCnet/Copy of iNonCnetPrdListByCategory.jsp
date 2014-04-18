<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>  


<%!
	public static String replaceString(String theString,String from,String to) 
	{ 
		String ret=theString; 
		int go=0; 
		if(ret!=null)
		{
			while (ret.indexOf(from,go)>=0) 
			{ 
				go=ret.indexOf(from,go); 
				ret=ret.substring(0,go)+to+ret.substring(go+from.length()); 
				go=go+to.length(); 
			} 
		}
		return ret; 

	} 
%>
<%
	String categoryID = request.getParameter("categoryID");
	String categoryDesc = request.getParameter("categoryDesc");
	String STYPE = request.getParameter("STYPE");
	String atrValStr = request.getParameter("atrvalstr");
	String prodDesc1 = request.getParameter("ProdDesc1");
	String mfrID = request.getParameter("mfrID");
	String mfrDesc = request.getParameter("mfrDesc");
	String noDataStatement ="No Data to Display"; 
	String isCatUser     = (String)session.getValue("IsCatUser");
	String usrFavGrp     = (String)session.getValue("USR_FAV_GRP");
	String usrFavDesc     = (String)session.getValue("USR_FAV_DESC");
	String clearSession  = "Y";   
	java.util.ArrayList mfrList = null;
	String mfrStr = "";
	boolean isValid = false;
	ReturnObjFromRetrieve retObj=null;
	ResultSet rSet = null;
	int rSetSize=0;
	int pageSize = 0; 
	int retObjcount = 0;
	try{
		if(request.getParameter("pageSize") != null)
		{
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		else
		{
			pageSize = 5;
		}
	}catch(Exception ex) 
	{
		pageSize = 5; 
	}
	String pageNo =request.getParameter("d-49520-p");
	String pgSizeCh =request.getParameter("pgSizeCh");
	String catDescDisp = categoryDesc;
	//if(categoryDesc!=null)catDescDisp=replaceString(categoryDesc,"@","&");
	//if(categoryDesc!=null)catDescDisp=replaceString(categoryDesc,"¥","&");
	if(categoryDesc!=null)catDescDisp=catDescDisp.replace('@','&');
	if(mfrDesc!=null)mfrDesc=mfrDesc.replace('@','&');
	if(atrValStr==null)atrValStr="";
	if(prodDesc1==null || "null".equals(prodDesc1))prodDesc1="";
	if(mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim()))
		mfrStr = " and EMM_MANUFACTURER = '"+mfrID+"' ";
	
	pageContext.setAttribute("tableclass", "its");

	//EzcParams ezcpparams = new EzcParams(true);
	//EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	
	EzCatalogParams ezcpparams = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams cnetParams = new EzCustomerItemCatParams(); 
		
	ReturnObjFromRetrieve retCatCntObj = null;
	String retCatCnt = request.getParameter("retCatCnt");
	
	if(retCatCnt==null || "null".equals(retCatCnt) || "".equals(retCatCnt))
		retCatCnt = "0";
	
	int itemsCnt = 0;

	int pageNum_T = 1;
	int pageMaxNo = pageSize;

	try
	{
		if(request.getParameter("pageNum") != null)
		{
			pageNum_T = Integer.parseInt(request.getParameter("pageNum"));
		}
		else
		{
			pageNum_T = 1;
		}
	}
	catch(Exception ex) 
	{
		pageNum_T = 1; 
	}

	pageMaxNo = pageNum_T*pageSize;
	
	if("BY_CAT".equals(STYPE))
	{
		ezcpparams.setType("GET_PRDS_COUNT_BY_CATEGORY");
		cnetParams.setCategoryID(categoryID);
		cnetParams.setQuery(mfrStr);
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		
		retCatCntObj = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);

		if(retCatCntObj!=null)
		{
			retCatCnt = retCatCntObj.getFieldValueString(0,"ProdsCount");
			itemsCnt = Integer.parseInt(retCatCnt);
			
			
		}
		if(pageMaxNo>itemsCnt)
			pageMaxNo = itemsCnt;
		
		ezcpparams = new ezc.ezparam.EzCatalogParams(); 
		cnetParams=new EzCustomerItemCatParams();
		
		cnetParams.setExt1(pageSize+"");
		cnetParams.setExt2(pageMaxNo+"");
		ezcpparams.setType("GET_PRDS_BY_CATEGORY");
		cnetParams.setQuery(mfrStr);
		isValid = true;
		cnetParams.setCategoryID(categoryID);
	}
	
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	if("Y".equals(clearSession))
	{
		session.removeAttribute("DISOBJCNET");
		session.removeAttribute("MFRFROMRET");
	}
	
	if(isValid)
	{
		if(session.getAttribute("DISOBJCNET")==null){
		
		retObj = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
		log4j.log("retObj>>>>"+retObj.getRowCount(),"I");

		if(retObj!=null && retObj.getRowCount()>0)
		{
			String rFields[] = new String[]{"ProdID","ProdIDDesc","ImgID","MfID","CatID","StatusCode","UnitPrice"}; 
			rSet = new ResultSet();
			rSet.addObject(retObj,rFields);
			session.setAttribute( "DISOBJCNET", rSet); 
		}
		}
		else{
			rSet = (ResultSet)session.getAttribute("DISOBJCNET");     	
		}
			
	}
	
	//out.println("retObj:::"+retObj.toEzcString());
		
%>