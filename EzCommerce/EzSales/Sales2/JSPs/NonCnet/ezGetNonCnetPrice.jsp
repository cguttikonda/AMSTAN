<%@ page import="ezc.sales.material.params.*,ezc.ezparam.*" %>
<%

 	String[] materialsP 	= null;
 	String[] manufacturersP	= null;
 	String[] mfrPartNosP 	= null;
 	
 	java.util.Hashtable cnetPriceHash = new java.util.Hashtable();
 	

	ezc.ezdisplay.ResultSetData dataObjP= null;
	int startIndexP=0;
	int endIndexP=0;
	int pageNumP=0;
	int colP = 0;
	String manNos ="";

	if(pageNo==null || "null".equals(pageNo))
		pageNo="1";

	try{
		pageNumP = Integer.parseInt(pageNo);
	}catch(Exception e){
	  	pageNumP = 0;
	}

	startIndexP = (pageNumP*pageSize)-pageSize;
	endIndexP   = (pageNumP*pageSize)-1;
	
	retObjcount = rSet.size(); 
	if(endIndexP>=retObjcount)
	endIndexP = retObjcount-1;
	
	int strSize = endIndexP-startIndexP;
	if(startIndexP==0)
		strSize = strSize +1;
	log4j.log("size >>>>>"+strSize,"I");
	materialsP 	= new String[strSize];	
	manufacturersP	= new String[strSize];
	mfrPartNosP 	= new String[strSize];
	
	try
	{

		for(int q=startIndexP;q<=endIndexP;q++)
		{
			 dataObjP =(ezc.ezdisplay.ResultSetData)rSet.get(q);
			 materialsP[colP] = dataObjP.getColumn1().toString();
			 manufacturersP[colP] = dataObjP.getColumn4().toString();
			 mfrPartNosP[colP] = dataObjP.getColumn1().toString();
			 
			 if(q==startIndexP)
				manNos    = dataObjP.getColumn4().toString();
			 else
				manNos    = manNos + "','" +dataObjP.getColumn4().toString();
			 
			 colP++;
			 
			 
			
		}
	}
	catch(Exception e)
	{
		log4j.log("Exception >>>>>"+e,"E");
	}
	
	
	EzCatalogParams catalogParamsCRI = new ezc.ezparam.EzCatalogParams();  
	EzCustomerItemCatParams ecicCRI = new EzCustomerItemCatParams(); 

	catalogParamsCRI.setType("NONCNET_PRICES_MAT_MF_MFP");
	ecicCRI.setProdID(prodNos);	
	ecicCRI.setExt1(manNos);	
	ecicCRI.setQuery("");	
	
	catalogParamsCRI.setObject(ecicCRI);
	catalogParamsCRI.setLocalStore("Y");
	Session.prepareParams(catalogParamsCRI);
	ReturnObjFromRetrieve cnetPriceRet = (ReturnObjFromRetrieve)webCatalogObj.getCustomerCategories(catalogParamsCRI);
	
	if(cnetPriceRet!=null && cnetPriceRet.getRowCount()>0)
	{
		log4j.log("cnetPriceRet >>>>>cnetPriceRet>>>"+cnetPriceRet.toEzcString(),"I");
		for(int k=0;k<cnetPriceRet.getRowCount();k++)
		{
			String matNo = cnetPriceRet.getFieldValueString(k,"EMM_NO");
			String cPrice = cnetPriceRet.getFieldValueString(k,"EMM_UNIT_PRICE");
			if(!"NA".equals(cPrice))
				cnetPriceHash.put(matNo,cPrice);
		}
	
	
	}
	
	
	//out.println("cnetPriceRet:::"+cnetPriceRet.toEzcString());
	
	
	
%>