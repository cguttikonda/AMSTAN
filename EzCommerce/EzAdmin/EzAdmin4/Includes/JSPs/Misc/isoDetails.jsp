<%@ page import = "ezc.ezsap.*"%>
<%@ page import = "ezc.ezutil.FormatDate"%>
<%@ include file="../../../Includes/Lib/SalesBean.jsp"%>
<%@ include file="../../../Includes/Lib/DateFunctions.jsp"%>
<%@ include file="../../../Includes/Lib/ServerFunctions.jsp"%>


<%
BapisdstatTable statinfo = null;
BapisdstatTableRow statRow = null;
SalesOrderGetstatusParams params = null;

String strucType = null;

// Date Format Object
FormatDate formatDate = new FormatDate();

String choice = request.getParameter("selectChoice");
String strSalesOrder = adjustSalesOrdNum(request.getParameter("SONumber")); 
params = new SalesOrderGetstatusParams();

if (servlet != null) {

	if(choice != null){
		if(choice.equals("EZC")){
			// Change for the Sales Order Status for the EzRef Order Number
			params = SBObject.ezuRefSalesOrderStatus(servlet, strSalesOrder, params);
		}else{
			params = SBObject.ezuSalesOrderStatus(servlet, strSalesOrder, params);
		}//end if
	}else{
		params = SBObject.ezuSalesOrderStatus(servlet, strSalesOrder, params);
	}
}
	
if(params != null){
	BapireturnStructure returnStruct = params.getReturn();	
	strucType = returnStruct.getType();

	if (strucType.equals("E")) {
		out.println("<table align=\"center\"><tr align=\"center\"><td class=blankcell>");
		out.println("<BR> Unable to Display Sales Order Details <BR>");
		out.println(" The follwing error occurred: " + returnStruct.getMessage()); 
		out.println("</td></tr></table>");
	}else{
		statinfo = params.getStatusinfo();
		if (statinfo != null) {
			statRow = statinfo.getRow(0);
		}
	}
}
%>