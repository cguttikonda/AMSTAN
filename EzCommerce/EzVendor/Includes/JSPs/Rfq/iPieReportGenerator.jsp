<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>

<%

	int retObjCount = 0;	
	double[] data = null;
	String[] labels = null;
	String report = null,selectedRfq = null,selectedReportType = null,selectedTime = null;	
	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();
		
	String status = request.getParameter("status");	
	
	if("QBV".equals(status))
	{
		selectedRfq = request.getParameter("CollectiveRfq");
		selectedReportType = request.getParameter("Report");
	}
	else if("VQH".equals(status))
	{
		selectedTime = request.getParameter("TimePeriod");	
		selectedReportType = request.getParameter("Report");
	}
		
		
		
	if(selectedReportType != null && (selectedRfq!=null || selectedTime!=null))
	{				
		if("QBV".equals(status))
		{
			reportParams.setCallPattern("REPORT"); 
			reportParams.setReportType(status);
			reportParams.setCollectiveRfq(selectedRfq);	
		}
		else if("VQH".equals(status))
		{
			reportParams.setCallPattern("REPORT");
			reportParams.setReportType(status);
			reportParams.setTimePeriod(selectedTime);	
		}						

		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(reportParams);
		Session.prepareParams(ezcParams);				
		retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);	
					
		if (retObj != null)
		{			
			retObjCount = retObj.getRowCount();
			System.out.println("REPORT CHART---Number of Rows Are "+retObjCount);
			data = new double[retObjCount];
			labels = new String[retObjCount];
			
			//Generation Of Pie Chart
			if("QBV".equals(status))
			{
				for(int i=0;i<retObjCount;++i)
				{
					data[i] = Double.parseDouble(retObj.getFieldValueString(i,"ERD_COUNTER"));
				}

				for(int j=0;j<retObjCount;++j)
				{
					labels[j] = retObj.getFieldValueString(j,"ERH_SOLD_TO");
				}
			}
			//Generation Of Pie Chart
			else if("VQH".equals(status))
			{
				for(int i=0;i<retObjCount;++i)
				{
					data[i] = Double.parseDouble(retObj.getFieldValueString(i,"NUMBER_OF_QUOTES"));
				}

				for(int j=0;j<retObjCount;++j)
				{
					labels[j] = retObj.getFieldValueString(j,"ERH_SOLD_TO");
				}
			}
		}		
	}		
%>
 