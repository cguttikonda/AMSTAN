<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ page import = "ezc.ezdispatch.params.*,ezc.ezdispatch.client.*,ezc.ezparam.*,ezc.sales.params.*" %>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>

<%
	//String soldto=(String) session.getValue("AgentCode");
	String soldto	= (String) session.getValue("docSoldTo");
	String syskey	= (String) session.getValue("SalesAreaCode");
	String soNo 	= request.getParameter("SalesOrder");

	EzDispatchInfoManager manager=new EzDispatchInfoManager();

	EzcSalesOrderParams  SalesOrderParams = new EzcSalesOrderParams();

	EziSalesOrderStatusParams testParams=new EziSalesOrderStatusParams();

	ReturnObjFromRetrieve finalRetObject=null;
	ReturnObjFromRetrieve delivHead=null;
	ReturnObjFromRetrieve retDel=new ReturnObjFromRetrieve();
	if (soNo!=null)
	{	
		testParams.setDocNumber(soNo);
		testParams.setSelection("H");
		testParams.setCustomerNumber( soldto);

     		SalesOrderParams.createContainer();
		SalesOrderParams.setObject(testParams);
		Session.prepareParams(SalesOrderParams);
		//EzoSalesOrderDelivery params =(EzoSalesOrderDelivery) EzSalesOrderManager.getSalesOrderDelivery(SalesOrderParams);
		//delivHead = params.getDelivHeader();
		//ReturnObjFromRetrieve params =(ReturnObjFromRetrieve) EzSalesOrderManager.getSalesOrderDelivery(SalesOrderParams);
		//delivHead = (ReturnObjFromRetrieve)params.getFieldValue("DELIV_HEADER");

		//For American Standard demo
		String sDoc_JCO = soNo;
		String sSoldTo_JCO = soldto;
		String sSorg_JCO = "BP01";
		String sSel_JCO = "H";
%>		
		<%@ include file="iInvoiceJCO.jsp"%>
<%		
		//out.println("finalRetObject::"+finalRetObject.toEzcString());
		delivHead = (ReturnObjFromRetrieve)finalRetObject.getFieldValue("DELIV_HEADER");
		//out.println("delivHead::"+delivHead.toEzcString());
		//For American Standard demo
		
		
		// this part has been commented because in ranbaxy we do not have sales order no in header level as deliveries are for billing doc and not sales order
		/*EzcParams params1=new EzcParams(true);
		params1.setLocalStore("Y");

		EziDispInfoHeaderInputParams inParams=new EziDispInfoHeaderInputParams();
		inParams.setSoNum(soNo);
		inParams.setStatus("'R','D'");
		inParams.setSoldTo(soldto);
		inParams.setSysKey(syskey);
		params1.setObject(inParams);
		Session.prepareParams(params1);
		retDel=(ReturnObjFromRetrieve)manager.ezGetAllHeaders(params1);*/
	}
%>
