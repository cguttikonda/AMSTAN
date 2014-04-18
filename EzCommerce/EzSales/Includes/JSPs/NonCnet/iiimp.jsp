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
	String categoryID = enSp(request.getParameter("categoryID"));
	String categoryDesc = enSp(request.getParameter("categoryDesc"));
	String STYPE = enSp(request.getParameter("STYPE"));
	String atrValStr = enSp(request.getParameter("atrvalstr"));
	String prodDesc1 = enSp(request.getParameter("ProdDesc1"));
	String mfrID = enSp(request.getParameter("mfrID"));
	String mfrDesc = enSp(request.getParameter("mfrDesc"));
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
		if(enSp(request.getParameter("pageSize")) != null)
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
	String pageNo = enSp(request.getParameter("d-49520-p"));
	String pgSizeCh = enSp(request.getParameter("pgSizeCh"));
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
	String retCatCnt = enSp(request.getParameter("retCatCnt"));
	
	if(retCatCnt==null || "null".equals(retCatCnt) || "".equals(retCatCnt))
		retCatCnt = "0";
	
	int itemsCnt = 0;

	int pageNum_T = 1;
	int pageMaxNo = pageSize;

	try
	{
		if(enSp(request.getParameter("pageNum")) != null)
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
	if("BY_CAT_PRDORDESC".equals(STYPE))
	{
		if(prodDesc1!=null && !"".equals(prodDesc1.trim()))
		{
			String tempDesc = deSp(prodDesc1);
			tempDesc = replaceString(tempDesc,"*","%");
			tempDesc = replaceString(tempDesc," ","%");
			
			
				ezcpparams.setType("GET_PRDS_CATEGORY");
				cnetParams.setQuery(mfrStr+"and (MM.EMM_NO like '%"+tempDesc+"%' or MD.EMD_DESC like '%"+tempDesc+"%')");
				
				if("ALL".equals(categoryID))
					cnetParams.setCategoryID((String)session.getValue("USER_CAT_STR"));
				else
					cnetParams.setCategoryID(categoryID);

				isValid = true;
			
			
		}
		else
		{
			isValid = false;
		}
	}
	else if("BY_CAT_ATRVAL".equals(STYPE))
	{
		try
		{
			log4j.log("STYPE>>>>"+STYPE,"I");
			
			log4j.log("atrValStr>>>>"+atrValStr,"I");

			if(atrValStr!=null && !"".equals(atrValStr.trim()) && atrValStr.indexOf('*')!=-1)
			{
				String[] atrPairArr = atrValStr.split("\\#");
				String qStr = "";

				for(int k=0;k<atrPairArr.length;k++)
				{
					String atrID = atrPairArr[k].split("\\*")[0];
					String atrValID = atrPairArr[k].split("\\*")[1];
					if(atrID!=null && !"".equals(atrID.trim()) && atrValID!=null && !"".equals(atrValID.trim()))
					{
						qStr += " ";
						isValid = true;
					}
				}
				if(isValid)
				{
					ezcpparams.setType("GET_PRDS_CAT_ATTR_ATTRVAL");
					cnetParams.setQuery(qStr+mfrStr);
					log4j.log("qStr>>>>"+qStr,"I");
				}


			}
		}
		catch(Exception e)
		{
			log4j.log("Exception>>>>"+e,"E");
			isValid = false;
		}
		log4j.log("isValid>>>>"+isValid,"I");
		
		cnetParams.setCategoryID(categoryID);	
	}
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);
	
	if("BY_CAT_PRDORDESC".equals(STYPE))
	{
		if(enSp(request.getParameter("d-49520-p")) != null || enSp(request.getParameter("d-49520-o"))!=null || "Y".equals(pgSizeCh))
		{
			clearSession = "N";
		}
	}

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
			//log4j.log("retObj>>>>"+retObj.toEzcString(),"I");
			if(retObj!=null && retObj.getRowCount()>0){
				String rFields[] = new String[]{"ProdID","ProdIDDesc","ImgID","MfID","CatID","StatusCode"}; 
				rSet = new ResultSet();
				rSet.addObject(retObj,rFields);
				session.setAttribute( "DISOBJCNET", rSet); 
			}	
		}else{
			rSet = (ResultSet)session.getAttribute("DISOBJCNET");     	
		}
		//log4j.log("rSet>>>>"+rSet,"I");
	}
	
	
	if("BY_CAT_PRDORDESC".equals(STYPE))
	{
		if(session.getAttribute("MFRFROMRET")==null)
		{

			if(retObj!=null && retObj.getRowCount()>0)
			{
				//retObj.sort(new String[]{"MfIDText"},true);
				mfrList = new java.util.ArrayList();
				for(int s=0;s<retObj.getRowCount();s++)
				{
					if(!mfrList.contains(retObj.getFieldValueString(s,"EMM_MANUFACTURER")+"¥"+retObj.getFieldValueString(s,"EMM_MANUFACTURER")))
						mfrList.add(retObj.getFieldValueString(s,"EMM_MANUFACTURER")+"¥"+retObj.getFieldValueString(s,"EMM_MANUFACTURER"));
				}
				java.util.Collections.sort(mfrList);
				session.setAttribute("MFRFROMRET",mfrList);
			}

		}
		else
		{
			mfrList = (java.util.ArrayList)session.getAttribute("MFRFROMRET");
		}
	}
	else
	{
		ReturnObjFromRetrieve retMfr = null;

		if(categoryID!=null)
		{
			String pItemCat = categoryID;

			if("ALL".equals(categoryID))
			{
				pItemCat = (String)session.getValue("USER_CAT_STR");
			}

			ezcpparams = new ezc.ezparam.EzCatalogParams(); 
			cnetParams=new EzCustomerItemCatParams();
			ezcpparams.setType("GET_PRDS_MFR");
			cnetParams.setQuery("where EMM_TYPE IN ('"+pItemCat+"')");
			ezcpparams.setObject(cnetParams);
			ezcpparams.setLocalStore("Y");
			Session.prepareParams(ezcpparams);

			retMfr = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);

			if(retMfr!=null)
			{
				int retMfrCnt = retMfr.getRowCount();

				mfrList = new java.util.ArrayList();

				for(int i=0;i<retMfrCnt;i++)
				{
					String mfrNum = retMfr.getFieldValueString(i,"EMM_MANUFACTURER");
					String mfrDescName = retMfr.getFieldValueString(i,"EMM_MANUFACTURER");

					if(!mfrList.contains(mfrDescName+"¥"+mfrNum))
						mfrList.add(mfrDescName+"¥"+mfrNum);
				}
				java.util.Collections.sort(mfrList);
			}
		}
	}
	
	ReturnObjFromRetrieve retAttr=null;
	int attrCnt = 0;
	if(!"ALL".equals(categoryID))
	{
		ezcpparams = new ezc.ezparam.EzCatalogParams(); 
		cnetParams=new EzCustomerItemCatParams();
		ezcpparams.setType("GET_ATTR_CATEGORY");
		cnetParams.setCategoryID(categoryID);
		cnetParams.setQuery("");
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		retAttr = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(ezcpparams);
	}	
	if(retAttr!=null)
		attrCnt = retAttr.getRowCount();
	//log4j.log("retAttr>>>>>>"+retAttr.toEzcString(),"I");
%>