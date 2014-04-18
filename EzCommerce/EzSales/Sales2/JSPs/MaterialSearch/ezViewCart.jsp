<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%//@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ page import="java.util.*"%>
<%
	
	if("SEARCH".equals((String)session.getValue("GoTo")))
		session.putValue("UserRoleOld","OTU");
	
	String strTcount =  request.getParameter("TotalCount");

	if(strTcount!=null){

		int totCount = (new Integer(strTcount)).intValue();

		int selCount =  0;
		String checkbox="",pCheckBox="";
		for ( int i = 0 ; i < totCount; i++ ) 
		{	checkbox = "CheckBox_"+i;	
			pCheckBox = request.getParameter(checkbox);
			if(pCheckBox!=null){
				selCount++;
			}
		}

		String delItems[]=new String[selCount];
		selCount=0;
		for ( int i = 0 ; i < totCount; i++ ) 
		{	checkbox = "CheckBox_"+i;	
			pCheckBox = request.getParameter(checkbox);
			if(pCheckBox!=null){
				delItems[selCount]=pCheckBox;
				selCount++;
			}
		}

		if(selCount>0){

			EzShoppingCart Cart1 = (EzShoppingCart)session.getValue("ezShoppingCart");

			if(Cart1!=null){
				Cart1.getCatAreaCart(session.getId());
				Cart1.deleteCart(delItems);

			}
			session.putValue("ezShoppingCart",Cart1);
		}
	}


%>

<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>

<%@ include file="iViewCart.jsp" %>

<%@ include file="../../../Includes/JSPs/Lables/iCheckCart_Lables.jsp"%>
<%
	String[] classVal       = request.getParameterValues("classValue");
	String className 	= request.getParameter("className");
	
	String[] selClassCharacter       = request.getParameterValues("selectedClassCharacter"); 
	String[] selValues       = request.getParameterValues("selectedValues"); 
	
	
	String backFlag = request.getParameter("back");
	if(session.getAttribute("getprices") != null)
	{
		session.removeAttribute("getprices");
	}
%>







<html>
<head>
<Script>
	  var tabHeadWidth=70
	  var tabHeight="60%"
</Script>
	<Script src="../../Library/JavaScript/ezDocURL.js"></Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script><script LANGUAGE="JavaScript">

 var total ="<%=cartCount%>"

var tc


function displayDate()
{
	for (i=1;i<total;i++)
	{
		obj = eval("document.forms[0].Reqdate_"+i);
		if(obj.value=="")
		{
			obj.value=document.forms[0].Reqdate_0.value
		}
	}
}
function formSubmit()
{
	y=CheckSelect()
	if(eval(y))
		document.cart.submit();
	
}

function fun1()
{

	if(newWindow.closed)
	{
		displayDate()
		clearInterval(tc)
	}

}
function fun2()
{
	tc=setInterval("fun1()",500)
}
function trim( inputStringTrim)
{
	fixedTrim = "";
	lastCh = " ";
	for( x=0;x < inputStringTrim.length; x++)
	{
		ch = inputStringTrim.charAt(x);
		if ((ch != " ") || (lastCh != " "))
		{ fixedTrim += ch; }
		lastCh = ch;
	}
	if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
	{
		fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
	}
	return fixedTrim
} //end trim

function isDate(sValue)
{
	// Checks for the following valid date formats:
	// MM/DD/YY   MM/DD/YYYY   MM-DD-YY   MM-DD-YYYY
	// Also separates date into month, day, and year variables

	// To require a 2 digit year entry, use this line instead:
	//var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{2}|\d{4})$/;

	// To require a 4 digit year entry, use this line instead:
	 var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

	var matchArray = sValue.match(datePat); // is the format ok?
	if (matchArray == null)
	{
		msgString ="Date is not in a valid format.";
		return false;
	}
	month = matchArray[1]; // parse date into variables
	day = matchArray[3];
	year =parseInt(matchArray[4]);
	if (month < 1 || month > 12)
	{
		// check month range
		msgString ="Month must be between 1 and 12.";
		return false;
	}

	/*if (year < 1900  || year > 2050)
	{
		// checkYear range
		msgString="Year must be between 1900  and 2050.";
		return false;
	}*/
	if (day < 1 || day > 31)
	{
		msgString="Day must be between 1 and 31.";
		return false;
	}
	if ((month==4 || month==6 || month==9 || month==11) && day==31)
	{
		msgString="Month "+month+" doesn't have 31 days!";
		return false;
	}
	if (month == 2)
	{
		// check for february 29th
		var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
		if (day>29 || (day==29 && !isleap))
		{
			msgString ="February of Year" + year + " doesn't have " + day + " days!";
                        return false;
		}
	}
		return true;  // date is valid
} //end isDate

function setAction(){

	document.body.style.cursor="wait"
	document.forms[0].action = "../ShoppingCart/ezStoreCart.jsp";
	document.returnValue = true;
}
var total="<%=cartCount%>";

