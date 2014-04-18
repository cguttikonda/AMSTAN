<html>
<head>


<script type="text/javascript">
 
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-35953021-1']);
  _gaq.push(['_setDomainName', 'myasb2b.com']);
  _gaq.push(["_set", "title", "ATP"]);
  _gaq.push(['_trackPageview']);
 
  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
  
  
function exportATP()
{	
	
	document.atpForm.action="ezExportATP.jsp";   	  		
	document.atpForm.target="_blank";
	document.atpForm.submit();       
}
 </script>
 </head>


<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>

<%
	
	String stAtpStr  = request.getParameter("stAtp");
		
	if("null".equals(stAtpStr) || stAtpStr==null)
		stAtpStr="";	
	
	String atpSTP	=   request.getParameter("selSoldTo");
	if(atpSTP==null || "null".equals(atpSTP))
		atpSTP=(String)session.getValue("AgentCode");
		
	String atpSHP	=   (String)session.getValue("ShipCode");
	String atpDiv  	=   (String)session.getValue("division");
	String atpDtc 	=   (String)session.getValue("dc");
	String atpSOr	=   (String)session.getValue("salesOrg");
		
	String atpion=request.getParameter("atpon");
		
	String atpForStr=request.getParameter("atpfor");
	int prdsLen =0;
	String selectedPrdsSplitArr[] = null;
	if(atpForStr!=null)
	{
		selectedPrdsSplitArr = atpForStr.split("§");
		prdsLen = selectedPrdsSplitArr.length;
	}
		
	
	//out.println(atpSHP+"---"+atpDiv+"---"+atpDtc+"---"+atpSOr+"---"+atpForStr+"---"+atpQtyStr);
	
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","PLANTDESC","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);
	
	HashMap zMatHM = new HashMap();
	String prodCodeStr = "";
	
	
	if(atpForStr!=null && !"null".equals(atpForStr) && !"".equals(atpForStr))
	{				

		DateFormat formatter1;
		Date DateFrom = new Date();
		formatter1 = new SimpleDateFormat("MM/dd/yyyy");

		DateFrom = (Date)formatter1.parse(atpion); 

		JCO.Client client=null;
		JCO.Function functionEx = null;	
		
		String site_S = (String)session.getValue("Site");
		String skey_S = "998";
		
		try
		{
			functionEx 		  = EzSAPHandler.getFunction("Z_EZ_GET_MATERIAL_AVAILABILITY",site_S+"~"+skey_S);
			JCO.ParameterList atpProc = functionEx.getImportParameterList();
			JCO.Table zMat 		  = functionEx.getTableParameterList().getTable("ZMATERIAL");

			atpProc.setValue(atpSOr,"SALES_ORGANIZATION");
			atpProc.setValue(atpDtc,"DISTRI_CHANNEL");
			atpProc.setValue(atpDiv,"DIVISON");
			
			atpProc.setValue(atpSTP,"KUNNR");
			atpProc.setValue(atpSHP,"KUNWE");
			atpProc.setValue(stAtpStr,"REGIO");
			
			/*atpProc.setValue("","KUNNR");
			atpProc.setValue("","KUNWE");
			atpProc.setValue("*","REGIO");*/
			
			
			
			if(prdsLen>0)
			{
				for(int i=0;i<prdsLen;i++)
				{
					String prodCode  =  selectedPrdsSplitArr[i].split("¥")[0];
					String prodQty   =  selectedPrdsSplitArr[i].split("¥")[1];										
					
					zMat.appendRow();
					zMat.setValue(prodCode,"MATERIAL");
					zMat.setValue(DateFrom,"REQ_DATE");
					zMat.setValue(prodQty,"REQ_QTY");
				}
			}			
						
			ezc.ezcommon.EzLog4j.log("ATP::JCO:::ALL:::TEST::START","F");

			try
			{
				client = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);				
				client.execute(functionEx);
				
			}
			catch(Exception ec)
			{
				out.println(":::::::::::::::::::ec::::::::::::::::::::"+ec);
			}

			JCO.Table atpResultTable = functionEx.getTableParameterList().getTable("RESULT");
			JCO.Table atpZMatTable 	 = functionEx.getTableParameterList().getTable("ZMATERIAL");
			
			ezc.ezcommon.EzLog4j.log("ATP::JCO:::ALL:::TEST::END","F");
			
			if(atpResultTable!=null)
			{				
				if (atpResultTable.getNumRows() > 0)
				{	
					
					do
					{						
						atpResultRet.setFieldValue("MATERIAL",atpResultTable.getValue("MATERIAL"));
						
						String prodCode = (String)atpResultTable.getValue("MATERIAL");
						
						if("".equals(prodCodeStr))
							prodCodeStr = prodCode;
						else
							prodCodeStr = prodCodeStr+"','"+prodCode;
						
						atpResultRet.setFieldValue("MATERIALDESC",atpResultTable.getValue("MFRPN"));
						atpResultRet.setFieldValue("AVAILQTY",atpResultTable.getValue("AVAIL_QTY"));
						atpResultRet.setFieldValue("PLANT",atpResultTable.getValue("PLANT"));	
						atpResultRet.setFieldValue("PLANTDESC",atpResultTable.getValue("PLANTDESC"));	
						atpResultRet.setFieldValue("STATUS",atpResultTable.getValue("STATUS"));											
						atpResultRet.setFieldValue("UPC",atpResultTable.getValue("EAN11"));	
						atpResultRet.setFieldValue("ENDLEADTIME",atpResultTable.getValue("ENDLEADTME"));	
						atpResultRet.addRow();  
					}
					while(atpResultTable.nextRow());
				}
			}
			
			if(atpZMatTable!=null)
			{				
				if (atpZMatTable.getNumRows() > 0)
				{					
					do
					{	
						int varHM = 1;
						String material = (String)atpZMatTable.getValue("MATERIAL");
						
						
						atpZMaterialRet.setFieldValue("MATERIAL",atpZMatTable.getValue("MATERIAL"));
						atpZMaterialRet.setFieldValue("REQQTY",atpZMatTable.getValue("REQ_QTY"));											
						atpZMaterialRet.addRow();
						
						zMatHM.put(atpZMatTable.getValue("MATERIAL"),atpZMatTable.getValue("REQ_QTY"));
					}
					while(atpZMatTable.nextRow());
				}
			}
		}
		catch(Exception e)
		{
			out.println("EXCEPTION>>>>>>"+e);
		}
		finally
		{
			if (client!=null)
			{
				JCO.releaseClient(client);
				client = null;
				functionEx=null;
			}
		}
		
		
	}
