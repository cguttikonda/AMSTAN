<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@ page import="java.awt.*,org.jCharts.*,org.jCharts.chartData.*,org.jCharts.properties.*,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.types.ChartType,org.jCharts.axisChart.*,org.jCharts.test.TestDataGenerator,org.jCharts.encoders.JPEGEncoder13,org.jCharts.properties.util.ChartFont,org.jCharts.encoders.ServletEncoderHelper"%>

<%

	int retObjCount = 0;	
	
	double[][] data = null;
	String[] labels = null;
	String report = null,selectedRfq = null,selectedReportType = null,selectedTime = null;	
	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();	
	
	String status ="MPA";
		
	reportParams.setCallPattern("REPORT");
	reportParams.setReportType(status);
	reportParams.setMaterialCode("100-100");
	
	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");
		
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);		
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
	
	
	if (retObj != null)
	{			
		retObjCount = retObj.getRowCount();
		System.out.println("REPORT CHART---Number of Rows Are "+retObjCount);
		data = new double[2][retObjCount];
		labels = new String[retObjCount];
		for(int i=0;i<retObjCount;++i)
		{
			data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"MAX"));
			data[1][i] = Double.parseDouble(retObj.getFieldValueString(i,"MIN"));
			labels[i] = retObj.getFieldValueString(i,"ERH_SOLD_TO");
		}
		
	}
	
	
%>	
	