

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp" %>

<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%
	//ezc.shopping.cart.common.EzShoppingCart Cart = (ezc.shopping.cart.common.EzShoppingCart)session.getValue("ezShoppingCart");
	java.util.ArrayList selectedItems=new java.util.ArrayList();
  	
  	int cartcount=0;
  	if(Cart!=null){
		//Cart.getCatAreaCart(session.getId());
		if(Cart!=null){
			cartcount=Cart.getRowCount();
			for(int i=0;i<cartcount;i++){
				selectedItems.add(Cart.getMaterialNumber(i));
			}
		}
	}

%>
<%@ include file="../../../Includes/JSPs/Sales/iHeaderDefaultValues.jsp" %>
<%

String inco1 = request.getParameter("inco1");
String inco2 = request.getParameter("inco2");
String Payterms = request.getParameter("payterms");
String generalNotes = request.getParameter("generalNotes");

Hashtable getFOC = new Hashtable();

String SCDocNr = request.getParameter("scDocNr");

String shop = request.getParameter("shop");
Hashtable getprices = new Hashtable();
ezc.ezbasicutil.EzCurrencyFormat myFormat = new ezc.ezbasicutil.EzCurrencyFormat();

String from = request.getParameter("from");
//String inco1 = request.getParameter()
 if(from != null)
   {
  	session.removeAttribute("getprices");
	session.removeAttribute("getFOC");
  }

if(session.getAttribute("getprices")!=null)
{
  getprices =(Hashtable)session.getAttribute("getprices");
  getFOC =(Hashtable)session.getAttribute("getFOC");
}

