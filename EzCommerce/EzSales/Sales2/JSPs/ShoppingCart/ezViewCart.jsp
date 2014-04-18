<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCart.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iCheckCart_Lables.jsp"%>

<%
      String pageFlg = request.getParameter("pageFlg");
      if(pageFlg==null || "null".equals(pageFlg))
      	pageFlg="";
      	
      String frameFlg = request.getParameter("fromMenu");
      //out.println((String)session.getValue("Agent"));
      
      String UserRole = (String)session.getValue("UserRole");
      String isCatUser     = (String)session.getValue("IsCatUser");
      String hookUrl     = (String)session.getValue("HookURL");
      UserRole=UserRole.trim();
      
      String isSubUser = (String)session.getValue("IsSubUser");
      String suAuth = (String)session.getValue("SuAuth");
%>

<html>
<title>ezViewCart</title>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>

<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
<Script>
		  var tabHeadWidth=80;
 	   	  var tabHeight="60%";    
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Style>

</Style>
<Script LANGUAGE="JavaScript">
  
var total ="<%=Cart.getRowCount()%>"   
var pageFlg="<%=pageFlg%>"
var frameFlg="<%=frameFlg%>"
var tc; 
function goToSearch()
{
	document.cart.action="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
	document.cart.submit();

}
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
function formSubmit(selIndex) 
{
	//y=CheckSelect()
	//if(eval(y))
		document.cart.DelFlag.value = 'Y';
		document.cart.selectedIndex.value = selIndex;
		document.cart.action="ezUpdateCart.jsp";
		document.cart.submit();
	
}
function backOrder()
{
	document.cart.action="../Sales/ezBackWaitSalesDisplay.jsp";
	document.cart.submit();
}
function search()
{
	var flg = '<%=pageFlg%>';
	
	if(flg=='Y')
		document.cart.target = "_parent";
	
	document.cart.action="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
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
var total="<%=Cart.getRowCount()%>";

function setBack()
{
	var flg = '<%=pageFlg%>';
		
	if(flg=='Y')
		document.cart.target = "_parent";
	//document.location.replace("../DrillDownCatalog/ezDrillDownVendorCatalog.jsp");
	document.location.replace("../Sales/ezManageOrdersFrameSet.jsp");
	
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


function setCreateOrder()
{
	y=chkQty("Quantity");
	
	var descObj = document.cart.pDesc;
	var len = descObj.length;
	
	if(isNaN(len))
	{
		var qty  = document.cart.elements['Quantity_0'].value;
		var cLot = document.cart.elements['caseLot_0'].value;	
		
		/*
		if((qty%cLot)!=0)
		{				
			alert("quantity of "+ descObj.value+" is  : " + qty  +"\nSolution :Please enter multiple of "+ cLot)	
			document.cart.elements['Quantity_0'].value =''
			return;
		}
		*/
		
	}
	else
	{
		for(i=0;i<len;i++)
		{
			var qty  = document.cart.elements['Quantity_' + i].value;
			var cLot = document.cart.elements['caseLot_' + i].value;			
			/*
			if((qty%cLot)!=0)
			{				
				alert("quantity of "+ descObj[i].value+" is  : " + qty  +"\nSolution :Please enter multiple of "+ cLot)	
				document.cart.elements['Quantity_' + i].value =''
				return;
			}
			*/
			
		}
	}
	if(eval(y))
	{
	     
             if(document.forms[0].onceSubmit.value!=1) {
              
              	hideMsg();
              
   		document.forms[0].onceSubmit.value=0
   		//document.forms[0].onceSubmit.value=1
		document.body.style.cursor="wait"
		document.forms[0].urlPage.value="ViewCart"
		document.forms[0].action = "../Misc/ezListWait.jsp?urlString=../Sales/ezAddSalesSh.jsp&fromCart=Y&pageFlg="+pageFlg+"&frameFlg="+frameFlg; 
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

function CheckSelect() 
{
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
function goBack()
{
<%
if("ezFavGroupFinalLevel.jsp".equalsIgnoreCase(from))
{
%>
		document.cart.action="../BusinessCatalog/ezFavGroupFinalLevel.jsp";
		document.cart.submit();
<%
	}else{
		if("ezCatalogFinalLevel.jsp".equalsIgnoreCase(from)){
%>
			document.cart.action="../BusinessCatalog/ezFavGroupFinalLevel.jsp";
			document.cart.submit();
<%		}else{
%>
			document.location.replace("../Misc/ezWelcome.jsp");
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
	
	if(isNaN(parseFloat(funTrim(field.value))))
	{
		alert("Please enter valid quantity")
		field.value=0;
		field.focus();
	
	}
	
	if((val != 0) && (val!="")&&(!isNaN(val)))
	{
		/*
		if((fValue%val)!=0)
		{
			alert("quantity of "+ prd +" is  : " + fValue  +"\nSolution :Please enter multiple of "+ val)
			field.value=0;
			field.focus();
		}
		*/
	}

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

function verifyQty(field,val,prd)
{	
	var fValue=field.value	
	
	/*
	if((val!=0) && (val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{	
			alert("Quantity of "+ prd +" is : " +fValue+"\nSolution :Please enter multiple of "+ val)
			field.value=0;
			field.focus();
			return false;
		}
	}
	*/
	return true;
}
function createCG()
{
	document.cart.action="ezCreateCatalogGroup.jsp"
	document.cart.submit();
}
function createQuote()
{
	hideMsg();
	document.body.style.cursor="wait";
	document.cart.action="../Quotation/ezGetSh.jsp"
	document.cart.submit();
}
function createOrder()
{
	hideMsg();
	document.body.style.cursor="wait";
	document.cart.action="../Sales/ezGetShNew.jsp"
	document.cart.submit();
}
function checkOut()
{
	document.cart.target="_top"
	document.cart.method="post"
	document.cart.action="<%=hookUrl%>"
	document.cart.submit()
}
function publishToCust()
{
	hideMsg();
	document.body.style.cursor="wait";
	document.cart.action="../BusinessCatalog/ezPrePublishToCust.jsp"
	document.cart.submit();
}
function publishToCustNew()
{
	var argsVariable = "";
	var retVal = window.showModalDialog("../BusinessCatalog/ezPrePublishToCustPopup.jsp",argsVariable,"dialogWidth:500px; dialogHeight:180px; center:yes");
	if(retVal!="")
	{
		hideMsg();
		document.cart.selCustomer.value = retVal;
		document.cart.action="../BusinessCatalog/ezPublishToCustNew.jsp"
		document.cart.submit();
	}
}

function hideMsg()
{
	buttonsSpan=document.getElementById("EzButtonsSpan")
	buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
	if(buttonsSpan!=null)
	{
		buttonsSpan.style.display="none"
		buttonsMsgSpan.style.display="block"
	}
}
</script>
</head>
<body  onLoad="scrollInit()" onresize="scrollInit()" scroll=no>
<form method="post" name="cart">
<%
	String display_header = shoCart_L; 	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<br>


<%
	String fromMenu 	= request.getParameter("fromMenu");
	String strSalesOrder    = "";
	String fromDate 	= "";
	String toDate 		= "";
	String patno 		= "";
	String status 		= "";
	String sessionback 	= "";
	

	if(fromMenu!=null)
	{}
	else
	{
		strSalesOrder   = (String)session.getAttribute("SONumber");
		fromDate 	= (String)session.getAttribute("FromDate");
		toDate 		= (String)session.getAttribute("ToDate");
		patno 		= (String)session.getAttribute("SoldTo");
		status 		= (String)session.getAttribute("status");
		sessionback 	= (String)session.getAttribute("back");
	}	

/*	session.removeValue("SONumber");
	session.removeValue("FromDate");
	session.removeValue("ToDate");
	session.removeValue("SoldTo");
	session.removeValue("status");
	session.removeValue("back");*/



int cartRows = 0; 
int cartItems =0;


if(Cart!=null && Cart.getRowCount()>0){
	cartRows = Cart.getRowCount();
	for(int i=0;i<cartRows;i++){
		try{
		     cartItems+=Double.parseDouble(Cart.getOrderQty(i));
		}catch(Exception e){
		}
	}
}

String[] prodUnitQty= new String[cartRows];
String[] prodCaseLot= new String[cartRows];
Hashtable selectdMet =(Hashtable)session.getAttribute("SELECTEDMET");
String back = request.getParameter("back");
%>
<Script>
	top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
</Script>
<input type="hidden" name="SONumber" value="<%=strSalesOrder%>">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type="hidden" name="SoldTo" value="<%=patno%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="pageUrl" value="BackOrder">
<input type="hidden" name="PODATE" value="">
<input type="hidden" name="orderType" value="">
<input type="hidden" name="netValue" value="">
<input type="hidden" name="selCustomer" value="">
<input type="hidden" name="selectedIndex" value="">


<%
if ((cartRows == 0)||(Cart == null))
{
%>
		<br><br><br>
		<Table align='center'><Tr><Td align='center' class=displayalert>
		No product(s) added to the Shopping Cart.
		</Td></Tr></Table>
		<BR><BR><BR>
		<center>
<%
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		//out.println("sessionbacksessionback  "+sessionback);
    		if(fromMenu!=null && "Y".equals(fromMenu))
    		{
    			//buttonName.add("Back");
			//buttonMethod.add("goToSearch()"); 
    		}
		else if(sessionback!=null && "O".equals(sessionback.trim()))
		{
			//buttonName.add("Back");
			//buttonMethod.add("backOrder()");    		
    		}
    		else
    		{
			//buttonName.add("Back");
			//buttonMethod.add("history.go(-1)");
		}	
			
    		
    		//buttonName.add("Back");
    		//buttonMethod.add("setBack()");
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
  <input type="hidden" name="~CALLER" value="CTLG" > 
  <Div id="theads">
	<table  id="tabHead"  width="80%"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1>
		<tr align="center">
      		<th width="15%" >Product</th>
      		<th width="32%" >Description</th>
      		<th width="15%" >Brand</th>
      		<th width="12%" >List Price</th>
      		<th width="12%" >Discount Price</th>
      		<th width="10%" ><%=quan_L%></th>
      		<th width="4%" >&nbsp</th>
      		</tr>
	</Table>
	</Div>
       	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:80%;height:60%">
	<Table align=center id="InnerBox1Tab"  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 width="100%">
<%
	java.math.BigDecimal bPrice = null;
	int Count = 0;
	String tDesc= "";
	//if(session.getAttribute("SELECTEDMET")!=null)
	//{
	
	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j(); 

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
		
		String discPerVal = (String)Cart.getDiscPer(i);
		String discCodeVal = (String)Cart.getDiscCode(i);
		
		String colTone = "";
		if(i%2==0)
			colTone = "style='background-color:#EFEFEF'";
%>
  	   	 <tr align="center" >
	     	 <td width="15%" valign="middle" align="left" <%=colTone%>>&nbsp; <%=tPNo%> </td>
    		 <td width="32%" valign="middle" align="left" <%=colTone%>> &nbsp;&nbsp;<%=desc%> </td>
    		 <td width="15%" valign="middle" align="left" <%=colTone%>><%= Cart.getBrand(i) %> </td>
    		 <td width="12%" valign="middle" align="right" <%=colTone%>>$<%= Cart.getOrgPrice(i) %> </td>
    		 <td width="12%" valign="middle" align="right" <%=colTone%>>$<%= Cart.getUnitPrice(i) %> </td>
    		 <td width="10%" valign="right" <%=colTone%>>
    		 
<%
		if("Y".equals(isCatUser))
		{
%>
			<input type="text" class="tx" readonly  name="Quantity_<%=i%>" size="7" maxlength="10"  style="text-align:right" value="<%=proQty%>" > 
			
			<input type="hidden" name="NEW_ITEM-DESCRIPTION[<%=i+1%>]" value="<%=desc%>" > 
			<input type="hidden" name="NEW_ITEM-MATGROUP[<%=i+1%>]" value="" > 
			<input type="hidden" name="NEW_ITEM-QUANTITY[<%=i+1%>]" value="<%=proQty%>" > 
			<input type="hidden" name="NEW_ITEM-UNIT[<%=i+1%>]" value="<%=UOM%>" > 
			<input type="hidden" name="NEW_ITEM-PRICE[<%=i+1%>]" value="<%=Cart.getUnitPrice(i)%>" > 
			<input type="hidden" name="NEW_ITEM-CURRENCY[<%=i+1%>]" value="<%=baseCurrency%>" > 
			<input type="hidden" name="NEW_ITEM-VENDORMAT[<%=i+1%>]" value="<%=Cart.getMaterialNumber(i)%>" > 
			<!--<input type="hidden" name="NEW_ITEM-MATNR[<%=i+1%>]" value="<%=Cart.getMaterialNumber(i)%>" >-->  
			<input type="hidden" name="NEW_ITEM-MANUFACTMAT[<%=i+1%>]" value="<%=tPNo%>" > 
<%
		}
		else
		{
%>
			<input type="text" class="InputBox"  name="Quantity_<%=i%>" size="7" maxlength="10"  style="text-align:right" onBlur = 'verifyQty1( this,"<%= minQ %>","<%= desc.replace('"',' ') %>")' value="<%=proQty%>" > 
<%
		}
%>
			
			
			
			<!--[<input type="text" size="4" class="tx" name="" value="<%=minQ%>" style="text-align:center" readonly>]-->
			<input type="hidden" readonly name="Reqdate_<%=i%>" value="1.11.1000">
			<input type="hidden" readonly name="caseLot_<%=i%>" value="<%= minQ %>">
			<input type="hidden" readonly name="pDesc" value="<%=desc.replace('"',' ')%>">
        		<input type="hidden" name="Currency_<%=i%>" readonly disabled maxlength="5" size="5" value="<%=baseCurrency%>" >
		       	<input type="hidden" name="Price_<%=i%>" readonly disabled size="4" value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
	      		<input type="hidden" name="Product_<%=i%>" size="18" value="<%=Cart.getMaterialNumber(i)%>">
	      		<input type="hidden" name="VendCatalog_<%=i%>" size="18" value="<%=Cart.getVendorCatalog(i)%>">		
	      		<input type="hidden" name="matId_<%=i%>" size="18" value="<%=Cart.getMatId(i)%>">
	      		<input type="hidden" name="mmFlag_<%=i%>" value="<%=Cart.getMultiMediaFlag(i)%>">
	      		<input type="hidden" name="ProductDesc_<%=i%>" value="<%=desc.replace('"',' ')%>">
	      		<input type="hidden" name="Pack_<%=i%>" value="<%=UOM%>">
	      		<input type="hidden" name="Brand_<%=i%>" value="<%=Cart.getBrand(i)%>">
	      		<input type="hidden" name="UPCNum_<%=i%>" value="<%=Cart.getUPCNumber(i)%>">
	      		<input type="hidden" name="CNETPrd_<%=i%>" value="<%=Cart.getVarPriceFlag(i)%>">
	      </td>
	      <td width="4%" align="center" <%=colTone%> title="Click here to remove this product from cart."> <img onClick = 'formSubmit(<%=i%>)' style="cursor:hand" height = '20' width = '20' src='../../Images/Common/delete_icon.gif'/> </td>
	      </tr>
<%
		// Calculate Price according to the Quantity
		Count = Count + 1;
	}
	//}
%>

</Table>
</Div>
		

<div align='center' style='Position:Absolute;width:100%;top:87%'>
	<span id="EzButtonsSpan">
<%
    		buttonName = new java.util.ArrayList();
    		buttonMethod = new java.util.ArrayList();
    		
    		if("Y".equals(isCatUser))
    		{
			buttonName.add("Delete");
			buttonMethod.add("formSubmit()");
    		
			buttonName.add("Check Out");
			buttonMethod.add("checkOut()");
    		}
    		else
    		{
			if("CM".equals(UserRole.toUpperCase()))
			{
				buttonName.add("Create Quotation");
				buttonMethod.add("createQuote()");

				buttonName.add("Publish To Customer");
				buttonMethod.add("publishToCustNew()");
				
			}

			//buttonName.add("Create Catalog");
			//buttonMethod.add("createCG()");

			//buttonName.add("Prepare Order");
			//buttonMethod.add("setCreateOrder()");
			
			if(!("Y".equals(isSubUser) && "VONLY".equals(suAuth)))
			{
				buttonName.add("Prepare Order");
				buttonMethod.add("createOrder()");

				buttonName.add("Add More Products");
				buttonMethod.add("search()");

			}

			//buttonName.add("Delete");
			//buttonMethod.add("formSubmit()");


			if(fromMenu!=null && "Y".equals(fromMenu))
			{
				/*buttonName.add("Back");
				buttonMethod.add("history.go(-1)"); */
			}
			else if(sessionback!=null && "O".equals(sessionback.trim()))
			{
				buttonName.add("Back");
				buttonMethod.add("backOrder()");    		
			}
			else if(back!=null)
			{
				back=back.trim();
				if("1".equals(back))
				{
					buttonName.add("Back");
					buttonMethod.add("goBack()");
				}
				else if("O".equals(back))
				{
					buttonName.add("Back");
					buttonMethod.add("backOrder()");
				}
				else if("2".equals(back))
				{
					buttonName.add("Back");
					buttonMethod.add("history.go(-1)");
				}
				else
				{
					//buttonName.add("Back");
					//buttonMethod.add("setBack()");			
				}

			}
			else if(!"Y".equals(pageFlg))
			{
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
			}
		}
		
    		
    		out.println(getButtonStr(buttonName,buttonMethod));
%>
	</span>	
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
	<Tr>
		<Td class="labelcell">Your request is being processed. Please wait</Td>
	</Tr>
	</Table>
	</span>
</div>
<%
}


%>


<input type="hidden" name="fromCart" value='Y'>
<input type="hidden" name="ProductGroup" value="<%=request.getParameter("ProductGroup")%>">
<input type="hidden" name="GroupDesc" 	value=""<%=request.getParameter("GroupDesc")%>>
<input type="hidden" name="urlPage">
<input type="hidden" name="TotalCount" 	value="<%=cartRows%>" >
<input type="hidden" name="DelFlag" 	value="N">
<input type="hidden" name="ProductGroup" value="<%=ProductGroup%>">
<input type="hidden" name=CatalogDescription  value="<%=CatalogDescription%>">
<input type="hidden" name=GroupLevel 	value="1">
<input type="hidden" name="GroupDesc" 	value="<%=groupDesc%>">
<input type="hidden" name="onceSubmit" 	value=0>
</form>
<Div id="MenuSol"></Div>
</body>
</html>