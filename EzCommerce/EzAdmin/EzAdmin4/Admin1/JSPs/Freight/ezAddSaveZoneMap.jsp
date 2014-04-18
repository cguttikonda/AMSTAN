<%@ page import="java.util.*,ezc.ezparam.*,ezc.fedex.freight.params.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"/>
<jsp:useBean id="EzFreightManager" class="ezc.fedex.freight.client.EzFreightManager" scope="page"/>
<%
	String countryCode = request.getParameter("countryCode");
	String fromZipStr = request.getParameter("fromZip");
	String toZipStr = request.getParameter("toZip");
	String zone = request.getParameter("zone");
	String dispData ="";
	
	int fromZip = Integer.parseInt(fromZipStr);
	int toZip = Integer.parseInt(toZipStr);
	
	EziZoneMapParams eziZoneMapParams = new EziZoneMapParams();
	EzcParams params = new EzcParams(false);
	
	eziZoneMapParams.setType("ZONES_BY_COUNTRYCODE");
	eziZoneMapParams.setCountryCode(countryCode);
	params.setObject(eziZoneMapParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve zmByCountry = (ReturnObjFromRetrieve)EzFreightManager.ezGetZoneMap(params);
	
	boolean zmExist = false;
	if(zmByCountry!=null && zmByCountry.getRowCount()>0)
	{
		for(int i=0;i<zmByCountry.getRowCount();i++)
		{
			String zoneFrmRet = zmByCountry.getFieldValueString(i,"EFZ_ZONE");
			int frmZpRet = Integer.parseInt(zmByCountry.getFieldValueString(i,"EFZ_FROM_ZIP"));
			int toZpRet = Integer.parseInt(zmByCountry.getFieldValueString(i,"EFZ_TO_ZIP"));
			
			if(zone.equals(zoneFrmRet))
			{
				if(fromZip>=frmZpRet && fromZip<=toZpRet)
				{
					zmExist = true;
					break;
				}
				if(toZip>=frmZpRet && toZip<=toZpRet)
				{
					zmExist = true;
					break;
				}
			}
		}
	}
	
	if(!zmExist)
	{
	
		eziZoneMapParams = new EziZoneMapParams();
		params = new EzcParams(false);

		eziZoneMapParams.setType("ADD_ZONE_MAP");
		eziZoneMapParams.setCountryCode(countryCode);
		eziZoneMapParams.setFromZip(fromZipStr);
		eziZoneMapParams.setToZip(toZipStr);
		eziZoneMapParams.setZone(zone);
		eziZoneMapParams.setCreatedBy(Session.getUserId());
		eziZoneMapParams.setModifiedBy(Session.getUserId());
		eziZoneMapParams.setExt1("");
		eziZoneMapParams.setExt2("");
		eziZoneMapParams.setExt3("");
		
		params.setObject(eziZoneMapParams);
		Session.prepareParams(params);
		EzFreightManager.ezAddZoneMap(params);
		
		dispData = "Zone mapping added successfully";
	}
	else
	{
		dispData = "<font color=red>Given mapping conflicts with existing mapping</font>";
	
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
		<a href="ezAddZoneMap.jsp"><img src="../../Images/Buttons/<%= ButtonDir%>/ok.gif" border=none></a>
		<!--<a href="javascript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>-->
	</Center>
</body>
</html>