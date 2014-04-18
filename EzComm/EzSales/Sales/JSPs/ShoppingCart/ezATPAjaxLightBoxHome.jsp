<%@ include file="ezATPInputs.jsp"%>
<script>
$(document).ready(function() {
	$(".fancybox").fancybox({closeBtn:true})
	});
</script>
<%
	atpSHP = "";

	/************ Setting inputs to FM ***********************/
	
	atpInputsRet.setFieldValue("SALESORG",atpSOr);
	atpInputsRet.setFieldValue("DIST_CHANNEL",atpDtc);	
	atpInputsRet.setFieldValue("DIVISON",atpDiv);
	atpInputsRet.setFieldValue("SOLDTO",atpSTP);	
	atpInputsRet.setFieldValue("SHIPTO",atpSHP);
	atpInputsRet.setFieldValue("REGION",stAtpStr);	
	atpInputsRet.addRow();	

	atpQtyPrdRet.setFieldValue("PROCODES",atpForStr);
	atpQtyPrdRet.setFieldValue("ORD_QTY",atpQtyStr);	
	atpQtyPrdRet.addRow();

	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);
	
	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","PLANTDESC","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	/********************End******************************/
	
	boolean flag_A = false;

	if(atpForStr!=null && !"null".equals(atpForStr) && !"".equals(atpForStr))
	{
		ReturnObjFromRetrieve retAtpLocalDB = null;
		EzcParams mainParamsAtp = new EzcParams(false);
		EziMiscParams miscParamsAtp = new EziMiscParams();
		miscParamsAtp.setIdenKey("MISC_SELECT");
		String query="SELECT EZP_PRODUCT_CODE FROM EZC_CATEGORIES,EZC_CATEGORY_PRODUCTS,EZC_PRODUCTS WHERE ECP_CATEGORY_CODE = EC_CODE AND  ECP_PRODUCT_CODE = EZP_PRODUCT_CODE AND EZP_PRODUCT_CODE IN ('"+atpForStr+"')";
		miscParamsAtp.setQuery(query);
		mainParamsAtp.setLocalStore("Y");
		mainParamsAtp.setObject(miscParamsAtp);
		Session.prepareParams(mainParamsAtp);	
		try{
			retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);

			if(retAtpLocalDB!=null && retAtpLocalDB.getRowCount()>0)
				flag_A = true;
		}
		catch(Exception e){}
	}
	
	if(flag_A)
	{
%>
		<%@ include file="ezATPJCO.jsp"%>
<%
	}

	Date dateNow = new Date ();
	DateFormat dformat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
	dformat.setTimeZone(TimeZone.getTimeZone("America/New_York"));
	String currentDate = dformat.format(dateNow);
	
	String userType_A  = (String)session.getValue("UserType");

	int cntAtpDB=0;
	ReturnObjFromRetrieve retAtpLocalDB = null;

	if(atpResultRet!=null && atpResultRet.getRowCount()>0)
	{
		EzcParams mainParamsAtp = new EzcParams(false);
		EziMiscParams miscParamsAtp = new EziMiscParams();

		String query="SELECT EZP_PRODUCT_CODE,EZP_PROD_ATTRS,EZP_SALES_ORG,EZP_TYPE,EZP_STATUS,EZP_LUXURY,EZP_CURR_PRICE,EZP_VOLUME,EZP_ATTR1,EZP_ATTR2,EZP_BRAND FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+prodCodeStr+"')";
		miscParamsAtp.setQuery(query);
		miscParamsAtp.setIdenKey("MISC_SELECT");

		mainParamsAtp.setLocalStore("Y");
		mainParamsAtp.setObject(miscParamsAtp);
		Session.prepareParams(mainParamsAtp);

		try
		{
			retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
			cntAtpDB=retAtpLocalDB.getRowCount();
		}
		catch(Exception e){}
	}

	for(int a=0;a<atpResultRet.getRowCount();a++)
	{
		String atpRetMat   = nullCheck(atpResultRet.getFieldValueString(a,"MATERIAL"),"");
		String atpRetQty   = nullCheck(atpResultRet.getFieldValueString(a,"AVAILQTY"),"");
		String atpStat     = nullCheck(atpResultRet.getFieldValueString(a,"STATUS"),"");
		String atpPlant    = nullCheck(atpResultRet.getFieldValueString(a,"PLANT"),"");
		String plantDes    = nullCheck(atpResultRet.getFieldValueString(a,"PLANTDESC"),"");
		String atpMatDesc  = nullCheck(atpResultRet.getFieldValueString(a,"MATERIALDESC"),"");
		String atpUPC      = nullCheck(atpResultRet.getFieldValueString(a,"UPC"),"");
		Date endLeadTime   = (Date)atpResultRet.getFieldValue(a,"ENDLEADTIME");


		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		String endLeadStr ="";
		String endLeadRem1 ="";

		try
		{
			endLeadStr = formatter.format(endLeadTime);
		}
		catch(Exception e){}

		Set keys = zMatHM.keySet();

		for (Iterator i = keys.iterator(); i.hasNext();)
		{
			String key = (String)i.next();
			Object value = (Object)zMatHM.get(key);
		}

		String atpReqQty="",atpAvail="",listPrice="",points="",kitCombo="N",prodStatus="";
		String luxury="N",prodStatDisp="",quickShip="N",textP="Points: ",retailCheck="",comboType="",brandCart="",imgLinkCart="",prod_Attr="",matSalesOrg="";

		if(!"".equals(atpUPC))
		{
			atpUPC = "000000000000"+atpUPC;
			atpUPC = atpUPC.substring(atpUPC.length()-12,atpUPC.length());
			atpUPC = atpUPC.trim();
		}			

		if(zMatHM.size()>0 && !"".equals(atpRetMat))
			atpReqQty = nullCheck((String)zMatHM.get(atpRetMat),"");
				
		if("0".equals(atpRetQty)) atpRetQty="";

		int reqQtyInt=0,retQtyInt=0;
		
		if(!"".equals(atpReqQty))
		{
			atpReqQty=eliminateDecimals(atpReqQty);
			reqQtyInt=Integer.parseInt(atpReqQty);
		}
		if(!"".equals(atpRetQty))
		{
			atpRetQty=eliminateDecimals(atpRetQty);
			retQtyInt=Integer.parseInt(atpRetQty);
		}

		if(cntAtpDB>0)
		{
			for(int ad=0;ad<cntAtpDB;ad++)
			{
				if(atpRetMat.equals(retAtpLocalDB.getFieldValueString(ad,"EZP_PRODUCT_CODE")))
				{
					listPrice="0";
					points="0";
					prod_Attr	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_PROD_ATTRS"),"");
					matSalesOrg 	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_SALES_ORG"),"");
					comboType 	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_TYPE"),"");
					prodStatus 	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_STATUS"),"");
					luxury 		 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_LUXURY"),"N");
					listPrice 	 = retAtpLocalDB.getFieldValueString(ad,"EZP_CURR_PRICE");
					points	  	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_VOLUME"),"");
					retailCheck	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_ATTR1"),"N/A");
					brandCart   	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_BRAND"),"N/A");
					imgLinkCart 	 = nullCheck(retAtpLocalDB.getFieldValueString(ad,"EZP_ATTR2"),"N/A");
				}
			}
		}

		Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");

		boolean prdAllowed = true;
		String custAttr ="";
		
		if(!"2".equals(userType_A))
		{
			try
			{
				custAttr	= (String)custAttrsHT.get(matSalesOrg);
				prdAllowed	= checkAttributes(prod_Attr,custAttr);
			}
			catch(Exception e){}
		}
		
		try
		{
			listPrice = new java.math.BigDecimal(listPrice).setScale(2,java.math.BigDecimal.ROUND_HALF_UP).toString();
		}
		catch(Exception e){}

		if(listPrice==null || "null".equals(listPrice)) listPrice="0";

		if("KI".equals(comboType)) kitCombo="Y";
		/*if("QS".equals(retailCheck)) quickShip="Y";*/

		if(!"N/A".equals(retailCheck))
		{
			if (retailCheck.equals("CS"))
				retailCheck = "All Custom Door and Vanity Top Items should be faxed to 1-800-3279387";
			/*else if (retailCheck.equals("QS"))
				retailCheck = "QUICK SHIP FAUCET";*/
			else
				retailCheck = nullCheck((String)cgHMRB.get(retailCheck),"");
		}
		else
			retailCheck="";

		if(points!=null && !"null".equals(points) && !"".equals(points))
		{
			textP += points;
		}
		else
			textP="";

		if(prdAllowed)
		{
			if(retQtyInt>=reqQtyInt)
			{
				atpAvail = " Fully Available";
				endLeadStr="";
			}
			else if(retQtyInt>0 && retQtyInt<reqQtyInt)
			{
				atpAvail = " Partially Available";
				endLeadRem = "Remainder on ";
			}
			else 
			{
				atpAvail = "";
				endLeadRem = "Earliest availability after ";
				atpRetQty = "Not Available";
			}
		}
		else
		{
			endLeadStr	= "";
			atpAvail	= "Not Include in Your Portfolio or Default Ship-To Account";
			atpRetQty	= "";
		}		

		if("Search".equals(atpRetMat))
		{
			atpRetMat="";
			atpReqQty="";
			atpAvail="";
			prodStatDisp="";
		}
		try
		{
			if("".equals(prodStatus))
			{
				prodStatDisp = "Active";
			}
			else
			{
				String prodStatusAttrs = nullCheck((String)prodStatusHT.get(prodStatus),"");

				if(!"".equals(prodStatusAttrs))
				{
					prodStatDisp 	= prodStatusAttrs.split("¥")[0];
					String str1	= prodStatusAttrs.split("¥")[1];
					String str2	= prodStatusAttrs.split("¥")[2];
					String str3	= prodStatusAttrs.split("¥")[3];
					String str4	= prodStatusAttrs.split("¥")[4];

					if("OVW".equals(str1)) endLeadRem = "";
					if("OVW".equals(str2)) endLeadStr = "";
					if("OVW".equals(str3)) atpRetQty = "";
					else if(!"DNO".equals(str3)) atpRetQty = str3;
					if("OVW".equals(str4)) atpAvail = "";
				}
			}
		}
		catch(Exception e){}
		
		if("".equals(endLeadStr)) endLeadRem = "";

		String blank="  ";
%>
		<h2>Product Availability Check at&nbsp;<%=currentDate%>&nbsp;FOR SHIP-TO STATE [<%=stAtpStr%>]</h2>
		<br>
		<table class="data-table" id="quickatp">
		<thead>
		<tr width='100%'>
			<td width=17%>Image<br>Brand</td>
			<td width=15%>Current Availability</td>
			<td width=10%>Req. Qty<br>List Price</td>
			<td width=25%>Material#<br>UPC<br>Description</td>
			<td width=20%>Product Status</td>
			<td width=15%>Features </td>
<%
		if(!"3".equals(userType_A))
		{
%>
			<td width=15%>Plant<br>Plant Desc</td>
<%
		}
%>		
		</tr>
		</thead>
		<tbody>
		<tr>
			<td width=17% class="a-center"><br>
<%
			if(!"N/A".equals(imgLinkCart))
			{
%>
				<img class="lazy" src="<%=imgLinkCart%>" data-original="<%=imgLinkCart%>" height="90" width="90">
				<br>
<%
			}
%>
			<%=brandCart%>
			</td >	
			<td width=15%><p><%=atpRetQty%><%=atpAvail%><br><%=endLeadRem%><%=endLeadStr%></p></td>
			<td width=10%><%=atpReqQty%><br>$<%=listPrice%> (USD)</td>
			<td width=25%><%=atpRetMat%><br><%=atpUPC%><br><%=atpMatDesc%></td>
			<td width=20%><p><%=prodStatDisp%></p></td>
			<td width=15%><p>Luxury: <%=luxury%><br>Kit/Combo: <%=kitCombo%><br><%=textP%><br><%=retailCheck%></p></td>
<%
			if(!"3".equals(userType_A))
			{
%>
				<td width=15%><p><%=atpPlant%><br><%=plantDes%></p></td>
<%
			}
%>		
			</tr>

<%@ include file="ezATPGA.jsp"%>
<%
	}
	ezc.ezcommon.EzLog4j.log("ATP:::::TEST::END","F");
%>	

	</tbody>
	</table>
	<br>
<p align="center"><b>The information displayed is the most up to date at this time and is subject to change.</b></p>