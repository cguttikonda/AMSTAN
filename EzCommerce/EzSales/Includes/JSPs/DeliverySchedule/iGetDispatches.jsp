<%@ page import = "ezc.ezparam.*" %>
<%@ page import = "ezc.ezdispatch.params.*,ezc.ezdispatch.client.EzDispatchInfoManager" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	String Stat=request.getParameter("Stat");
	String LAST_LOGIN_DATE =request.getParameter("qFlag");	

	LAST_LOGIN_DATE=(LAST_LOGIN_DATE== null || "null".equals(LAST_LOGIN_DATE) || LAST_LOGIN_DATE.trim().length()==0)?"11/11/1990":LAST_LOGIN_DATE;

	java.util.GregorianCalendar fromDate =new java.util.GregorianCalendar(1990,11,11);
	java.util.GregorianCalendar toDate =(java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();

	try{
		int yy =Integer.parseInt(LAST_LOGIN_DATE.substring(6,10));
		int mm =Integer.parseInt(LAST_LOGIN_DATE.substring(0,2));
		int dd=Integer.parseInt(LAST_LOGIN_DATE.substring(3,5));
		fromDate =new java.util.GregorianCalendar(yy,(mm-1),dd);
	}catch(Exception e){}


	ezc.ezdispatch.client.EzDispatchInfoManager EzManager = new ezc.ezdispatch.client.EzDispatchInfoManager();
	EzcParams params=new EzcParams(true);
	EziDispatchParams iParams=new EziDispatchParams();
	ezc.ezparam.ReturnObjFromRetrieve dlvHGlobal = new ezc.ezparam.ReturnObjFromRetrieve();
	int dlvHCount=0;
	int disheaderCount =0;
	ReturnObjFromRetrieve dlvH = new ezc.ezparam.ReturnObjFromRetrieve();
	ReturnObjFromRetrieve disheader = new ezc.ezparam.ReturnObjFromRetrieve();
	ReturnObjFromRetrieve disitem = new ezc.ezparam.ReturnObjFromRetrieve();
			
	iParams.setSelection(Stat);
	iParams.setFromDate(fromDate.getTime());
	iParams.setToDate(toDate.getTime());
	
	EzBill_headerTable headerTable = new EzBill_headerTable();
	EzBill_itemTable itemTable = new  EzBill_itemTable();
	EzBapidlvhdrTable dlvHTable = new EzBapidlvhdrTable();

	iParams.setBillingHeadersOut(headerTable);
	iParams.setBillingItemsOut(itemTable);
	iParams.setDelivHdr(dlvHTable);

	params.setObject(iParams);
	Session.prepareParams(params);
	try
	{
	
		
		EzoDispatch finalRetObj= new EzoDispatch();
		EzoDispatch finalRetObj= (EzoDispatch)EzManager.ezGetCustomerDeliveries(params);
		dlvH = finalRetObj.getDelivHdr();
		disheader = finalRetObj.getBillingHeadersOut();
		disitem = finalRetObj.getBillingItemsOut();
	
		dlvHCount=dlvH.getRowCount();
		disheaderCount = disheader.getRowCount();
		
		Vector types = new Vector();
		types.addElement("date");
		EzGlobal.setColTypes(types);
		Vector names = new Vector();
		names.addElement("Actualgidate");
		EzGlobal.setColNames(names);
		dlvHGlobal = EzGlobal.getGlobal(dlvH);	
	}catch(Exception e){}
%>	