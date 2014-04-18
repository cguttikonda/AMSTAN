<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iCheckCart_Lables.jsp"%>
<html>
<title>ezViewCart</title>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<Script>
		  var tabHeadWidth=80
 	   	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script LANGUAGE="JavaScript">

var total ="<%=Cart.getRowCount()%>"
var tc;
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

function search()
{
	
	parent.document.location.href="../BusinessCatalog/ezProductSearch.jsp?backFlg=DVC";
	
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
var total="<%=Cart.getRowCount()%>";

function setBack()
{
	//document.location.replace("../Misc/ezWelcome.jsp");
	document.location.href="../Misc/ezWelcome.jsp";
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
	y=chkQty("Quantity");
	if(eval(y))
	{
             if(document.forms[0].onceSubmit.value!=1) {
             	document.forms[0].onceSubmit.value=0
   		//document.forms[0].onceSubmit.value=1
		document.body.style.cursor="wait"
		document.forms[0].urlPage.value="ViewCart"
		document.forms[0].action = "../Misc/ezListWait.jsp?urlString=../Sales/ezAddSalesSh.jsp";
		document.forms[0].target="display";
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


/*function VerifyNum( i, U )
{
	var quant;
	var flag = 'F';
	var fraction=0;
	var value = 0;
	quant = document.forms[0].elements['Quantity_' + i].value;
	if(trim(quant)=="" )
	{
		alert('<%=qtyEmpty_A%>')
	document.returnValue = false;
			return;
	}
	var len = quant.length;
	for( j=0; j < len; j++)
	{  var ch = quant.charAt(j);
		if((ch=='.') && (flag=='F')){
								flag="T";
									j++;
								value = quant.substring(0,j-1);
								fraction=quant.substring(j,len);
								var fraclen = fraction.length;
							    if(fraclen>=2){ fraction = fraction.substring(0,2);}
								if(fraclen==1) {fraction = fraction.substring(0,1)+'0';}
								if(fraclen==0) {fraction = '00';}
								//else  fraction='00';

								quant = value+'.'+fraction;
								len = quant.length;
								ch = quant.charAt(j);
								//alert('Check ---> '+quant+"   "+value+"   "+ fraction);
							}
		if ( !isDigit( ch ) )
		{
			alert("<%=qtyBeNum_A%> ");
			document.forms[0].elements['Quantity_' + i].select();
			document.forms[0].elements['Quantity_' + i].focus();
			document.returnValue = false;
			return;
			//return false;
		}
	}



if((U=='EA')||(U=='PC'))
{
if(fraction>0){
	alert('<%=fracQty_A%>');
	document.forms[0].elements['Quantity_' + i].select();
	document.forms[0].elements['Quantity_' + i].focus();
	document.returnValue = false;
	return;
}
}

if(flag=='F'){
//fraction = '00';
quant=quant+'.00';
}
if(quant<=0)
{
	alert('<%=thQtyGtZero_A%>');
	document.forms[0].elements['Quantity_' + i].select();
	document.forms[0].elements['Quantity_' + i].focus();
	document.returnValue = false;
	return;
}

document.forms[0].elements['Quantity_' + i].value=quant;
//document.forms[0].elements['CheckBox_' + i].checked=true;
document.returnValue = true;
}
*/
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
function goBack1()
{
	document.cart.action="../DrillDownCatalog/ezCatalogFinalLevel.jsp?alertStr=S";
	document.cart.submit();

}
function goBack()
{
<%
if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
{
%>
		document.cart.action="../DrillDownCatalog/ezFavGroupFinalLevel.jsp";
		document.cart.submit();
<%
	}else{
		if("ezCatalogFinalLevel.jsp".equalsIgnoreCase(from)){
%>
			document.cart.action="../DrillDownCatalog/ezFavGroupFinalLevel.jsp";
			document.cart.submit();
<%		}else{
%>
			//document.location.replace("../Misc/ezWelcome.jsp");
			parent.document.location.href="../Misc/ezWelcome.jsp";
<%		}
	}
%>

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

	var fValue=field.value
	
	
	/*
	if((val != 0) && (val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{
			alert("quantity of "+ prd +" is  : " + fValue  +"\nSolution :Please enter multiple of "+ val)
			field.value=0;
			field.focus();
		}
	}
	*/

}


function selectAll(obj)
{
	if(obj.checked==true)
	{
		for(var i=0;i<<%=Cart.getRowCount()%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=true;
		}
	}
	else
	{
		for(var i=0;i<<%=Cart.getRowCount()%>;i++)
		{
			document.forms[0].elements['CheckBox_' + i].checked=false;
		}
	}
}
function createCG()
{
	document.cart.action="ezCreateCatalogGroup.jsp"
	document.cart.submit();
}

</script>
</head>
<body  onLoad="scrollInit(10)" onresize="scrollInit(10)" scroll=no>
<form method="post" action="ezUpdateCart.jsp" name="cart">


<table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
    <td height="25" class="displayheaderback" align=center width="80%"><%=shoCart_L%></td>
    <td height="25" class="displayheaderback" align=right width="30%">Shopping Cart Items:<%=Cart.getRowCount()%>&nbsp;&nbsp;</td>
</tr>
</table>
<%
int cartRows = Cart.getRowCount();
if ((cartRows == 0)||(Cart == null))
{
%>
		<br><br><br>
		<Table align='center'><Tr><Td align='center' class=displayalert>
		<%=noItemAddCrt_L%>.
		</Td></Tr></Table>
		<BR><BR><BR>
		<center>
<%
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		
    			buttonName.add("Back");
    			buttonMethod.add("setBack()");
    		
    		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
		<Div id="MenuSol"></Div>
<%
	return;
}
if ((cartRows > 0)&&(Cart != null))
{
%>

  <input type="hidden" name="shop" value="shop">
  <Div id="theads">
	<table  id="tabHead"  width="80%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<tr align="center">
      		<th width="10%" ><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></th>
      		<th width="20%" >Product</th>
      		<th width="45%" >Description</th>
      		<th width="25%" ><%=quan_L%></th>
      		</tr>
	</Table>
	</Div>
       	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%">
	<Table align=left id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	java.math.BigDecimal bPrice = null;
	int Count = 0;
	for ( int i = 0 ; i < cartRows ; i++ )
	{
		String minQ =(String)selMet.get(Cart.getMaterialNumber(i));
		if(minQ == null || "".equals(minQ)|| "null".equals(minQ))
			minQ="1";

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
		
		String tPNo = "";
		try
		{
			tPNo = Integer.parseInt(Cart.getMaterialNumber(i)+"")+"";
		}
		catch(Exception e){
			tPNo = Cart.getMaterialNumber(i)+"";
		}
		
		try
		{
			proQty = proQty.substring(0,proQty.indexOf('.'));
		}
		catch(Exception e){}

%>
  	   	 <tr align="center">
	     	 <td width="10%" valign="middle"><input type="checkbox" name="CheckBox_<%=i%>" value="Selected" unchecked></td>
	     	 <td width="20%" valign="middle" align="left">&nbsp; <%=tPNo%> </td>
    		 <td width="45%" valign="middle" align="left"> &nbsp;&nbsp;&nbsp;&nbsp;<%=desc%> </td>
		 <td width="25%" valign="right">&nbsp;
			<input type="text" class="InputBox"  name="Quantity_<%=i%>" size="15" maxlength="7"  style="text-align:right" onBlur = 'verifyQty1( this,"<%= minQ %>","<%= desc %>")' value="<%=proQty%>" > 
			<!--[<input type="text" size="4" class="tx" name="" value="<%=minQ%>" style="text-align:center" readonly>]-->
			<input type="hidden" readonly name="Reqdate_<%=i%>" value="1.11.1000">
        		<input type="hidden" name="Currency_<%=i%>" readonly disabled maxlength="5" size="5" value="<%=baseCurrency%>" >
		       	<input type="hidden" name="Price_<%=i%>" readonly disabled size="4" value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
	      		<input type="hidden" name="Product_<%=i%>" size="18" value="<%=Cart.getMaterialNumber(i)%>">
			</nobr>
	      </td>
	      </tr>
<%
		// Calculate Price according to the Quantity
		Count = Count + 1;
	}
%>

</Table>
		</Div>
		

<div  id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:80%'>
<%
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		
    		buttonName.add("Create Catalog");
    		buttonMethod.add("createCG()");
    		
    		buttonName.add("Place Order");
    		buttonMethod.add("setCreateOrder()");
    		buttonName.add("Delete");
    		buttonMethod.add("formSubmit()");
    		buttonName.add("Add More Products");
    		buttonMethod.add("search()");
    		String back = request.getParameter("back");
		
		if("1".equals(back))
		{
    			buttonName.add("Back");
    			buttonMethod.add("goBack1()");
    		}
    		/*else{
    			buttonName.add("Back");
    			buttonMethod.add("setBack1()");

		}
    		*/
    		
    		if("Psearch".equals(back))
		{
			//buttonName.clear();
			//buttonMethod.clear();
			buttonName.add("Back");
			buttonMethod.add("history.go(-1)");
			//out.println(getButtonStr(buttonName,buttonMethod));
    		}
    		//buttonName.add("Back");
    		//buttonMethod.add("goBack()");
    		out.println(getButtonStr(buttonName,buttonMethod));
    		
    		
%>
</div>
<%
}
%>
<input type="hidden" name="fromCart" value='Y'>
<input type="hidden" name="urlPage">
<input type="hidden" name="TotalCount" size="18" value="<%=cartRows%>" >
<input type="hidden" name="DelFlag" size="1" value="N">
<input type=hidden name="ProductGroup" value="<%=ProductGroup%>">
<input type=hidden name=CatalogDescription  value="<%=CatalogDescription%>">
<input type=hidden name=GroupLevel value="1">
<input type=hidden name="GroupDesc" value="<%=groupDesc%>">
<input type="hidden" name="onceSubmit" value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
