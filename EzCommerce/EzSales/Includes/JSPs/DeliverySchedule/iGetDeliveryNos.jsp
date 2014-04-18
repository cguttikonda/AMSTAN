<%@ include file="../Misc/iBlockControl.jsp"%>  
<%@ page import="ezc.ezparam.*"%>
<%@ include file="../../../Includes/Lib/ezSalesBean.jsp"%>

<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	ReturnObjFromRetrieve orderList = new ReturnObjFromRetrieve();
	ReturnObjFromRetrieve returnStruct=null;
	
	EzcSalesOrderParams  ezcSalesOrderParams = new EzcSalesOrderParams();
	EziSalesOrderSearchParams iParams = new EziSalesOrderSearchParams();
	EziExtSalesOrderSearchParams iExtParams = new EziExtSalesOrderSearchParams();
	iParams.setStatusFlag("B");
	ezcSalesOrderParams.setObject(iParams);
	ezcSalesOrderParams.setObject(iExtParams);
	Session.prepareParams(ezcSalesOrderParams);
	System.out.println("KKKKKKKKKKKKKKKKKKKPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
        EzoSalesOrderList params =(EzoSalesOrderList) EzSalesOrderManager.ezuSalesOrderListWithStatus(ezcSalesOrderParams);
        System.out.println("KKKKKKKKKKKKKKKKKKKPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
 	returnStruct = params.getReturn();
	if ( returnStruct.getRowCount() > 0 )
	{
		String errType = String.valueOf(returnStruct.getFieldValue(0,"Type"));
	 	if (errType.equalsIgnoreCase("E"))
		{
			orderList = params.getSalesOrders();
		}
	} 
	else
	{
		orderList = params.getSalesOrders();
	}
%>
