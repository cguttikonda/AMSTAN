<%@ include file="../Misc/iBlockControl.jsp"%>  
<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.ezparam.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%@ include file="../../../Includes/Lib/ezGlobalBean.jsp"%>
<%
	//status Getting from the menu to display Delivered/Acknowledged Orders. 
	String Stat=request.getParameter("Stat");
	String qFlag=request.getParameter("qFlag");
	String skey=(String) session.getValue("SalesAreaCode");
	String soldto=(String) session.getValue("AgentCode");
	
	EzDispatchInfoManager manager=new EzDispatchInfoManager();
	EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
	EzcParams params=new EzcParams(true);
	params.setLocalStore("Y");

	inParams.setSoldTo(soldto.trim());
	inParams.setSysKey(skey);
	inParams.setStatus("'"+Stat+"'"); // R or D
	inParams.setQueryFlag("ALL");
	
	if(!"ALL".equals(qFlag))
	{
		try{
		String LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
		int yy =Integer.parseInt(LAST_LOGIN_DATE.substring(6,10));
		int mm =Integer.parseInt(LAST_LOGIN_DATE.substring(0,2));
		int dd=Integer.parseInt(LAST_LOGIN_DATE.substring(3,5));
		//out.println(mm+"/"+dd+"/"+yy);
		//inParams.setFromDate(mm+"/"+dd+"/"+yy);
		inParams.setFromDate("01/01/1995");
		}catch(Exception e){out.println(e);}
	}

	
	
	//inParams.setCreatedBy(Session.getUserId());
	params.setObject(inParams);
	Session.prepareParams(params);

System.out.println("Sureshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
	//ReturnObjFromRetrieve retobj=new ReturnObjFromRetrieve(); //(ReturnObjFromRetrieve)manager.ezGetSalesOrders(params);
	ReturnObjFromRetrieve retobj=(ReturnObjFromRetrieve)manager.ezGetSalesOrders(params);
System.out.println("Sureshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhend");

	int retCount=retobj.getRowCount();
	ezc.ezparam.ReturnObjFromRetrieve retGlobal=null;
	//if("ALL".equals(qFlag))
	//{
		Vector types = new Vector();
		types.addElement("date");
		types.addElement("date");
		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		names.addElement("EZDI_DC_DATE");
		names.addElement("EZDI_EXP_ARIVAL_TIME");
		EzGlobal.setColNames(names);
		retGlobal = EzGlobal.getGlobal(retobj);
	//}

%>
