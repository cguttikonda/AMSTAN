<%@ page import = "ezc.ezcommon.*,ezc.ezdispatch.client.*,ezc.client.*,ezc.ezparam.*,java.util.*" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%
	FormatDate fd=new FormatDate();
	String soNum=request.getParameter("soNo");
	String soDate=request.getParameter("soDate");
	String poNum=request.getParameter("poNo");
	String delNo=request.getParameter("DeliveryNo"); 
%>
<%@ include file="../../../Includes/JSPs/DeliverySchedule/iDelLines.jsp"%>


   