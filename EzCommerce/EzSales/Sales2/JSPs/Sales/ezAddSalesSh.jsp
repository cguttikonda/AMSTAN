<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Sales/iAddSalesSh.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iHeaderDefaultValues.jsp" %>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>
<% 
   String pageFlg  = request.getParameter("pageFlg");
   String frameFlg = request.getParameter("frameFlg");
%>

<html>
<head>
	<title>Create Sales Order -- Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
		  var tabHeadWidth=90
 	   	  var tabHeight="45%"  	   
</Script>

<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>  
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script> 
<script>


var UserRole="<%=UserRole%>"; 
var SoldTo = "<%= SoldTo %>";
var Agent = "<%= Agent %>";
var shipRowCount = "<%=listShipTos.getRowCount()%>";   
var RefDocType ="<%=RefDocType%>";

var pageFlg ="<%=pageFlg%>"
var frameFlg ="<%=frameFlg%>"

function qtyFocus(obj)
{
   eval("document.generalForm."+obj+".focus();");
}
function select1()
{
	<%// @ include file="../../../Includes/JSPs/Sales/iHeaderSelect.jsp" %>     
	document.generalForm.poNo.focus();
}

var retlen
var rol

var today ="<%= FormatDate.getStringFromDate(new
Date(),".",FormatDate.DDMMYYYY) %>"
var MValues = new Array();
var MDate = new Array();

//MDate[0] = "desiredDate";

MValues[0] =new EzMList("poNo","PO Number");
MValues[1] =new EzMList("poDate","PO Date");
MValues[2] =new EzMList("requiredDate","Required Date");
//MValues[3] =new EzMList("carrierName","Carrier Name");
function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
var MValues1 = new Array();
MValues1[0]="desiredQty";
var total = "<%=cartcount%>";

function chk()
{
	for(c=0;c<MValues.length;c++)
	{

		if( funTrim(eval("document.generalForm."+MValues[c].fldname+".value")) == "")
		{
			eval("document.generalForm."+MValues[c].fldname+".focus()")
			alert("<%=plzEnter_A%>"+MValues[c].flddesc);
			return false;
		}

	}

	for(var a=0;a<MSelect.length;a++)
	{
		res=mselect(MSelect[a]);
		if(!res)
		{
			return false;
		}
	}
	for(b=0;b<MValues1.length;b++)
	{
		res= chkQty(MValues1[b]);
		if(!res)
		{
		 	return false;
		}
	}
	for(b=0;b<MValues1.length;b++)
	{
		y= chkQtyone(MValues1[b]);
		if(eval(y))
		{
			alert("<%=plzEnterQty_A%>");
			return false;
		}
	}

	for(c=0;c<MDate.length;c++)
	{
		if(total==1)
		{
		      if(  funTrim( eval("document.generalForm.desiredQty.value")) == "")
		      {
			if( funTrim(eval("document.generalForm."+MDate[c]+".value")) == "")
			{
				alert("<%=plzReqDate_A%>");
				return false;
			}
			else
			{

				a=(funTrim(eval("document.generalForm."+MDate[c]+"_0.value"))).split(".");
				b=(today).split(".");
					d1=new Date(a[2],a[0]-1,a[1])
					d2=new Date(b[2],b[0]-1,b[1])


				if(  d1  <  d2)
				{
					alert("<%=compReqDate_A%>");
					document.generalForm.desiredQty.focus();
					return false;
				}

			}
                                   }
		}
		else if(total > 1)
		{
			for(i=0;i<total;i++)
			{
			     if(funTrim(eval("document.generalForm.desiredQty["+i+"].value")) != "")
			     {
				if( funTrim(eval("document.generalForm."+MDate[c]+"["+i+"].value")) == "")
				{
					alert("<%=plzReqDate_A%>");
					return false;
				}
				else
				{

					a=(funTrim(eval("document.generalForm."+MDate[c]+"["+i+"].value"))).split(".");
					b=(today).split(".");
					d1=new Date(a[2],(a[1]-1),a[0])
					d2=new Date(b[2],(b[1]-1),b[0])

					if( d1 < d2)
					{
						alert("<%=compReqDate_A%>");
						eval("document.generalForm.desiredQty["+i+"].focus()")
						return false;
					}
				}
			}
                                    }
		}
	}

      var q=verifyAllQty();
      if (!(eval(q)))
      {
	return false;
      }

      return true;
}

