<%@ include file="ezATPInputs.jsp"%>
<%
	stAtpStr = "*";
	atpSTP	 = "";
	atpSHP	 = "";
	atpQtyStr= "999999999";
	
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

	String atpColRRet[]={"MATERIAL","MATERIALDESC","AVAILQTY","PLANT","PLANTDESC","STATUS","UPC","ENDLEADTIME"};
	ReturnObjFromRetrieve atpResultRet = new ReturnObjFromRetrieve(atpColRRet);
	
	String atpColZMat[]={"MATERIAL","REQQTY"};
	ReturnObjFromRetrieve atpZMaterialRet = new ReturnObjFromRetrieve(atpColZMat);
	
	/********************End******************************/	
	
	if(!"".equals(atpForStr))
	{				
%>
		<%@ include file="ezATPJCO.jsp"%>
<%
	}
%>
<h2><%=pageTitle%></h2>
<br>
	<table class="data-table" id="quickatp">
	<thead>
	<tr width='90%'>
		<td width=40%>Material </td>
		<td width=35%>Plant</td>		
		<td width=25%>Current Availability</td>
	</tr>
	</thead>
	<tbody>
<%		
	long retQtyIntTot=0l;
	long retQtyInt=0l;

	String notInclude = "Not Include in Your Portfolio or Default Ship-To Account";
	boolean quaShow = true;
	ReturnObjFromRetrieve retAtpLocalDB = null;

	if(atpResultRet!=null && atpResultRet.getRowCount()>0)
	{
		EzcParams mainParamsAtp = new EzcParams(false);
		EziMiscParams miscParamsAtp = new EziMiscParams();

		String query="SELECT EZP_PRODUCT_CODE,EZP_PROD_ATTRS,EZP_SALES_ORG FROM EZC_PRODUCTS WHERE EZP_PRODUCT_CODE IN ('"+prodCodeStr+"')";
		miscParamsAtp.setQuery(query);
		miscParamsAtp.setIdenKey("MISC_SELECT");

		mainParamsAtp.setLocalStore("Y");
		mainParamsAtp.setObject(miscParamsAtp);
		Session.prepareParams(mainParamsAtp);

		try
		{
			retAtpLocalDB = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsAtp);
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
		
		String prod_Attr   = "";
		String matSalesOrg = "";

		if(retAtpLocalDB.find("EZP_PRODUCT_CODE",atpRetMat))
		{
			int row = retAtpLocalDB.getRowId("EZP_PRODUCT_CODE",atpRetMat);

			prod_Attr = nullCheck(retAtpLocalDB.getFieldValueString(row,"EZP_PROD_ATTRS"),"");
			matSalesOrg = nullCheck(retAtpLocalDB.getFieldValueString(row,"EZP_SALES_ORG"),"");
		}		

		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

		String atpReqQty="",atpAvail="",listPrice="",points="",kitCombo="",prodStatus="",luxury="";

		if("0".equals(atpRetQty)) atpRetQty="";

		if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
			atpRetQty=eliminateDecimals(atpRetQty);

		if(!"".equals(atpUPC))
		{	
			atpUPC = "000000000000"+atpUPC;
			atpUPC = atpUPC.substring(atpUPC.length()-12,atpUPC.length());
			atpUPC = atpUPC.trim();	
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
		
		if(prdAllowed)
		{
			
			if(atpRetQty!=null && !"null".equals(atpRetQty) && !"".equals(atpRetQty))
			{
				try
				{
					retQtyInt 	= Long.parseLong(atpRetQty);
					retQtyIntTot  = retQtyIntTot + retQtyInt;
				}
				catch (Exception e){}
			}
		}
		else
		{
			quaShow = false;
		}
%>
		<tr>
			<td width=40%><p><%=atpRetMat%>, <%=atpMatDesc%></p></td>
			<td width=35%><p><%=atpPlant%>, <%=plantDes%></p></td>		
			<td width=25%><p><%if(quaShow){%><%=retQtyInt%><%}else{%><%=notInclude%><%}%></p></td>
		</tr>
	
<%@ include file="ezATPGA.jsp"%>
<%
	}
		ezc.ezcommon.EzLog4j.log("ATP:::ALL:::TEST::END"+(new Date()),"F");
%>
		<tr>
			<td width=25%>&nbsp;</td>	
			<td width=10%>TOTAL : </td>			
			<td width=10%><p><%if(quaShow){%><%=retQtyIntTot%><%}else{%><%=notInclude%><%}%></p></td>
		</tr>
	</tbody>
	</table>