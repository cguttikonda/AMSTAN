<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*,ezc.ezutil.FormatDate"%>
<%@ page import="ezc.ezcnetconnector.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzWorkFlowManager" class="ezc.ezworkflow.client.EzWorkFlowManager" scope="session" />
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager"/>
<%
	String manfIds ="";
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(true);
	
	ezDiscParams.setType("GET_DISCOUNTS");
	ezDiscParams.setExt1("WHERE ESD_CREATED_BY='"+(String)Session.getUserId()+"' AND ESD_EXT1!='DEL' ORDER BY ESD_CREATED_ON DESC");
	
	discMainParams.setObject(ezDiscParams);
	discMainParams.setLocalStore("Y");
	Session.prepareParams(discMainParams);
	
	ReturnObjFromRetrieve retDiscounts = null;
	int retDiscountsCount = 0;
	
	try
	{
		retDiscounts = (ReturnObjFromRetrieve)ezDiscountManager.ezGetDiscount(discMainParams);
	}
	catch(Exception e){}
	
	//out.println("retDiscounts::::::::::"+retDiscounts.toEzcString());
	
	if(retDiscounts!=null)
	{
		retDiscountsCount = retDiscounts.getRowCount();
		
		for(int i=0;i<retDiscountsCount;i++)
		{
			String mfrID 	= retDiscounts.getFieldValueString(i,"ESD_MFR_ID");
			
			manfIds = manfIds+"','"+mfrID;
		}
	}

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
	
	String template		= (String)session.getValue("Templet");
	String UserRole 	= (String)session.getValue("UserRole");
	String participant	= (String)session.getValue("UserGroup");
	String syskey		= (String)session.getValue("SalesAreaCode");

	ArrayList desiredSteps=new ArrayList();
	if("CM".equals(UserRole))
		desiredSteps.add("1");
	else if("DM".equals(UserRole))
		desiredSteps.add("2");	
	else if("LF".equals(UserRole))
		desiredSteps.add("3");
	else if("SM".equals(UserRole))
		desiredSteps.add("4");	
	else if("SBU".equals(UserRole))
		desiredSteps.add("5");
	else if("INDREG".equals(UserRole))
		desiredSteps.add("6");	
	
	ReturnObjFromRetrieve retsoldto = null;
	int retsoldtoCount = 0;
	
	ezc.ezparam.EzcParams mainParamsu = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams paramsu = new ezc.ezworkflow.params.EziWFParams();
	paramsu.setTemplate(template);
	paramsu.setSyskey(syskey);
	paramsu.setPartnerFunction("AG");
	paramsu.setParticipant(participant);
	paramsu.setDesiredSteps(desiredSteps);
	mainParamsu.setObject(paramsu);
	Session.prepareParams(mainParamsu);
	
	retsoldto = (ReturnObjFromRetrieve)EzWorkFlowManager.getWorkFlowUsers(mainParamsu);
	
	if(retsoldto!=null)
		retsoldtoCount = retsoldto.getRowCount();
		
	//out.println("retsoldto:::::::::"+retsoldto.toEzcString());	
%>