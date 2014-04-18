<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%
	
	String material = request.getParameter("material");
	String vendor	= request.getParameter("vendor");
	String plant	= request.getParameter("plant");
	
	
	String errorMessage 	= "";
	boolean qmInfoAvailable = false;
	ezc.ezparam.ReturnObjFromRetrieve globalRet 	= null;
	
	ezc.ezpreprocurement.client.EzPreProcurementManager ezPreProcurementManager      = new ezc.ezpreprocurement.client.EzPreProcurementManager();
	ezc.ezpreprocurement.params.EziQMInfoParams eziQMInfoParams     = new ezc.ezpreprocurement.params.EziQMInfoParams();
	ezc.ezparam.EzcParams ezcParams  = new ezc.ezparam.EzcParams(true);
	eziQMInfoParams.setMaterial(material);
	eziQMInfoParams.setVendor(vendor);
	eziQMInfoParams.setPlant(plant);
	ezcParams.setObject(eziQMInfoParams);
	Session.prepareParams(ezcParams);
	ezc.ezparam.ReturnObjFromRetrieve qminfoRetObj =  (ezc.ezparam.ReturnObjFromRetrieve)ezPreProcurementManager.ezGetQMInfoRecords(ezcParams);	
	if(qminfoRetObj != null)
	{
		int qminfoCount = qminfoRetObj.getRowCount();
		if(qminfoCount > 0)
		{
			if("N".equals(qminfoRetObj.getFieldValueString(0,"ISERROR")))
			{
				qmInfoAvailable = true;
				Vector types = new Vector();
				types.addElement("date");
				types.addElement("date");
				types.addElement("date");
				EzGlobal.setColTypes(types);
				EzGlobal.setDateFormat("dd.MM.yyyy");

				Vector colNames = new Vector();
				colNames.addElement("RELEASE_UNTIL");
				colNames.addElement("RESET_ON");
				colNames.addElement("VALID_TO");
				EzGlobal.setColNames(colNames);	
				
				globalRet = EzGlobal.getGlobal(qminfoRetObj);					
			}
			else
			{
				errorMessage = qminfoRetObj.getFieldValueString(0,"ERROR_MESSAGE");
				qmInfoAvailable = false;
			}
		}
	}
	
%>