<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>
<%
	ReturnObjFromRetrieve orderList = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve returnStruct=null;
	ReturnObjFromRetrieve oH =null;
	ReturnObjFromRetrieve so=null;

	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	EziSalesOrderSearchParams iParams = new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams iExtParams = new EziExtSalesOrderSearchParams();
	EzBapicustselectTable custtable = new EzBapicustselectTable();
	EzBapicustselectTableRow custtableRow =null;

	EzBapiordersTable ordtable= new EzBapiordersTable();
	EzBapiordersTableRow ordtableRow =null;

try{
			ArrayList duplicate = new ArrayList();
			String EzDocTypes = "ORD";	
				if(EzDocTypes != null)
				{
				EzStringTokenizer doctypesSt = new EzStringTokenizer(EzDocTypes,",");
					int doctypesCt =doctypesSt.getTokens().size();
					if(doctypesCt == 0)
					{
						if(!duplicate.contains(EzDocTypes))
						{
							duplicate.add(EzDocTypes);
							ordtableRow = new EzBapiordersTableRow();
							ordtableRow.setDocType(EzDocTypes);
							ordtable.appendRow(ordtableRow);
						}
					}else{
						for(int linall=0;linall<doctypesCt;linall++)
						{
				String docT = (String)doctypesSt.getTokens().elementAt(linall);
				docT=docT.trim();

						if(docT.length()==4)
						{
							if(!duplicate.contains(docT))
							{
								duplicate.add(docT);
								ordtableRow = new EzBapiordersTableRow();
								ordtableRow.setDocType(docT);
								ordtable.appendRow(ordtableRow);
							}
						}
						}
					}
				}

}catch(Exception e){}

	iParams.setSalesOrders(ordtable);
	iParams.setStatusFlag("C");
	if(base!=null && !"null".equals(base) && !"".equals(base))
	{

		int ffy=Integer.parseInt(fd.substring(6,10))-1900;
		int ffd=Integer.parseInt(fd.substring(3,5));
		int ffm=Integer.parseInt(fd.substring(0,2))-1;
		int tty=Integer.parseInt(td.substring(6,10))-1900;
		int ttd=Integer.parseInt(td.substring(3,5));
		int ttm=Integer.parseInt(td.substring(0,2))-1;

	 	Date fromDate = new Date(ffy,ffm,ffd);
	 	Date toDate = new Date(tty,ttm,ttd);

		iParams.setDocumentDate(fromDate);
		iParams.setDocumentDateTo(toDate);

		ezcSalesOrderParams.setObject(iParams);
		ezcSalesOrderParams.setObject(iExtParams);
		Session.prepareParams(ezcSalesOrderParams);
		if(customer != null)
		{
  			ArrayList duplicate = new ArrayList();
			int custLen = customer.length;
			for(int i=0;i<custLen;i++)
			{
				if(!duplicate.contains(customer[i]) &&( allCust.contains(customer[i]) || "CU".equals(UserRole)))
				{
					duplicate.add(customer[i]);
					custtableRow = new EzBapicustselectTableRow();
					custtableRow.setCustomer(customer[i]);
					custtable.appendRow(custtableRow);
				}
			}
			iParams.setCustomerSelection(custtable);
		        EzoSalesOrderList params =(EzoSalesOrderList) EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
		 	returnStruct = params.getReturn();
			if ( returnStruct.getRowCount() > 0 )
			{
				String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
			 	if (errType.equalsIgnoreCase("E"))
				{
					//strMaterial = " Unable to get the List of Sales Orders";
					orderList = params.getSalesOrders();
				}
			}else{
				// Get the list Of Orders
				//strMaterial = " ";
				orderList = params.getSalesOrders();

			}
			oH = params.getOrderStatusHeaderOut();
		}
	}
%>