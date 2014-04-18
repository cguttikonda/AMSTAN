<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iLang_Lables.jsp" %>
<%@ include file= "../../../Includes/Lib/ezSessionBean.jsp" %>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%@ page import = "ezc.ezmisc.params.*,ezc.ezparam.*" %>
<jsp:useBean id="ezMiscManager" class="ezc.ezmisc.client.EzMiscManager" scope="session" />

<%
	int cartRows        =  0;
	int cartItems       =  0;
	String username	 =  Session.getUserId();


	EzShoppingCart Cart = null;

	EzcShoppingCartParams params = new EzcShoppingCartParams();
	EziReqParams reqparams = new EziReqParams();
	EziShoppingCartParams subparams = new EziShoppingCartParams();

	String agentCode=(String)session.getValue("AgentCode");
	String salesAreaCode=(String)session.getValue("SalesAreaCode");
	String user=Session.getUserId();	

	subparams.setLanguage("EN");
	params.setObject(subparams);
	Session.prepareParams(params);
	try{
		Cart = (EzShoppingCart)SCManager.getSavedCart(params);
	}catch(Exception err){}
	
	if(Cart!=null && Cart.getRowCount()>0)
	{
		cartRows = Cart.getRowCount();

		for(int i=0;i<cartRows;i++)
		{
			try{
			    cartItems+=Double.parseDouble(Cart.getOrderQty(i));
			}catch(Exception e){
			}
		}
	}
     
	String reviewToActCnt ="0";
     
	EzcParams reviewMainParams = new EzcParams(false);
	EziMiscParams miscParams = new EziMiscParams();

	//miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_SALES_DOC_HEADER WHERE ESDH_STATUS='NEGOTIATED' AND ESDH_MODIFIED_BY ! = '"+username+"'");
	miscParams.setQuery("SELECT count(*)REVIEW_COUNT FROM EZC_WF_DOC_HISTORY_HEADER  ,EZC_SALES_DOC_HEADER  WHERE  EWDHH_AUTH_KEY IN('SO_CREATE') AND EWDHH_SYSKEY IN('"+salesAreaCode+"') AND  EWDHH_WF_STATUS IN ('NEGOTIATED') AND EWDHH_CREATED_BY IN('"+user+"','C6100') AND  EWDHH_DOC_ID=ESDH_DOC_NUMBER AND ESDH_SOLD_TO IN('"+agentCode+"')");  
	reviewMainParams.setLocalStore("Y");
	reviewMainParams.setObject(miscParams);
	Session.prepareParams(reviewMainParams);

	ezc.ezparam.ReturnObjFromRetrieve reviewOrdersObj = (ezc.ezparam.ReturnObjFromRetrieve)ezMiscManager.ezSelect(reviewMainParams);

	if(reviewOrdersObj!=null && reviewOrdersObj.getRowCount()>0) 	
	reviewToActCnt = reviewOrdersObj.getFieldValueString(0,"REVIEW_COUNT");
	
%>
<html>
<head>
<title>Welcome</title>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

<Script>
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
	top.banner.document.myForm.reviewCnt.value = "<%=reviewToActCnt%>";
</Script>

<script>
function funShowWindow(myURL)
{
	open(myURL,"EzSo","menubar=no,personalbar=no,toolbar=no,width=775,height=500,left=10,top=20");
}
function funShow(myURL)
{
	
	document.body.style.cursor="wait"
	document.location.replace(myURL)

}
function funShowEdit(webOrNo,soldTo,sysKey)
{
	document.SOForm.webOrNo.value=webOrNo
	document.SOForm.soldTo.value=soldTo
	document.SOForm.sysKey.value=sysKey
	document.SOForm.pageUrl.value="EditOrder"
	document.SOForm.target = "_parent"
	var newFilter=null;
	document.SOForm.action="../Misc/ezListWaitSalesDisplay.jsp"
	document.body.style.cursor="wait"
	document.SOForm.submit();
}
</script>
</head>
<body>
<form name="SOForm">
<input type="hidden" name="webOrNo" >
<input type="hidden" name="soldTo" >
<input type="hidden" name="sysKey" >
<input type="hidden" name="pageUrl">
</form>
<br><br><br><br>
<table align=center>
<tr>
<td align=center class=displayalert>
<%
	String webOrNo ="";
	String soldTo="";
	String sysKey="";

	if(session.getValue("webOrNo") != null)
	{
		String all= (String)session.getValue("webOrNo") ;
		try{
		webOrNo=all.substring(0,all.indexOf(","));
		soldTo=all.substring(all.indexOf(",")+1,all.lastIndexOf(","));
		sysKey=all.substring(all.lastIndexOf(",")+1,all.length());
		}catch(Exception e){}
	}

	out.println(session.getValue("EzMsg"));
	session.removeValue("EzMsg");
	if(session.getValue("webOrNo") != null)
	{
		session.removeValue("webOrNo");
	}
	session.removeAttribute("pono_porder");
	session.removeAttribute("reqdate_porder");
	session.removeAttribute("carname_porder");

%>
</td>
</tr>
</table>
<br><br><br>
<center>
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();	
	
	if(webOrNo.trim().length() ==0)
	{
		//buttonName.add("Ok");
		//buttonMethod.add("funShow(\"../Misc/ezWelcome.jsp\")");
		
	}
	else
	{
		buttonName.add("Ok");
		buttonMethod.add("funShow("+webOrNo+","+soldTo+","+sysKey+")");
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</center>
<Div id="MenuSol"></Div>
</body>
</html>
