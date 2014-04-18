<%@include file="../../Library/Globals/errorPagePath.jsp"%>
<%@include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<%@ page import = "java.util.*"%>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@page import="ezc.ezadmin.ezadminutils.client.*,ezc.ezadmin.ezadminutils.params.*,ezc.ezparam.*,ezc.ezpreprocurement.client.*,ezc.ezpreprocurement.params.*"%>
<%@page import="org.jCharts.axisChart.AxisChart,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelPosition,org.jCharts.axisChart.customRenderers.axisValue.renderers.ValueLabelRenderer,org.jCharts.chartData.AxisChartDataSet,org.jCharts.chartData.DataSeries,org.jCharts.chartData.interfaces.IAxisDataSeries,org.jCharts.encoders.ServletEncoderHelper,org.jCharts.properties.*,org.jCharts.properties.util.ChartFont,org.jCharts.types.ChartType,java.awt.*"%>
<%
	int retObjCount = 0;
	int noOfMaterials = 0;
	EzcParams 		ezcParams 	= null;
	ReturnObjFromRetrieve 	retObj 		= null;		
	EzPreProcurementManager procurementManager = new EzPreProcurementManager();
	EziReportParams 	reportParams = new EziReportParams();
	Vector materials = new Vector();
	
	
	String reportType = request.getParameter("Report");
	String vendor = request.getParameter("Vendor");	
	reportParams.setCallPattern("REPORT");
	reportParams.setVendorCode(vendor);	
	reportParams.setReportType(reportType);
	
	ezcParams = new EzcParams(false);
	ezcParams.setLocalStore("Y");
	ezcParams.setObject(reportParams);
	Session.prepareParams(ezcParams);				
	retObj = (ReturnObjFromRetrieve)procurementManager.getReportData(ezcParams);
	
	System.out.println("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
	
	if(retObj!=null) 
	{
		retObjCount = retObj.getRowCount();
	}	

/*************************************************************
0 :: 0 Field Name : ERH_PO_NO ----> Field Value : 8000001275
0 :: 1 Field Name : ERH_PO_OR_CON ----> Field Value : C
0 :: 2 Field Name : ERD_MATERIAL ----> Field Value : 000000000003000368
0 :: 3 Field Name : ERD_MATERIAL_DESC ----> Field Value : N-BUTYL LITHIUM 15% IN HEXANE
0 :: 4 Field Name : ERD_PRICE ----> Field Value : 90000.00
0 :: 5 Field Name : ERD_QUANTITY ----> Field Value : 150.000
0 :: 6 Field Name : ERD_UOM ----> Field Value : KG
0 :: 7 Field Name : MAX_QPRICE ----> Field Value : 90000.00
0 :: 8 Field Name : MIN_QPRICE ----> Field Value : 90000.00
0 :: 9 Field Name : QUOTES ----> Field Value : 1
0 :: 10 Field Name : DELIVERY_DATE ----> Field Value : 29-05-2005                    
 ***************************************************************/

	if(retObjCount>0)
	{
		for(int i=0;i<retObjCount;++i)
		{
			String mat = retObj.getFieldValueString(i,"ERD_MATERIAL");
			if(!materials.contains(mat))
			materials.add(mat);
		}
		noOfMaterials = materials.size();					

		for(int k=0;k<noOfMaterials;++k)
		{
		String materialCode = (String)materials.get(k);		
%>
		<table id="tabHead" align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1  width="95%">
			<tr align="center" valign="middle">	    	        
				<th width="10%" rowspan=2>Material Code</th>
				<th width="18%" rowspan=2>Material Name</th>
				<th width="5%" rowspan=2>No Of Supplies</th>
				<th width="3%" rowspan=2>No Of Quotes</th>
				<th width="50%" colspan=4>Supply History</th>
				<th width="10%" rowspan=2>Min Price Quoted</th>
				<th width="10%" rowspan=2>Max Price Quoted</th>
				<th width="10%" rowspan=2><font color="#ff0000">Contract</font> / <font color="#0000ff"> PO </font>No</th>
			</tr>
			<tr>
				<th width="10%" >Quantity</th>
				<th width="8%" >Units</th>
				<th width="10%" >Price(in RS)</th>
				<th width="14%" >Delivery Date</th>	    	
			</tr>
	 	
<%			
			int supplyCounter =0;
			for(int i=0;i<retObjCount;++i)
			{
				String matCode = retObj.getFieldValueString(i,"ERD_MATERIAL");
				if(materialCode.equals(matCode))				
				{
%>
			<tr>
<%
					++supplyCounter;
					String matDesc = retObj.getFieldValueString(i,"ERD_MATERIAL_DESC");
					String price = retObj.getFieldValueString(i,"ERD_PRICE");
					String qty = retObj.getFieldValueString(i,"ERD_QUANTITY");
					String units = retObj.getFieldValueString(i,"ERD_UOM");
					String deliveryDate = retObj.getFieldValueString(i,"DELIVERY_DATE");
					String maxPrice = retObj.getFieldValueString(i,"MAX_QPRICE");
					String minPrice = retObj.getFieldValueString(i,"MIN_QPRICE");
					String noOfQuotes = retObj.getFieldValueString(i,"QUOTES");
					String conPoNo = retObj.getFieldValueString(i,"ERH_PO_NO");
					String conOrPo = retObj.getFieldValueString(i,"ERH_PO_OR_CON");
					if(conPoNo==null || "null".equals(conPoNo)) conPoNo="----";
%>
				<td width="10%"><%=Long.parseLong(matCode)%></td>
				<td width="18%"><%=matDesc%></td>
				<td width="5%"><%=supplyCounter+""%></td>
				<td width="3%"><%=noOfQuotes+""%></td>
				<td width="10%"><%=qty%></td>
				<td width="8%"><%=units%></td>
				<td width="10%"><%=price%></td>
				<td width="14%"><%=deliveryDate%></td>
				<td width="10%"><%=minPrice%></td>
				<td width="10%"><%=maxPrice%></td>
				<td width="10%">
<% 
				if("P".equals(conOrPo))
				{
%>					
					<font color="#ff0000"><%=conPoNo%></font>
<%
				}
				else if("C".equals(conOrPo))
				{
%>
					<font color="#0000ff"><%=conPoNo%></font>
<%
			        }
			        else 
			        {
 %>
					<font color="green"><%=conPoNo%></font>
<%
				}
%>
			        </td>
			</tr>
<%
				}
			}
%>
		</table>		
<%		
		}
	}
	else if("CVQH".equals(reportType))
	{
%>
	<BR><BR><BR><BR><BR>
	<center>
	<Th>There Are No Materials Supply History For This Vendor</Th>
	</center>
<%
	}	
%>
<Div id="MenuSol"></Div>