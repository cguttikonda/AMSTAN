<%@ page import="ezc.sales.material.params.*,ezc.ezparam.*" %>
<jsp:useBean id="EzcMaterialManager" class="ezc.sales.material.client.EzcMaterialManager" />
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
	String prdType_C = "";

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
	ezc.ezcommon.EzLog4j.log("size >>>>>"+strSize,"I");
	materialsP 	= new String[strSize];	
	manufacturersP	= new String[strSize];
	mfrPartNosP 	= new String[strSize];
	
	try
	{

		for(int q=startIndexP;q<=endIndexP;q++)
		{
			 dataObjP =(ezc.ezdisplay.ResultSetData)rSet.get(q);
			 prdType_C =dataObjP.getColumn10().toString();
			 
			 if("CNET".equals(prdType_C))
			 {
				 materialsP[colP] = dataObjP.getColumn1().toString();
				 manufacturersP[colP] = dataObjP.getColumn8().toString();
				 mfrPartNosP[colP] = dataObjP.getColumn9().toString();
				 colP++;
			 }
			 
			 ezc.ezcommon.EzLog4j.log("mat info >>>>>>>>>"+dataObjP.getColumn1().toString()+"**"+dataObjP.getColumn8().toString()+"**"+dataObjP.getColumn9().toString(),"I");
		}
	}
	catch(Exception e)
	{
		ezc.ezcommon.EzLog4j.log("Exception >>>>>"+e,"E");
	}
	
	if(colP>0)
	{
		EzcMaterialParams ezcPParams = new EzcMaterialParams();
		EziCnetPriceParams cnetPParams = new EziCnetPriceParams();

		cnetPParams.setMaterials(materialsP);	
		cnetPParams.setManufacturers(manufacturersP);	
		cnetPParams.setMfrPartNos(mfrPartNosP);	
		cnetPParams.setType("CNET_PRICES_MAT_MF_MFP");
		ezcPParams.setObject(cnetPParams);
		ezcPParams.setLocalStore("Y");
		Session.prepareParams(ezcPParams);
		ReturnObjFromRetrieve cnetPriceRet = (ReturnObjFromRetrieve)EzcMaterialManager.ezGetCNETPrices(ezcPParams);

		if(cnetPriceRet!=null && cnetPriceRet.getRowCount()>0)
		{
			ezc.ezcommon.EzLog4j.log("cnetPriceRet >>>>>"+cnetPriceRet.toEzcString(),"I");
			for(int k=0;k<cnetPriceRet.getRowCount();k++)
			{
				String matNo = cnetPriceRet.getFieldValueString(k,"ECP_MATERIAL");
				String cPrice = cnetPriceRet.getFieldValueString(k,"ECP_PRICE");
				if(!"NA".equals(cPrice))
					cnetPriceHash.put(matNo,cPrice);
			}
		}
	}
%>