<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	String servType = request.getParameter("servType");
	String countryCode = request.getParameter("countryCode");
	String zipCode = request.getParameter("zipCode");
	String weight = request.getParameter("weight");
	String packType = request.getParameter("packType");
	
	ezc.ezcommon.EzLog4j.log("servType::::"+servType,"D");
	ezc.ezcommon.EzLog4j.log("countryCode::::"+countryCode,"D");
	ezc.ezcommon.EzLog4j.log("zipCode::::"+zipCode,"D");
	ezc.ezcommon.EzLog4j.log("weight::::"+weight,"D");
	ezc.ezcommon.EzLog4j.log("packType::::"+packType,"D");
	
	int zoneCnt = 0;
	String zoneNo = "";
	
	EziZoneMapParams eziZoneParams = new EziZoneMapParams();
	EzcParams zoneParams = new EzcParams(false);
	
	eziZoneParams.setType("ZONE_BY_ZIP_COUNTRYCODE");
	eziZoneParams.setCountryCode(countryCode);
	eziZoneParams.setZip(zipCode);
	zoneParams.setObject(eziZoneParams);
	Session.prepareParams(zoneParams);
	ReturnObjFromRetrieve zoneRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetZoneMap(zoneParams);
	
	if(zoneRet!=null)
		zoneCnt = zoneRet.getRowCount();

	if(zoneCnt>0)
	{
		zoneNo = zoneRet.getFieldValueString(0,"EFZ_ZONE");
		
		ezc.ezcommon.EzLog4j.log("zoneNo::::"+zoneNo,"D");
		
		int fmCnt = 0;
		
		String wtQry = " AND EFFM_WEIGHT_INPOUNDS>="+weight+" ORDER BY EFFM_WEIGHT_INPOUNDS ASC";
		
		if(packType!=null && "ENV".equals(packType)) wtQry = "";
		
		String subQuery = "WHERE EFFM_STYPE_CODE='"+servType+"' AND EFFM_ZONE='"+zoneNo+"' AND EFFM_COUNTRY_CODE='"+countryCode+"'"+wtQry;
		
		EziFreightMasterParams eziFMParams = new EziFreightMasterParams();
		EzcParams fmParams = new EzcParams(false);

		eziFMParams.setType("GET_ALL_FREIGHTS");
		eziFMParams.setExt1(subQuery);
		fmParams.setObject(eziFMParams);
		Session.prepareParams(fmParams);
		ReturnObjFromRetrieve fmRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetFreightMaster(fmParams);

		if(fmRet!=null)
			fmCnt = fmRet.getRowCount();
		
		if(fmCnt==0 && !"".equals(wtQry))
		{
			wtQry = " AND EFFM_WEIGHT_INPOUNDS<"+weight+" AND EFFM_KEY='G' ORDER BY EFFM_WEIGHT_INPOUNDS DESC";
			subQuery = "WHERE EFFM_STYPE_CODE='"+servType+"' AND EFFM_ZONE='"+zoneNo+"' AND EFFM_COUNTRY_CODE='"+countryCode+"'"+wtQry;
			eziFMParams.setExt1(subQuery);
			fmRet = (ReturnObjFromRetrieve)EzFreightManager.ezGetFreightMaster(fmParams);
			fmCnt = fmRet.getRowCount();
		}
		
		if(fmCnt>0)
		{
			String freightPrice = fmRet.getFieldValueString(0,"EFFM_PRICE");
			String fKey = fmRet.getFieldValueString(0,"EFFM_KEY");
			
			java.math.BigDecimal fPrice_bd = null;
			java.math.BigDecimal fWeight_bd = null;
			java.math.BigDecimal totFreight_bd = null;
			
			if(fKey!=null && ("R".equals(fKey) || "G".equals(fKey)))
			{
				try
				{
					fPrice_bd = new java.math.BigDecimal(freightPrice);
					fWeight_bd = new java.math.BigDecimal(weight);
					
					totFreight_bd = fWeight_bd.multiply(fPrice_bd);
					totFreight_bd = totFreight_bd.setScale(2,java.math.BigDecimal.ROUND_UP);
					
					freightPrice = totFreight_bd.toString();
				}
				catch(Exception e){}
			}
			
			ezc.ezcommon.EzLog4j.log("freightPrice::::"+freightPrice,"D");
			
			out.print("FRIEGHT#"+freightPrice);
		}
	}
%>