<%@ page import="ezc.ezparam.*,ezc.ezsap.*,ezc.client.*"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*,java.text.*" %>
<%
	if(session.getValue("EzDeliveryLines")!= null)
	{
		session.removeValue("EzDeliveryLines");
	}
	if(session.getAttribute("getprices") != null)
	{
		session.removeAttribute("getprices");
	}
	if(session.getAttribute("getValues") != null)
	{
		session.removeAttribute("getValues");
	}
	
	System.out.println("Start of the 11111111iListSalesOrders page >>>>>>>>>>>>>>>>>>>");
		
	/****	 To get the List of Sales Orders   
	
	Few Important Descriptions of Variables Used in this page.

	A1. statKeys-- ArrayList, contains all allowed statuses for  Given User Role.
	A2. statDesc--ArrayList,  contains descriptions of statuses used in the Heading of the List page.	
		      Pls note that statKeys and statDesc indexes must be matched.
	A3. displayStatus-- Hashtable , Used to display Satus columns in List Page.

	A4. NewFilter-- Used to filter the rows based on Last Login date and Last Login Time.
	A5. vec-- ArrayList, contains list of statues to be fetched  for current request. 
		if the orderStatus is "Null"  it will contain first element in statKeys
		if the orderStatus is "All" it will conatin all elements of statKeys.
	
	---------------------------------------------------------------------


	Type Codes
	
	As you know for all List Querys  SoldTo ,ShipTo and SalesAreas checks  are necessary.   
	If you want  to add more checks  like on Created by , on modified by etc you need to set Type Codes
	as following.

	
	E1. "C"-- If you would like to Query on Created By 
	E2. "M"-- If you would like to Query on Modified By

	If the NewFilter flag is Y Values will be filtred on Last Login Date also.
		
	

	Error Prone Cases

	1. If request status is not existed in statKeys.
	2. If lengths of statKeys and statDesc are not matched.
	3. If displayStatus does conatin any requested status  as Key.
		
	
	*/

	formatDate = new FormatDate();
	ezc.ezbasicutil.EzSearchReturn mySearch= new ezc.ezbasicutil.EzSearchReturn();
	ReturnObjFromRetrieve retobj = null;		

	String strMaterial = request.getParameter("MATERIAL");
	String strPOnumber = request.getParameter("PONUMBER");
	if(strPOnumber != null)	strPOnumber = strPOnumber.trim();
	String orderStatus=request.getParameter("orderStatus");
	String orderByMaterial=request.getParameter("orderByMaterial"); 
	String newFilter=request.getParameter("newFilter");
	String searchType=request.getParameter("SearchType");
	
	String refDocType = request.getParameter("RefDocType"); // this parameter is for orders created from saved orders 
			
	// SECTION CHANGED BY MB TO HANDLED MULTIPLE STATUSES
	String[] orderType_N_Array = request.getParameterValues("ORDERTYPE");

  	if ((orderType_N_Array != null)){
  		for (int i=0;i<orderType_N_Array.length;i++){
  			if (i==0)
  				orderStatus = "'NEGOTIATED'";
  			else
  				orderStatus = ","+"SUBMITTED";
  		}
  	}
  	// END OF SECTION CHANGED BY MB
  	
	String orderType_N = request.getParameter("ORDERTYPE");
	//out.println("orderType_N::::::::::::::::::"+orderType_N);
	if("N".equals(orderType_N))
		orderStatus = "'NEGOTIATED'";
	else if("A".equals(orderType_N))
		orderStatus = "'SUBMITTED'";
	//out.println(orderType_N);
	
	
	String orderStatustemp=request.getParameter("orderStatus");
	
	user=Session.getUserId();	
	//out.print("user::::"+user);
	userRole=(String)session.getValue("UserRole");	
	LAST_LOGIN_DATE=(String)session.getValue("LAST_LOGIN_DATE");
	LAST_LOGIN_TIME=(String)session.getValue("LAST_LOGIN_TIME"); 
	agentCode=(String)session.getValue("AgentCode");
	salesAreaCode=(String)session.getValue("SalesAreaCode"); 
	
	ArrayList statKeys=new ArrayList(); 
	ArrayList statDesc=new ArrayList();
	ArrayList allStatKeys=new ArrayList();
	
	//statKeys.add("'New'"); 				statDesc.add("Saved");
	//statKeys.add("'RetNew'");				statDesc.add("Saved Return");
	//statKeys.add("'Transfered'");				statDesc.add("Accepted");
	//statKeys.add("'RETTRANSFERED'");			statDesc.add("Posted Return");

	if("CU".equals(userRole) || "AG".equals(userRole))
	{
		statKeys.add("'New'"); 				statDesc.add("Saved");			
		statKeys.add("'Transfered'");			statDesc.add("Accepted");		
		statKeys.add("'Negotiated'");			statDesc.add("Negotiated");
		statKeys.add("'Submitted'");			statDesc.add("Submitted");
	}
	else if("CM".equals(userRole))
	{

		statKeys.add("'New'"); 				statDesc.add("Saved");
		statKeys.add("'Transfered'");			statDesc.add("Accepted");
		statKeys.add("'Negotiated'");			statDesc.add("Negotiated");
		statKeys.add("'Submitted'");			statDesc.add("Submitted");
	}
	//out.println("orderStatus>>>>>>>>>>>><<<<<<<<11111"+orderStatus);
	
	refDocType=(refDocType==null)?"P": refDocType;
	orderStatus=(orderStatus==null)?(String)statKeys.get(0):orderStatus;
	ArrayList vec= new ArrayList();
	vec.add(orderStatus);
	vec=("All".equals(orderStatus))?statKeys:vec;
	
	
%>
<%@ include file="iGetWorkFlowSessionUsers.jsp"%> 
<%@ include file="iWebSOList.jsp"%>   

	
