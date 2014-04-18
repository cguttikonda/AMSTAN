<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String discId = request.getParameter("discId");
	String status = request.getParameter("status");
	String chkDel = request.getParameter("chkDel");
	String chkVal = request.getParameter("chkVal");
	
	String user = Session.getUserId();
	user=user.trim();
	
	String subQry = "";
	
	if(chkDel!=null && "DEL".equals(chkDel))
	{
		subQry = "N',ESD_EXT1='DEL";
	}
	else if(chkDel!=null && "EDIT".equals(chkDel))
	{
		subQry = "N',ESD_DISCOUNT='"+chkVal+"',ESD_EXT1='EDIT";
	}
	else
	{
		subQry = status;
	}
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(true);
	
	if(discId!=null && !"null".equals(discId) && !"".equals(discId))
	{
		ezDiscParams.setStatus(subQry);
		ezDiscParams.setModifiedBy(user);
		ezDiscParams.setDiscId(discId);

		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);


		try
		{
			ezDiscountManager.ezEditDiscount(discMainParams);
		}
		catch(Exception e){}
	}
	
	response.sendRedirect("ezGetDiscounts.jsp");
%>