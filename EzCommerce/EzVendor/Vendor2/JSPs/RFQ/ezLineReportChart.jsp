<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="org.jCharts.axisChart.axis.scale.*"%>
<%@ page import="java.awt.*,org.jCharts.*,org.jCharts.chartData.*,org.jCharts.properties.*,org.jCharts.types.ChartType,org.jCharts.axisChart.*,org.jCharts.test.TestDataGenerator,org.jCharts.encoders.JPEGEncoder13,org.jCharts.properties.util.ChartFont,org.jCharts.encoders.ServletEncoderHelper"%>
<%@ page import="ezc.ezparam.*,org.jCharts.chartData.*,org.jCharts.encoders.*,org.jCharts.nonAxisChart.*,org.jCharts.properties.*,java.awt.*" %>
<%@ page import ="java.util.*" %>
<html>
<head>
<Title>----</Title>
</head>
<body>
<%
	int retObjCount = 0;	
	int MaxQuotations = 0;
	double MaxPrice = 0;	
	double[] data = null;
	String[] labels = null;
	double dataarr[][] = null;	
	String report = null,selectedRfq = null,selectedTime = null,selectedMat= null;	

	String[] legendLabels = null;
	String title= null;
	String xAxisTitle= null;
	String yAxisTitle= null;
	String[] xAxisLabels =null; 

	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();		

	report = request.getParameter("Report");	
	//out.println(report);
	
	if("RQPA".equals(report))
	{
		selectedRfq = request.getParameter("CollectiveRfq");		
		reportParams.setCollectiveRfq(selectedRfq);	
	}
	else if("MAQPH".equals(report))
	{
		selectedTime = request.getParameter("TimePeriod");
		out.println(selectedTime);
		reportParams.setTimePeriod(selectedTime);	
	}
	else if("MPA".equals(report))
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

			reportParams.setPurchaseGrp(purOrg);	
			reportParams.setPurchaseOrg(purGroup);	
		}
		selectedMat = request.getParameter("Material");
		//out.println(selectedMat);
		reportParams.setMaterialCode(selectedMat);	
	}
	selectedMat = request.getParameter("Material");
	reportParams.setCallPattern("REPORT");
	reportParams.setReportType(report);
	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);		
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
	
	if (retObj != null)
	{
		retObjCount = retObj.getRowCount();		
	}	
	
	if(retObjCount>0)
	{
	
		//LineChart Delcarations
		LegendProperties legendProperties = new LegendProperties();
		ChartProperties chartProperties = new ChartProperties();
		AxisProperties axisProperties = new AxisProperties(false);	
	
		ChartFont axisScaleFont = new ChartFont( new Font( "Georgia Negreta cursiva", Font.PLAIN, 13 ), Color.red );
		ChartFont naxisScaleFont = new ChartFont( new Font( "Times New Roman", Font.PLAIN, 18 ), Color.red );
		axisProperties.getXAxisProperties().setScaleChartFont( axisScaleFont );
		axisProperties.getYAxisProperties().setScaleChartFont( axisScaleFont );

		ChartFont axisTitleFont = new ChartFont( new Font( "Arial Narrow", Font.PLAIN, 11 ), Color.black );
		axisProperties.getXAxisProperties().setTitleChartFont( axisTitleFont );
		axisProperties.getYAxisProperties().setTitleChartFont( axisTitleFont );
		
		/*
		DataAxisProperties yAxis= (DataAxisProperties) axisProperties.getYAxisProperties();
		UserDefinedScaleCalculator udef = new UserDefinedScaleCalculator(10.00, 25000.00);
		udef.setMaxValue(9000000.00);
		udef.setMinValue(20.00);
		udef.setNumberOfScaleItems(10);
				
		yAxis.setScaleCalculator(udef);
		*/			
		


		if("RQPA".equals(report))
		{
			Vector vendors = null;
			String[] field = {"ERD_COUNTER"};
			retObj.sort(field,false);																					
			MaxQuotations = Integer.parseInt(retObj.getFieldValueString(0,"ERD_COUNTER"));											
			if(MaxQuotations>0)
			{
				String[] field1 = {"ERD_PRICE"};
				retObj.sort(field1,false);	
				MaxPrice = Double.parseDouble(retObj.getFieldValueString(0,"ERD_PRICE"));								
			}				
			vendors = new Vector();				
			for(int i=0;i<retObjCount;++i)
			{
				String vendor = retObj.getFieldValueString(i,"ERH_SOLD_TO");
				if(!vendors.contains(vendor))
				vendors.add(vendor);				
			}		
			
			title = "RFQ Wise Quotation Price Analysis";
			xAxisTitle = "Quotations";
			yAxisTitle = "Price";
			xAxisLabels = new String[MaxQuotations+1];
			xAxisLabels[0] = "Initial";
			for(int i=1;i<MaxQuotations+1;++i)
			{		
				xAxisLabels[i] = "QT"+i;
			}
			int vendorVectorSize = vendors.size();	
			legendLabels = new String[vendorVectorSize];
			for(int i=0;i<vendorVectorSize;++i)
			{
				legendLabels[i]=(String)vendors.get(i); 
			}	
			DataSeries dataSeries = new DataSeries( xAxisLabels, xAxisTitle, yAxisTitle,title );
			dataarr = new double[vendorVectorSize][MaxQuotations+1];
			for(int i=0;i<vendorVectorSize;++i)
			{
				Hashtable values = new Hashtable();
				String vendor = (String)vendors.get(i);
				for(int k=0;k<retObjCount;++k)
				{
					String v=retObj.getFieldValueString(k,"ERH_SOLD_TO");
					if(vendor.equals(v))
					{						
						String p=retObj.getFieldValueString(k,"ERD_PRICE");
						String c=retObj.getFieldValueString(k,"ERD_COUNTER");				
						values.put(c,p);
					}			
				}				
				for(int j=0;j<MaxQuotations+1;++j)
				{
					String index = new Integer(j).toString();
					Object obj = values.get(index);
					if(obj != null)
					{
						double d=Double.parseDouble((String)obj);
						dataarr[i][j] = d;
					}
					else
					{
						dataarr[i][j] = 0;
					}						
				}
			}	
			Paint[] paints= new Paint[vendorVectorSize];
			Random r = new Random();
			for(int i=0;i<paints.length;++i)
			{
				paints[i] = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
			}
			Stroke[] strokes = new Stroke[vendorVectorSize];
			for(int l=0;l<vendorVectorSize;++l)
			{
				strokes[l] = LineChartProperties.DEFAULT_LINE_STROKE;
			}	
			Shape[] shapes = new Shape[vendorVectorSize]; 
			for(int m=0;m<vendorVectorSize;++m)
			{
				shapes[m] = PointChartProperties.SHAPE_CIRCLE;
			}		
			LineChartProperties lineChartProperties = new LineChartProperties(strokes,shapes);
			AxisChartDataSet acds = new AxisChartDataSet(dataarr, legendLabels, paints,ChartType.LINE, lineChartProperties );
			dataSeries.addIAxisPlotDataSet(acds);	
			AxisChart axisChart = new AxisChart(dataSeries, chartProperties, axisProperties,legendProperties, 950, 660);
			ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);
			
		}
		else if("MAQPH".equals(report))
		{
			Vector materials = null;			
			// --------------- Row 0 ---------------------
			//0 :: 0 Field Name : ERD_MATERIAL ----> Field Value : 100-100
			//0 :: 1 Field Name : ERD_COUNTER ----> Field Value : 1
			//0 :: 2 Field Name : AVG_PRICE ----> Field Value : 29.571428
			String[] field = {"ERD_COUNTER"};
			retObj.sort(field,false);																					
			MaxQuotations = Integer.parseInt(retObj.getFieldValueString(0,"ERD_COUNTER"));											
			//out.println("Max Quotation ---->"+MaxQuotations);
			materials = new Vector();				
			for(int i=0;i<retObjCount;++i)
			{
				String mat = retObj.getFieldValueString(i,"ERD_MATERIAL");
				if(!materials.contains(mat))
				materials.add((mat));				
			}		
			//out.println("materials  ---->"+materials);
			title = "Materials Average Quotation Price Analysis";
			xAxisTitle = "Quotations";
			yAxisTitle = "Price";
			xAxisLabels = new String[MaxQuotations+1];
			xAxisLabels[0] = "Initial";
			for(int i=1;i<MaxQuotations+1;++i)
			{		
				xAxisLabels[i] = "QT"+i;
			}
			int materialVectorSize = materials.size();	
			legendLabels = new String[materialVectorSize];
			String tCode="";
			for(int i=0;i<materialVectorSize;++i)
			{
				tCode = (String)materials.get(i);
				legendLabels[i]= Long.parseLong(tCode)+""; //Long.parseLong((String)materials.get(i)); 
			}	
			DataSeries dataSeries = new DataSeries( xAxisLabels, xAxisTitle, yAxisTitle,title );
			dataarr = new double[materialVectorSize][MaxQuotations+1];
			for(int i=0;i<materialVectorSize;++i)
			{
				Hashtable values = new Hashtable();
				String material = (String)materials.get(i);
				for(int k=0;k<retObjCount;++k)
				{
					String v=retObj.getFieldValueString(k,"ERD_MATERIAL");
					if(material.equals(v))
					{						
						String p=retObj.getFieldValueString(k,"AVG_PRICE");
						String c=retObj.getFieldValueString(k,"ERD_COUNTER");				
						values.put(c,p);
					}			
				}				
				//out.println(values);
				for(int j=0;j<MaxQuotations+1;++j)
				{
					String index = new Integer(j).toString();
					Object obj = values.get(index);
					if(obj != null)
					{
						double d=Double.parseDouble((String)obj);
						dataarr[i][j] = d;
					}
					else
					{
						dataarr[i][j] = 0;
					}						
				}
			}	

			Paint[] paints= new Paint[materialVectorSize];
			Random r = new Random();
			for(int i=0;i<paints.length;++i)
			{
				paints[i] = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
			}
			Stroke[] strokes = new Stroke[materialVectorSize];
			for(int l=0;l<materialVectorSize;++l)
			{
				strokes[l] = LineChartProperties.DEFAULT_LINE_STROKE;
			}	
			Shape[] shapes = new Shape[materialVectorSize]; 
			for(int m=0;m<materialVectorSize;++m)
			{
				shapes[m] = PointChartProperties.SHAPE_CIRCLE;
			}		
			LineChartProperties lineChartProperties = new LineChartProperties(strokes,shapes);
			AxisChartDataSet acds = new AxisChartDataSet(dataarr, legendLabels, paints,ChartType.LINE, lineChartProperties );
			dataSeries.addIAxisPlotDataSet(acds);	
			AxisChart axisChart = new AxisChart(dataSeries, chartProperties, axisProperties,legendProperties, 950, 660);
			ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);						
		}
		else if("MPA".equals(report))
		{
			Vector materials = null;
			
			//9 :: 0 Field Name : ERH_PO_NO ----> Field Value : 4500011261
			//9 :: 1 Field Name : ERH_RFQ_NO ----> Field Value : 6000104425
			//9 :: 2 Field Name : ERH_COLLETIVE_RFQ_NO ----> Field Value : 1000000015
			//9 :: 3 Field Name : ERH_SOLD_TO ----> Field Value : 1100000058
			//9 :: 4 Field Name : ERD_COUNTER ----> Field Value : 1
			//9 :: 5 Field Name : ERD_PRICE ----> Field Value : 11223.00

			String[] field = {"ERH_RFQ_NO"};
			retObj.sort(field,true);																					
			MaxQuotations = (retObj.getRowCount()-1);											
			//out.println("Max Quotation ---->"+MaxQuotations);
			materials = new Vector();				
			
			materials.add(selectedMat);				
			
			title = "Materials Price Analysis";
			xAxisTitle = "RFQ";
			yAxisTitle = "Price";
			xAxisLabels = new String[MaxQuotations+1];
			//xAxisLabels[0] = "Initial";
			for(int i=0;i<MaxQuotations+1;++i)
			{		
				xAxisLabels[i] = ""+(i+1);
			}
			int materialVectorSize = materials.size();	
			legendLabels = new String[materialVectorSize];
			String tCode="";
			for(int i=0;i<materialVectorSize;++i)
			{
				tCode = (String)materials.get(i);
				legendLabels[i]= Long.parseLong(tCode)+""; //Long.parseLong((String)materials.get(i)); 
			}
			
			DataSeries dataSeries = new DataSeries( xAxisLabels, xAxisTitle, yAxisTitle,title );
			dataarr = new double[materialVectorSize][MaxQuotations+1];
			
			
			double dblVal = 0.0;
			
			
			for(int i=0;i<materialVectorSize;++i)
			{
				Hashtable values = new Hashtable();
				String material = (String)materials.get(i);


				for(int k=0;k<retObjCount;++k)
				{
					System.out.println(retObj.getFieldValueString(k,"ERD_PRICE"));
					dblVal	+= Double.parseDouble(retObj.getFieldValueString(k,"ERD_PRICE"));				
				}		
								


				
				for(int k=0;k<retObjCount;++k)
				{
					String p=retObj.getFieldValueString(k,"ERD_PRICE");
					String c=(k)+"";				
					values.put(c,p);
				}				
				//out.println(values);
				for(int j=0;j<MaxQuotations+1;++j)
				{
					String index = new Integer(j).toString();
					Object obj = values.get(index);
					if(obj != null)
					{
						double d=Double.parseDouble((String)obj);
						dataarr[i][j] = d;
					}
					else
					{
						dataarr[i][j] = 0;
					}						
				}
			}	

			Paint[] paints= new Paint[materialVectorSize];
			Random r = new Random();
			for(int i=0;i<paints.length;++i)
			{
				paints[i] = new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255));
			}
			Stroke[] strokes = new Stroke[materialVectorSize];
			for(int l=0;l<materialVectorSize;++l)
			{
				strokes[l] = LineChartProperties.DEFAULT_LINE_STROKE;
			}	
			Shape[] shapes = new Shape[materialVectorSize]; 
			for(int m=0;m<materialVectorSize;++m)
			{
				shapes[m] = PointChartProperties.SHAPE_CIRCLE;
			}	
			LineChartProperties lineChartProperties = new LineChartProperties(strokes,shapes);
			AxisChartDataSet acds = new AxisChartDataSet(dataarr, legendLabels, paints,ChartType.LINE, lineChartProperties );
			dataSeries.addIAxisPlotDataSet(acds);	
			AxisChart axisChart = new AxisChart(dataSeries, chartProperties, axisProperties,legendProperties, 950, 660);
			
			
			
			ServletEncoderHelper.encodeJPEG13(axisChart, 1.0f, response);
		}
	}
	else if("RQPA".equals(report))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>Quotations Price Is Not Available For This Colletive RFQ NO</Th>
	</center>
<%
	}
	else if("MAQPH".equals(report))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>The Average Quotation Price History Not Available</Th>
	</center>
<%
	}
	else if("MPA".equals(report))
	{
%>	
	<BR><BR><BR><BR><BR>
	<center>
	<Th>Material Prices Not Available</Th>
	</center>
<%
	}
%>	

<Div id="MenuSol"></Div>
</body>
</html>