function formBack()
{
           // alert("fromDetails");
	 //document.location.replace("../Misc/ezMenuFrameset.jsp"); //remove top by kp
	 //document.body.style.cursor="wait"
	 //document.generalForm.action="../ShoppingCart/ezViewCart.jsp";
	 //document.generalForm.submit();
	 
	 document.generalForm.action="ezCopySalesOrder.jsp";
	 document.generalForm.submit();
	   
	 //history.go(-1)
}

function goBack()
{
 	 document.generalForm.action="../DrillDownCatalog/ezProductSearch.jsp";
	 document.generalForm.submit();
}

function goBackToManualEntry()
{
	document.generalForm.action="ezProductEntry.jsp?From=Cart";
	document.generalForm.submit();
}

function goBackToCart()
{
	document.generalForm.action="../ShoppingCart/ezViewCart.jsp";
	document.generalForm.submit();
}
function chkReqDate()
{
	obj = eval("document.generalForm.requiredDate")
	reqdat= funTrim(obj.value)

	var today ="<%=FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) %>"

	a=reqdat.split(".");
	b=(today).split(".");
	d1=new Date(a[2],(a[1]-1),a[0])
	d2=new Date(b[2],(b[1]-1),b[0])

	if( d1 < d2)
	{
		alert("Required date must be greater than or equal to todays date");
		obj.focus()
		return false;
	}else{
	return true
	}
}
function formSubmit2(obj,obj2)
{
	var val = document.generalForm.shippingType.value
	var key	= new Array(5); 
	if(isNaN(val))
	{
		key=val.split("#");
		document.generalForm.shippingTypeValue.value=key[0];
		document.generalForm.shippingTypeDesc.value=key[1];
	}
	if(total==0)
	{
		alert("Please add atleast one product");
		return;
	}
	if(obj=="ezAddSaveSales.jsp")
	{
		document.generalForm.status.value=obj2;
	}
	if(obj=="ezGetPricesSh.jsp")
	{
		y=chk();
		if(eval(y))
		{
			y=chkReqDate();
		}
		if(eval(y))
		{
			if(document.generalForm.shippingType.value=='SP#Special' && document.generalForm.specialShIns.value=='')
			{
				alert('Please enter special shipping instructions')
				document.generalForm.specialShIns.focus()
				return
			}
			if(document.generalForm.shippingType.value!='SP#Special') 
				document.generalForm.specialShIns.value=''
		}

	}
	else
	{
		y="true";
	}
	if(eval(y))
	{
		hideMsg();
		document.body.style.cursor="wait";
		document.generalForm.action=obj;
		document.generalForm.submit();
	}
}
function fun(obj)
{
	if(obj=="include")
	   obj="ezAddSalesSh.jsp"

	document.body.style.cursor.style="wait";
	document.generalForm.action=obj;
	document.generalForm.submit();
}
function openNewWindow(obj,i)
{
	var len = document.generalForm.del_sch_date.length
	var deldate = "",delqty="",obj="";
	if(isNaN(len))
	{
		deldate=document.generalForm.del_sch_date
		delqty = document.generalForm.del_sch_qty
		obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value
	}
	else
	{
		deldate=eval("document.generalForm.del_sch_date["+i+"]");
		delqty = eval("document.generalForm.del_sch_qty["+i+"]");
		obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value
	}

	newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=400,width=400,status=no,toolbar=no,menubar=no,location=no")
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
			field.value='';
			field.focus();
		}
	}
	*/

}
/*
function verifyQty(field,val,prd)
{
}
*/
function verifyAllQty()
{
	var prd="";
	var val="";
	var fValue="";
	return true
}
function backOrder()
{
	document.generalForm.action="../Sales/ezBackWaitSalesDisplay.jsp";
	document.generalForm.submit();
}