String[] upcNo=new String[cartcount];
if(session.getAttribute("getprices")==null)
{%>

<%

	Hashtable selMet= new Hashtable();

	if(cartcount > 0)
	{
	    
	    for(int i=0;i<cartcount;i++)
	    {
		
		
		selMet.put(Cart.getMaterialNumber(i),"GRP1"+","+"1");
		upcNo[i]="1";
		
		System.out.println(Cart.getMaterialNumber(i));
	    }
	}
session.putValue("SELECTEDMET",selMet);
}


	String soldToInfoStr    =(String)session.getValue("oneTimeSoldToInfo");
	String shipToInfoStr    =(String)session.getValue("oneTimeShipToInfo");
	
	if(soldToInfoStr==null) soldToInfoStr="";
	if(shipToInfoStr==null) shipToInfoStr="";
	soldToInfoStr=soldToInfoStr.trim();
	shipToInfoStr=shipToInfoStr.trim();
	
	
	String oneTimeshipTo	= null;
	String shipToName	= null;
	String shipToCountry 	= null;
	String shipToStreet 	= null;
	String shipToCity 	= null;
	String shipToRegion 	= null;
	String shipToZipCode 	= null;
	String shipToAddress1 	= null;
	String shipToAddress2 	= null;
	
	
	String soldToName	=  null;
	String soldToCountry 	=  null;
	String soldToStreet 	=  null;
	String soldToCity 	=  null;
	String soldToRegion 	=  null;
	String soldToZipCode 	=  null;
	String soldToAddress1 	=  null;
	String soldToAddress2 	=  null;
				  
	
	if(shop!=null){
		if("OTU".equalsIgnoreCase((String)session.getValue("UserRoleOld"))){
			if(!("".equals(soldToInfoStr))){

				java.util.StringTokenizer soldTostk=new java.util.StringTokenizer(soldToInfoStr,"ее");
				try{
					soldToName	= (String)soldTostk.nextToken();
					soldToStreet 	= (String)soldTostk.nextToken();
					soldToCity 	= (String)soldTostk.nextToken();
					soldToRegion 	= (String)soldTostk.nextToken();
					soldToZipCode 	= (String)soldTostk.nextToken();
					soldToCountry 	= (String)soldTostk.nextToken();
				}catch(Exception e){}

			}

			if(!("".equals(shipToInfoStr))){

				java.util.StringTokenizer shipTostk=new java.util.StringTokenizer(shipToInfoStr,"ее");
				try{
				shipToName	= (String)shipTostk.nextToken();
				shipToStreet 	= (String)shipTostk.nextToken();
				shipToCity 	= (String)shipTostk.nextToken();
				shipToRegion 	= (String)shipTostk.nextToken();
				shipToZipCode 	= (String)shipTostk.nextToken();
				shipToCountry 	= (String)shipTostk.nextToken();
				}catch(Exception e){}

			}
		}else{
			
			if(listShipTos!=null && listShipTos.getRowCount()>0){
				shipToName	= listShipTos.getFieldValueString(0,"ECA_NAME").trim();
				shipToCountry 	= listShipTos.getFieldValueString(0,"ECA_COUNTRY").trim();
				shipToStreet 	= listShipTos.getFieldValueString(0,"ECA_ADDR_1");
				shipToCity 	= listShipTos.getFieldValueString(0,"ECA_CITY");
				shipToRegion 	= listShipTos.getFieldValueString(0,"ECA_STATE");
				shipToZipCode 	= listShipTos.getFieldValueString(0,"ECA_PIN");
				shipToAddress1 	= "";
				shipToAddress2 	= "";
				
				soldToCountry 	= listShipTos.getFieldValueString(0,"ECA_COUNTRY").trim();
				soldToStreet 	= listShipTos.getFieldValueString(0,"ECA_ADDR_1");
				soldToCity 	= listShipTos.getFieldValueString(0,"ECA_CITY");
				soldToRegion 	= listShipTos.getFieldValueString(0,"ECA_STATE");
				soldToZipCode 	= listShipTos.getFieldValueString(0,"ECA_PIN");
				soldToAddress1 	= "";
				soldToAddress2 	= "";
			}


			if(retsoldto!=null && retsoldto.getRowCount()>0){
				soldToName	= retsoldto.getFieldValueString(0,"ECA_NAME");
				
				
			}
			
			
			
			
		}
	}else{
		oneTimeshipTo	= request.getParameter("shipTo");
		shipToName	= request.getParameter("shipToName");
		shipToCountry 	= request.getParameter("shipToCountry");
		shipToStreet 	= request.getParameter("shipToStreet");
		shipToCity 	= request.getParameter("shipToCity");
		shipToRegion 	= request.getParameter("shipToRegion");
		shipToZipCode 	= request.getParameter("shipToZipCode");
		shipToAddress1 	= request.getParameter("shipToAddress1");
		shipToAddress2 	= request.getParameter("shipToAddress2");


		soldToName	= request.getParameter("soldToName");
		soldToCountry 	= request.getParameter("soldToCountry");
		soldToStreet 	= request.getParameter("soldToStreet");
		soldToCity 	= request.getParameter("soldToCity");
		soldToRegion 	= request.getParameter("soldToRegion");
		soldToZipCode 	= request.getParameter("soldToZipCode");
		soldToAddress1 	= request.getParameter("soldToAddress1");
		soldToAddress2 	= request.getParameter("soldToAddress2");
	}	
	
	
	if(oneTimeshipTo==null)	oneTimeshipTo="";
	if(shipToName==null)	shipToName="";
	if(shipToCountry==null)	shipToCountry="";
	if(shipToStreet==null)	shipToStreet="";
	if(shipToCity==null)	shipToCity="";
	if(shipToRegion==null)	shipToRegion="";
	if(shipToZipCode==null)	shipToZipCode="";
	if(shipToAddress1==null)shipToAddress1="";
	if(shipToAddress2==null)shipToAddress2="";
	
	
	if(soldToName==null)	soldToName="";
	if(soldToCountry==null)	soldToCountry="";
	if(soldToStreet==null)	soldToStreet="";
	if(soldToCity==null)	soldToCity="";
	if(soldToRegion==null)	soldToRegion="";
	if(soldToZipCode==null)	soldToZipCode="";
	if(soldToAddress1==null)soldToAddress1="";
	if(soldToAddress2==null)soldToAddress2="";






%>



<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<html>
<head>
	<title>Create Sales Order -- Powered by EzCommerce Inc</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	  var tabHeadWidth=95
	  var tabHeight="45%"

</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<Script src="../../Library/JavaScript/ezCountries.js"></Script>
	<Script src="../../Library/JavaScript/ezDocURL.js"></Script>	

<script>

var UserRole="<%=UserRole%>";
var SoldTo = "<%= SoldTo %>";
var Agent = "<%= Agent %>";
var shipRowCount = "<%=listShipTos.getRowCount()%>";
var RefDocType ="<%=RefDocType%>";
function qtyFocus(obj)
{
   eval("document.generalForm."+obj+".focus();");
}
function select1()
{
	<%@ include file="../../../Includes/JSPs/Sales/iHeaderSelect.jsp" %>

	document.generalForm.poNo.focus();
}


var retlen
var rol

var today ="<%= FormatDate.getStringFromDate(new
Date(),".",FormatDate.DDMMYYYY) %>"
var MValues = new Array();
var MDate = new Array();

