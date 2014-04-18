<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.ezparam.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	ezc.client.EzcUtilManager utilManager =  new ezc.client.EzcUtilManager(Session);

	String SoldTo=(String) session.getValue("AgentCode");
	String SysKey=(String) session.getValue("SalesAreaCode");

	String delNum=request.getParameter("DeliveryNo");
	/*String sto=request.getParameter("soldTo");

	String defSoldTo =""; 

	boolean flag=false;
	StringTokenizer stoken=new StringTokenizer(SoldTo,",");
	if (stoken.countTokens()>1)
		flag=true;


	if ((flag)&&(sto!=null)&&(!("".equals(sto)))){
		defSoldTo= utilManager.getUserDefErpSoldTo();
		if (!(defSoldTo.equals(sto)))
			utilManager.setSysKeyAndSoldTo(SysKey,sto.trim());
	}*/
	

	EzDispatchInfoManager manager=new EzDispatchInfoManager();
	EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
	EzcParams params=new EzcParams(true);
	params.setLocalStore("Y");

	inParams.setDelvNo(delNum);
	params.setObject(inParams);
	Session.prepareParams(params);
	ReturnObjFromRetrieve retHeadDetails=(ReturnObjFromRetrieve)manager.ezGetDispInfoHeader(params);

	EziDispInfoLinesInputParams inParams1 = new EziDispInfoLinesInputParams();
	inParams1.setDelvNo(delNum);
	params.setObject(inParams1);
	Session.prepareParams(params);
	ReturnObjFromRetrieve retLineDetails=(ReturnObjFromRetrieve)manager.ezGetDispInfoLines(params);

	/*if ((flag)&&(sto!=null)&&(!("".equals(sto)))){
		if (!(defSoldTo.equals(sto)))
			utilManager.setSysKeyAndSoldTo(SysKey,defSoldTo);
	}*/
%>
