<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
<div class="page-title">
<%@ include file="../../../Includes/JSPs/Misc/iCheckATPCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
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

<html>
<head>
<script type="text/javascript" >

function resetForm()
{
   document.getElementById("userForm").reset();
} 
function closeForm()
{
   window.close();
} 

</script>
</head>

<body scroll=no>
<form name="ifForm" id="userForm" action="">

<h2>Product Availability Check</h2> 	
</div>

<div class="col1-set">
<div class="info-box">

<ul class="form-list">

<!--<li>
	<label for="soldtoname">Company Name:</label>
	<div class="select-box">

	<select name="selSoldTo">
<%
	if(soldTosSesGet!=null)
	{
		for(int i=0;i<soldTosSesGet.getRowCount();i++)
		{
			String soldToCode_A 	= soldTosSesGet.getFieldValueString(i,"EC_ERP_CUST_NO");
			String soldToName_A 	= soldTosSesGet.getFieldValueString(i,"ECA_NAME");

			String selected_A = "selected";

			if(atpSTP.equals(soldToCode_A))
			{
%>				
				<option value="<%=soldToCode_A%>" <%=selected_A%>><%=soldToCode_A%> - <%=soldToName_A%></option>
<%			}
			else
			{
%>	
				<option value="<%=soldToCode_A%>" ><%=soldToCode_A%> - <%=soldToName_A%></option>
<%
			}
		}
	}
%>
	</select>
	</div>
</li>

<li>
	<label for="soldtoname">Ship-to State:</label>
	<div class="select-box">
	<select name="stAtp">
<%
	if(statesSesGet!=null)
	{
		for(int i=0;i<statesSesGet.getRowCount();i++)
		{
			String shipToStateCode 	= statesSesGet.getFieldValueString(i,"STATECODE");
			String shipToStateName 	= statesSesGet.getFieldValueString(i,"STATENAME");

			String selected_A = "selected";

			if(stAtpStr.equals(shipToStateCode))
			{
%>				
				<option value="<%=shipToStateCode%>" <%=selected_A%>><%=shipToStateName%></option>
<%			}
			else
			{
%>	
				<option value="<%=shipToStateCode%>" ><%=shipToStateName%></option>
<%
			}
		}
	}
%>
	</select>
	</div>
</li>
<li>
<label for="date">When ?:</label>
<input type="text" size="12" id="atpon" name="atpon" value="<%=atpion%>" readonly /><%=getDateImage("atpon")%>
</li>-->
</ul>

<!--<p>Please enter ASB Material Code below.</p>
<p>For Material#, use the format 2709048C.xxx(xxx is the 3 digits color/finish code)</p>-->

	<table class="data-table" id="quickatp">
	<thead>
	<tr>
		<td width=20%>Material#</td>
		<td width=5%>Qty</td>
		<td width=15%>EAN/UPC</td>		
		<td width=25%>Material Desc</td>
		<td width=10%>List Price(USD)</td>
		<td width=5%>Luxury (Y/N)</td>
		<td width=5%>Kit/Combo (Y/N)</td>
		<td width=5%>Points</td>
		<td width=10%>Product Status</td>
		<td width=10%>Availability</td>
	</tr>
	</thead>
	<tbody>