function setBack()
{
	if("0"=="<%=backFlag%>"){
		document.cart.target="main";
		document.cart.action="../Misc/ezMenuFrameset.jsp";

	}else{
		document.cart.action="ezSearchMaterialsList.jsp";
	}
	document.cart.submit();
	
}
function chkQty(name)
{
	if(total==1)
	{
		y= verifyQty(eval("document.cart."+name+"_0"),name);

		if(!y)
		{
			return false;
		}
	}
	else if(total > 1)
	{
		for(i=0;i<total;i++)
		{
			y= verifyQty(eval("document.cart."+name+"_"+i),name);
			if(!y)
			{
			   return false;
			}
		}
	}

	return true;
}

function verifyQty(theField,name)
{
	 if(funTrim(theField.value) == "")
	{
	}
	else if(funTrim(theField.value) < 0)
	{
		alert("<%=qtyNotZero_A%>");

		theField.value="";
		theField.focus();
		return false;
	}
	else if(isNaN(parseFloat(funTrim(theField.value))))
	{
		alert("<%=plzEntValQty_A%>");

		theField.value="";
		theField.focus();
		return false;
	}
	return true;

}


function setCreateOrder(){
	
/*	if("CU"=="<%=(String)session.getValue("UserRole")%>"){
		document.forms[0].action = "../Sales/ezAddSalesSearchSh.jsp?RefDocType=P&shop=shop";
		document.forms[0].submit();
	}else{
		
		document.forms[0].target="_top";
		document.forms[0].action = "/ezOrdCreLogin.htm"
		document.forms[0].submit();
	}
	

*/
	y=chkQty("Quantity");
	if(eval(y))
	{
             if(document.forms[0].onceSubmit.value!=1) {
   		document.forms[0].onceSubmit.value=1
		document.body.style.cursor="wait"
		document.forms[0].urlPage.value="ViewCart"
		document.forms[0].action = "../Misc/ezListWait.jsp?urlString=../Sales/ezAddSalesSh.jsp";
		//remove ../Misc/ezEditMenuFrameset.jsp
		//document.forms[0].target="main";
		document.returnValue = true;
		document.forms[0].submit();
              }
	}
	else
	{
		return false;
	}
	
}

function CheckSelect() {
	var pCount=0;
	var selCount=0;
	pCount = document.cart.TotalCount.value;
	var i = 0;
	for ( i = 0 ; i < pCount; i++ ) {
		if(document.cart.elements['CheckBox_' + i].checked){
			selCount = selCount + 1;
		}
	}
	if(selCount<1){
		alert("<%=plzDelProd_A%>");
		document.returnValue = false;
		return false;
	}else{
		document.body.style.cursor="wait"
		document.cart.DelFlag.value = 'Y';
		document.returnValue = true;
		return true;
	}
}

function isDigit(s)
{
  if ( s >= 0 && s <= 9 )return true;
	return false;
}



function VerifyDate( i ) {
	var rdate;

	//=============================================================
	//TBD: ********* Once the isDate function is implemented. *****
	// Uncomment all the below commented lines
	//=============================================================

	rdate = document.cart.elements['Reqdate_' + i].value;
	rdate = trim(rdate);
      if ( rdate == '' )
	{
		alert('<%=reqDtemty_A%>');
		document.forms[0].elements['Reqdate_' + i].select();
		document.forms[0].elements['Reqdate_' + i].focus();
		document.returnValue = false;
	}
	else
	{
		if ( !isDate(rdate ) )
		{
			alert("<%=wrongDt_A%>")
			document.forms[0].elements['Reqdate_' + i].select();
			document.forms[0].elements['Reqdate_' + i].focus();
			document.returnValue = false;
		}
		else
		{
			document.forms[0].elements['CheckBox_' + i].checked = true;
			document.returnValue = true;
		}
	} //end if
}
function goBack()
{
	if("0"=="<%=backFlag%>"){
		document.cart.target="main";
		document.cart.action="../Misc/ezMenuFrameset.jsp";
	}else{
		document.cart.action="ezSearchMaterialsList.jsp";
	}
	document.cart.submit();
}
function setDeleteFlag(){
	document.cart.DelFlag.value = 'Y';
	document.returnValue = true;
}
function CheckCart() {
	var pCount;
	pCount = document.cart.TotalCount.value;
	if (pCount < 1){
		alert("<%=addProdCat_A%>");
		document.returnValue = false;
	}
	else{
		document.returnValue = true;
	}
}


function verifyQty1(field,val,prd)
{
/*
	var fValue=field.value
	if((val != 0) && (val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{
			alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
			field.value=0;
			field.focus();
		}
	}
*/
}
</script>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<title>ezViewCart</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
</head>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post" action="ezViewCart.jsp" name="cart">
<input type=hidden name=className value="<%=className%>">


<%
	if(classVal!=null){
		for(int i=0;i<classVal.length;i++){
%>
			<input type=hidden name=classValue value="<%=classVal[i]%>">

<%
		}
	}
%>


<%
	if(selClassCharacter!=null){
		for(int i=0;i<selClassCharacter.length;i++){
%>
			<input type=hidden name=selectedClassCharacter value="<%=selClassCharacter[i]%>">

<%
		}
	}
%>

