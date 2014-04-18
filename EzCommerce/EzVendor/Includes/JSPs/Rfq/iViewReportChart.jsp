<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezparam.*,ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@ page import ="java.util.*" %>

<%
	boolean goFlag = true;
	int retObjCount = 0,purAreaRetObjCount = 0;	
	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null,purAreaRetObj = null;			
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EzAdminUtilsManager adminUtilManager = new EzAdminUtilsManager();
	EziAdminUtilsParams adminUtilsParams = null;
	
	EziReportParams eziReportParams = new EziReportParams();

	String status = request.getParameter("status");				
	
	if("MMMP".equals(status) || "MVQPH".equals(status) || "MPA".equals(status))
	{
		eziReportParams = new EziReportParams();
		eziReportParams.setCallPattern("LIST");
		eziReportParams.setReportType("MATERIALS");
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(eziReportParams);
		Session.prepareParams(ezcParams);				
		retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);	
		if(retObj != null)
			retObjCount = retObj.getRowCount();		
	}
	else if("CVQH".equals(status))
	{
		
		retObj = (ezc.ezparam.ReturnObjFromRetrieve)session.getValue("VendorsRetObj");
		/*eziReportParams = new EziReportParams();
		eziReportParams.setCallPattern("LIST");
		eziReportParams.setReportType("VENDORS");
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(eziReportParams);
		Session.prepareParams(ezcParams);				
		retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);*/
		if(retObj != null)
		{
			retObjCount = retObj.getRowCount();		
		}	
	}	
	else if("RQPA".equals(status))
	{
		eziReportParams = new EziReportParams();
		eziReportParams.setCallPattern("LIST");
		eziReportParams.setReportType("RFQS");
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(eziReportParams);
		Session.prepareParams(ezcParams);				
		retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);	
		if(retObj != null)
			retObjCount = retObj.getRowCount();		
	}	
	else if("PGEH".equals(status) || "PGQH".equals(status) || "PGFH".equals(status))
	{
		adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setAreaType("AV");		
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(adminUtilsParams);
		Session.prepareParams(ezcParams);				
		retObj = (ReturnObjFromRetrieve)adminUtilManager.getUsersAreasWithDefaults(ezcParams);	
		if(retObj != null)
			retObjCount = retObj.getRowCount();		
		if(retObjCount>0)
		{
			String[] columns = {"PUR_AREA_CODE","PUR_AREA_NAME","PUR_GRP","PUR_ORG"};
			purAreaRetObj = new ReturnObjFromRetrieve(columns);
			Vector purAreas = new Vector();
			Hashtable purAreaValues = new Hashtable();
			
			for(int i=0;i<retObjCount;++i)
			{
				String s = retObj.getFieldValueString(i,"ESKD_SYS_KEY");				
				if(!purAreas.contains(s))
				purAreas.add(s);
			}			
			int vsize = purAreas.size();
			for(int i=0;i<vsize;++i)
			{				
				String purGrp = null;
				String purOrg = null;
				String purAreaName = null;
				String s =(String)purAreas.get(i);
				for(int k=0;k<retObjCount;++k)
				{
					String pcode = retObj.getFieldValueString(k,"ESKD_SYS_KEY");
					String data = retObj.getFieldValueString(k,"ECAD_KEY");
					if(pcode.equals(s))					
					{						
						if(purAreaName==null)
						purAreaName = retObj.getFieldValueString(k,"ESKD_SYS_KEY_DESC");
						if(purGrp==null && "PURGROUP".equals(data))
							purGrp = retObj.getFieldValueString(k,"ECAD_VALUE");
						else if(purOrg==null && "PURORG".equals(data))
							purOrg = retObj.getFieldValueString(k,"ECAD_VALUE");

					}
					if(purAreaName!=null && purGrp!=null && purOrg!=null)
					break;
				}
				purAreaRetObj.setFieldValue("PUR_AREA_CODE",s);
				purAreaRetObj.setFieldValue("PUR_AREA_NAME",purAreaName);
				purAreaRetObj.setFieldValue("PUR_GRP",purGrp);
				purAreaRetObj.setFieldValue("PUR_ORG",purOrg);
				purAreaRetObj.addRow();				
			}
			purAreaRetObjCount = purAreaRetObj.getRowCount();						
		}
	}

					
%>


 