<%	for(int a=0;a<prdsLen;a++)
	{
		
		String atpRetMat   = atpResultRet.getFieldValueString(a,"MATERIAL");
		String atpRetQty   = atpResultRet.getFieldValueString(a,"AVAILQTY");
		String atpStat     = atpResultRet.getFieldValueString(a,"STATUS");
		String atpPlant    = atpResultRet.getFieldValueString(a,"PLANT");
		String atpMatDesc  = atpResultRet.getFieldValueString(a,"MATERIALDESC");
		String atpUPC      = atpResultRet.getFieldValueString(a,"UPC");
		Date endLeadTime   = (Date)atpResultRet.getFieldValue(a,"ENDLEADTIME");
		
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		String endLeadStr ="";
		
		try{
		endLeadStr = formatter.format(endLeadTime);
		
		}catch(Exception e){}
		
		
		
		String atpReqQty="",atpAvail="",listPrice="",points="",kitCombo="",prodStatus="",luxury="";
		
		if(zMatHM.size()>0)
			atpReqQty = (String)zMatHM.get(atpRetMat);
							
		if(atpRetMat==null || "null".equals(atpRetMat) || "1234".equals(atpRetMat))
			atpRetMat="";
		
		if(atpRetQty==null || "null".equals(atpRetQty) || "0".equals(atpRetQty))
			atpRetQty="";
			
		if(atpReqQty==null || "null".equals(atpReqQty) || "".equals(atpRetMat))
			atpReqQty="";
			
		if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
			atpRetQty=eliminateDecimals(atpRetQty);
			
		if(atpReqQty!=null && !"null".equals(atpReqQty) && !"".equals(atpReqQty))
			atpReqQty=eliminateDecimals(atpReqQty);					
		
		if(atpMatDesc==null || "null".equals(atpMatDesc))
			atpMatDesc="";
		if(atpUPC==null || "null".equals(atpUPC))
			atpUPC="";
			
		int reqQtyInt=0,retQtyInt=0;
		
		if(atpReqQty!=null && !"null".equals(atpReqQty) && !"".equals(atpReqQty))
			reqQtyInt=Integer.parseInt(atpReqQty);
		
		if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
			retQtyInt=Integer.parseInt(atpRetQty);

		if(atpRetMat!=null && !"null".equals(atpRetMat) && !"1234".equals(atpRetMat) && !"".equals(atpRetMat))
		{		
			ReturnObjFromRetrieve retAtpLocalDB = null;
			int cntAtpDB=0;	
			EzcParams mainParamsAtp = new EzcParams(false);
			EziMiscParams miscParamsAtp = new EziMiscParams();
			miscParamsAtp.setIdenKey("MISC_SELECT");
			String query="SELECT EZP_PRODUCT_CODE,EZP_CURR_PRICE,EZP_VOLUME,EPA_ATTR_CODE,EPA_ATTR_VALUE FROM EZC_PRODUCTS,EZC_PRODUCT_ATTRIBUTES WHERE EZP_PRODUCT_CODE=EPA_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+atpRetMat+"') AND EPA_ATTR_CODE IN ('DCH_STATUS','DIVISION','PROD_HIERARCHY1','ITEM_CAT_GROUP')";
			miscParamsAtp.setQuery(query);
			mainParamsAtp.setLocalStore("Y");
			mainParamsAtp.setObject(miscParamsAtp);
			Session.prepareParams(mainParamsAtp);	
			try{	retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
				cntAtpDB=retAtpLocalDB.getRowCount();}
			catch(Exception e){out.println("Exception in Getting Data"+e);}
						
			if(retAtpLocalDB != null  && cntAtpDB>0)
			{			
				listPrice="0";
				points="0";
				listPrice = retAtpLocalDB.getFieldValueString(0,"EZP_CURR_PRICE");
				points	  = retAtpLocalDB.getFieldValueString(0,"EZP_VOLUME");
				
				try
				{
					listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				}
				catch(Exception e){}
				
				if(listPrice==null || "null".equals(listPrice))
					listPrice="0";
				
				/*try
				{
					points = new java.math.BigDecimal(points).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
				}
				catch(Exception e){}*/
								
				for(int ad=0;ad<cntAtpDB;ad++)
				{
					if("ITEM_CAT_GROUP".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
					{
						kitCombo = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
						if("LUMF".equals(kitCombo))
							kitCombo="Y";
						else
							kitCombo="N";
					}					
					if("DCH_STATUS".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
					{
						prodStatus = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
						if("Z3".equals(prodStatus) || "Z2".equals(prodStatus) || "Z4".equals(prodStatus))
							prodStatus="Discontinued";
						else if("ZF".equals(prodStatus))
							prodStatus="To Be Discontinued";
						else if("11".equals(prodStatus))
							prodStatus="New";
						else
							prodStatus="Active";
					}					
					if("DIVISION".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
					{
						luxury = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
						if("25".equals(luxury) || "26".equals(luxury) || "35".equals(luxury))
							luxury="Y";
						else
							luxury="N";
											
					}					
					if(("".equals(luxury) || "N".equals(luxury)) && "PROD_HIERARCHY1".equals(retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_CODE")))
					{
						luxury = retAtpLocalDB.getFieldValueString(ad,"EPA_ATTR_VALUE");
						
						if(luxury!=null && !"null".equals(luxury) && !"".equals(luxury))
						{														
							if("10".equals(luxury.substring(2,4)) || "20".equals(luxury.substring(2,4)))							
								luxury="Y";							
							else
								luxury="N";															
						}										
					}				
				}
			}			
			if(retQtyInt>=reqQtyInt)
				atpAvail = "Fully Available";
			else if(retQtyInt>0 && retQtyInt<reqQtyInt)
				atpAvail = "Partially Available";
			else 
				atpAvail = endLeadStr;
				
			
				
			if("Search".equals(atpRetMat))
			{
				atpRetMat="";
				atpReqQty="";
				atpAvail="";
				prodStatus="";
			}
		}				
%>
	<tr>
		
		<!--<td width=20%><input size="15" type="text" name="atpfor" class="input-text" value="<%=atpRetMat%>"/></td>
		<td width=5%><input size="3" type="text" name="atpqty" class="input-text" value="<%=atpReqQty%>"/></td>-->
		<td width=20%><%=atpRetMat%></td>
		<td width=5%><%=atpReqQty%></td>
		<td width=15%><p><%=atpUPC%></p></td>
		<td width=25%><p><%=atpMatDesc%></p></td>
		<td width=10%><p><%=listPrice%></p></td>
		<td width=5%><p><%=luxury%></p></td>
		<td width=5%><p><%=kitCombo%></p></td>
		<td width=5%><p><%=points%></p></td>
		<td width=10%><p><%=prodStatus%></p></td>
		<td width=10%><p><%=atpAvail%><br><%=atpRetQty%></p></td>
		

	</tr>
<%	}
%>
	</tbody>
	</table>


<div class="buttons-set form-buttons">
<!--<button type="submit" class="button btn-black" ><span><span>Check Availability</span></span></button>
<button class="button btn-black"  onClick="resetForm()"><span><span>Reset</span></span></button>-->

<button class="button btn-black"  onClick="closeForm()"><span><span>Close</span></span></button>

</div> <!-- Info box -->
</div> <!-- col1-set -->
<form>
</body>
</html>


</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->



