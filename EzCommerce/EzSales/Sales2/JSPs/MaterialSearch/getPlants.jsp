<%@ page import="ezc.ezparam.*" %>
<%@ include file="../../../Includes/Lib/SessionBean.jsp"%>
<%@ include file="iStaticLogin.jsp"%>
<%
	ezc.ezparam.EzcParams   myParams	=new ezc.ezparam.EzcParams(true);
	ezc.ezmaterialsearch.client.EzMaterialSearchManager msManager	=new ezc.ezmaterialsearch.client.EzMaterialSearchManager();
	ezc.ezmaterialsearch.params.EziMaterialAvailabilityParams msParams	=new ezc.ezmaterialsearch.params.EziMaterialAvailabilityParams();
	msParams.setSalesOrg("0010");
	msParams.setDistrChan("10");
	myParams.setObject(msParams);
	Session.prepareParams(myParams);
	  ReturnObjFromRetrieve retPlantList = (ezc.ezparam.ReturnObjFromRetrieve)msManager.ezGetPlants(myParams);
	out.println(retPlantList.toEzcString());
%>		