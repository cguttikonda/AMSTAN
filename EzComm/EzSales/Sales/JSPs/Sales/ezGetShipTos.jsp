<%@ page import="ezc.ezparam.*,ezc.ezmisc.params.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%!
	public Vector getSubUserShips(String user_id,ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		miscParams.setIdenKey("MISC_SELECT");
		//String query="SELECT A.*, B.ECA_NO, B.ECA_NAME, B.ECA_COMPANY_NAME,B.ECA_ERP_UPDATE_FLAG, B.ECA_PHONE, B.ECA_ADDR_2,B.ECA_ADDR_1,B.ECA_CITY,B.ECA_STATE,B.ECA_PIN,B.ECA_COUNTRY,B.ECA_TRANSORT_ZONE,B.ECA_JURISDICTION_CODE,B.ECA_LANG,B.ECA_EMAIL,B.ECA_WEB_ADDR FROM EZC_CUSTOMER A , EZC_CUSTOMER_ADDR B WHERE  A.EC_PARTNER_FUNCTION IN ('WE') AND A.EC_PARTNER_NO IN (SELECT DISTINCT(EECD_DEFAULTS_VALUE) FROM EZC_ERP_CUSTOMER_DEFAULTS WHERE EECD_NO IN (SELECT EUD_VALUE FROM EZC_USER_DEFAULTS WHERE EUD_USER_ID='"+user_id+"' AND EUD_KEY='SOLDTOPARTY' ) AND EECD_DEFAULTS_KEY='SHIPTO' AND EECD_USER_ID='"+user_id+"') AND B.ECA_LANG = 'EN' AND A.EC_NO = B.ECA_NO AND EC_SYS_KEY='"+sysKey+"' AND EC_BUSINESS_PARTNER='"+bussPart+"'";
		String query="SELECT DISTINCT(EUD_VALUE) SHIPTO FROM EZC_USER_DEFAULTS WHERE  EUD_USER_ID='"+user_id+"' AND EUD_KEY='SHIPTOPARTY' ";

		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		Vector toDelShips = null;
		int retCnt = 0;
		if(retObjMisc!=null){
			retCnt = retObjMisc.getRowCount();
			toDelShips =new Vector();
		}	
		if(retCnt>0)	
		{
			for(int i=0;i<retCnt;i++)	
			{
				toDelShips.add(retObjMisc.getFieldValueString(i,"SHIPTO"));		

			}
		}

		return toDelShips;
	}	
	public ReturnObjFromRetrieve getListOfShipTos(String selSol,String userType,String BussPart, String isSubUser, ezc.session.EzSession Session)
	{
		

		ezc.ezparam.ReturnObjFromRetrieve retObjMisc =null;
		ezc.ezparam.EzcParams mainParamsMisc= new ezc.ezparam.EzcParams(false);
		
		ezc.ezmisc.params.EziMiscParams miscParams = new ezc.ezmisc.params.EziMiscParams();
		ezc.ezmisc.client.EzMiscManager ezMiscManager = new ezc.ezmisc.client.EzMiscManager();
		
		miscParams.setIdenKey("MISC_SELECT");
		
		String appendQry = "";
		if("3".equals(userType))
			appendQry = "AND EC_BUSINESS_PARTNER='"+BussPart+"'";
		String query="SELECT DISTINCT(EC_PARTNER_NO),ECA_COMPANY_NAME,ECA_ACCOUNT_GROUP,ECA_EXT1 FROM EZC_CUSTOMER,EZC_CUSTOMER_ADDR WHERE EC_ERP_CUST_NO='"+selSol+"' AND EC_PARTNER_FUNCTION='WE' AND EC_NO=ECA_NO ";
	
		miscParams.setQuery(query);
		mainParamsMisc.setLocalStore("Y");
		mainParamsMisc.setObject(miscParams);
		Session.prepareParams(mainParamsMisc);	

		try
		{		
			ezc.ezcommon.EzLog4j.log("miscParams.getQuery()::34566::::::"+miscParams.getQuery() ,"I");
			retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezSelect(mainParamsMisc);
			if("Y".equals(isSubUser))
			{
				if(retObjMisc!=null)
				{
					Vector delShips = (Vector)getSubUserShips(Session.getUserId(),Session);
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String toBeDel = retObjMisc.getFieldValueString(i,"EC_PARTNER_NO");
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
						{
							retObjMisc.deleteRow(i);
						}
						else
						{
							if(!delShips.contains(toBeDel))
								retObjMisc.deleteRow(i);
						}
					}
				}
			}			
			else
			{
				if(retObjMisc!=null)
				{
					for(int i=retObjMisc.getRowCount()-1;i>=0;i--)
					{
						String blockCode_A = retObjMisc.getFieldValueString(i,"ECA_EXT1");
						if(blockCode_A!=null && "BL".equalsIgnoreCase(blockCode_A))
							retObjMisc.deleteRow(i);
					}
				}
			}
		}
		catch(Exception e)
		{
			ezc.ezcommon.EzLog4j.log("Exception in Getting Data"+e,"E");
		}
		

		return retObjMisc;
	}