function funDelete()
{
	var tabObj	= document.getElementById("InnerBox1Tab")
	var rowItems 	= tabObj.getElementsByTagName("tr");
	var len 	= rowItems.length;
	var code;
	count = 0;
	
	
	if(len<=1)
	{
		alert("Sales Order must have atleast one product");
		return;
	}
	
	var chkObj = document.generalForm.chk;

	if(len==1)
	{
		if(chkObj.checked)
		{
			code = chkObj.value;
			count = 1;
		}	
	}
	else
	{
		for(i=len-1;i>=0;i--)
		{

			if(chkObj[i].checked)
			{
				if(count == 0)
				{
					code = chkObj[i].value;

				}else
				{
					code += ","+chkObj[i].value;


				}
				count++;
			}

		}
	}
	
	if(count<=0)
	{
		alert("Please select atleast one product to delete")
		return;
	}
	else
	{
		document.generalForm.DelFlag.value='DEL'
		
		
		var myObj = document.generalForm.chk;
		
		if(confirm("Do You want to delete the product(s) that you select?"))
		{
			deleteQuery(code);
			count = 0;
			for(i=len-1;i>=0;i--)
			{
				if(len==1)
				{
					if(myObj.checked)
						tabObj.deleteRow(i)	
				}
				else
				{
					if(myObj[i].checked)
					{
						tabObj.deleteRow(i);	
					}
				}
			}			
		}
		
	}
	
	document.generalForm.total.value = rowItems.length;
	total = rowItems.length;
}

function deleteQuery(code)
{
	Initialize();
	var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezUpdateCartProducts.jsp?productNo="+code+"&pageFlag=DELETE"+"&date="+new Date();
	if(req!=null)
	{
		req.onreadystatechange = Process2;
		req.open("GET", url, true);
		req.send(null);
	}
	
	
	
}
function Process2()
{
   
   if (req.readyState == 4)
   {
	var resText = req.responseText;	 	        	
	var resultText	= resText.split("#");
        
	if (req.status == 200){
	        top.menu.document.msnForm.cartHolder.value = resultText[1];
	}
	
   }
   
}

function ezAddProducts()
{
	var returnVal 	= document.generalForm.returnValue.value;         
	var tabObj	= document.getElementById("InnerBox1Tab") 
	var rowItems 	= tabObj.getElementsByTagName("tr");
	var len 	= rowItems.length;
	var retValue	= "";	

	count = 0;
	var selPrdList;
	
	if(len==1)
	{
		selPrdList	= document.generalForm.product.value;      
	}
	else
	{
		for(i=0;i<len;i++)
		{	
			if(count==0)
				selPrdList	= eval("document.generalForm.product["+i+"]").value;
			else	
				selPrdList	+= "@@@"+eval("document.generalForm.product["+i+"]").value;  
			count++;
		}
	}
	str = "../BusinessCatalog/ezProductSearchForSales.jsp?retVal="+selPrdList;
	
	retVal=window.showModalDialog(str,"",'center:yes;dialogWidth:50;dialogHeight:25;status:no;minimize:yes');
	
	
	
	if(retVal!=null && retVal!=undefined)
	{
		if(retVal.retProd=='CLOSE')
		{
			retValue = "N";
		}
		else
		{
			retValue = "Y";
		}
	}
	else
		retValue = "N";
	
	return retValue;
}

myProdCode	= new Array();
myProducts	= new Array();
myProdDesc	= new Array();
myProdUom	= new Array();
myProdUpc	= new Array();

function moreProducts()
{

	/*ret = ezAddProducts();



	if(ret!='N' )
	{
	
	var prodcnt =0;
	myProdCode	= retVal.retProd.split(",");	
	myProdDesc	= retVal.retDesc.split(",");	
	myProdUom	= retVal.retUom.split(",");	
	myProdUpc	= retVal.retUpc.split(",");	

	var tabObj		= document.getElementById("InnerBox1Tab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	
	var rowCountValue 	= rowItems.length;
	
	document.generalForm.total.value = rowCountValue;

	prodcnt	= myProdCode.length;
	var lineCount=0;
	for (lineCount=0;lineCount<prodcnt;lineCount++)
	{
		ezAddNewRow(lineCount);
	}
	total = rowItems.length;
	}
	scrollInit();*/
	
	
	
	if(frameFlg!="Y")
		document.generalForm.target = "_parent";
	document.generalForm.action = "../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
	document.generalForm.submit();
	
}

