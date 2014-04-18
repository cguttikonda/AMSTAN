<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="org.jCharts.axisChart.AxisChart,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.chartData.AxisChartDataSet,org.jCharts.chartData.DataSeries,org.jCharts.chartData.interfaces.IAxisDataSeries,org.jCharts.encoders.ServletEncoderHelper,org.jCharts.properties.*,org.jCharts.properties.util.ChartFont,org.jCharts.types.ChartType,java.awt.*"%>
<%@ page import="java.awt.*,org.jCharts.*,org.jCharts.chartData.*,org.jCharts.properties.*,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.types.ChartType,org.jCharts.axisChart.*,org.jCharts.test.TestDataGenerator,org.jCharts.encoders.JPEGEncoder13,org.jCharts.properties.util.ChartFont,org.jCharts.encoders.ServletEncoderHelper"%>

<%
	int retObjCount = 0;
	int MaxQuotations = 2;
	int chartWidth  = 850;
	int chartHeight = 565;	
	double[][] data = null;
	String report = null,selectedMaterial = null,selectedTime = null;
	String xAxisTitle = null;
	String yAxisTitle = null;
	String title = null;
	String[] labels = null;
	String[] legendLabels = new String[2];
	
	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();	
	
	report = request.getParameter("Report");
	

	if("MMMP".equals(report) || "MVQPH".equals(report) || "VQRH".equals(report))
	{
		
		ReturnObjFromRetrieve purAreaDefaults = null;
		EzAdminUtilsManager adminUtilManager = new EzAdminUtilsManager();
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setAreaType("AV");		
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(adminUtilsParams);
		Session.prepareParams(ezcParams);				
		purAreaDefaults = (ReturnObjFromRetrieve)adminUtilManager.getUsersAreasWithDefaults(ezcParams);		
		int purAreaCount = purAreaDefaults.getRowCount();
		String sysKey = (String)session.getAttribute("SYSKEY");

		if(purAreaCount>0)
		{
			String purGroup = null,purOrg = null;
			for(int i=0;i<purAreaCount;++i)
			{
				String parea = purAreaDefaults.getFieldValueString(i,"ESKD_SYS_KEY"); 
				if(sysKey.equals(parea))
				{
					String temp = purAreaDefaults.getFieldValueString(i,"ECAD_KEY");
					if(purGroup==null && "PURGROUP".equals(temp))
					{
						purGroup = purAreaDefaults.getFieldValueString(i,"ECAD_VALUE");
					}
					else if(purOrg==null && "PURORG".equals(temp))
					{
						purOrg = purAreaDefaults.getFieldValueString(i,"ECAD_VALUE");
					}
				}
				if(purGroup!=null && purOrg!=null)
				break;
			}

			reportParams.setPurchaseGrp(purGroup);	
			reportParams.setPurchaseOrg(purOrg);	
		}
		if("VQRH".equals(report))
		{
			selectedTime = request.getParameter("TimePeriod");
			reportParams.setTimePeriod(selectedTime);
		}
		else
		{
			selectedMaterial = request.getParameter("Material");
			reportParams.setMaterialCode(selectedMaterial);
		}
		
	}
	/*else if("VQRH".equals(report))
	{
		selectedTime = request.getParameter("TimePeriod");
		reportParams.setTimePeriod(selectedTime);	
	}*/
				
	reportParams.setCallPattern("REPORT");
	reportParams.setReportType(report);
	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");		
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);		
	
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
	System.out.println("XXXXXXXXXXXXXXXXXXX$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		
	if (retObj != null)
		retObjCount = retObj.getRowCount();	
		
	if(retObjCount>0)
	{
		data = new double[2][retObjCount];
		labels = new String[retObjCount];		

		//LineChart Delcarations
		LegendProperties legendProperties = new LegendProperties();
		ChartProperties chartProperties = new ChartProperties();
		AxisProperties axisProperties = new AxisProperties(false);
		
		ChartFont axisScaleFont = new ChartFont( new Font( "Georgia Negreta cursiva", Font.PLAIN, 13 ), Color.red );
		ChartFont naxisScaleFont = new ChartFont( new Font( "Times New Roman", Font.PLAIN, 18 ), Color.red );
		axisProperties.getXAxisProperties().setScaleChartFont( axisScaleFont );
		axisProperties.getYAxisProperties().setScaleChartFont( axisScaleFont );
			
		ChartFont axisTitleFont = new ChartFont( new Font( "Arial Narrow", Font.PLAIN,11), Color.black );
		axisProperties.getXAxisProperties().setTitleChartFont( axisTitleFont );
		axisProperties.getYAxisProperties().setTitleChartFont( axisTitleFont );


		if("MMMP".equals(report))
		{

			xAxisTitle= "VENDORS";
			yAxisTitle= "PRICES";
			title= "Vendor Material-Price Analysis";
			legendLabels[0] = "Max Price";
			legendLabels[1] = "Min Price";

			for(int i=0;i<retObjCount;++i)
			{
				data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"MAX"));
				data[1][i] = Double.parseDouble(retObj.getFieldValueString(i,"MIN"));
				labels[i] = retObj.getFieldValueString(i,"ERH_SOLD_TO");
			}
		}
		else if("MVQPH".equals(report))
		{
			xAxisTitle= "VENDORS";
			yAxisTitle= "QUANTITY";
			title= "Materials VENDOR-QUANTITY-PRICE Analysis";
			
			//Making vector with vendors
			Vector Vendors = new Vector();			
			for(int i=0;i<retObjCount;++i)
			{
				String s = retObj.getFieldValueString(i,"ERH_SOLD_TO");
				if(!Vendors.contains(s))
				{
					Vendors.add(s);					
				}
			}
			//out.println(Vendors+"<br>");			
			//Finding out Number Of Times supplied per each vendor
			Hashtable supplyNo = new Hashtable();
			int NoOfVendors = Vendors.size();
			labels = new String[NoOfVendors];
			for(int i=0;i<NoOfVendors;++i)
			{			
				String temp = (String)Vendors.get(i);
				labels[i] = temp;
				int counter = 0;
				for(int k=0;k<retObjCount;++k)
				{
					if(temp.equals(retObj.getFieldValueString(k,"ERH_SOLD_TO")))
					++counter;
				}
				supplyNo.put(temp,new Integer(counter).toString());
			}
			//out.println(supplyNo);
			//Finding Out Maximum Quotations
			Enumeration enum = supplyNo.elements();
			
			while(enum.hasMoreElements())
			{
				int t = Integer.parseInt((String)enum.nextElement());
				if(t>MaxQuotations)
				MaxQuotations = t;		
			}
			//out.println("MaxQuotes --->"+MaxQuotations);
			data = new double[MaxQuotations][NoOfVendors];
			for(int m=0;m<NoOfVendors;++m)
			{				
				String vendorCode = (String)Vendors.get(m);
				double[] val = new double[Integer.parseInt((String)supplyNo.get(vendorCode))];
				int valCounter = 0;
				//out.println("****Line**"+m+"****"+val.length+"*****");
				for(int i=0;i<retObjCount;++i)
				{
					if(vendorCode.equals(retObj.getFieldValueString(i,"ERH_SOLD_TO")))
					{
						val[valCounter] = Double.parseDouble(retObj.getFieldValueString(i,"ERD_QUANTITY")) ;
						//out.println("---"+valCounter+"---->"+val[valCounter]);
						++valCounter;
					}
				}
				
				//out.println("<br>");
				//out.println("<br><br><br><br>---->"+val.length+"<br>");
				for(int n=0;n<MaxQuotations;++n)
				{					
					if(n<val.length)
						data[n][m] = val[n];				
					else	
						data[n][m] = 0.01;				
					//out.println("-->"+data[n][m]+"<br>");
				}
				//out.println("End of line<BR><BR>");
			}
			legendLabels =new String[MaxQuotations];			
			for(int i=0;i<MaxQuotations;++i)
			{
				legendLabels[i] = new Integer(i+1).toString();
			}
			/****************************
			out.println("<br><br>");
			for(int i=0;i<NoOfVendors;++i)
			{
				for(int j=0;j<MaxQuotations;++j)
				{
					out.println(data[j][i]);
				}
				out.println("<br><br>");
			}
			****************************/
			
			/************************************************************
			************************************************************
			WRITE MORE CODEWRITE MORE CODEWRITE MORE CODEWRITE MORE CODE
			************************************************************
			************************************************************/

		}
		else if("VQRH".equals(report))
		{
			xAxisTitle= "VENDORS";
			yAxisTitle= "NUMBER OF REQUESTS/RESPONSES";
			title= "Vendor Quotations Request-Response Analysis";
			legendLabels[0] = "Quotation Requests";
			legendLabels[1] = "Quotation Responses";
			
			for(int i=0;i<retObjCount;++i)
			{
				data[0][i] = Double.parseDouble(retObj.getFieldValueString(i,"NUMBER_OF_REQUESTS"));
				data[1][i] = Double.parseDouble(retObj.getFieldValueString(i,"NUMBER_OF_RESPONSES"));
				if (data[1][i]==0)
					data[1][i] = 0.01;
				labels[i] = retObj.getFieldValueString(i,"ERH_SOLD_TO");
			}

		}

		
		DataSeries dataSeries = new DataSeries( labels, xAxisTitle, yAxisTitle, title );	
		Paint[] paints = null;
		
		if("MVQPH".equals(report))
		{
			paints = TestDataGenerator.getRandomPaints(MaxQuotations);
		}
		else		
		{
			paints = TestDataGenerator.getRandomPaints(MaxQuotations);
		}
		
		ClusteredBarChartProperties clusteredBarChartProperties= new ClusteredBarChartProperties();

		ChartFont titleFont = new ChartFont(new Font("Georgia Negreta cursiva",Font.PLAIN,14),Color.black);
		chartProperties.setTitleFont(titleFont);
		ValueLabelRenderer valueLabelRenderer = new ValueLabelRenderer(false,false,true,-1);
		valueLabelRenderer.setValueLabelPosition(ValueLabelPosition.ON_TOP);
		valueLabelRenderer.useVerticalLabels(false);
		clusteredBarChartProperties.addPostRenderEventListener(valueLabelRenderer);
		clusteredBarChartProperties.setWidthPercentage(0.7f);

		AxisChartDataSet axisChartDataSet= new AxisChartDataSet(data, legendLabels, paints, ChartType.BAR_CLUSTERED, clusteredBarChartProperties );
		dataSeries.addIAxisPlotDataSet( axisChartDataSet );	
		AxisChart axisChart= new AxisChart( dataSeries, chartProperties, axisProperties, legendProperties,chartWidth,chartHeight);		
		ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);
		

	}
	else if("MMMP".equals(report) || "MVQPH".equals(report))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>There Are No Quotations Made By Any Vendor</Th>
	</center>

<%
	}		
	else if("VQRH".equals(report))
	{
%>	
	<BR><BR><BR><BR><BR>
	<center>
	<Th>There Are No Quotation Requests-Reponses Data Available.</Th>
	</center>
<%
	}
%>
<Div id="MenuSol"></Div>