%>
<%
	String selSoldTo = request.getParameter("selSoldTo");
	String selSold="",soldToQT="";
	String shipToQT = request.getParameter("shipTo");
	EzcParams focParamsMisc = new EzcParams(false);
	EziMiscParams focParams = new EziMiscParams();

	ReturnObjFromRetrieve retShips = null;

	if(selSoldTo!=null && !"null".equalsIgnoreCase(selSoldTo) && !"".equals(selSoldTo))
	{
		selSold = (String)session.getValue("AgentCode");
		soldToQT = (String)session.getValue("AgentCode");

		if(request.getParameter("selSoldTo")!=null && !"".equals(request.getParameter("selSoldTo")) && !"null".equals(request.getParameter("selSoldTo")))		
		
		try
		{
			retShips = (ReturnObjFromRetrieve)getListOfShipTos(selSold.split("##")[0],(String)session.getValue("UserType"),(String)session.getValue("BussPart"),(String)session.getValue("IsSubUser"),Session);
			ezc.ezcommon.EzLog4j.log("ezGetShipTos.jsp1::::::::::::"+retShips.toEzcString(),"I");
		}
		catch(Exception e){ezc.ezcommon.EzLog4j.log("Error in ezGetShipTos.jsp::::::::::::","I");}
	}

	String buffer = "<select name='shipTo'  style='width:300px !important;'><option value = 'A'>ALL </option>";
	
  		ArrayList byPassShips = new ArrayList();
 		if(retShips!=null)
 		{
 			retShips.sort(new String[]{"EC_PARTNER_NO"},true);
 			for(int i=0;i<retShips.getRowCount();i++)
 			{
 				String shipToCode_A 	= retShips.getFieldValueString(i,"EC_PARTNER_NO");
 				String shipToName_A 	= retShips.getFieldValueString(i,"ECA_COMPANY_NAME");
				
				if(byPassShips.contains(shipToCode_A))
					continue;
				else
					byPassShips.add(shipToCode_A); 				
 
 				String tempShip 	= retShips.getFieldValueString(i,"ECA_ACCOUNT_GROUP");
				if("CPDA".equalsIgnoreCase(tempShip)) shipToName_A = "Drop Ship";

				String selected_A = "selected";
 
 				if(shipToQT.equals(shipToCode_A))
 				{
 					buffer = buffer+"<option value='"+shipToCode_A+"'"+selected_A+"> "+shipToName_A+" : "+shipToCode_A+"</option>";
 				}	 
 				else
 				{
 					buffer = buffer+"<option value='"+shipToCode_A+"'> "+shipToName_A+" : "+shipToCode_A+"</option>"; 					
  				}
 			}
 		}

	buffer = buffer+"</select>";

	response.getWriter().println(buffer);
%>