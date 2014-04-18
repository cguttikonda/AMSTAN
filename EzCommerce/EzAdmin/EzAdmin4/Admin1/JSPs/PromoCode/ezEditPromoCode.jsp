<%@ page import="java.util.*,ezc.ezparam.*,ezc.ezdiscount.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<%
	String promoCode = request.getParameter("promoCode");
	String status = request.getParameter("status");
	String chkDel = request.getParameter("chkDel");
	String chkVal = request.getParameter("chkVal");
	
	String user = Session.getUserId();
	user=user.trim();
	
	String subQry = "";
	
	if(chkDel!=null && "DEL".equals(chkDel))
	{
		subQry = "N',EPC_EXT1='DEL";
	}
	else if(chkDel!=null && "EDIT".equals(chkDel))
	{
		subQry = "N',EPC_DISCOUNT='"+chkVal+"',EPC_EXT1='EDIT";
	}
	else
	{
		subQry = status;
	}
	
	ezc.ezdiscount.client.EzDiscountManager ezDiscountManager = new ezc.ezdiscount.client.EzDiscountManager();
	
	EziDiscountParams ezDiscParams = new EziDiscountParams();
	EzcParams discMainParams = new EzcParams(false);
	
	if(promoCode!=null && !"null".equals(promoCode) && !"".equals(promoCode))
	{
		ezDiscParams.setStatus(subQry);
		ezDiscParams.setModifiedBy(user);
		ezDiscParams.setPromoCode(promoCode);

		discMainParams.setObject(ezDiscParams);
		discMainParams.setLocalStore("Y");
		Session.prepareParams(discMainParams);


		try
		{
			ezDiscountManager.ezEditPromotion(discMainParams);
		}
		catch(Exception e){}
	}
	
	response.sendRedirect("ezGetPromoCode.jsp");
%>