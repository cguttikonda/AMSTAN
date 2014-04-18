<%@ page import ="ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.ezparam.*"%>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%

	ezc.client.EzcUtilManager UtilManager =new ezc.client.EzcUtilManager(Session);
	String soldto=(String) session.getValue("AgentCode");
	String syskey=(String) session.getValue("SalesAreaCode");
	
	String sonum=request.getParameter("SalesOrder");
	String Stat=request.getParameter("Stat");
	String St="";
	if (Stat!=null)
		St=Stat;
	if ((Stat==null)||("".equals(Stat.trim())))
		Stat="'R','D'";
	else
		Stat="'"+Stat+"'";

	ReturnObjFromRetrieve retList=null;
	EzDispatchInfoManager manager=new EzDispatchInfoManager();
	EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
	EzcParams params=new EzcParams(true);
	params.setLocalStore("Y");

	if (sonum!=null)
	{
		inParams.setSoNum(sonum);
		inParams.setStatus(Stat);
		inParams.setSoldTo(soldto);
		inParams.setSysKey(syskey);

		params.setObject(inParams);
		Session.prepareParams(params);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		retList=(ReturnObjFromRetrieve)manager.ezGetAllHeaders(params);
	}
%>
