<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>

<%@ page import = "ezc.ezchart.EzChartGenerator" %>
<%@ page import = "ezc.ezchart.params.*" %>

<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.text.ParseException" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.Locale" %>
<%@ page import = "java.util.*" %>

<%
	int offset =0;
	int offsetcount =0 ;
	int retObjCount = 0;
	int MaxQuotations = 0;
	String  StdXResolution = "980";
	String  StdYResolution = "600";

	String xAxisTitle = null;
	String yAxisTitle = null;
	String title = null;
	String  url= null;
	String label = null;

	String s1[] = {"XKEY","YKEY"};
	ezc.ezparam.ReturnObjFromRetrieve retbuild = new ezc.ezparam.ReturnObjFromRetrieve(s1);
	ezc.ezparam.ReturnObjFromRetrieve retbuilddiff = new ezc.ezparam.ReturnObjFromRetrieve(s1);

	String dataseries[] = {"SERIES","LEGEND_LABELS"};
	ezc.ezparam.ReturnObjFromRetrieve dataSetsRet = new ezc.ezparam.ReturnObjFromRetrieve(dataseries);

	EzGraphParams graphParams = new EzGraphParams();

	/*
	graphParams.setChartTitle("CHART TITLE");
	graphParams.setDomainAxisLabel("XAXIS-LABEL");
	graphParams.setRangeAxisLabel("YAXIS-LABEL");
	graphParams.setURL("../Purorder/ezListPOs.jsp?OrderType=All");

	*/

	graphParams.setIsUrls(false);
	graphParams.setIsLegend(true);
	graphParams.setIsToolTips(true);
	graphParams.setPlotOrientation("VERTICAL");
	graphParams.setLabelRotation("2.3");
	graphParams.setBarWidth("0.03");
	graphParams.setBackgroundPaint("White");
	

	/*
	graphParams.setIsIntervalMarker(true);
	graphParams.setIsValueMarker(false);
	graphParams.setMarkerLabel("Target Range");
	graphParams.setMarkerRange1("200");
	graphParams.setMarkerRange2("900"); 

	*/

	double MaxPrice = 0;	
	double[] data = null;
	String[] labels = null;
	double dataarr[][] = null;	
	String report = null,selectedRfq = null,selectedTime = null,selectedMat= null,matDesc=null;	

	String[] legendLabels = null;
	String[] xAxisLabels =null; 

	EzcParams ezcParams = null;
	ReturnObjFromRetrieve retObj = null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams reportParams = new EziReportParams();		
	
	report = request.getParameter("Report");	
		
	if("RQPA".equals(report))
	{
		selectedRfq = request.getParameter("CollectiveRfq");		
		reportParams.setCollectiveRfq(selectedRfq);	
	}
	else if("MAQPH".equals(report))
	{
		selectedTime = request.getParameter("TimePeriod");
		//out.println(selectedTime);
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
	matDesc = request.getParameter("MatDesc");
	if(matDesc==null)
	{
		matDesc = "";
	}
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
		//out.println("retObjCount::"+retObjCount);

		
	}
	if(retObjCount>0)
	{
	
		//LineChart Delcarations
		
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
				System.out.println("Maximum Price Is  "+MaxPrice);
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
			
			
			int vendorVectorSize = vendors.size();	
			offsetcount = vendorVectorSize;
						
			for(int i=0;i<vendorVectorSize;++i)
			{
				int  chkflag = 0;
				Hashtable values = new Hashtable();
				String vendor = (String)vendors.get(i);
				retbuild = new ezc.ezparam.ReturnObjFromRetrieve(s1);
				
				for(int k=0;k<retObjCount;++k)
				{
					String v=retObj.getFieldValueString(k,"ERH_SOLD_TO");
					if(vendor.equals(v))
					{						
						String p=retObj.getFieldValueString(k,"ERD_PRICE");
						String c=retObj.getFieldValueString(k,"ERD_COUNTER");				
						values.put(c,p);
						
						retbuild.setFieldValue("YKEY",p);
						retbuild.setFieldValue("XKEY","Q"+(Integer.parseInt(c)+1));
						retbuild.addRow();
												
						chkflag = chkflag+1;
					}			
				}
				if(chkflag>0)
				{
									
					dataSetsRet.setFieldValue("SERIES",retbuild);
					dataSetsRet.setFieldValue("LEGEND_LABELS",Long.parseLong(vendor)+"");
					dataSetsRet.addRow();
				}
				
			}	
			
		}
		else if("MAQPH".equals(report))
		{
			
			Vector materials = null;
			
			
			
			String[] field = {"ERD_COUNTER"};
			retObj.sort(field,true);																					
			MaxQuotations = Integer.parseInt(retObj.getFieldValueString(0,"ERD_COUNTER"));											
			
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
						
			int materialVectorSize = materials.size();
			offsetcount = materialVectorSize;
								
			for(int i=0;i<materialVectorSize;++i)
			{
				int  chkflag = 0;
				Hashtable values = new Hashtable();
				String material = (String)materials.get(i);
				retbuild = new ezc.ezparam.ReturnObjFromRetrieve(s1);
				for(int k=0;k<retObjCount;++k)
				{
					
					String v=retObj.getFieldValueString(k,"ERD_MATERIAL");
					if(material.equals(v))
					{						
						
						String p=Double.parseDouble(retObj.getFieldValueString(k,"AVG_PRICE"))+"";
						String c="Q"+retObj.getFieldValueString(k,"ERD_COUNTER");				
						
											
						retbuild.setFieldValue("YKEY",p);
						retbuild.setFieldValue("XKEY",c);
						retbuild.addRow();
						
						chkflag = chkflag+1;
						
					}
					
					
					
				}
				if(chkflag>0)
				{
					
					dataSetsRet.setFieldValue("SERIES",retbuild);
					dataSetsRet.setFieldValue("LEGEND_LABELS",Long.parseLong(material)+"");
					dataSetsRet.addRow();
				}	
							
			}

				
		}
		else if("MPA".equals(report))
		{
						
			title = "Material Price Analysis  "+matDesc+" ("+Long.parseLong(selectedMat)+")";
			xAxisTitle = "RFQ";
			yAxisTitle = "Price";
			//9 :: 0 Field Name : ERH_PO_NO ----> Field Value : 4500011261
			//9 :: 1 Field Name : ERH_RFQ_NO ----> Field Value : 6000104425
			//9 :: 2 Field Name : ERH_COLLETIVE_RFQ_NO ----> Field Value : 1000000015
			//9 :: 3 Field Name : ERH_SOLD_TO ----> Field Value : 1100000058
			//9 :: 4 Field Name : ERD_COUNTER ----> Field Value : 1
			//9 :: 5 Field Name : ERD_PRICE ----> Field Value : 11223.00

			String[] field = {"ERH_RFQ_NO"};
			retObj.sort(field,true);
			offsetcount = retObjCount;			
			for(int i=0;i<retObjCount;++i)
			{
				label = i+1+"";

				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",Double.parseDouble(retObj.getFieldValueString(i,"ERD_PRICE"))+"",i);
				retbuild.setFieldValueAt("XKEY",label,i);
								
			}
				
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS",matDesc+"("+Long.parseLong(selectedMat)+")",0);
			
			
		}
		if(offsetcount>13)
		{
			offset = (offsetcount-13);
			StdXResolution = (Integer.parseInt(StdXResolution)+(offset*30))+"";
			//out.println("StdXResolution :::"+StdXResolution);
					
		}
		graphParams.setChartTitle(title);
		graphParams.setDomainAxisLabel(xAxisTitle);
		graphParams.setRangeAxisLabel(yAxisTitle);
		graphParams.setXResolution(StdXResolution);
		graphParams.setYResolution(StdYResolution);

		ezc.ezparam.EzcParams graphmainParams = new ezc.ezparam.EzcParams(false);
		graphmainParams.setObject(graphParams);

		String filename = EzChartGenerator.generateChart("Line",dataSetsRet,graphmainParams,session, new PrintWriter(out));
		String graphURL1 = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
%>
		<img src="<%= graphURL1 %>" width=<%= StdXResolution %> height=600 border=0 align="center" usemap="#<%= filename %>">
<%	
	
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


<html>
<head>
	<Title>Material Price Analysis Report---Powered by Answerthink(India)Ltd.</Title>
</head>
<Div id="MenuSol"></Div>
</html>