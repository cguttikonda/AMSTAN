<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*,ezc.ezutil.FormatDate"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	/****************************************
	*		Disc Type		*
	*					*
	* 1.Mfr/All Cust 	  - MAC		*
	* 2.Mfr/Spl Cust 	  - MSC		*
	* 3.Mfr/Item Cat/All Cust - MIAC	*
	* 4.Mfr/Item Cat/Spl Cust - MISC	*
	*					*
	*		Threshold		*
	*					*
	* 1.Mfr			  - MFR		*
	* 2.Mfr/Item Cat	  - MIC		*
	*					*
	****************************************/
	
	String manfId 	= request.getParameter("manfId");
	String itemCat	= request.getParameter("itemCat");
	String discount = request.getParameter("discount");
	String soldTo 	= request.getParameter("soldTo");
	String manfDesc = request.getParameter("mfr");
	String syskey	= (String)session.getValue("SalesAreaCode");
	
	String discType = "";
	String threshType = "";
	String dispData = "";
	
	String user = Session.getUserId();
	user=user.trim();

	boolean addDiscount = false;
	
	boolean getThreshold = false;
	boolean getManfId = false;
	boolean getItemCat = false;
	boolean getSoldTo = false;
	boolean getDiscount = false;
	boolean error = false;
	
	java.math.BigDecimal discount_BD = null;
	java.math.BigDecimal threshold_BD = null;
	
	if(manfId!=null && !"null".equalsIgnoreCase(manfId) && !"".equals(manfId)) getManfId = true;
	
	if(itemCat!=null && !"null".equalsIgnoreCase(itemCat) && !"".equals(itemCat))
	{
		getItemCat = true;
	}
	else
	{
		itemCat = "";
	}

	if(soldTo!=null && !"null".equalsIgnoreCase(soldTo) && !"".equals(soldTo))getSoldTo = true;
	
	if(discount!=null && !"null".equalsIgnoreCase(discount) && !"".equals(discount))
	{
		try
		{
			discount_BD = new java.math.BigDecimal(discount);
			discount_BD = discount_BD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
		}
		catch(Exception e)
		{
			discount_BD = new java.math.BigDecimal("0");
		}
		getDiscount = true;
	}
	
	if(getManfId && getItemCat && getDiscount)
	{
		threshType = "MIC";
		getThreshold = true;
		
		discType = "MISC";
		
		if(getSoldTo && "ALL".equals(soldTo))
			discType = "MIAC";
	}
	
	if(getManfId && !getItemCat && getDiscount)
	{
		threshType = "MFR";
		getThreshold = true;
		
		discType = "MSC";
		
		if(getSoldTo && "ALL".equals(soldTo))
			discType = "MAC";
	}
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezThreshParams = new EziDiscountParams();
	EzcParams threshMainParams = new EzcParams(false);
	
	ReturnObjFromRetrieve retThresholds = null;
	int retThresholdsCount = 0;

	if(getThreshold)
	{
		if("MFR".equals(threshType))
		{
			ezThreshParams.setType("GET_THRESH_TYPE_MFR");
			ezThreshParams.setDiscType(threshType);
			ezThreshParams.setMfr(manfId);
		}

		if("MIC".equals(threshType))
		{
			ezThreshParams.setType("GET_THRESH_TYPE_MFR_PRODCAT");
			ezThreshParams.setDiscType(threshType);
			ezThreshParams.setMfr(manfId);
			ezThreshParams.setProdCat(itemCat);
		}

		threshMainParams.setObject(ezThreshParams);
		threshMainParams.setLocalStore("Y");
		Session.prepareParams(threshMainParams);

		try
		{
			retThresholds = (ReturnObjFromRetrieve)ezDiscountManager.ezGetThreshold(threshMainParams);
		}
		catch(Exception e)
		{
			error = true;
		}
	}
	
	if(retThresholds!=null)
	{
		retThresholdsCount = retThresholds.getRowCount();
	
		if(retThresholdsCount>0)
		{
			String threshVal = retThresholds.getFieldValueString(0,"EDT_THRESHOLD");
			
			try
			{
				threshold_BD = new java.math.BigDecimal(threshVal);
				
				int compare = discount_BD.compareTo(threshold_BD);
				
				if(compare==1)
				{
					threshold_BD = threshold_BD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
				
					dispData = "Discount "+discount_BD+" ¤¤ should not be greater than Threshold "+threshold_BD+" ¤¤";
				}
				else
				{
					addDiscount = true;
				}
			}
			catch(Exception e)
			{
				error = true;
			}
		}
		else
		{
			dispData = "No Threshold configured for the given information <br><br> Please contact your administrator";
		}
	}
	else
	{
		error = true;
	}
	
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	if(addDiscount)
	{
		String validFrom 	= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
		String validTo  	= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY);
	
		ezDiscParams.setSyskey(syskey);
		ezDiscParams.setDiscType(discType);
		ezDiscParams.setMfr(manfId);
		ezDiscParams.setProdCat(itemCat);
		ezDiscParams.setCustomer(soldTo);
		ezDiscParams.setDiscount(discount_BD+"");
		ezDiscParams.setCreatedBy(user);
		ezDiscParams.setModifiedBy(user);
		ezDiscParams.setValidFrom(validFrom);
		ezDiscParams.setValidTo(validTo);
		ezDiscParams.setStatus("N");
		
		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);
		
		try
		{
			ezDiscountManager.ezAddDiscount(discMainParams);
		}
		catch(Exception e)
		{
			error = true;
		}
	}
	
	if(error)
	{
		dispData = "Problem occured while creating Discount";
	}
	
	if(!addDiscount || error)
	{
		if("".equals(dispData)) dispData = "BLANK";
		if(itemCat==null || "null".equalsIgnoreCase(itemCat) || "".equals(itemCat)) itemCat = "BLANK";
		dispData = "<font color=red>"+dispData+"</font>";
%>
<jsp:forward page="ezCreateDiscount.jsp">  
	<jsp:param name="showDisp" value="Y"/>
	<jsp:param name="dispData" value="<%=dispData%>"/>
 	<jsp:param name="manfId"   value="<%=manfId%>"/>
	<jsp:param name="manfDesc" value="<%=manfDesc%>"/>
	<jsp:param name="itemCat"  value="<%=itemCat%>"/>
	<jsp:param name="soldTo"   value="<%=soldTo%>"/> 
	<jsp:param name="discount" value="<%=discount%>"/>
</jsp:forward>
<%
		//response.sendRedirect("ezCreateDiscount.jsp?showDisp=Y&dispData="+dispData+"&manfId="+manfId+"&manfDesc="+manfDesc+"&itemCat="+itemCat+"&soldTo="+soldTo+"&discount="+discount);
	}
	else
	{
		dispData = "Discount has been created successfully";
	}
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<Script>
	function funOk()
	{
		document.myForm.action="ezCreateDiscount.jsp";
		document.myForm.submit();
	}
</Script>
</head>
<body>
<form method="post" name="myForm">
	<br><br><br><br>
<%
	String noDataStatement = dispData;
%>
	<%@ include file="../Misc/ezDisplayNoData.jsp"%>
	<br><br>
	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Ok");
	buttonMethod.add("funOk()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</Div>
</form>
</body>
<Div id="MenuSol"></Div>
</html>