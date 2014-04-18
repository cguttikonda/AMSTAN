<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String threshNo = request.getParameter("threshNo");
	
	boolean error = false;
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	if(threshNo!=null && !"null".equalsIgnoreCase(threshNo) && !"".equals(threshNo))
	{
		ezDiscParams.setThreshId(threshNo);

		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);
		
		try
		{
			ezDiscountManager.ezDelThreshold(discMainParams);
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
	
	String dispData = "Threshold is deleted successfully";
	
	if(error)
	{
		dispData = "Problem occured while deleting Threshold";
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
		<a href="ezGetThreshold.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	</Center>
</body>
</html>