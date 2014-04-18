<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ page import = "ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>

<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<jsp:useBean id="ConfigManager" class="ezc.client.EzSystemConfigManager" scope="session"/>


<div class="main-container col2-layout middle account-pages">
<div class="main">
<div class="col-main1">
<div class="page-title">

<%
		
		String selShipToInfo=request.getParameter("selShipTo_S");		
		String uId= (String)Session.getUserId().toUpperCase();						
		boolean updBoolS=false;
		EzcParams mainParamsSH= new EzcParams(false);
		EziMiscParams miscParamsSH= new EziMiscParams();
		
		miscParamsSH.setIdenKey("MISC_UPDATE");
		String query="UPDATE EZC_USER_DEFAULTS SET EUD_VALUE='"+selShipToInfo+"' WHERE EUD_USER_ID='"+uId+"' AND EUD_KEY='C_ERPSHIPTO'";
		miscParamsSH.setQuery(query);

		mainParamsSH.setLocalStore("Y");
		mainParamsSH.setObject(miscParamsSH);
		Session.prepareParams(mainParamsSH);	
		try
		{		
			ezc.ezcommon.EzLog4j.log("query::::::::"+query ,"I");
			ezMiscManager.ezUpdate(mainParamsSH);
			ezc.ezcommon.EzLog4j.log("query::::::::"+query ,"I");
			updBoolS=true;
		}
		catch(Exception e)
		{
			out.println("Exception in Getting Data"+e);
		}

		String displayHeader="No Change!";	
		if(updBoolS)
		{
			session.removeValue("ShipCode");				
			session.putValue("ShipCode",selShipToInfo);
			displayHeader="Default ShipTo Code has been switched";
		}
					
%>

<h2 ><%=displayHeader%></h2> 	

</div>


  <div class="buttons-set form-buttons">
        <p class="back-link"><a href="../Misc/ezDashBoard.jsp"><small>&laquo; </small>Go Home</a></p>
    </div>
	

<div class="col1-set">
<div class="info-box">


	
</div> <!-- Info box -->
</div> <!-- col1-set -->
</div> <!-- col-main -->
</div> <!--main -->
</div> <!-- main-container col1-layout -->