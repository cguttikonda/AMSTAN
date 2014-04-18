<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%
	String approver	= request.getParameter("approver");

	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve fdActRetObj = null;
	String query = "";

	if(approver!=null && !"null".equalsIgnoreCase(approver) && !"".equals(approver))
	{
		focParams.setIdenKey("MISC_SELECT");

		query = "SELECT VALUE2 FROM EZC_VALUE_MAPPING WHERE MAP_TYPE='APPRTOACCT' AND VALUE1='"+approver+"'";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	if(fdActRetObj!=null)
	{
		String soldTo_A = "";

		for(int i=0;i<fdActRetObj.getRowCount();i++)
		{
			String tempSold_A = fdActRetObj.getFieldValueString(i,"VALUE2");
			tempSold_A = "0000000000"+tempSold_A;
			tempSold_A = tempSold_A.substring(tempSold_A.length()-10,tempSold_A.length());

			if("".equals(soldTo_A))
				soldTo_A = tempSold_A;
			else
				soldTo_A = soldTo_A+"','"+tempSold_A;
		}
		focParams.setIdenKey("MISC_SELECT");

		//query = "SELECT DISTINCT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_SYS_KEY = '"+sysKey+"' AND A.EC_PARTNER_FUNCTION IN ('AG') AND A.EC_ERP_CUST_NO IN ('"+soldTo_A+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";
		query = "SELECT DISTINCT A.*, B.* FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE A.EC_PARTNER_FUNCTION IN ('AG') AND A.EC_ERP_CUST_NO IN ('"+soldTo_A+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO";

		focParams.setQuery(query);

		focParamsMisc.setLocalStore("Y");
		focParamsMisc.setObject(focParams);
		Session.prepareParams(focParamsMisc);	

		try
		{
			fdActRetObj = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(focParamsMisc);
		}
		catch(Exception e){}
	}

	String buffer = "<select id='selSoldToInfo' name='selSoldToInfo'><option value=''>------Select------</option>";
	if(fdActRetObj!=null)
	{
		String selSoldName 	= "";
		String selSoldAddr1	= "";
		String selSoldCity 	= "";
		String selSoldState 	= "";
		String selSoldCountry 	= "";
		String selSoldZipCode	= "";
		String selSoldPhNum 	= "";
		String selSoldEmail 	= "";

		java.util.ArrayList fdAct_AL = new java.util.ArrayList();

		for(int i=0;i<fdActRetObj.getRowCount();i++)
		{
			String blockCode_A 	= fdActRetObj.getFieldValueString(i,"ECA_EXT1");
			if(blockCode_A==null || "null".equalsIgnoreCase(blockCode_A)) blockCode_A = "";

			if(!"BL".equalsIgnoreCase(blockCode_A))
			{

			String soldToCode_A 	= fdActRetObj.getFieldValueString(i,"EC_ERP_CUST_NO");
			String soldToName_A 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");

			if(fdAct_AL.contains(soldToCode_A))
				continue;

			fdAct_AL.add(soldToCode_A);

			selSoldName 	= fdActRetObj.getFieldValueString(i,"ECA_NAME");
			selSoldAddr1	= fdActRetObj.getFieldValueString(i,"ECA_ADDR_1");
			selSoldCity 	= fdActRetObj.getFieldValueString(i,"ECA_CITY");
			selSoldState 	= fdActRetObj.getFieldValueString(i,"ECA_DISTRICT");
			selSoldCountry 	= fdActRetObj.getFieldValueString(i,"ECA_COUNTRY");
			selSoldZipCode	= fdActRetObj.getFieldValueString(i,"ECA_POSTAL_CODE");
			selSoldPhNum 	= fdActRetObj.getFieldValueString(i,"ECA_PHONE");
			selSoldEmail 	= fdActRetObj.getFieldValueString(i,"ECA_EMAIL");

			selSoldAddr1 	= (selSoldAddr1==null || "null".equals(selSoldAddr1)|| "".equals(selSoldAddr1))?"":selSoldAddr1;
			selSoldCity 	= (selSoldCity==null || "null".equals(selSoldCity)|| "".equals(selSoldCity))?"":selSoldCity;// for city
			selSoldState 	= (selSoldState==null || "null".equals(selSoldState) || "".equals(selSoldState))?"":selSoldState;
			selSoldCountry 	= (selSoldCountry==null || "null".equals(selSoldCountry)|| "".equals(selSoldCountry))?"":selSoldCountry.trim();
			selSoldZipCode 	= (selSoldZipCode==null || "null".equals(selSoldZipCode)|| "".equals(selSoldZipCode))?"":selSoldZipCode;
			selSoldPhNum 	= (selSoldPhNum==null || "null".equals(selSoldPhNum)|| "".equals(selSoldPhNum))?"":selSoldPhNum;
			selSoldEmail 	= (selSoldEmail==null || "null".equals(selSoldEmail)|| "".equals(selSoldEmail))?"":selSoldEmail;

			String soldParams = selSoldName+"#"+selSoldAddr1+"#"+selSoldCity+"#"+selSoldState+"#"+selSoldCountry+"#"+selSoldZipCode+"#"+selSoldPhNum+"#"+soldToCode_A;
			buffer = buffer+"<option value='"+soldParams+"'>"+soldToCode_A+"("+soldToName_A+")</option>";
			}
		}
	}
	buffer = buffer+"</select>";
	response.getWriter().println(buffer);
%>