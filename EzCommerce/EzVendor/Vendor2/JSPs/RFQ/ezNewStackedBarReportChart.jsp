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
<%
	String graphType = request.getParameter("GraphType");
	if("".equals(graphType)||"null".equals(graphType)|| graphType==null )
		graphType="3DBar";
	
	
	int retObjCount = 0;
	int MaxQuotations = 2;
	String  StdXResolution = "980";
	String  StdYResolution = "600";
	
	String report = null,selectedMaterial = null,selectedTime = null;
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
	graphParams.setXResolution("980");
	graphParams.setYResolution("600");

	/*
	graphParams.setIsIntervalMarker(true);
	graphParams.setIsValueMarker(false);
	graphParams.setMarkerLabel("Target Range");
	graphParams.setMarkerRange1("200");
	graphParams.setMarkerRange2("900"); 

	*/
	
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
		
	if (retObj != null)
	{
		int offset =0;
		retObjCount = retObj.getRowCount();
		int offsetcount =30;

		if(retObjCount>10)
		{
			
			offset = (retObjCount-10);
			StdXResolution = (Integer.parseInt(StdXResolution)+(offset*80))+"";
			

		}

	}
		
		
	if("MVQPH".equals(report))
	{
		retObjCount =0;
	}
		
	if(retObjCount>0)
	{
		
		if("MMMP".equals(report))
		{

			xAxisTitle= "VENDORS";
			yAxisTitle= "PRICES";
			title= "Vendor Material-Price Analysis";
			
			for(int i=0;i<retObjCount;++i)
			{
				label = retObj.getFieldValueString(i,"ERH_SOLD_TO");
				
				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"MAX"),i);
				retbuild.setFieldValueAt("XKEY",label,i);
				
				retbuilddiff.addRow();
				retbuilddiff.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"MIN"),i);
				retbuilddiff.setFieldValueAt("XKEY",label,i);
									
			}
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Maximum ",0);
			
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuilddiff,1);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS"," Minimum ",1);
			
		}
		else if("MVQPH".equals(report))
		{
			/*xAxisTitle= "VENDORS";
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
			}*/
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
			
			for(int i=0;i<retObjCount;++i)
			{
								
				label = retObj.getFieldValueString(i,"ERH_SOLD_TO");
								
				retbuild.addRow();
				retbuild.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"NUMBER_OF_REQUESTS"),i);
				retbuild.setFieldValueAt("XKEY",label,i);

				retbuilddiff.addRow();
				retbuilddiff.setFieldValueAt("YKEY",retObj.getFieldValueString(i,"NUMBER_OF_RESPONSES"),i);
				retbuilddiff.setFieldValueAt("XKEY",label,i);
				
			}
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuild,0);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS","Quotation-Requests ",0);
						
			dataSetsRet.addRow();
			dataSetsRet.setFieldValueAt("SERIES",retbuilddiff,1);
			dataSetsRet.setFieldValueAt("LEGEND_LABELS","Quotation-Responses ",1);
			
			

		}

		//out.println("StdXResolution :::"+StdXResolution);
		graphParams.setXResolution(StdXResolution);
		graphParams.setYResolution(StdYResolution);
		graphParams.setChartTitle(title);
		graphParams.setDomainAxisLabel(xAxisTitle);
		graphParams.setRangeAxisLabel(yAxisTitle);

		ezc.ezparam.EzcParams graphmainParams = new ezc.ezparam.EzcParams(false);
		graphmainParams.setObject(graphParams);

		String filename = EzChartGenerator.generateChart(graphType,dataSetsRet,graphmainParams,session, new PrintWriter(out));
		String graphURL1 = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;
%>
		<!--<img src="<%= graphURL1 %>" width=<%=StdXResolution %> height=600 border=0 align="center" usemap="#<%= filename %>">-->
		<html>
				<head>
				<link rel="stylesheet" href="../../../../..Library/Styles/ezThemeGreen.css">
				<title> Graphs </title>
				<Script>
				function funSelect()
				{
					var graphtype="";
					graphtype = document.myForm.GraphType.value;
					//document.myForm.action ="ezChart.jsp"
					document.myForm.submit();
				}
				function funLoad()
				{
					var graphtype="<%=graphType%>";
					document.myForm.GraphType.value=graphtype;
					
				}
				</Script>
				</head>
				<body onLoad="funLoad()">
				<form name="myForm" >
				
					<table width="50%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
						
							  <Th width="40%" align="left">Select Graph Type :</Th>	
							  <td width="60%">
							  	<select name="GraphType" style="width:100%" id="" onChange="javaScript:funSelect()">
									<option value="">-Select Graph Type-</option>
									<option value="3DBar">3DBar</option>
									<option value="Bar">Bar</option>
									<option value="StackedBar">StackedBar</option>
									<option value="Pie">Pie</option>
									<option value="3DPie">3DPie</option>
									<option value="MultiplePie">MultiplePie</option>
									<option value="Area">Area</option>
									<option value="StackedArea">StackedArea</option>
									<option value="Line">Line</option>
									<option value="Line3D">Line3D</option>
									
									
								</select>
							  </td>
							
					</table>
					
					<table  id="tabHead1" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
					<td  width="100%" align="center" class="displayheader">
					<img src="<%= graphURL1 %>" width=<%=StdXResolution%> height=600 border=0 align="center" usemap="#<%= filename %>">
					</td>
					</table>
					
					<input type="hidden" name="selGraph" value="" >
					<input type="hidden" name="Report" value='<%=report%>' >
					<input type="hidden" name="TimePeriod" value='<%=selectedTime%>' >
					<input type="hidden" name="Material" value='<%=selectedMaterial%>' >
						
				</form>	
				</body>
				</html>
		
<%	
	

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