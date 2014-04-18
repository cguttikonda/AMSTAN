<%@ include file="../Misc/iBlockControl.jsp"%>  

<%@ page import = "ezc.ezcommon.*,ezc.ezdispatch.client.*,ezc.ezparam.*" %>
<%@ page import ="ezc.ezdispatch.params.*"%>
<jsp:useBean id="SOManager" class="ezc.sales.client.EzSalesOrderManager" scope="session"/>
<%@ page import = "ezc.ezutil.FormatDate"%>

<%
	//EzSalesManager Manager=new EzSalesManager();
	EzDispatchInfoManager manager = new EzDispatchInfoManager();

	EzcSalesOrderParams  SalesParams = new EzcSalesOrderParams();
	ezc.sales.params.EziSalesOrderStatusParams testParams=new ezc.sales.params.EziSalesOrderStatusParams();

	String soNum = null;
	String soDate= null; 
	String poNum= null; 
	String som = request.getParameter("SalesOrder");

	if (som!=null){
		StringTokenizer st=new StringTokenizer(som,"|");
		soNum =st.nextToken();
		poNum =st.nextToken();
		soDate=st.nextToken();
	}
	ReturnObjFromRetrieve delivHead=null;
	ReturnObjFromRetrieve retDel=null;
	if (soNum!=null)
	{	
		String skey = (String) session.getValue("SalesAreaCode");
 		String soldto = (String) session.getValue("AgentCode");

		testParams.setDocNumber(soNum);
		testParams.setSelection("H");
		testParams.setCustomerNumber(soldto);

     		SalesParams.createContainer();
		SalesParams.setObject(testParams);

		String oqty="";
		Session.prepareParams(SalesParams);
System.out.println("JJJJJJJJJJJJJJJJJJJAAAAAAAAAAAAAAAAAGGGGGGGGGGGGGGGGGGGAAAAAAAAAAAAAAA");
		//EzoSalesOrderDelivery soParams =(EzoSalesOrderDelivery) SOManager.getSalesOrderDelivery(SalesParams);
		//out.println("SOManager=================>>>	"+(ReturnObjFromRetrieve)SOManager.getSalesOrderDelivery(SalesParams));
		retDel=(ReturnObjFromRetrieve)SOManager.getSalesOrderDelivery(SalesParams);
		///out.println("retDelretDelretDel	"+retDel.toEzcString());
		delivHead = (ReturnObjFromRetrieve)retDel.getFieldValue(0,"DELIV_HEADER");		
		//if(delivHead!=null)
		//out.println("retDelretDelretDel	"+delivHead.toEzcString());
System.out.println("JJJJJJJJJJJJJJJJJJJAAAAAAAAAAAAAAAAAGGGGGGGGGGGGGGGGGGGAAAAAAAAAAAAAAA");
		//out.println("soParamssoParamssoParamssoParams	"+soParams);
		//delivHead = soParams.getDelivHeader();
		EzcParams params1=new EzcParams(true);
		params1.setLocalStore("Y");
		EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
		inParams.setSoNum(soNum);
		inParams.setSoldTo(soldto);
		inParams.setSysKey(skey);
		params1.setObject(inParams);
		Session.prepareParams(params1);
		retDel=(ReturnObjFromRetrieve)manager.ezGetDeliveryNumbers(params1);
	}
%>