%>



<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>

<%!
public String eliminateDecimals(String myStr)
{
	String remainder = "";
	if(myStr.indexOf(".")!=-1)
	{
		remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
		myStr = myStr.substring(0,myStr.indexOf("."));
	}
	return myStr;
}
%>

<body>
<form name="atpForm">

<h2>Product Availability Check</h2> 

<a href="JavaScript:exportATP()">Export to MS Excel</a>


</div>

<br>


	<table class="data-table" id="quickatp">
	<thead>
	<tr width='90%'>
		<td width=10%>Availability</td>
		<td width=15%>Material#</td>
		<td width=20%>Material Desc</td>
		
		<td width=5%>Qty</td>
		<td width=5%>EAN/UPC</td>				 
		<td width=5%>List Price(USD)</td>
		<!--<td width=5%>Plant<br>Plant Desc</td>-->
		<td width=5%>Luxury (Y/N)</td>
		<td width=5%>Kit/Combo (Y/N)</td>
		<td width=5%>Points</td>
		<td width=5%>Product<br>Status</td>
		
	</tr>
	</thead>
	<tbody>
	
<%	
	ezc.ezcommon.EzLog4j.log("ATP:::ALL:IN::FOR::TEST::START","F");
		ReturnObjFromRetrieve retAtpLocalDB = null;
		int cntAtpDB=0;	
		EzcParams mainParamsAtp = new EzcParams(false);
		EziMiscParams miscParamsAtp = new EziMiscParams();
		miscParamsAtp.setIdenKey("MISC_SELECT");
		String query="SELECT EZP_PRODUCT_CODE,EZP_TYPE,EZP_STATUS,EZP_LUXURY,EZP_CURR_PRICE,EZP_VOLUME,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EZP_PRODUCT_CODE=EPA_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+prodCodeStr+"') AND EPA_ATTR_CODE IN ('DCH_STATUS','DIVISION','PROD_HIERARCHY1','ITEM_CAT_GROUP')";
		miscParamsAtp.setQuery(query);
		mainParamsAtp.setLocalStore("Y");
		mainParamsAtp.setObject(miscParamsAtp);
		Session.prepareParams(mainParamsAtp);	
		try{	retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
			cntAtpDB=retAtpLocalDB.getRowCount();}
		catch(Exception e){out.println("Exception in Getting Data"+e);}
			
			
		for(int a=0;a<atpResultRet.getRowCount();a++)
		{
		
		String atpRetMat   = atpResultRet.getFieldValueString(a,"MATERIAL");
		String atpRetQty   = atpResultRet.getFieldValueString(a,"AVAILQTY");
		String atpStat     = atpResultRet.getFieldValueString(a,"STATUS");
		String atpPlant    = atpResultRet.getFieldValueString(a,"PLANT");
		String plantDes    = atpResultRet.getFieldValueString(a,"PLANTDESC");		
		String atpMatDesc  = atpResultRet.getFieldValueString(a,"MATERIALDESC");
		String atpUPC      = atpResultRet.getFieldValueString(a,"UPC");
		Date endLeadTime   = (Date)atpResultRet.getFieldValue(a,"ENDLEADTIME");
		
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		String endLeadStr ="";
		String endLeadRem ="";
		String endLeadRem1 ="";
		
		try{
		endLeadStr = formatter.format(endLeadTime);
		
		}catch(Exception e){}
		
		Set keys = zMatHM.keySet();
		
	    	for (Iterator i = keys.iterator(); i.hasNext();)
	    	{
		String key = (String) i.next();
		Object value = (Object) zMatHM.get(key);
		//out.println(key + " = " + value);
   		}
		
		
		
		String atpReqQty="",atpAvail="",listPrice="",points="",kitCombo="",prodStatus="",luxury="N";
		
		if(atpMatDesc==null || "null".equals(atpMatDesc))
			atpMatDesc="";
		if(atpUPC==null || "null".equals(atpUPC))
			atpUPC="";
			
		if(atpRetMat==null || "null".equals(atpRetMat))
			atpRetMat="";			
					
		if(zMatHM.size()>0 && !"".equals(atpRetMat))
			atpReqQty = (String)zMatHM.get(atpRetMat);
							
				
		if(atpRetQty==null || "null".equals(atpRetQty) || "0".equals(atpRetQty))
			atpRetQty="";
			
		if(atpReqQty==null || "null".equals(atpReqQty))
			atpReqQty="";	
											
		
		int reqQtyInt=0,retQtyInt=0;
		
		if(atpReqQty!=null && !"null".equals(atpReqQty) && !"".equals(atpReqQty))
		{
			atpReqQty=eliminateDecimals(atpReqQty);	
			reqQtyInt=Integer.parseInt(atpReqQty);
			
		}
		
		if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
		{
			atpRetQty=eliminateDecimals(atpRetQty);
			retQtyInt=Integer.parseInt(atpRetQty);
			
		}
													
		if(retAtpLocalDB != null  && cntAtpDB>0)
		{															
			for(int ad=0;ad<cntAtpDB;ad++)
			{
				if(atpRetMat.equals(retAtpLocalDB.getFieldValueString(ad,"EZP_PRODUCT_CODE")))
				{
				listPrice="0";
				points="0";
				String comboType = retAtpLocalDB.getFieldValueString(ad,"EZP_TYPE");
				prodStatus 	 = retAtpLocalDB.getFieldValueString(ad,"EZP_STATUS");
				luxury 		 = retAtpLocalDB.getFieldValueString(ad,"EZP_LUXURY");
				listPrice 	 = retAtpLocalDB.getFieldValueString(ad,"EZP_CURR_PRICE");
				points	  	 = retAtpLocalDB.getFieldValueString(ad,"EZP_VOLUME");

				try
				{
					listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				}
				catch(Exception e){}

				if(listPrice==null || "null".equals(listPrice))
					listPrice="0";



				ReturnObjFromRetrieve prodDetailsRetRelComp = null;
				//if("KI".equals(comboType) || "LUMF".equals(kitCombo) || "ZERL".equals(kitCombo) || "ZLMF".equals(kitCombo))
				if("KI".equals(comboType))
				{
					kitCombo="Y";
					EzcParams prodParamsMiscComp = new EzcParams(false);
					EziMiscParams prodParamsComp = new EziMiscParams();

					prodParamsComp.setIdenKey("MISC_SELECT");
					String queryComp="SELECT EZP_VOLUME from EZC_PRODUCTS,EZC_PRODUCT_RELATIONS WHERE EZP_PRODUCT_CODE = EPR_PRODUCT_CODE2 AND  EPR_PRODUCT_CODE1='"+atpRetMat+"'  AND EPR_RELATION_TYPE='SBOM'";							
					prodParamsComp.setQuery(queryComp);
					prodParamsMiscComp.setLocalStore("Y");
					prodParamsMiscComp.setObject(prodParamsComp);
					Session.prepareParams(prodParamsMiscComp);	

					try
					{
						prodDetailsRetRelComp = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(prodParamsMiscComp);
					}
					catch(Exception e){}

					for(int i=0;i<prodDetailsRetRelComp.getRowCount();i++)
					{
						try 
						{
							points = new java.math.BigDecimal(points).add(new java.math.BigDecimal(prodDetailsRetRelComp.getFieldValueString(i,"EZP_VOLUME"))).setScale(3,java.math.BigDecimal.ROUND_HALF_UP).toString();
						}
						catch(Exception e){}
						
						//out.println("points:::"+points);
					}
				}
				else
				{
					kitCombo="N";
				}

				//if("DCH_STATUS".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
				{
					if("Z3".equals(prodStatus) || "Z2".equals(prodStatus) || "Z4".equals(prodStatus))
						prodStatus="Discontinued";
					else if("ZM".equals(prodStatus))
						prodStatus="Modification - Contact Customer Care for Ordering";
					else if("ZP".equals(prodStatus))
						prodStatus="Production Hold - ordering is impermissible";
					else if("ZF".equals(prodStatus))
						prodStatus="To Be Discontinued";
					else if("11".equals(prodStatus))
						prodStatus="New";
					else
						prodStatus="Active";
				}


				if("Y".equals(luxury))																									
					luxury="Y";							
				else
					luxury="N";															


				}
			}
		}
		if(retQtyInt>=reqQtyInt)
		{
			atpAvail = "Fully Available";
			endLeadStr="";
		}
		else if(retQtyInt>0 && retQtyInt<reqQtyInt)
		{
			atpAvail = "Partially Available";
			endLeadRem = "Remainder on ";
		}
		else 
		{
			atpAvail = "";
			endLeadRem = "Earliest availability after ";
			atpRetQty = "Not Available";
		}

		if("Search".equals(atpRetMat))
		{
			atpRetMat="";
			atpReqQty="";
			atpAvail="";
			prodStatus="";
		}
		
		
		if("".equals(endLeadStr))
			endLeadRem = "";
			
%>
	<tr>
		
		<td width=30%><p><%=atpRetQty%>&nbsp;&nbsp;<%=atpAvail%><br><%=endLeadRem%><%=endLeadStr%></p></td>
		<td width=15%><%=atpRetMat%></td>
		<td width=20%><p><%=atpMatDesc%></p></td>		
		<td width=5%><%=atpReqQty%></td>
		<td width=5%><p><%=atpUPC%></p></td>
		
		<td width=5%><p><%=listPrice%></p></td>		
		<!--<td width=5%><p><%=atpPlant%><br><%=plantDes%></p></td>-->
		<td width=5%><p><%=luxury%></p></td>
		<td width=5%><p><%=kitCombo%></p></td>
		<td width=5%><p><%=points%></p></td>
		<td width=5%><p><%=prodStatus%></p></td>
		
		

	</tr>
<%	
	
	}
	ezc.ezcommon.EzLog4j.log("ATP:::ALL:IN::FOR::TEST::END","F");
%>
	</tbody>
	</table>




</form>
</body>
</html>