<%
	if(selValues!=null){
		for(int i=0;i<selValues.length;i++){
%>
			<input type=hidden name=selectedValues value="<%=selValues[i]%>">

<%
		}
	}
%>

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" width="40%">&nbsp;</td>
    <td height="35" class="displayheaderback"  width="40%"><%=shoCart_L%></td>
    <td height="35" class="displayheaderback" width="20%">Shopping Cart Items:<%=cartCount%></td>
</tr>
</table>
<%

if ((cartCount > 0)&&(Cart != null))
{
%>

  <input type="hidden" name="shop" value="shop">
  <Div id="theads">
	<table  id="tabHead"  width="70%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<tr align="center">
      		<th width="10%" ><%=mark_L%></th>
      		<th width="65%" ><%=proddesc_L%></th>
      		<th width="25%" ><%=quan_L%></th>
      		</tr>
	</Table>
	</Div>
       	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:20%">
	<Table align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	java.math.BigDecimal bPrice = null;
	int Count = 0;
	for ( int i = 0 ; i < cartCount ; i++ )
	{
		String minQ ="1";
		String UOM = Cart.getUOM(i);
		UOM = UOM.toUpperCase();
		String parameters = i+", '"+UOM+"'";
		//float Quantity = (new Float(Cart.getOrderQty(i))).floatValue();
		double proQty1=0;
		String proQty=(String)Cart.getOrderQty(i);
		try{
		proQty1=Double.parseDouble(proQty);
		proQty=String.valueOf(proQty1);
	  	}catch(Exception ee){ }
		if(("0.0").equals(proQty))
                 proQty="";
		String baseCurrency = Cart.getCurrency(i);
		if ( baseCurrency == null )baseCurrency="USD";

		java.math.BigDecimal bUprice = new java.math.BigDecimal(Cart.getUnitPrice(i));

		String desc =(String)Cart.getMaterialDesc(i);
		desc=desc.replace('\'','`');
		desc=desc.replace('\"',' ');

%>
  	   	 <tr align="center">
	     	 <td width="10%" valign="middle"><input type="checkbox" name="CheckBox_<%=i%>" value="<%=Cart.getMaterialNumber(i)%>" unchecked></td>
    		 <td width="65%" valign="middle" align="left"> &nbsp;&nbsp;&nbsp;&nbsp;
    		  <a style='text-decoration:none'  href="Javascript:matDetails('<%=Cart.getMaterialNumber(i)%>','<%=(desc).replace('"',' ')%>')"><%=desc%></a>
    		 
    		 </td>
		 <td width="25%" valign="right">
			<input type="text" class="InputBox"  name="Quantity_<%=i%>" size="15" maxlength="7"  style="text-align:right" onBlur = 'verifyQty1( this,"<%= minQ %>","<%= desc %>")' value="<%=proQty%>" > 
			<input type="hidden" readonly name="Reqdate_<%=i%>" value="1.11.1000">
        		<input type="hidden" name="Currency_<%=i%>" readonly disabled maxlength="5" size="5" value="<%=baseCurrency%>" >
		       	<input type="hidden" name="Price_<%=i%>" readonly disabled size="4" value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
	      		<input type="hidden" name="Product_<%=i%>" size="18" value="<%=Cart.getMaterialNumber(i)%>">

	      </td>
	      </tr>
<%
		// Calculate Price according to the Quantity
		Count = Count + 1;
	}
%>

</Table>
		</Div>
		

<div  id="buttonDiv" align='center' STYLE='Position:Absolute;width:100%;top:87%'>
   <Table width="100%" align="center">
      <Tr>
           <Td align="center" class="blankcell">
          <!-- <a href="JavaScript:setCreateOrder()"><img  src="../../Images/Buttons/<%= ButtonDir%>/placeorder.gif" <%=statusbar%>  title="<%=clkHerePlcOrd_L%>" border="none"></a>
	  <a href="JavaScript:formSubmit()"><img  src="../../Images/Buttons/<%= ButtonDir%>/delete.gif"   <%=statusbar%> title="<%=clkHereDelCart_L%>"  border="none"></a> -->
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Place Order");
	buttonMethod.add("setCreateOrder()");
	buttonName.add("Delete");
	buttonMethod.add("formSubmit()");

	String back = request.getParameter("back"); 
	if("1".equals(back))
	{
		buttonName.add("Back");
		buttonMethod.add("goBack()");
	
	
	}
	else
	{
		buttonName.add("Back");
		buttonMethod.add("setBack()");
	
	}
	out.println(getButtonStr(buttonName,buttonMethod));
%>
          </Td>
      </Tr>
   </Table>
  </div>
<input type="hidden" name="urlPage">
<input type="hidden" name="TotalCount" size="18" value="<%=cartCount%>" >
<%
	}else{
%>		<br><br><br>
		<Table align='center'><Tr><Td align='center' class=displayalert>
		<%=noItemAddCrt_L%>.
		</Td></Tr></Table><BR><BR><BR>
		<CENTER>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("setBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>		
		
 		</center>
<%
	} //End if 
%>
<input type="hidden" name="DelFlag" size="1" value="N">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="back" value="<%=backFlag%>">

</form>
</body>
</html>
