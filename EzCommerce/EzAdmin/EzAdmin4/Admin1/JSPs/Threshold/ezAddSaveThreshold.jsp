<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	/****************************************
	*					*
	*		Threshold		*
	*					*
	* 1.Mfr			  - MFR		*
	* 2.Mfr/Item Cat	  - MIC		*
	*					*
	****************************************/
	
	String manfId = request.getParameter("manfId");
	String itemCat = request.getParameter("itemCat");
	String threshold = request.getParameter("threshold");
	String manfDesc = request.getParameter("mfr");
	String discType = "";
	String user = Session.getUserId();
	user=user.trim();

	boolean addThreshold = false;
	
	boolean getManfId = false;
	boolean getItemCat = false;
	boolean getThreshold = false;
	boolean error = false;
	
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
	
	if(threshold!=null && !"null".equalsIgnoreCase(threshold) && !"".equals(threshold))
	{
		try
		{
			threshold_BD = new java.math.BigDecimal(threshold);
			threshold_BD = threshold_BD.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
		}
		catch(Exception e)
		{
			threshold_BD = new java.math.BigDecimal("0");
		}
		getThreshold = true;
	}
	
	if(getManfId && getItemCat && getThreshold)
	{
		discType = "MIC";
		addThreshold = true;
	}
	else if(getManfId && !getItemCat && getThreshold)
	{
		discType = "MFR";
		addThreshold = true;
	}
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	if(addThreshold)
	{
		ezDiscParams.setDiscType(discType);
		ezDiscParams.setMfr(manfId);
		ezDiscParams.setProdCat(itemCat);
		ezDiscParams.setThreshold(threshold_BD+"");
		ezDiscParams.setCreatedBy(user);

		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);
		
		try
		{
			ezDiscountManager.ezAddThreshold(discMainParams);
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
	
	String dispData = "Threshold for "+manfDesc+" created successfully";
	
	if(error)
	{
		dispData = "Problem occured while creating Threshold";
	}
%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<%@ include file="../../Library/Globals/CacheControl.jsp"%>
</head>
<body>
	<br><br><br><br>
	<Table width="60%" border="1" align="center" bordercolorlight=#000000 bordercolordark=#ffffff cellspacing=0 cellpadding=2>
	<Tr>
		<Th align=center><%=dispData%></Th>
	</Tr>
	</Table>
	<br><br>
	<Center>
		<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
</body>
</html>