MDate[0] = "desiredDate";

MValues[0] =new EzMList("poNo","PO Number");
MValues[1] =new EzMList("poDate","PO Date");
MValues[2] =new EzMList("requiredDate","Required Date");
MValues[3] =new EzMList("soldToName",  "Sold To Name");
MValues[4] =new EzMList("soldToStreet","Sold To Street");
MValues[5] =new EzMList("soldToCity","Sold To City");
MValues[6] =new EzMList("soldToRegion","Sold To Region");
MValues[7] =new EzMList("soldToZipCode","Sold To ZipCode");
MValues[8] =new EzMList("shipToName","Ship To Name");
MValues[9] =new EzMList("shipToStreet","Ship To Street");
MValues[10] =new EzMList("shipToCity","Ship To City");
MValues[11] =new EzMList("shipToRegion","Ship To Region");
MValues[12] =new EzMList("shipToZipCode","Ship To ZipCode");
function EzMList(fldname,flddesc)
{
	this.fldname=fldname;
	this.flddesc=flddesc;
}
var MValues1 = new Array();
MValues1[0]="desiredQty";
var total = "<%=cartcount%>";


function funZip(sValue)
{	
	var validChars="0123456789- ";
	var nLoop=0;
	var nLength=sValue.length;
	for(nLoop=0;nLoop<nLength;nLoop++)
	{
		cChar=sValue.charAt(nLoop);
		if (validChars.indexOf(cChar)==-1)
		{
			return false;
		}
	}
	return true;
}





