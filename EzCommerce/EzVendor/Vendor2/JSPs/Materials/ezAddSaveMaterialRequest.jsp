<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iCacheControl.jsp" %>
<%@ include file="../../../Includes/JSPs/Misc/iEzDateConvertion.jsp" %>

<%@ page import="java.util.*,java.text.*"%>
<%@ page import="ezc.ezparam.*" %>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session">
</jsp:useBean>
<jsp:useBean id="AppManager" class="ezc.ezvendorapp.client.EzVendorAppManager" />

<%
	String matdesc=request.getParameter("mat_desc");
	String matuom=request.getParameter("mat_uom");
	String matqty=request.getParameter("mat_qty");
	String comments=request.getParameter("comments");
	String sysKey=(String)session.getValue("SYSKEY");
	String type=request.getParameter("Type");

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezvendorapp.params.EzMaterialRequestStructure struct =  new ezc.ezvendorapp.params.EzMaterialRequestStructure();
	Date d=new Date();
	SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
	String SysDate=sdf.format(d);

	struct.setMaterialDesc(matdesc);
	struct.setUom(matuom);
	struct.setRequiredQty(matqty);
	struct.setRequestDesc(comments);
	struct.setCreatedDate(SysDate);
	struct.setCreatedBy(Session.getUserId());
	struct.setActivationDate(SysDate);
	struct.setClosingDate("");
	struct.setCurrentStatus("A");
	struct.setRefDocNo("1");
	struct.setVisibilityLevel(request.getParameter("chk1"));
	struct.setSysKey(sysKey);
	String reqDate = request.getParameter("reqDate");
	if(reqDate==null)
	{
		reqDate="";
	}
	else
	{
		reqDate=dateConvertion(reqDate,(String)session.getValue("DATEFORMAT"));
	}
	struct.setExt1(reqDate);
	struct.setExt2("");
	struct.setRequestType(type);

	mainParams.setObject(struct);
	mainParams.setLocalStore("Y");
	Session.prepareParams(mainParams);
	AppManager.ezAddMaterialRequest(mainParams);

	response.sendRedirect("ezListMaterialsInternal.jsp?Type="+type);

%>
<Div id="MenuSol"></Div>
