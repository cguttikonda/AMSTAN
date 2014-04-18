<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*" %>
<%



	
	String poNum = request.getParameter("PurOrderNum");
	String POorCon = request.getParameter("POorCon");

	ezc.ezpreprocurement.client.EzPreProcurementManager ezrfqmanager = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziGenericFMParams ezigenericfmparams     = new ezc.ezpreprocurement.params.EziGenericFMParams();
	
	ezc.ezparam.EzcParams ezcparamsunits  = new ezc.ezparam.EzcParams(true);
	
	ezigenericfmparams.setObjectId("PO_AMENDMENT");
	ezigenericfmparams.setInput1(poNum);
	
	ezcparamsunits.setObject(ezigenericfmparams);
	Session.prepareParams(ezcparamsunits);
	
	
	ezc.ezparam.ReturnObjFromRetrieve retAmdPODetails =  (ezc.ezparam.ReturnObjFromRetrieve)ezrfqmanager.ezCallGenericFM(ezcparamsunits);
	
	int retAmdPODetailsCnt = 0;
	if(retAmdPODetails!=null && retAmdPODetails.getRowCount()>0)
	{
		retAmdPODetailsCnt = retAmdPODetails.getRowCount();
		
		boolean b = retAmdPODetails.sort(new String[]{"UDATE"},false);
		
	}	
	
	
	ReturnObjFromRetrieve finalRet = new ReturnObjFromRetrieve(new String[]{"UDATE","UTIME","USERNAME","RETOBJ"});
	ReturnObjFromRetrieve tempRet  = null;
	
	Date tempDate=new Date(1975,01,01);
	Date cDate = null;
	Date tDate = null;
	String uName = null;
	for(int i=0;i<retAmdPODetails.getRowCount();i++)
	{
		
		uName = retAmdPODetails.getFieldValueString(i,"USERNAME");	
		cDate = (Date)retAmdPODetails.getFieldValue(i,"UDATE");	
		tDate = (Date)retAmdPODetails.getFieldValue(i,"UTIME");	
		int a = cDate.compareTo(tempDate);
		if(a != 0)
		{
			if(i != 0)
			{
				tempRet.sort(new String[]{"TABDESC"},true);
				finalRet.setFieldValue("UDATE",tempDate);
				finalRet.setFieldValue("UTIME",tDate);
				finalRet.setFieldValue("USERNAME",uName);
				finalRet.setFieldValue("RETOBJ",tempRet);
				finalRet.addRow();
			}
		
			tempRet=new ReturnObjFromRetrieve(new String[]{"OBJECTID","TABNAME","TABDESC","FNAME","FDESC","USERNAME","UDATE","UTIME","TABKEY","VALUE_OLD","VALUE_NEW","UNIT_OLD","UNIT_NEW","CUKY_OLD","CUKY_NEW","DATATYPE"});	
		}
		
		
		tempRet.setFieldValue("OBJECTID",retAmdPODetails.getFieldValue(i,"OBJECTID"));
		tempRet.setFieldValue("TABNAME",retAmdPODetails.getFieldValue(i,"TABNAME"));
		tempRet.setFieldValue("TABDESC",retAmdPODetails.getFieldValue(i,"TABDESC"));
		tempRet.setFieldValue("FNAME",retAmdPODetails.getFieldValue(i,"FNAME"));
		tempRet.setFieldValue("FDESC",retAmdPODetails.getFieldValue(i,"FDESC"));
		tempRet.setFieldValue("USERNAME",retAmdPODetails.getFieldValue(i,"USERNAME"));
		tempRet.setFieldValue("UDATE",retAmdPODetails.getFieldValue(i,"UDATE"));
		tempRet.setFieldValue("UTIME",retAmdPODetails.getFieldValue(i,"UTIME"));
		tempRet.setFieldValue("TABKEY",retAmdPODetails.getFieldValue(i,"TABKEY"));
		tempRet.setFieldValue("VALUE_OLD",retAmdPODetails.getFieldValue(i,"VALUE_OLD"));
		tempRet.setFieldValue("VALUE_NEW",retAmdPODetails.getFieldValue(i,"VALUE_NEW"));
		tempRet.setFieldValue("UNIT_OLD",retAmdPODetails.getFieldValue(i,"UNIT_OLD"));
		tempRet.setFieldValue("UNIT_NEW",retAmdPODetails.getFieldValue(i,"UNIT_NEW"));
		tempRet.setFieldValue("CUKY_OLD",retAmdPODetails.getFieldValue(i,"CUKY_OLD"));
		tempRet.setFieldValue("CUKY_NEW",retAmdPODetails.getFieldValue(i,"CUKY_NEW"));
		tempRet.setFieldValue("DATATYPE",retAmdPODetails.getFieldValue(i,"DATATYPE"));
		tempRet.addRow();
		
		tempDate = cDate;
		
		if(i == retAmdPODetails.getRowCount()-1)
		{
			tempRet.sort(new String[]{"TABDESC"},true);
			finalRet.setFieldValue("UDATE",tempDate);
			finalRet.setFieldValue("UTIME",tDate);
			finalRet.setFieldValue("USERNAME",uName);
			finalRet.setFieldValue("RETOBJ",tempRet);
			finalRet.addRow();
		}

	}
	
	
	
	
%>