function chk()
{
	for(c=0;c<MValues.length;c++)
	{

		if( funTrim(eval("document.generalForm."+MValues[c].fldname+".value")) == "")
		{
			eval("document.generalForm."+MValues[c].fldname+".focus()")
			alert("<%=plzEnter_A%>"+MValues[c].flddesc);
			return false;
		}else if(c==7||c==12){
			var val=eval("document.generalForm."+MValues[c].fldname+".value");
			if(val.length<5){
				eval("document.generalForm."+MValues[c].fldname+".focus()")
				alert("Zip Code must be 5 digits number");
				return false;
				
			}
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

 		 if("CATALOG"=="<%=(String)session.getValue("GoTo")%>"){
 		 	document.generalForm.action="../BusinessCatalog/ezFullCatalog.jsp?back=1";
		 	document.body.style.cursor="wait"
			document.generalForm.submit();
 		 	
 		 	
 		 }else if("SEARCH"=="<%=(String)session.getValue("GoTo")%>"){
 		 	document.generalForm.action="../MaterialSearch/ezSearchMaterials.jsp?back=1";
			document.body.style.cursor="wait"
			document.generalForm.submit();
 		 		
 		 }else{
			 document.generalForm.action="../Misc/ezBackViewCartFrameset.jsp";
			 document.body.style.cursor="wait"
			 document.generalForm.submit();
		}
}
function chkReqDate()
{
	obj = eval("document.generalForm.requiredDate")
	reqdat= funTrim(obj.value)

	var today ="<%= FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) %>"

	a=reqdat.split(".");
	b=(today).split(".");
	d1=new Date(a[2],(a[0]-1),a[1])
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

	}
	else
	{
		y="true";
	}
	if(eval(y))
	{
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
	deldate=eval("document.generalForm.del_sch_date["+i+"]");
	delqty = eval("document.generalForm.del_sch_qty["+i+"]");
	obj=obj + "&dates=" + deldate.value +"&qtys="+delqty.value
	//alert(obj)

	newWindow = window.open(obj,"multi","resizable=no,left=250,top=100,height=400,width=400,status=no,toolbar=no,menubar=no,location=no")
		//newWindow.name="parent.opener.document.generalForm."+obj
		//newWindow.name="parent.opener."+obj
}
function verifyQty(field,val,prd)
{
/*
var fValue=field.value
	if((val!="")&&(!isNaN(val)))
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

function verifyAllQty()
{
	var prd="";
	var val="";
	var fValue="";

/*
	if(total==1)
	{
		var prd=eval("document.generalForm.prodDesc.value")
		var val=eval("document.generalForm.produpcNo.value")
		var fValue=eval("document.generalForm.desiredQty.value")
		var field=eval("document.generalForm.desiredQty")

		if((val!="")&&(!isNaN(val)))
		{
			if((fValue%val)!=0)
			{
				alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
				field.value=0;
				field.focus();
				return false;
			}
		}
		return true
	}else{
		for(c=0;c<total;c++)
		{
			var prd=eval("document.generalForm.prodDesc["+c+"].value")
			var val=eval("document.generalForm.produpcNo["+c+"].value")
			var fValue=eval("document.generalForm.desiredQty["+c+"].value")
			var field=eval("document.generalForm.desiredQty["+c+"]")

			if((val!="")&&(!isNaN(val)))
			{
				if((fValue%val)!=0)
				{
					alert("Shipper quantity of "+ prd +" is  : " + val  +"\nSolution :Please enter multiple of "+ val)
					field.value=0;
					field.focus();
					return false;
				}
			}

		}
		return true
	}
*/
return true
}
function showATP(ind)
	{
		prodCode = ""
		prodDesc =""
		reqDate =""
		reqQty =""
		uom=""

		if (document.generalForm.product[ind]!=null)
		{
			prodCode = document.generalForm.product[ind].value
			prodDesc =document.generalForm.productDesc[ind].value
			reqDate =document.generalForm.desiredDate[ind].value
	 		reqQty =document.generalForm.desiredQty[ind].value
	 		uom=document.generalForm.pack[ind].value

		}
		else
		{
			prodCode = document.generalForm.product.value
			prodDesc =document.generalForm.productDesc.value
			reqDate =document.generalForm.desiredDate.value
	 		reqQty =document.generalForm.desiredQty.value
	 		uom=document.generalForm.pack.value

		}

		myurl ="ezGetATP.jsp?ProductCode="+prodCode+"&ProdDesc="+prodDesc+"&ReqDate="+reqDate+"&ReqQty="+reqQty+"&UOM="+uom
		retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=200,width=500,status=no,toolbar=no,menubar=no,location=no")
		//retVal=showModalDialog(myurl," ",'center:yes;dialogWidth:25;dialogHeight:14;status:no;minimize:yes')
	}
	
	function funBlur(obj,name)
	{
	
		var blueObj = eval("document.generalForm."+name)
		
		if(blueObj!=null)
		{
		  if(blueObj.value =='')
		  {
		       blueObj.value= obj.value
		  }
		}
	}
	function funBlurSelect(obj,name)
	{
		var blueObj = eval("document.generalForm."+name)
		if(blueObj!=null)
		{

			for(var j=0;j<blueObj.length;j++)
			{	
				if(blueObj[j].value ==obj.value)
				{
					blueObj[j].selected=true;
					break;
				}
			}
		}
	}

</script>
<script src="../../Library/JavaScript/ezSniffer.js"></script>
<script src="../../Library/JavaScript/ezCalValue.js"></script>
<script>
var cannotbelessthan0="can not be less than 0"
var entervalid="<%=plzEntValid_A%>"
var inNumbers ="<%=inNum_A%>"
</script>
<script src="../../Library/JavaScript/ezVerifyField.js"></script>
<script src="../../Library/JavaScript/ezSelSelect.js"></script>
<script>
<%-- the variables declared are used in ezMandatorySelectHeader.js
 changes here reflect to ezAddSales.jsp --%>
var PleaseselectShipTo ="<%=plzSelShipTo_A%>"
var PleaseselectSoldTo="<%=plzSoldTo_A%>"

</script>
<script src="../../Library/JavaScript/ezMandatorySelectHeader.js">
</script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script src="../../Library/JavaScript/ezChangeAddressText.js"></script>
<script src="../../Library/JavaScript/ezChangeAddress.js"></script>
<script src="../../Library/JavaScript/ezTrim.js"></script>

</head>
<body onLoad="scrollInit();" onresize="scrollInit()" scroll=no>
<form method="post" action="ezPlaceOrder.jsp" name="generalForm">
<input type="hidden"  name="status">
<input type="hidden"  name="currency" value="<%=Currency%>">

<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" width="40%">
 <%   
    if(!("CATALOG".equals((String)session.getValue("GoTo"))||"SEARCH".equals((String)session.getValue("GoTo")))){
 %>   
	<a style="text-decoration:none"  class=subclass href="../Misc/ezSalesHome.jsp" target="_top"><img src="../../Images/Buttons/<%= ButtonDir%>/home_button.gif"  title="Home" border=0 style="cursor:hand"> </a>&nbsp; <a style="text-decoration:none"  class=subclass href="../Misc/ezLogout.jsp" target="_top"><img src="../../Images/Buttons/<%= ButtonDir%>/logout_butt.gif"  title="Logout" style="cursor:hand"  border=0></a></td>
<%
    }
%>
	
    <td height="35" class="displayheaderback"  width="60%"><%=creOrder_L%></td>
</tr>
</table>



<Table width=85% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
      <tr >
		<th width="17%" class="labelcell" align="left"><%=poNo_L%></th>
		<td width="17%"><input type="text" class=InputBox name="poNo" maxlength="20" size="13" value="<%= ("null".equals(PONO)||PONO==null)?"":PONO%>" ></td>
		<th width="17%" class="labelcell" align="left">Sold To Name </th>
		<Td width="17%"><input type='text' class=InputBox name='soldToName'  value="<%=soldToName%>" onBlur="funBlur(this,'shipToName')"></Td>
		<th width="17%" class="labelcell" align="left">Ship To Name </th>
		<Td width="17%"><input type='text' class=InputBox name='shipToName'  value="<%=shipToName%>"><input type='hidden' class=InputBox name='shipTo'  value="<%=listShipTos.getFieldValueString(0,"EC_PARTNER_NO").trim()%>"></Td>

	
	</tr>
	<tr> 
		<th class="labelcell" align="left">Ship Via </th>
			<Td >
				<Select name="shipVia" width="40%">
					<!--<Option Value="01">standard</Option>
					<Option Value="02">Pick up</Option>
					<Option Value="03">Immediately</Option>
					<Option Value="04">Transport Service</Option>-->
					<Option Value="05">Truck</Option>
					<Option Value="06">Common Carrier</Option>
					<Option Value="07">Will-Call</Option>
					<Option Value="08">UPS/DHL-Ground</Option>
					<Option Value="09">UPS/DHL-ND Air 8AM</Option>
					<Option Value="10">UPS/DHL-ND Air 10AM</Option>
					<Option Value="11">UPS/DHL-ND Air 3PM</Option>
					<Option Value="12">UPS/DHL- 2 Day Air</Option>
					<Option Value="13">UPS/DHL-Economy</Option>
					<!--<Option Value="RE">Returns</Option>
					<Option Value="Y1">Empty/Return pick-up</Option>-->
				</Select>
		</Td>
		<th class="labelcell" align="left">Street </th>
		<Td ><input type='text' class=InputBox name='soldToStreet'  value="<%=soldToStreet%>" onBlur="funBlur(this,'shipToStreet')"></Td>
		<th class="labelcell" align="left">Street </th>
		<Td ><input type='text' class=InputBox name='shipToStreet'  value="<%=shipToStreet%>"></Td>      	
	</tr>
	<Tr>
		<th class="labelcell" align="left" rowspan=2><%=poDate_L%></th>
		<td nowrap rowspan=2><input type="text" class=InputBox name="poDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%=PODate%>"><a href='javascript:showCal("document.generalForm.poDate",120,280,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")' style="text-decoration:none"><img src="../../Images/Buttons/<%= ButtonDir%>/calender.gif"  title="<%=calToolTip%>" height="20" border="none" valign="center" ></a></td>
		<!--
		<th class="labelcell" align="left">Terms</th>
		<Td >
			<Select name="Terms" width="40%">
				<Option Value="Pay Before Delivery">Pay Before Delivery</Option>
				<Option Value="Payable upon receipt">Payable upon receipt</Option>
				<Option Value="Before 10th of next month">Before 10th of next month</Option>
			</Select>
		</Td>
		-->
		<th class="labelcell" align="left">City </th>
		<Td ><input type='text' class=InputBox name='soldToCity'  value="<%=soldToCity%>" onBlur="funBlur(this,'shipToCity')"></Td>
		<th class="labelcell" align="left">City </th>
		<Td ><input type='text' class=InputBox name='shipToCity'  value="<%=shipToCity%>"></Td>
	</Tr>
	<Tr>
		
		<th class="labelcell" align="left">State </th>
		<Td ><input type='text' class=InputBox name='soldToRegion'  value="<%=soldToRegion%>" onBlur="funBlur(this,'shipToRegion')"></Td>
		<th class="labelcell" align="left">State </th>
		<Td ><input type='text' class=InputBox name='shipToRegion'  value="<%=shipToRegion%>"></Td>
	</Tr>
	<Tr> 
		<th class="labelcell" align="left" rowspan=2><%=rDate_L%></th>
		<td nowrap rowspan=2><input type="text" class=InputBox name="requiredDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%= ("null".equals(REQDate)||REQDate==null)? "" : REQDate%>"><a href='javascript:showCal("document.generalForm.requiredDate",130,280,"<%= cDate%>","<%= cMonth%>","<%= cYear%>")' style="text-decoration:none">  <img src="../../Images/Buttons/<%= ButtonDir%>/calender.gif"  title="<%=calToolTip%>" height="20" border="none" valign="center" ></td>
		<th class="labelcell" align="left">Postal Code </th>
		<Td ><input type='text' class=InputBox name='soldToZipCode' maxlength="5"  value="<%=soldToZipCode%>" onBlur="funBlur(this,'shipToZipCode')"></Td>
		<th class="labelcell" align="left">Postal Code </th>
		<Td ><input type='text' class=InputBox name='shipToZipCode' maxlength="5"  value="<%=shipToZipCode%>"></Td>
	</Tr>
	<Tr>	
		
		<th class="labelcell" align="left">Country </th>
		<Td >
			<Select name="soldToCountry" style="width:100%"  onBlur="funBlurSelect(this,'shipToCountry')">
			<Script>
				for(i=0;i<ezCountry.length;i++)
				{
				    if(ezCountry[i].code == 'US')
				    {
					document.write('<Option value='+ezCountry[i].code+' selected>'+ezCountry[i].desc+'</Option>');
				    }
				    else
				    {
				        document.write('<Option value='+ezCountry[i].code+'>'+ezCountry[i].desc+'</Option>');
				    }
				}
			</Script>
			</Select>
			<input type='hidden' name='soldToAddress1'  value=""> 
		</Td>
	        <th class="labelcell" align="left">Country </th>
		<Td >
			<Select name="shipToCountry"  style="width:100%">
			<Script>
				for(i=0;i<ezCountry.length;i++)
				{
				    if(ezCountry[i].code == 'US')
				    {
					document.write('<Option value='+ezCountry[i].code+' selected>'+ezCountry[i].desc+'</Option>');
				    }
				    else
				    {
				        document.write('<Option value='+ezCountry[i].code+'>'+ezCountry[i].desc+'</Option>');
				    }
				}
			</Script>	
	 		</Select>
			<input type='hidden' name='shipToAddress1'  value="">
			<input type='hidden' name='orderDate'  value='<%=OrderDate %>'>
			<input type='hidden' name='soldTo'  value='<%=SoldTo%>'></td>
		</Td>
	</Tr>
	</table>

<Div id="theads">
<Table  width="95%"  id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >

   <%@ include file="../../../Includes/JSPs/Sales/iProductDetailTr.jsp"
%>
</Table>
</Div>
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="orderDate" value="<%=OrderDate%>">
<input type="hidden" name="refDocType" value="<%=RefDocType%>">
<input type="hidden" name="scDoc" value="<%=SCDoc%>">
<input type="hidden" name="scDocNr" value="<%=SCDocNr%>">

<input type="hidden" name="inco1" value="<%=inco1%>">
<input type="hidden" name="inco2" value="<%=inco2%>">
<input type="hidden" name="payterms" value="<%=Payterms%>">
<input type="hidden" name="generalNotes" value="<%=generalNotes%>">

<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:45%;left:2%">
<Table id="InnerBox1Tab"  align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%@ include file="../../../Includes/JSPs/Sales/iProductCartDetailTd.jsp" %>
</Table>
</Div>

<input type="hidden" name="total" value="<%=cartcount%>">
<div id="buttonDiv"  align="center" style="visibility:visible;position:absolute;top:90%;width:100%">
<%
	if(cartcount !=0)
	{
%>
<Table align=center>
	<Tr>
		<Td class="blankcell" align="center">
		<a href='javascript:formSubmit2("ezGetPricesSh.jsp","NO")' ><img  tabIndex="<%=cartcount+1%>" src="../../Images/Buttons/<%= ButtonDir%>/getprices.gif"  title="<%=getPrice_T%>"   <%=statusbar%> border="none" valign="center"></a>
		<a href='JavaScript:formBack()'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" <%=statusbar%> tabIndex="<%=cartcount+1%>"  title="<%=clkHereHome_L%>"  border="none"></a>
		</Td>
	</Tr>
</Table>

<%	}else
	{
%>
	<Table align=center>
		<Tr>
			<Td class="blankcell" align="center">
				<a href='JavaScript:formBack()'><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" <%=statusbar%> tabIndex="<%=cartcount+1%>"  title="<%=prePage_T%>"  border="none"></a>
			</Td>
		</Tr>
	</Table>

<%

	}

%>
</div>
</form>

</body>
</html>

