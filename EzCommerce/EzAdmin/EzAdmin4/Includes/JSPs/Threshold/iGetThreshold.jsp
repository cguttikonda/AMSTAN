<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<%@ page import="ezc.ezcnetconnector.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager"/>
<%
	String manfIds = "";
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	ezDiscParams.setType("GET_ALL_THRESHOLDS");
	ezDiscParams.setExt1("");

	discMainParams.setObject(ezDiscParams);
	discMainParams.setLocalStore("Y");
	Session.prepareParams(discMainParams);

	ReturnObjFromRetrieve retThresholds = null;
	int retThresholdsCount = 0;
	
	try
	{
		retThresholds = (ReturnObjFromRetrieve)ezDiscountManager.ezGetThreshold(discMainParams);
	}
	catch(Exception e){}
	
	if(retThresholds!=null)
	{
		retThresholdsCount = retThresholds.getRowCount();
		
		for(int i=0;i<retThresholdsCount;i++)
		{
			String mfrID 	= retThresholds.getFieldValueString(i,"EDT_MFR_ID");
			
			manfIds = manfIds+"','"+mfrID;
		}
	}
		
	//out.println("retThresholds:::::::::::::::"+retThresholds.toEzcString());
	//out.println("manfIds:::::::::::::::"+manfIds);
	
	ReturnObjFromRetrieve retCat=null;
	int retCatCnt = 0;

	EzcParams ezcpparams = new EzcParams(false);
	EzCnetConnectorParams cnetParams=new EzCnetConnectorParams();
	
	cnetParams.setQuery("order by cds_Cat.CatID");
	ezcpparams.setObject(cnetParams);
	ezcpparams.setLocalStore("Y");
	Session.prepareParams(ezcpparams);

	retCat = (ReturnObjFromRetrieve)CnetManager.ezGetCnetCategories(ezcpparams);

	if(retCat!=null)
		retCatCnt = retCat.getRowCount();
		
	//out.println("retCat:::::::::::::"+retCat.toEzcString());
	
	ReturnObjFromRetrieve retMfr=null;
	int retMfrCnt = 0;

	if(manfIds!=null && !"null".equals(manfIds) && !"".equals(manfIds))
	{
		if(manfIds.startsWith("','")) manfIds = manfIds.substring(3);
	
		String subQuery = "and cds_Prod.MfID in ('"+manfIds+"') order by cds_Vocez.Text";
		
		cnetParams.setStatus("GET_PRDS_MFR");
		cnetParams.setQuery(subQuery);
		ezcpparams.setObject(cnetParams);
		ezcpparams.setLocalStore("Y");
		Session.prepareParams(ezcpparams);

		retMfr = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(ezcpparams);
	}
	
	if(retMfr!=null)
		retMfrCnt = retMfr.getRowCount();

	//out.println("retMfr>>>>"+retMfr.toEzcString());
	
	Hashtable manfIdHash = new Hashtable();
	
	Hashtable itemCatHash = (Hashtable)Session.get("ITEM_CAT");
	
	if(itemCatHash==null)
	{
		itemCatHash = new Hashtable();
	
		if(retCatCnt>0)
		{
			for(int i=0;i<retCatCnt;i++)
			{
				String catID = retCat.getFieldValueString(i,"CatID");
				String catDesc = retCat.getFieldValueString(i,"Description");

				itemCatHash.put(catID,catDesc);
			}
		}
	}
	
	Session.put("ITEM_CAT",itemCatHash);
	
	if(retMfrCnt>0)
	{
		for(int i=0;i<retMfrCnt;i++)
		{
			String manfId = retMfr.getFieldValueString(i,"MfID");
			String manfDesc = retMfr.getFieldValueString(i,"Text");
			
			manfIdHash.put(manfId,manfDesc);
		}
	}
	
	//out.println("itemCatHash>>>>"+itemCatHash);
	//out.println("manfIdHash>>>>"+manfIdHash);
%>