function ezAddNewRow(lineCount)
{
	var myProductsLength	= myProducts.length;
	
	
	
	var tabObj		= document.getElementById("InnerBox1Tab")
	var rowItems 		= tabObj.getElementsByTagName("tr");
	var rowCountValue 	= rowItems.length;
	
	
	
	var rowId 		= tabObj.insertRow(rowCountValue);
	elementsArray		= new Array();
	rowCount 		= rowCountValue;


	hiddenFields="<input type='hidden' 	name='desiredDate'   	value=''>";
	hiddenFields+="<input type='hidden' 	name='prodsForDelete'   value=''>";
	hiddenFields+="<input type='hidden' 	name='qtysForDelete' 	value=''>";
	hiddenFields+="<input type='hidden' 	name='datesForDelete' 	value=''>";
	//hiddenFields+="<input type='hidden' 	name='product' 		value="+myProdCode[lineCount]+">";

	elementsArray[0]  ='<input type="checkbox" name="chk"	value='+myProdCode[lineCount]+'>'
	elementsArray[1]  ='<input type="text" class="tx"  size=25 name=product      	style="text-align:left" 	readonly	value='+myProdCode[lineCount]+'>'
	elementsArray[2]  ='<input type="text" class="tx"  size=40 name=prodDesc        style="text-align:left"  	readonly	value="'+myProdDesc[lineCount]+'">'
	elementsArray[3]  ='<input type="text" class="tx"  size=10 name=pack       	style="text-align:center"  	readonly	value='+myProdUom[lineCount]+'>'+hiddenFields
	elementsArray[4]  ='<input type="text" class=InputBox size="10" maxlength="15" STYLE="text-align:right" 	name="desiredQty" onBlur="verifyQty1(this,\''+funTrim(myProdUpc[lineCount])+'\',\''+myProdCode[lineCount]+'\')" value="">&nbsp;['+funTrim(myProdUpc[lineCount])+']'
	
	eleWidth = new Array();
	eleAlign = new Array();
	
	eleWidth[0]  = "5%";	eleAlign[0] = "left";
	eleWidth[1]  = "25%";	eleAlign[1] = "left";
	eleWidth[2]  = "40%";	eleAlign[2] = "left";
	eleWidth[3]  = "10%";	eleAlign[3] = "center";
	eleWidth[4]  = "20%";	eleAlign[4] = "left";
	
	
	len=elementsArray.length
	
	for (i=0;i<len;i++){
		cell0Data = elementsArray[i]
		cell0=rowId.insertCell(i);
		cell0.innerHTML=cell0Data;
		cell0.align=eleAlign[i];
		cell0.width= eleWidth[i]
	}
	rowCount++;
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


<script>  
	var cannotbelessthan0="can not be less than 0"
	var entervalid="<%=plzEntValid_A%>"
	var inNumbers ="<%=inNum_A%>"
	var serverName = "<%=request.getServerName()%>";
</Script>	

<Script src="../../Library/JavaScript/Sales/ezCarrierAjax.js"></Script>
<script src="../../Library/JavaScript/ezVerifyField.js"></script>

<script>
        top.menu.document.msnForm.cartHolder.value = "<%=cartItems%>";
	var PleaseselectShipTo ="<%=plzSelShipTo_A%>"
	var PleaseselectSoldTo="<%=plzSoldTo_A%>"
</script>
<script src="../../Library/JavaScript/ezMandatorySelectHeader.js"></script> 
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/Misc/ezChangeAddress.js"></script>
<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>

</head>
<body onLoad="scrollInit();select1();Initialize()" onresize="scrollInit()" scroll=no>
<form method="post" action="ezPlaceOrder.jsp" name="generalForm">
<input type="hidden"  name="status">
<input type="hidden"  name="currency" value="<%=Currency%>">
 
<%@ include file="../../../Includes/JSPs/Sales/iHeaderDisplay.jsp" %>       

<Div id="theads">
<Table  width="90%"  id="tabHead"  align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
   <%@ include file="../../../Includes/JSPs/Sales/iProductDetailTr.jsp"%>   
</Table>
</Div>
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="orderDate" value="<%=OrderDate%>">
<input type="hidden" name="refDocType" value="<%=RefDocType%>">
<input type="hidden" name="scDoc" value="<%=SCDoc%>">
<input type="hidden" name="scDocNr" value="<%=SCDocNr%>">
<input type="hidden" name="DelFlag" value=''>
<input type="hidden" name="backFlag" value='ADDDELETE'>
<input type="hidden" name="frameFlg" value='<%=frameFlg%>'>

<input type="hidden" name="returnValue" value=''>
<input type="hidden" name="inco1" value="<%=inco1%>">
<input type="hidden" name="inco2" value="<%=inco2%>">
<input type="hidden" name="payterms" value="<%=Payterms%>">
<input type="hidden" name="generalNotes" value="<%=generalNotes%>">

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:100%;height:45%;left:2%">
<Table id="InnerBox1Tab"  align=center  border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 width="100%">

<%@ include file="../../../Includes/JSPs/Sales/iProductCartDetailTd.jsp" %>   

</Table>
</Div>
<input type="hidden" name="total" value="<%=cartcount%>">
<div id="buttonDiv"  align="center" style="visibility:visible;position:absolute;top:90%;width:100%">
<%
	String fromCart		= request.getParameter("fromCart"); 
		
	String strSalesOrder    = "";   
	String fromDate 	= "";
	String toDate 		= "";
	String patno 		= "";  
	String status 		= "";
	String back		= "";
	
	
	strSalesOrder   = (String)session.getAttribute("SONumber"); 
	fromDate 	= (String)session.getAttribute("FromDate");
	toDate 		= (String)session.getAttribute("ToDate");
	patno 		= (String)session.getAttribute("SoldTo");
	status 		= (String)session.getAttribute("status");
	back 		= (String)session.getAttribute("back");

	/*session.removeValue("SONumber");
	session.removeValue("FromDate");
	session.removeValue("ToDate");
	session.removeValue("SoldTo");
	session.removeValue("status"); 
	session.removeValue("back");*/
	
	
	String flgBack 		= request.getParameter("bkpflg");
	if(cartcount !=0)
	{
	
		
	
%>
<Table align=center>
	<Tr>
	<Td class="blankcell" align="center">
	<span id="EzButtonsSpan">
<%
		
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Add More Products");
	buttonMethod.add("moreProducts()");
	buttonName.add("Delete Products");
	buttonMethod.add("funDelete()");
	buttonName.add("Obtain Prices");
	buttonMethod.add("formSubmit2(\"ezGetPricesSh.jsp\",\"NO\")");
	buttonName.add("Back");
	
	String fromDetails 	= request.getParameter("fromDetails");
	//out.println("bkpflgbkpflgbkpflgbkpflg"+flgBack);
	
	
	if(fromCart!=null && "Y".equals(fromCart))
		buttonMethod.add("goBackToCart()");
	else if(back!=null && !"null".equals(back.trim()) && "O".equals(back.trim()))
		buttonMethod.add("backOrder()");
	else if("Y".equals(fromDetails))
	{
		buttonMethod.add("formBack()");
	}
	else if(flgBack!=null)
	{
		if("Manual".equals(flgBack))
			buttonMethod.add("goBackToManualEntry()");
		else if("QuickOrdEntBk".equals(flgBack))
			buttonMethod.add("goBackToManualEntry()");
		else if("CpyOrdr".equals(flgBack))
			buttonMethod.add("formBack()");
		else	
			buttonMethod.add("goBack()");
	}
	else if("Y".equals(BackOrder))
		buttonMethod.add("goBackToCart()");
	else 
		buttonMethod.add("formBack()");	
		
	
	
	
		
		
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
	</Td>
	</Tr>
</Table>  

<%	}else
	{
%>
	<Table align=center>
		<Tr>
			<Td class="blankcell" align="center">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	buttonName.add("Back");
	
	if(fromCart!=null && "Y".equals(fromCart))
		buttonMethod.add("goBackToCart()");
	else if(back!=null && "O".equals(back.trim()))
		buttonMethod.add("backOrder()");
	else if("Y".equals(BackOrder))
		buttonMethod.add("goBackToCart()");		
	else
		buttonMethod.add("formBack()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
			</Td>
		</Tr>
	</Table>

<%

	}

%>
<input type="hidden" name="fromCart" value="<%=fromCart%>">
<input type="hidden" name="mBack" value="C">
<input type="hidden" name="SONumber" value="<%=strSalesOrder%>">
<input type="hidden" name="FromDate" value="<%=fromDate%>">
<input type="hidden" name="ToDate" value="<%=toDate%>">
<input type="hidden" name="SoldTo" value="<%=patno%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="pageUrl" value="BackOrder">
<input type="hidden" name="PODATE" value="">
<input type="hidden" name="orderType" value="">
<input type="hidden" name="netValue" value="">
<input type="hidden" name="bkpflg" value="<%=flgBack%>">
<input type="hidden" name="shippingTypeDesc" value="">
<input type="hidden" name="shippingTypeValue" value="">
</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>