<%@ page import="ezc.ezcnetconnector.params.*,ezc.ezparam.*" %>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />
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
	String pageNo = request.getParameter("d-49520-p");
	String pgSizeCh = request.getParameter("pgSizeCh");
	String catDescDisp = categoryDesc;
	//if(categoryDesc!=null)catDescDisp=replaceString(categoryDesc,"@","&");
	//if(categoryDesc!=null)catDescDisp=replaceString(categoryDesc,"¥","&");
	if(categoryDesc!=null)catDescDisp=catDescDisp.replace('@','&');
	if(mfrDesc!=null)mfrDesc=mfrDesc.replace('@','&');
	if(atrValStr==null)atrValStr="";
	if(prodDesc1==null || "null".equals(prodDesc1))prodDesc1="";
	if(mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim()))
		mfrStr = " and cds_Prod.MfID = '"+mfrID+"' ";
	
	pageContext.setAttribute("tableclass", "its");

	if(request.getParameter("d-49520-p") != null || request.getParameter("d-49520-o")!=null || "Y".equals(pgSizeCh)){
		clearSession = "N";
	}
	if("Y".equals(clearSession)){
		session.removeAttribute("DISOBJCNET");
		session.removeAttribute("MFRFROMRET");
	}

	 
	EzcParams ezcpparams = new EzcParams(true);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	if("BY_CAT".equals(STYPE))
	{
		cnetParams.setStatus("GET_PRDS_CATEGORY");
		cnetParams.setQuery(mfrStr);
		isValid = true;
		cnetParams.setCategoryID(categoryID);
	}
	if("BY_CAT_PRDORDESC".equals(STYPE))
	{
		if(prodDesc1!=null && !"".equals(prodDesc1.trim()))
		{
			/*String subQry = "";
			
			try
			{
				java.util.StringTokenizer prdOrDesc = new java.util.StringTokenizer(prodDesc1);
				
				int i = 0;
				while(prdOrDesc.hasMoreTokens())
				{
					String tempSearch = (String)prdOrDesc.nextToken();

					if(i==0)
						subQry = " or cds_Prod.MfPN like '%"+tempSearch+"%' or cds_Stdnez.Description like '%"+tempSearch+"%'";
					else
						subQry = subQry+" or cds_Prod.MfPN like '%"+tempSearch+"%' or cds_Stdnez.Description like '%"+tempSearch+"%'";
					
					i++;
				}
			}
			catch(Exception e){}*/
			
			String tempDesc = prodDesc1;
			tempDesc = replaceString(tempDesc,"*","%");
			tempDesc = replaceString(tempDesc," ","%");
			cnetParams.setStatus("GET_PRDS_CATEGORY");
			cnetParams.setQuery(mfrStr+"and (cds_Prod.MfPN like '%"+tempDesc+"%' or cds_Stdnez.Description like '%"+tempDesc+"%')");
			isValid = true;
		}
		else
		{
			isValid = false;
		}
		if("ALL".equals(categoryID))
			cnetParams.setCategoryID((String)session.getValue("USER_CAT_STR"));
		else
			cnetParams.setCategoryID(categoryID);
		
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
						qStr += " join cds_Atr atr"+k+" on (cds_Prod.ProdID = atr"+k+".ProdID) and atr"+k+".CatID = '"+categoryID+"' and atr"+k+".AtrID = '"+atrID+"' and atr"+k+".ValID = '"+atrValID+"'";
						isValid = true;
					}
				}
				if(isValid)
				{
					cnetParams.setStatus("GET_PRDS_CAT_ATTR_ATTRVAL");
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
	if(isValid)
	{
		if(session.getAttribute("DISOBJCNET")==null){
			retObj = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
			log4j.log("retObj>>>>"+retObj.getRowCount(),"I");
			//log4j.log("retObj>>>>"+retObj.toEzcString(),"I");
			if(retObj!=null && retObj.getRowCount()>0){
				String rFields[] = new String[]{"ProdID","ProdIDDesc","CatID","MktID","MktIDDesc","ImgID","MfID","MfIDText","MfPN","StatusCode"}; 
				rSet = new ResultSet();
				rSet.addObject(retObj,rFields);
				session.setAttribute( "DISOBJCNET", rSet); 
			}	
		}else{
			rSet = (ResultSet)session.getAttribute("DISOBJCNET");     	
		}
		//log4j.log("rSet>>>>"+rSet,"I");
	}
	
	if(session.getAttribute("MFRFROMRET")==null)
	{
		
		if(retObj!=null && retObj.getRowCount()>0)
		{
			//retObj.sort(new String[]{"MfIDText"},true);
			mfrList = new java.util.ArrayList();
			for(int s=0;s<retObj.getRowCount();s++)
			{
				if(!mfrList.contains(retObj.getFieldValueString(s,"MfIDText")+"¥"+retObj.getFieldValueString(s,"MfID")))
					mfrList.add(retObj.getFieldValueString(s,"MfIDText")+"¥"+retObj.getFieldValueString(s,"MfID"));
			}
			java.util.Collections.sort(mfrList);
			session.setAttribute("MFRFROMRET",mfrList);
		}
		
	}
	else
	{
		mfrList = (java.util.ArrayList)session.getAttribute("MFRFROMRET");
	}
	
	
	
	
	
	ReturnObjFromRetrieve retAttr=null;
	int attrCnt = 0;
	if(!"ALL".equals(categoryID))
	{
		ezcpparams = new EzcParams(true);
		cnetParams=new EzCnetConnectorParams();
		cnetParams.setStatus("GET_ATTR_CATEGORY");
		cnetParams.setCategoryID(categoryID);
		cnetParams.setQuery("");
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);
		retAttr = (ReturnObjFromRetrieve)CnetManager.ezGetCnetAttributesByStatus(ezcpparams);
	}	
	if(retAttr!=null)
		attrCnt = retAttr.getRowCount();
	//log4j.log("retAttr>>>>>>"+retAttr.toEzcString(),"I");
	
%>