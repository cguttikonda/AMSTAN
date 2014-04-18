<%@ page import="ezc.ezparam.ReturnObjFromRetrieve,ezc.ezbasicutil.EzExcelDriver" %>
<%@ page import="java.util.*" buffer="512kb" autoFlush="true" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ page import="ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>

<%
        
        EzExcelDriver driver = new EzExcelDriver();
        
	EziFreightMasterParams eziFMParams = new EziFreightMasterParams();
	EzcParams params = new EzcParams(false);
	eziFMParams.setType("GET_ALL_FREIGHTS");
	eziFMParams.setExt1("");
	params.setObject(eziFMParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve frRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetFreightMaster(params);

        
        ArrayList myLabels 	= new ArrayList();
     	ArrayList sMHead1 	= new ArrayList();
    	
	ArrayList myLabelsArr[] = new ArrayList[1];
	ArrayList mHead[] 	= new ArrayList[1];
	
	myLabels.add("EFFM_STYPE_CODE");
	myLabels.add("EFFM_ZONE");
	myLabels.add("EFFM_COUNTRY_CODE");
	myLabels.add("EFFM_PACK_TYPE");
	myLabels.add("EFFM_WEIGHT_INPOUNDS");
	myLabels.add("EFFM_PRICE");
	myLabels.add("EFFM_KEY");
	
	
	myLabelsArr[0]	= myLabels;
	
	sMHead1.add("Freight Master Data");
	mHead[0] = sMHead1;
	
    	ReturnObjFromRetrieve retArr[] = new ReturnObjFromRetrieve[1];
	retArr[0] = frRet;
	
	try
    	{
    	  driver.ezCreateExcel(response,"FreightMaster.xls",retArr,myLabelsArr,mHead,false);
    	}
    	catch(Exception e){  
    	  System.out.println("Exception occured while writing data to excel"+e);
    	}
    	
%>