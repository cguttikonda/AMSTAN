<%@ page import="ezc.ezparam.*,ezc.ezsap.*,ezc.client.*"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ page import="ezc.ezmisc.params.*" %>
<%@ include file="../../../Includes/Lib/ezWorkFlow.jsp"%>
<jsp:useBean id="AUM" class="ezc.ezadmin.ezadminutils.client.EzAdminUtilsManager" scope="session" />
<%@ page import = "ezc.ezadmin.ezadminutils.params.*" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />

<%
	
	
	String user=Session.getUserId();	
	String userRole=(String)session.getValue("UserRole");	
	String LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	String LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME"); 
	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode"); 
	
	


//igetwfsessusers


	String template		= (String)session.getValue("Templet");
	String group		= (String)session.getValue("UserGroup");
	String catalog_area	= (String)session.getValue("SalesAreaCode");
	String desiredStep	= "";
	String superiorsusers 	= "";
	String participant	= "";
	String sabardinates 	= "";

	ArrayList desireStepV 	= new ArrayList();
	ArrayList downStepV 	= new ArrayList();
	if(userRole.equals("CU"))
	{
		desireStepV.add("-1");
		desireStepV.add("-2");
		desireStepV.add("-3");

	}else if(userRole.equals("CM"))
	{
		downStepV.add("1");
		desireStepV.add("-1");
		desireStepV.add("-2");

	}else if(userRole.equals("LF"))
	{
		desireStepV.add("-1");
		downStepV.add("1");
		downStepV.add("2");

	}else if(userRole.equals("BP"))
	{
		downStepV.add("1");
		downStepV.add("2");
		downStepV.add("3");
	}


	ezc.ezparam.ReturnObjFromRetrieve retsoldto = null;
	ezc.ezparam.ReturnObjFromRetrieve retsoldtoDown = null;

	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezworkflow.params.EziWFParams wfparams= new ezc.ezworkflow.params.EziWFParams();
	wfparams.setTemplate(template);
	wfparams.setSyskey(catalog_area);
	wfparams.setParticipant((String)session.getValue("Participant"));


	wfparams.setDesiredSteps(desireStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldto=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);


	wfparams.setDesiredSteps(downStepV);
	mainParams.setObject(wfparams);
	Session.prepareParams(mainParams);
	retsoldtoDown=(ezc.ezparam.ReturnObjFromRetrieve)EzWorkFlow.getWorkFlowUsers(mainParams);

	if(retsoldto != null)
	{
		int wfcount = retsoldto.getRowCount();
		String[] superiors = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			superiors[i] = retsoldto.getFieldValueString(i,"EU_ID");
			if(superiorsusers.trim().length() == 0)
				superiorsusers = (superiors[i]).trim();
			else
				superiorsusers += "','"+(superiors[i]).trim();

		}
	}
	if(retsoldtoDown != null)
	{
		int wfcount = retsoldtoDown.getRowCount();
		String[] sabardinate = new String[wfcount];
		for(int i=0;i<wfcount;i++)
		{
			sabardinate[i] = retsoldtoDown.getFieldValueString(i,"EU_ID");
			if(sabardinates.trim().length() == 0)
				sabardinates = (sabardinate[i]).trim();
			else
				sabardinates += "','"+(sabardinate[i]).trim();
		}
	}
	
	ReturnObjFromRetrieve partnersRet = null;
	String soldTo = (String) session.getValue("AgentCode");
	
	if(catalog_area!=null && soldTo!=null)
	{
		soldTo = soldTo.trim();
	
		String mySoldTo = "";
		
		try
		{
			soldTo = Long.parseLong(soldTo)+"";
			mySoldTo = "0000000000"+soldTo;
			mySoldTo = mySoldTo.substring((mySoldTo.length()-10),mySoldTo.length());
		}
		catch(Exception ex){mySoldTo = soldTo;}
	
		EziAdminUtilsParams adminUtilsParams = new EziAdminUtilsParams();
		adminUtilsParams.setSyskeys(catalog_area);
		adminUtilsParams.setPartnerValueBy(mySoldTo);

		mainParams.setObject(adminUtilsParams);
		Session.prepareParams(mainParams);

		partnersRet = (ReturnObjFromRetrieve)AUM.getUsersByPartnerValueAndArea(mainParams);
	}

	int partnersRetCnt = 0;
	String subuserIds="";
	
	if(partnersRet!=null)
	{
		for(int i=partnersRet.getRowCount()-1;i>=0;i--)
		{
			String tempuserId = partnersRet.getFieldValueString(i,"EU_ID");

			if("".equals(subuserIds))
			{
				subuserIds=(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
			else
			{
				subuserIds=subuserIds+"','"+(partnersRet.getFieldValueString(i,"EU_ID")).trim();
			}
		}
		
		partnersRetCnt = partnersRet.getRowCount();
	}	

	
//iwebsolist


	
	EzcParams mainParamsMisc= new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();
	
	ReturnObjFromRetrieve retObjMisc = null;
	int countMisc=0
		
	String orderStatus1="";
		
	for(int vlength=0;vlength<vec.size();vlength++)
		{
			if(vlength==0)
				orderStatus1=(String)(vec.get(vlength));
			else
				orderStatus1=orderStatus1+","+(String)(vec.get(vlength));
		}

		StringTokenizer stoken=new StringTokenizer(agentCode,",");
		String SoldTos ="";

		if (stoken.countTokens()>1)
		{
			while(stoken.hasMoreTokens())
			{
				if(SoldTos.trim().length() ==0)
				SoldTos="'"+stoken.nextToken()+"'";
				else
				SoldTos+=",'"+stoken.nextToken()+"'";
			}
		}
		else
			SoldTos=agentCode;		

		if("CU".equals(userRole) )
		{				
			
			
			
			
			

			//miscParams.setQuery("select * from EZC_SEC_SALES_WORKFLOW where essw_year='"+year+"' and essw_month='"+month+"'");
			miscParams.setQuery("SELECT EWDHH_AUTH_KEY AUTHKEY,EWDHH_DOC_ID DOCID,EWDHH_SYSKEY SYSKEY,EWDHH_KEY DOCKEY,EWDHH_DOC_DATE DOCDATE,EWDHH_WF_STATUS STATUS,EWDHH_CREATED_ON CREATEDON,EWDHH_MODIFIED_ON MODIFIEDON,EWDHH_CREATED_BY CREATEDBY,EWDHH_MODIFIED_BY MODIFIEDBY,EWDHH_CURRENT_STEP CURRENTSTEP,EWDHH_NEXT_PARTICIPANT NEXTPARTICIPANT,EWDHH_PARTICIPANT_TYPE PARTICIPANTTYPE, EWDHH_NEXT_D_PARTICIPANT DELPARTICIPANT,EWDHH_D_PARTICIPANT_TYPE DELPARTICIPANTTYPE,EWDHH_REF1 REF1 ,ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE   FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  
			WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_SYSKEY IN ('"+salesAreaCode+"') AND EWDHH_WF_STATUS IN ('NEGOTIATED') AND EWDHH_CREATED_BY 
			IN ('"+user+"','"+subuserIds+"','"+superiorsusers+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+agentCode+"') AND 
			ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'02/27/2012',110)");


			mainParamsMisc.setLocalStore("Y");
			mainParamsMisc.setObject(miscParams);
			Session.prepareParams(mainParamsMisc);	
			try
			{
				retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezGetData(mainParamsMisc);
				countMisc  = retObjMisc.getRowCount(); 
			}
			catch(Exception e)
			{
				out.println("Exception in Getting Data"+e);
			}
	
		}
		else if("CM".equals(userRole))
		{

			
				//miscParams.setQuery("select * from EZC_SEC_SALES_WORKFLOW where essw_year='"+year+"' and essw_month='"+month+"'");
				miscParams.setQuery("SELECT EWDHH_AUTH_KEY AUTHKEY,EWDHH_DOC_ID DOCID,EWDHH_SYSKEY SYSKEY,EWDHH_KEY DOCKEY,EWDHH_DOC_DATE DOCDATE,EWDHH_WF_STATUS STATUS,EWDHH_CREATED_ON CREATEDON,EWDHH_MODIFIED_ON MODIFIEDON,EWDHH_CREATED_BY CREATEDBY,EWDHH_MODIFIED_BY MODIFIEDBY,EWDHH_CURRENT_STEP CURRENTSTEP,EWDHH_NEXT_PARTICIPANT NEXTPARTICIPANT,EWDHH_PARTICIPANT_TYPE PARTICIPANTTYPE, EWDHH_NEXT_D_PARTICIPANT DELPARTICIPANT,EWDHH_D_PARTICIPANT_TYPE DELPARTICIPANTTYPE,EWDHH_REF1 REF1 ,ESDH_DOC_NUMBER WEB_ORNO,ESDH_ORDER_DATE  ORDER_DATE,ESDH_PO_NO PO_NO,ESDH_SOLD_TO SOLD_TO_CODE,ESDH_BACK_END_ORDER BACKEND_ORNO,ESDH_STATUS_DATE STATUS_DATE,ESDH_RES1 RES1,ESDH_SOLDTO_ADDR_1 SOTO_ADDR1,ESDH_SHIP_TO SHIP_TO_CODE, ESDH_SHIPTO_ADDR_1 SHTO_ADDR1,ESDH_PURCH_DATE PURCH_DATE   FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  
				WHERE  EWDHH_AUTH_KEY IN ('SO_CREATE') AND EWDHH_SYSKEY IN ('"+salesAreaCode+"') AND EWDHH_WF_STATUS IN ('NEGOTIATED') AND EWDHH_CREATED_BY 
				IN ('"+user+"','"+SoldTos+"') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN ('"+agentCode+"') AND 
				ESDH_ORDER_DATE BETWEEN  CONVERT(DATETIME,'04/01/2011',110)  AND  CONVERT(DATETIME,'02/27/2012',110)");

				mainParamsMisc.setLocalStore("Y");
				mainParamsMisc.setObject(miscParams);
				Session.prepareParams(mainParamsMisc);	
				
				try
				{
					retObjMisc = (ReturnObjFromRetrieve)ezMiscManager.ezGetData(mainParamsMisc);
					countMisc  = retObjMisc.getRowCount(); 
				}
				catch(Exception e)
				{
					out.println("Exception in Getting Data"+e);
				}
	

		}


	
	

	
%>

