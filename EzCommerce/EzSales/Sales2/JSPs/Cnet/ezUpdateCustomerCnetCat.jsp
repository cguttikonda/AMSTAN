<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iBlockControl.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%@ page import="ezc.ezparam.*" %>
<%

	String soldTo = request.getParameter("soldToSel");
	String catCnt = request.getParameter("retCatCnt");
	java.util.ArrayList aL = new java.util.ArrayList();
	int cnt = 0;
	try
	{
		cnt = Integer.parseInt(catCnt);
	}
	catch(Exception e)
	{
		cnt = 0;
	}
	
	for(int i=0;i<cnt;i++)
	{
		String chkBox = request.getParameter("ic_"+(i+1));
		if(chkBox!=null)
			aL.add(chkBox);
	}
	if(aL.size()>0)
	{
		String[] ics = new String[aL.size()];
		for(int k=0;k<aL.size();k++)
			ics[k] = (String)aL.get(k);
			
			



		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("DEL_CUST");
		ecic.setSoldTo(soldTo);
		ecic.setExt1((String)session.getValue("SalesAreaCode"));
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		webCatalogObj.deleteCustomerCategories(catalogParams);

		catalogParams = new ezc.ezparam.EzCatalogParams();
		ecic = new EzCustomerItemCatParams();
		
		catalogParams.setType("ADD_CUST_IC");
		ecic.setSoldTo(soldTo);
		ecic.setItemCats(ics);
		ecic.setCreatedBy(Session.getUserId());
		ecic.setExt1((String)session.getValue("SalesAreaCode"));
		ecic.setExt2("");
		ecic.setExt3("");
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		webCatalogObj.addCustomerCategories(catalogParams);



	}
	else
	{
		EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
		EzCustomerItemCatParams ecic = new EzCustomerItemCatParams();

		catalogParams.setType("DEL_CUST");
		ecic.setSoldTo(soldTo);
		ecic.setExt1((String)session.getValue("SalesAreaCode"));
		catalogParams.setLocalStore("Y");
		catalogParams.setObject(ecic);
		Session.prepareParams(catalogParams);

		webCatalogObj.deleteCustomerCategories(catalogParams);
	
	
	}
	response.sendRedirect("ezListCustomerCnetCat.jsp?soldTo="+soldTo+"&upd=Y");
%>