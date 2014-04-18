<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*,ezc.ezcnetconnector.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager"/>
<%
	/****************************************
	*					*
	*		Promo Type		*
	*					*
	* 1.Order		  - PCORD	*
	* 2.Mfr			  - PCMFR	*
	* 3.Mfr/Item Cat	  - PCMAI	*
	* 4.Mfr Part No		  - MFRPN	*
	*					*
	****************************************/
	
	String mfrPartNo = request.getParameter("mfrPartNo");
	String manfId = request.getParameter("manfId");
	String itemCat = request.getParameter("itemCat");
	String discount = request.getParameter("discount");
	String manfDesc = request.getParameter("mfr");
	String promoType = request.getParameter("selType");
	String fromDate = request.getParameter("fromDate");
	String toDate = request.getParameter("toDate");
	String user = Session.getUserId();
	user=user.trim();
	
	String stHrs = (request.getParameter("stHrs").equals("")?"  ":request.getParameter("stHrs"));
	String stMin = (request.getParameter("stMin").equals("")?"  ":request.getParameter("stMin"));
	String endHrs = (request.getParameter("endHrs").equals("")?"  ":request.getParameter("endHrs"));
	String endMin = (request.getParameter("endMin").equals("")?"  ":request.getParameter("endMin"));
	
	fromDate = fromDate+" "+stHrs+":"+stMin+":00.0";
	toDate = toDate+" "+endHrs+":"+endMin+":00.0";

	boolean getDiscount = false;
	boolean error = false;
	boolean chkMfrPartNo = true;
	String chkOk = "N";
	
	if(manfId==null || "null".equalsIgnoreCase(manfId)) manfId = "";
	if(itemCat==null || "null".equalsIgnoreCase(itemCat)) itemCat = "";
	
	if(promoType!=null && "MFRPN".equals(promoType))
	{
		if(mfrPartNo!=null && !"null".equals(mfrPartNo))
		{
			mfrPartNo = mfrPartNo.trim();
			
			ReturnObjFromRetrieve retMfrPn = null;

			EzCnetConnectorParams cnetParams = new EzCnetConnectorParams();
			EzcParams miscMainParams = new EzcParams(false);

			cnetParams.setStatus("GET_PRDS_MFR_PART_NO");
			cnetParams.setQuery(mfrPartNo);

			miscMainParams.setObject(cnetParams);
			miscMainParams.setLocalStore("Y");
			Session.prepareParams(miscMainParams);

			try
			{
				retMfrPn = (ReturnObjFromRetrieve)CnetManager.ezGetCnetProductsByStatus(miscMainParams);
			}
			catch(Exception e){}

			if(retMfrPn!=null)
			{
				String mfrPnCnt = retMfrPn.getFieldValueString("mfrpn_count");
				
				if("0".equals(mfrPnCnt))
				{
					chkMfrPartNo = false;
					chkOk = "Y";
				}
				else
				{
					manfId = mfrPartNo;
				}
				
			}
		}
	}
	else if(promoType!=null && "PCORD".equals(promoType))
	{
		manfId = "";
		itemCat = "";
	}
	else if(promoType!=null && "PCMFR".equals(promoType))
	{
		itemCat = "";
	}

	java.math.BigDecimal discount_BD = null;	
	
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
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	if(getDiscount && chkMfrPartNo)
	{
		ezDiscParams.setPromoType(promoType);
		ezDiscParams.setMfr(manfId);
		ezDiscParams.setProdCat(itemCat);
		ezDiscParams.setDiscount(discount_BD+"");
		ezDiscParams.setCreatedBy(user);
		ezDiscParams.setModifiedBy(user);
		ezDiscParams.setValidFrom(fromDate);
		ezDiscParams.setValidTo(toDate);
		ezDiscParams.setStatus("N");

		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);
		
		try
		{
			ezDiscountManager.ezAddPromotion(discMainParams);
		}
		catch(Exception e)
		{
			error = true;
		}
	}
	else
	{
		error = true;
	}
	
	String dispData = "Promotional Code created successfully";
	
	if(error)
	{
		dispData = "Problem occured while creating Promotional Code";
	}
	if(!chkMfrPartNo)
	{
		dispData = "Entered manufacture part number is not valid";
	}
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
	<script>
	function funOk(obj)
	{
		if(obj=='Y')
		{
			document.myForm.action="ezAddPromoCode.jsp";
			document.myForm.submit();
		}
		else
		{
			document.myForm.action="ezGetPromoCode.jsp";
			document.myForm.submit();
		}
	}
	</script>
</head>
<body>
<form name=myForm>
<input type="hidden" name="mfrPartNo" value="<%=mfrPartNo%>">
<input type="hidden" name="discount" value="<%=discount%>">
	<br><br><br><br>
	<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center><%=dispData%></Th>
	</Tr>
	</Table>
	<br><br>
	<Center>
		<a href="javascript:funOk('<%=chkOk%>')"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
	</Center>
</form>
</body>
</html>