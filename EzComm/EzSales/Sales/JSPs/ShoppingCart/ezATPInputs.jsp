<%@ page import="ezc.ezparam.*,ezc.ezbasicutil.*,java.util.*" %>
<%@ page import="ezc.customer.invoice.params.*,ezc.ezmisc.params.*,ezc.ezadmin.ezadminutils.params.*" %>
<%@ page import="java.text.*,ezc.ezsap.*,ezc.client.*,ezc.ezutil.FormatDate" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session"/>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iRetailCheck.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iMethods.jsp"%>
<%!
	public String eliminateDecimals(String myStr)
	{
		String remainder = "";
		if(myStr.indexOf(".")!=-1)
		{
			remainder = myStr.substring(myStr.indexOf(".")+1,myStr.length());
			myStr = myStr.substring(0,myStr.indexOf("."));
		}
		return myStr;
	}
	public String nullCheck(String str,String str1)
	{
		String ret = str;

		if(ret==null || "null".equalsIgnoreCase(ret) || "".equals(ret)) ret = str1;

		return ret;
	}
	public boolean checkAttributes(String prdAttrs,String custAttr)
	{
		boolean prdAllowed = true;
		int i1 = custAttr.indexOf("X");
		char c1;
		while (i1 >= 0)
		{
			c1 = prdAttrs.charAt(i1);

			prdAllowed = true;
			if('X'==c1)
			{
				prdAllowed = false;
				break;
			}
			i1 = custAttr.indexOf("X",i1+1);
		}
		return prdAllowed;
	}
%>
<%
	String userTyp  = (String)session.getValue("UserType");
 	Date dNow = new Date( );
   	SimpleDateFormat ft = new SimpleDateFormat ("MM/dd/yyyy 'at' hh:mm:ss a zzz");
   	String pageTitle = "Current Network Availability on "+ft.format(dNow);

	String stAtpStr = nullCheck(request.getParameter("stAtp"),"");
	String atpSTP	= nullCheck(request.getParameter("selSoldTo"),"");
	String atpion	= nullCheck(request.getParameter("atpon"),"");
	String atpForStr = nullCheck(request.getParameter("atpfor"),"");
	String atpQtyStr = nullCheck(request.getParameter("atpqty"),"");
	String atpSHP	= (String)session.getValue("ShipCode");
	String atpDiv  	= (String)session.getValue("division");
	String atpDtc 	= (String)session.getValue("dc");
	String atpSOr	= (String)session.getValue("salesOrg");

	String endLeadRem ="";

	if("".equals(atpSTP)) atpSTP=(String)session.getValue("AgentCode");

	int prdsLen 	=0;
	String selectedPrdsSplitArr[] = null;

	if(atpForStr!=null)
	{
		selectedPrdsSplitArr = atpForStr.split("§");
		prdsLen = selectedPrdsSplitArr.length;
	}

	String prodCodeStr = "";	
	
	String atpInputs[]={"SALESORG","DIST_CHANNEL","DIVISON","SOLDTO","SHIPTO","REGION"};
	ReturnObjFromRetrieve atpInputsRet = new ReturnObjFromRetrieve(atpInputs);

	String atpQtyPrd[]={"PROCODES","ORD_QTY"};
	ReturnObjFromRetrieve atpQtyPrdRet = new ReturnObjFromRetrieve(atpQtyPrd);

	HashMap zMatHM = new HashMap();

	/*******************Hashtables********************/
	
	// Key - Product Status
	// Value - Prod Status Desc, End Lead Reminder, End Lead Time, Qty Returned, Availability
	// OVW - Over write
	// DNO - Dont over write

	Hashtable prodStatusHT = new Hashtable();

	prodStatusHT.put("Z2","Discontinued¥OVW¥OVW¥Not Available¥OVW");
	prodStatusHT.put("Z3","Discontinued¥OVW¥OVW¥Not Available¥OVW");
	prodStatusHT.put("Z4","Discontinued¥OVW¥OVW¥DNO¥DNO");
	prodStatusHT.put("ZM","Modification - Contact Customer Care for Ordering¥DNO¥DNO¥DNO¥DNO");
	prodStatusHT.put("ZP","Production Hold - ordering is impermissible¥DNO¥DNO¥DNO¥DNO");
	prodStatusHT.put("ZF","To Be Discontinued¥DNO¥DNO¥DNO¥DNO");
	prodStatusHT.put("11","New¥OVW¥OVW¥TBD¥OVW");

	/*******************Hashtables********************/
%>