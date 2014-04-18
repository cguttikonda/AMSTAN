<%@ include file="ezATPInputs.jsp"%>
<style type="text/css" media="screen">
	@import "../../Library/Styles/demo_table_jui.css";
	@import "../../Library/Styles/jquery-ui-1.7.2.custom.css";

	/*
	 * Override styles needed due to the mix of three different CSS sources! For proper examples
	 * please see the themes quotetable in the 'Examples' section of this site
	 */
	.dataTables_info { padding-top: 0; }
	.dataTables_paginate { padding-top: 0; }
	.css_right { float: right; }
	#example .fg-toolbar { font-size: 0.8em }
	#theme_links span { float: left; padding: 2px 10px; }
	#example { -webkit-box-shadow: 2px 2px 6px #666; box-shadow: 2px 2px 6px #666; border-radius: 5px; }
	#example tbody {
		border-left: 1px solid #AAA;
		border-right: 1px solid #AAA;
	}
	#example thead th:first-child { border-left: 1px solid #AAA; }
	#example thead th:last-child { border-right: 1px solid #AAA; }
</style>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="../../Library/Script/complete.min.js"></script>
<script type="text/javascript" src="../../Library/Script/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="../../Library/Script/TableTools-2.1.1/js/TableTools.min.js"></script> 
<script  src="../../Library/Script/colResizable-1.3.min.js"></script>

<script type="text/javascript">
$(document).ready( function() {
	$('#example').dataTable( {
		"bJQueryUI": true,
		"bPaginate": false,		
		"bSort" : false,
		"bStateSave":true,

		"sDom": '<"H"Tfr>t<"F"ip>',		
		"oTableTools": {
		"sSwfPath": "/AST/EzComm/EzSales/Sales/Library/Script/TableTools-2.1.1/swf/copy_csv_xls_pdf.swf",
		"sInfo":"Use Browser Print and press Esc. When done",
		"aButtons": [
				{
				    "sExtends":    "csv",
				    "sButtonText": "Download CSV",
				    "sFileName" : "CartItemsAvailability.csv"
				}
			]
		}

	} );
} );
	
$(function(){

	var onSampleResized = function(e){
		var columns = $(e.currentTarget).find("th");
		var msg = "columns widths: ";
		columns.each()
	};

	$("#example").colResizable({
		liveDrag:true,
		gripInnerHtml:"<div class='grip'></div>",
		draggingClass:"dragging",
		onResize:onSampleResized});
});

</script>

<%
	if(prdsLen>0)
	{
		for(int i=0;i<prdsLen;i++)
		{
			String prodCodes = selectedPrdsSplitArr[i].split("¥")[0];
			String prodQty   = selectedPrdsSplitArr[i].split("¥")[1];

			atpQtyPrdRet.setFieldValue("PROCODES",prodCodes);
			atpQtyPrdRet.setFieldValue("ORD_QTY",prodQty);	
			atpQtyPrdRet.addRow();
		}
	}

	/************ Setting inputs to FM ***********************/

	atpInputsRet.setFieldValue("SALESORG",atpSOr);
	atpInputsRet.setFieldValue("DIST_CHANNEL",atpDtc);	
	atpInputsRet.setFieldValue("DIVISON",atpDiv);
	atpInputsRet.setFieldValue("SOLDTO",atpSTP);
	atpInputsRet.setFieldValue("SHIPTO",atpSHP);
	atpInputsRet.setFieldValue("REGION",stAtpStr);
	atpInputsRet.addRow();

	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);

	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","PLANTDESC","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);

	if(atpQtyPrdRet!=null && atpQtyPrdRet.getRowCount()>0)
	{
%>
	<%@ include file="ezATPJCO.jsp"%>
<%
	}

	Date dateNow = new Date ();
	SimpleDateFormat dformat = new SimpleDateFormat("MM/dd/yyyy hh:mm a");
	String currentDate = dformat.format(dateNow);
%>
<h2>Product Availability Check at&nbsp;<%=currentDate%></h2>
<br>
	<table class="display" id="example" >
	<thead>
	<tr>
		<td width=15%>Current Availability</td>
		<td width=10%>Req. Qty<br>List Price</td>
		<td width=25%>Material#<br>UPC<br>Description</td>
		<td width=20%>Product Status</td>
		<td width=15%>Features </td>
	</tr>
	</thead>
	<tbody class="display">
<%
	int cntAtpDB=0;
	ReturnObjFromRetrieve retAtpLocalDB = null;

	if(atpResultRet!=null && atpResultRet.getRowCount()>0)
	{
		EzcParams mainParamsAtp = new EzcParams(false);
		EziMiscParams miscParamsAtp = new EziMiscParams();

		String query="SELECT EZP_PRODUCT_CODE,EZP_PROD_ATTRS,EZP_SALES_ORG,EZP_TYPE,EZP_STATUS,EZP_LUXURY,EZP_CURR_PRICE,EZP_VOLUME,EZP_ATTR1 FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+prodCodeStr+"')";
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
		String luxury="N",prodStatDisp="",quickShip="N",textP="Points: ",retailCheck="",comboType="",prod_Attr="",matSalesOrg="";

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
				}
			}
		}
		
		Hashtable custAttrsHT	= (Hashtable)session.getValue("CUSTATTRS");

		boolean prdAllowed = true;
		String custAttr ="";
		
		if(!"2".equals(userTyp))
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

		if(!"N/A".equals(retailCheck))
		{
			if (retailCheck.equals("CS"))
				retailCheck = "All Custom Door and Vanity Top Items should be faxed to 1-800-3279387";
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
					if("OVW".equals(str4)) atpAvail = "";
				}
			}
		}
		
		catch(Exception e){}
		if("".equals(endLeadStr)) endLeadRem = "";
%>
		<tr>
			<td width=15%><p><%=atpRetQty%><%=atpAvail%><br><%=endLeadRem%><%=endLeadStr%></p></td>
			<td width=10%><%=atpReqQty%><br>$<%=listPrice%> (USD)</td>
			<td width=25%><%=atpRetMat%><br><%=atpUPC%><br><%=atpMatDesc%></td>
			<td width=20%><p><%=prodStatDisp%></p></td>
			<td width=15%><p>Luxury: <%=luxury%><br>Kit/Combo: <%=kitCombo%><br><%=textP%><br><%=retailCheck%></p></td>
		</tr>

<%@ include file="ezATPGA.jsp"%>
<%
	}
%>
	</tbody>
	</table>
<p align="center"><b>The information displayed is the most up to date at this time and is subject to change.</b></p>