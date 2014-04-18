<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@ page import="java.awt.*,org.jCharts.*,org.jCharts.chartData.*,org.jCharts.properties.*,org.jCharts.types.ChartType,org.jCharts.axisChart.*,org.jCharts.test.TestDataGenerator,org.jCharts.encoders.JPEGEncoder13,org.jCharts.properties.util.ChartFont,org.jCharts.encoders.ServletEncoderHelper"%>
<%

	int retObjCount = 0;	
	int MaxQuotations = 0;
	int numberOfMaterials = 0;
	double MaxPrice = 0;
	double[] data = null;
	String[] labels = null;
	String selectedReportType = null,selectedTime = null;	
	Vector materials = null;
	Hashtable materialQuotes = null;
	EzcParams ezcParams = null;

	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();	
	
	String status = request.getParameter("status");	
	String timePeriod = request.getParameter("TimePeriod");	
	
	out.println("STATUS - "+status);
	out.println("TIMEPERIOD - "+timePeriod);
	
	if("MAPQH".equals(status))
	{
		selectedTime = request.getParameter("TimePeriod");			
	}
		
	if(selectedTime!=null)
	{		
		
		if("MAPQH".equals(status))
		{
			reportParams.setCallPattern("REPORT");
			reportParams.setReportType(status);
			reportParams.setTimePeriod(timePeriod);	
		}
		ezcParams = new EzcParams(false);
		ezcParams.setLocalStore("Y");
		ezcParams.setObject(reportParams);
		Session.prepareParams(ezcParams);
				
		retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);		
		
		if (retObj != null)
		{			
			retObjCount = retObj.getRowCount();			
			materials = new Vector();						
			materialQuotes = new Hashtable();
			
			/*******Preapring The Final Return Object - START ***********/
			for(int i=0;i<retObjCount;++i)
			{
				String mat = retObj.getFieldValueString(i,"ERD_MATERIAL");
				if(!materials.contains(mat))
				materials.add(mat);
			}
			
			numberOfMaterials = materials.size();
			for(int k=0;k<numberOfMaterials;++k)
			{
				String material = (String)materials.get(k);
				
				for(int i=0;i<retObjCount;++i)
				{
					String temp = retObj.getFieldValueString(i,"ERD_MATERIAL");
					if (material.equals(temp))
					{
						Object obj = materialQuotes.get(material);
						if(obj==null)
						{
							String str = retObj.getFieldValueString(i,"ERD_COUNTER");
							materialQuotes.put(material,str);
						}
						else
						{
							int new_no = Integer.parseInt(retObj.getFieldValueString(i,"ERD_COUNTER"));
							int old_no = Integer.parseInt((String)materialQuotes.get(material));
							if(new_no>old_no)
							materialQuotes.put(material,retObj.getFieldValueString(i,"ERD_COUNTER"));							
						}
					}
				}
			}
			out.println("<BR>Material Quotations----->"+materialQuotes+"<br>");
			
			Enumeration enum = materialQuotes.elements();
			int max = 0;
			
			while(enum.hasMoreElements())
			{
				String s = (String)enum.nextElement();
				int k = Integer.parseInt(s);
				if(max<k)
				max = k;
			}
			MaxQuotations = max;
			
			out.println("<br>Maximum Number Of Quotations - "+MaxQuotations);
			
			/*******Preapring The Final Return Object - END ***********/
			
		}
		
	}
	
	
%>
 