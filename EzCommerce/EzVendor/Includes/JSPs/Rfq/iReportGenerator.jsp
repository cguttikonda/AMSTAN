<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@ page import="java.awt.*,org.jCharts.*,org.jCharts.chartData.*,org.jCharts.properties.*,org.jCharts.types.ChartType,org.jCharts.axisChart.*,org.jCharts.test.TestDataGenerator,org.jCharts.encoders.JPEGEncoder13,org.jCharts.properties.util.ChartFont,org.jCharts.encoders.ServletEncoderHelper"%>
<%

	int retObjCount = 0;	
	int MaxQuotations = 0;
	double MaxPrice = 0;
	double[] data = null;
	String[] labels = null;
	String report = null,selectedRfq = null,selectedReportType = null,selectedTime = null;	
	EzcParams ezcParams = null;
	Vector vendors = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();	
	
	String status = request.getParameter("status");	
	
	if("QBV".equals(status) || "VQPA".equals(status))
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
		else if("VQPA".equals(status))
		{
			reportParams.setCallPattern("REPORT");
			reportParams.setReportType(status);
			reportParams.setCollectiveRfq(selectedRfq);	
		}				

		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");

		if("QBV".equals(status) || "VQH".equals(status))
		{		
			ezcParams.setObject(reportParams);
			Session.prepareParams(ezcParams);		
			retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
		}
		else if("VQPA".equals(status))
		{		
			ezcParams.setObject(reportParams);
			Session.prepareParams(ezcParams);		
			retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
		}		
		
		
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
			//Generation Of Line Chart
			else if("VQPA".equals(status))
			{																
				String[] field = {"ERD_COUNTER"};
				retObj.sort(field,false);																					
				MaxQuotations = Integer.parseInt(retObj.getFieldValueString(0,"ERD_COUNTER"));								
				
				if(MaxQuotations>0)
				{
					String[] field1 = {"ERD_PRICE"};
					retObj.sort(field1,false);	
					MaxPrice = Double.parseDouble(retObj.getFieldValueString(0,"ERD_PRICE"));				
					System.out.println("Maximum Price Is  "+MaxPrice);
				}				
				vendors = new Vector();				
				for(int i=0;i<retObjCount;++i)
				{
					String vendor = retObj.getFieldValueString(i,"ERH_SOLD_TO");
					if(!vendors.contains(vendor))
					vendors.add(vendor);				
				}
				out.println("---------->"+vendors+"<br>");
			}
		}
		
	}
	
	
%>
 