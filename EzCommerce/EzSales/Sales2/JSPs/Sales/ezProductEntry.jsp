<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iProductEntry.jsp"%>
<Html>
<Head>

<title>Create Sales Order -- Powered by Answerthink</title>
<style>
	.initial 	{ background-color: #CCCCCC;color:#000000 }
	.normal 	{ background-color: #CCCCCC;color:#000000 }
	.highlight 	{ background-color: #8888FF;color:#FFFFFF }
	.dynamicDiv 
	 { 
		width:450px;
		height:60%;
		border:solid 1px #c0c0c0;
		background-color:#F5F5F5;
		font-size:11px;
		font-family:verdana;
		color:#000;
		padding:5px; 
	 }
	
</style>


<script src="../../Library/JavaScript/Misc/ezTrim.js"></script> 

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
var req;
var ezProdEntryDiv=document.createElement("Div"); 
var ezProdEntryPosX="";
var ezProdEntryPosY="";
var currId="";
var myReqType="";
var globalIndex=0;
var globalXY=0;

function selectData(matData)
{
	var myArray=matData.split("$$");
	if(myArray.length>1)
	{
		var myProdCodeObj=document.myForm.product;
		var len=myProdCodeObj.length;
		
		var productCode=eval("document.myForm.product["+globalIndex+"]");
		var productDesc=eval("document.myForm.productDesc["+globalIndex+"]");
		var uom=eval("document.myForm.uom["+globalIndex+"]");	
		var venCatalog=eval("document.myForm.VendCatalog["+globalIndex+"]");	
		var brand = eval("document.myForm.brand["+globalIndex+"]")
		var price = eval("document.myForm.price["+globalIndex+"]")
		
		for(i=0;i<len;i++){
		if(myProdCodeObj[i].value!="" && globalIndex!=i  && (myProdCodeObj[i].value)== myArray[0]){
			alert("Product code already entered");
			myProdCodeObj[globalIndex].value="";
			myProdCodeObj[globalIndex].focus();
			return false
		       }
		       
                }
		
		productCode.value = myArray[0];
		productDesc.value=myArray[1];
		uom.value=myArray[2];
		venCatalog.value=myArray[4];
		brand.value=myArray[5];
		price.value=myArray[6];
		
		
	}
	ezCCDivOut();
	
}

function setBack() 
{
	document.location.replace("../Misc/ezWelcome.jsp");
}
function verifyQty1(field,index)
{

	var fValue=field.value
	if(isNaN(fValue) && fValue!=""){
		alert("Please enter valid quantity");
		field.value=0;
		field.focus();
	}else{
		var prodDescObj=eval("document.myForm.productDesc["+index+"]");
		var caseLotObj=eval("document.myForm.caseLot["+index+"]");

		/*
		if((caseLotObj.value != 0) && (caseLotObj.value !="")&&(!isNaN(caseLotObj.value)))
		{
			if((fValue%caseLotObj.value)!=0)
			{
				alert("Quantity of "+ prodDescObj.value +" is  : " + fValue  +"\nSolution :Please enter multiple of "+ caseLotObj.value)
				field.value=0;
				field.focus();
			}
		}
		*/
	}	

}
function checkEntry()
{
	var prodCodeObj=document.myForm.product;
	var len=prodCodeObj.length;
	var myStatus=false;
	for(i=0;i<len;i++){
		if(prodCodeObj[i].value!=""){
			myStatus=true;
			break;
		}
		
	}
	return myStatus;
}
function prepareCart()
{
	if(checkEntry()){
		document.myForm.action="ezAddProductEntryToCart.jsp";
		document.myForm.submit();
	}else{
		alert("Please enter at least one product code");
	}
}
function addLine()
{

		var tabObj		= document.getElementById("InnerBox1Tab")
		var rowItems 		= tabObj.getElementsByTagName("tr");
		var rowCountValue 	= rowItems.length;
		var addLineDiv		= document.getElementById("addLineDiv"+rowCountValue)
		
		addLineDiv.style.visibility="hidden";
		
		var myCount =rowCountValue+51;
		
		eleWidth = new Array();
		eleAlign = new Array();
	  	eleVal   = new Array();

		eleWidth[0]  = "20%";	eleAlign[0] = "center";
		eleWidth[1]  = "30%";	eleAlign[1] = "left";
		eleWidth[2]  = "15%";	eleAlign[2] = "left";
		eleWidth[3]  = "10%";	eleAlign[3] = "left";
		eleWidth[4]  = "10%";	eleAlign[4] = "center";
		eleWidth[5]  = "15%";	eleAlign[5] = "left";

		var initCount=50;
		for(i=0;i<initCount;i++){
			eleVal[0] ='<input type="text" size="20" class="InputBox" name="product" tabindex='+myCount+'  onBlur="entryOut(this.value,\''+rowCountValue+'\');" onKeyUp="SendQuery(this.value,\'prod'+rowCountValue+'\',\'A\',\''+rowCountValue+'\')" value="" autocomplete="off" id=\'prod'+rowCountValue+'\'>';
			eleVal[1] ='<input type="text" size="30" class="tx" name="productDesc" value="" readonly>';
			eleVal[2] ='<input type="text" size="15" class="tx" name="brand" value="" readonly>';
			eleVal[3] ='<input type="text" size="10" class="tx" name="price" value="" readonly>';
			eleVal[4] ='<input type="text" size="10" class="tx" name="uom" value="" readonly>';
			eleVal[5] ='<input type="text" size="10" class="InputBox" name="qty" style="text-align:right" onBlur="verifyQty1(this,\''+rowCountValue+'\')" value="" tabindex='+(myCount+1)+'>&nbsp;<input type="hidden" size="4" class="tx" name="caseLot" value="" style="text-align:center" readonly> <input type="hidden" name="VendCatalog" value="">';
			if(i==(initCount-1)){
				
				eleVal[5] +='<Div id="addLineDiv'+(rowCountValue+1)+'" style="overflow:auto;position:absolute;visibility:visible"><a href="javascript:addLine()" title="Click here to add more lines"  style="text-decoration:none"><font size="2" color="red" ><b>&nbsp;[+]</font></b></a><Div>';
			}
			
			var rowId = tabObj.insertRow(rowCountValue);
			for(c=0; c<eleVal.length;c++){

				var cell0=rowId.insertCell(c);
				cell0.width = eleWidth[c];
				cell0.align = eleAlign[c];
				cell0.innerHTML =eleVal[c];
			}
			rowCountValue++;
			myCount=myCount+2;
		}

}
function getKey(keyStroke)
{
	keyHit = (isNav) ? keyStroke.which : event.keyCode;
	whichKey = String.fromCharCode(keyHit).toLowerCase();
	checkKey(keyHit);
}
function ezCCDivOut()
{
	ezProdEntryDiv.style.visibility="hidden";
	
}
function ezMakeDivs()
{
	document.body.appendChild(ezProdEntryDiv);
	
	
	ezProdEntryDiv.id 		= "ezProdEntryDiv"; 
	ezProdEntryDiv.style.margin 	= "0px auto"; 
	ezProdEntryDiv.style.visibility	= "hidden"; 
	ezProdEntryDiv.style.overflow	= "auto"; 
	ezProdEntryDiv.style.position	= "absolute"; 
	ezProdEntryDiv.style.top	= "0px"; 
	ezProdEntryDiv.className 	="dynamicDiv";	
	ezProdEntryDiv.setAttribute("align","center"); 

	/*
	with(ezProdEntryDiv)
	{
		id="ezProdEntryDiv"
		style.position="absolute"
		style.top="0px"
		style.visibility="hidden";
		style.background="#F5F5F5";
	}
	*/
	
}

function entryOut(myVal,myIndex)
{
	ezCCDivOut();
	SendQuery(myVal,"prod0",'B',myIndex)
	
}
function findPosX(obj) 
{
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{ 
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	curleft=curleft-160;
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent) 
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;

	curtop=curtop+16;
	return curtop;
}

function Initialize()
{

	try
	{
		req=new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req=new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req=null;
		}
	} 
	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req=new XMLHttpRequest();
	}
}

function SendQuery(key,myId,type,myIndex)
{
	
	globalIndex=myIndex;
	globalXY=event.y;
	
	if(key!="" &&  key!=null && key.length<4)
	{
	    //alert('Please enter at least 4 characters in order to reasonably narrow your selection.');
	    return false;
	}
	
	if(event.keyCode==13 && type=="A"){
		entryOut(key,myIndex)
		
	}else{
	
		if(key!="" &&  key!=null ){
			currId=myId;
			myReqType=type;
			var myProdCodeObj=document.myForm.product;
			var myProdQtyObj=document.myForm.qty;
			var len=myProdCodeObj.length;
			var myChk=true;
			
			if(key!="" && myReqType!="A"){
			
				for(i=0;i<len;i++){
					if(myProdCodeObj[i].value!="" && myIndex!=i  && (myProdCodeObj[i].value).toUpperCase() == key.toUpperCase()){
						myChk=false;
						myProdQtyObj[myIndex].focus();
						if(event.keyCode==0)
						{
							alert("Product code already entered");
							myProdCodeObj[myIndex].value="";
							myProdCodeObj[myIndex].focus();
							return false;
							
						}
						break;
					}
				}
			}	
			
			if(myChk){
			
				if(myReqType=="A")
				key=key+"*";
				try
				{
					req=new ActiveXObject("Msxml2.XMLHTTP");
				}
				catch(e)
				{
					try
					{
						req=new ActiveXObject("Microsoft.XMLHTTP");
					}
					catch(oc)
					{
						req=null;
					}
				}

				if(!req&&typeof XMLHttpRequest!="undefined")
				{
					req=new XMLHttpRequest();
				}


                                
				var url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/Sales/ezWebProductSearchResult.jsp?productNo="+key+"&myReqType="+myReqType+"&date="+new Date();	
				
				if(req!=null)
				{
					req.onreadystatechange = Process;    
					req.open("GET", url, true);
					req.send(null);

				}
			}
		}else{
			var productDesc=eval("document.myForm.productDesc["+myIndex+"]");
			var uom=eval("document.myForm.uom["+myIndex+"]");
			var qty=eval("document.myForm.qty["+myIndex+"]");
			var caseLot=eval("document.myForm.caseLot["+myIndex+"]");
			var venCatalog =eval("document.myForm.VendCatalog["+myIndex+"]");
			var itembrand =eval("document.myForm.brand["+myIndex+"]");		
			var itemListPrice =eval("document.myForm.price["+myIndex+"]");		
			
			productDesc.value=""; 
			uom.value="";
			qty.value="";
			caseLot.value="";
			venCatalog.value="";
			itembrand.value="";
			itemListPrice.value="";
			
		}
	}	

}
 
function Process()
{

	if (req.readyState == 4)
        {
        
		if (req.status == 200)
		{
			
		  	
			if(myReqType=="A"){
			
				ezProdEntryDiv.style.visibility="hidden";
				var myObj=document.getElementById(currId);
				ezProdEntryDiv.style.top=110+"px"
				ezProdEntryDiv.style.left=200+"px";
				ezProdEntryDiv.style.visibility="visible";
				ezProdEntryDiv.innerHTML=req.responseText;
				
				
				
			}else{
				var resText=req.responseText;
				
				if(resText.indexOf("#No")!=-1){
					
					var product=eval("document.myForm.product["+globalIndex+"]");
					product.value="";
					var productDesc=eval("document.myForm.productDesc["+globalIndex+"]");
					productDesc.value="";
					
					var uom=eval("document.myForm.uom["+globalIndex+"]");
					uom.value="";
					
					var qty=eval("document.myForm.qty["+globalIndex+"]");
					qty.value="";
					
					var caseLot=eval("document.myForm.caseLot["+globalIndex+"]");
					caseLot.value="";
					
					var venCatalog =eval("document.myForm.VendCatalog["+globalIndex+"]");	
					venCatalog.value="";
					
					var itembrand =eval("document.myForm.brand["+globalIndex+"]");	
					itembrand.value="";


					var itemListPrice =eval("document.myForm.price["+globalIndex+"]");	
					itemListPrice.value="";
	
					
					alert("Please Enter valid product code");
					product.focus();
				}else{
					var myArray=resText.split("$$");
					var productDesc=eval("document.myForm.productDesc["+globalIndex+"]");
					
					if(myArray.length>1)
					{
						productDesc.value=myArray[1];
						var uom=eval("document.myForm.uom["+globalIndex+"]");
						uom.value=myArray[2];
						var qty=eval("document.myForm.qty["+globalIndex+"]");
						qty.value="";
						var caseLot=eval("document.myForm.caseLot["+globalIndex+"]");
						caseLot.value=myArray[3];
						var venCatalog =eval("document.myForm.VendCatalog["+globalIndex+"]");	
						venCatalog.value=funTrim(myArray[4]);
						var itembrand =eval("document.myForm.brand["+globalIndex+"]");	
						itembrand.value=myArray[5];
						var itemListPrice =eval("document.myForm.price["+globalIndex+"]");	
                                                itemListPrice.value=myArray[6];

						qty.focus();
					}
			 		
					
				}
				
			}
			
			 
		}  
	}
}

myProdCode	= new Array();
myProducts	= new Array();
myProdDesc	= new Array();
myProdUom	= new Array();
myProdUpc	= new Array();
myProdCat	= new Array();
myProdBrand	= new Array();
myProdListPrice	= new Array();

function ShowCatalog()
{
	
	var catalogData = document.myForm.catalogData.value;
	if(catalogData=="0")
	{	
		alert("Please select a catalog")
		return false;
	}
	
	var catalogDataArr = catalogData.split("¥");
	var grpNum 	= catalogDataArr[0];
	var grpDesc 	= catalogDataArr[1];
	
	var len = document.myForm.product.length
	count = 0;
	var selPrdList;

	if(isNaN(len))
	{
		if(document.myForm.product.value!="")
			selPrdList	= document.myForm.product.value;
	}
	else
	{
		for(i=0;i<len;i++)
		{	
			if(document.myForm.product[i].value!="")
			{
			
				if(count==0)
					selPrdList	= eval("document.myForm.product["+i+"]").value;
				else	
					selPrdList	+= "@@@"+eval("document.myForm.product["+i+"]").value; 

				count++;
			}	
		}
	}
	
	
	
	
	str = "ezCatProdSelect.jsp?ProductGroup="+grpNum+"&GroupDesc="+grpDesc+"&retVal="+selPrdList;
	retVal=window.showModalDialog(str,"",'center:yes;dialogWidth:40;dialogHeight:25;status:no;minimize:yes');
	
	if(retVal!=null && retVal.retProd!=null && retVal.retDesc!=null && retVal.retUom!=null && retVal.retUpc!=null && retVal.retCat!=null && retVal.retBrand!=null && retVal.retListPrice!=null)
	{
		
		
		myProdCode	= retVal.retProd.split("¥");	
		myProdDesc	= retVal.retDesc.split("¥");	
		myProdUom	= retVal.retUom.split("¥");	
		myProdUpc	= retVal.retUpc.split("¥");
		myProdCat	= retVal.retCat.split("¥");
		myProdBrand     = retVal.retBrand.split("¥");
		myProdListPrice = retVal.retListPrice.split("¥");
		
		
		
		var product           = document.myForm.product
		var productDesc       = document.myForm.productDesc
		var productUom        = document.myForm.uom
		var productCaseLot    = document.myForm.caseLot
		var productCatalog    = document.myForm.VendCatalog
		var productBrand      = document.myForm.brand
		var productListPrice  = document.myForm.price
		
		
		var j = 0;
		for(i=0;i<product.length;i++)
		{
			if(product[i].value=="")
			{		
				j=i;
				break;
			}

		}
		
		for(i=0;i<myProdCode.length;i++)
		{
			if(isNaN(myProdCode[i]))
				tprCode = myProdCode[i]
			else	
				tprCode = parseFloat(myProdCode[i])
			
			product[j].value        = tprCode
			productDesc[j].value    = myProdDesc[i]
			productUom[j].value     = myProdUom[i]
			productCaseLot[j].value = funTrim(myProdUpc[i])
			productCatalog[j].value = funTrim(myProdCat[i])
			productBrand[j].value      = myProdBrand[i]
			productListPrice[j].value  = myProdListPrice[i]
			
			j++;
			
			if(j>=product.length)	
				addLine();
		}	
	 }		
		

		
}
</Script>
<Script>
	  var tabHeadWidth=95
	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<Body  onLoad='ezMakeDivs();scrollInit();'  onresize="scrollInit();" scroll=no>
<Form name="myForm" method="post">
<input type="hidden" name="productNo">
<input type="hidden" name="myReqType">
<input type="hidden" name=ProductGroup value="<%=pGroupNumber%>">
<input type="hidden" name="bkpflg" value="QuickOrdEntBk">


<%
	String display_header = "Manual Sales Order Entry"; 	
	int Rows = ret.getRowCount();
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>


<Table width=50% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<Tr>
	<Th width =50% class="labelcell" align="center" colspan=3>Personalized Catalog</th>
		<Td width =50% nowrap colspan=3 align="center">
		<Div id="ListBoxDiv1">
		<select  name ="catalogData" style="width:100%" id=CalendarDiv>
		<option value="0" selected>-Select Catalog-</option>
<%		
			String GroupNum="", GroupDescription="";
			for (int i = 0;i<Rows;i++)
			{
				GroupNum 	 = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
				GroupDescription = (String)ret.getFieldValue(i,PROD_GROUP_WEB_DESC);
				String GrpVal = GroupNum+"¥"+GroupDescription;
				if(GroupNum.equalsIgnoreCase(pGroupNumber))
				{
%>						<option value="<%=GrpVal%>" selected><%=GroupDescription%></option>
<%				}
				else
				{
%>					<option value="<%=GrpVal%>"><%=GroupDescription%></option>
<%				}
			}
%>		</select>
		</Div>
		</td>
		<td>
<%			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Adopt");
			buttonMethod.add("ShowCatalog()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>		</td>
</Tr>
</Table>

<Div id="theads">
	<Table  width="95%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Th width="20%">Product</Th>
		<Th width="30%">Description</Th>
		<Th width="15%">Brand</Th>
		<Th width="10%">List Price($)</Th>
		<Th width="10%">UOM</Th> 
		<Th width="15%">Quantity</Th>
	</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	int initCount=150;
	int count=1;
	int cartCount=0;
	java.util.Hashtable mySelProds=null;
	
	
	if("Cart".equals(From) && Cart!=null && Cart.getRowCount()>0){
		cartCount=Cart.getRowCount();
		int tempCount=0;
		tempCount=cartCount/initCount;
		tempCount=tempCount*50;
		if(cartCount%50>0)tempCount=tempCount+150;
		initCount=tempCount;
		mySelProds=(java.util.Hashtable)session.getValue("MYSELPRODS");
	}
	
	
	for(int i=0;i<initCount;i++)
	{
	
	String myMatCode="";
	String myMatDesc="";
	String myMatUOM="";
	String myMatQty="";
	String myCaseLot="";
	String tempMatCode="";
	String myVendCatalog="";
	String myItemBrand="";
	String myItemListPrice="";
	
	
	
	if(cartCount>0&& i<cartCount ){
	
		     myMatCode      = Cart.getMaterialNumber(i);
		     myMatDesc      = Cart.getMaterialDesc(i);
		     myMatUOM       = Cart.getUOM(i);
		     myMatQty       = Cart.getOrderQty(i);
		     myVendCatalog  = Cart.getVendorCatalog(i);
		     myCaseLot      = (String)mySelProds.get(myMatCode.toLowerCase());
		     myItemBrand    = Cart.getBrand(i);
		     myItemListPrice= Cart.getUnitPrice(i);
		     
		     try
		     {
		     	tempMatCode = Integer.parseInt(myMatCode)+"";
		     }
		     catch(Exception e)
		     {
		     	tempMatCode = myMatCode;
		     }
	}
	else
	{
		
	}
%>
	<Tr>
		<Td width="20%" align="center" >
		<input type="text" size="18" class="InputBox" name="product" value="<%=tempMatCode%>" tabindex=<%=count%>  onKeyUp="SendQuery(this.value,'prod<%=i%>','A','<%=i%>')"  autocomplete="off" id='prod<%=i%>'>
		<input type="hidden" name="VendCatalog" value="<%=myVendCatalog%>">
		</Td>
		<Td width="30%"><input type="text" size="35" class="tx" name="productDesc" value="<%=myMatDesc%>"  readonly></Td>
		<Td width="15%"><input type="text" size="15" class="tx" name="brand" value="<%=myItemBrand%>"  readonly></Td>
		<Td width="10%"><input type="text" size="10" class="tx" name="price" value="<%=myItemListPrice%>"  readonly></Td>
		<Td width="10%" align="center"><input type="text" size="6" class="tx" name="uom" value="<%=myMatUOM%>" readonly></Td>
		<Td width="15%" align="left">
		<input type="text" size="10" class="InputBox" name="qty" style="text-align:right" value="<%=myMatQty%>" tabindex=<%=count+1%> onBlur="verifyQty1(this,'<%=i%>')">
		<input type="hidden" name="caseLot" value="<%=myCaseLot%>">
		<%if(i==(initCount-1)){	%>
			<Div id="addLineDiv<%=initCount%>" style="overflow:auto;position:absolute;visibility:visible">
			<a href="javascript:addLine()" title="Click here to add more lines" style="text-decoration:none"><font size="2" color="red"><b>[+]</b></font></a>
			<Div>
		<%}%>
		</Td>
	</Tr>
<%
	count=count+2;
	}
%>    
	
</Table>		
</Div>
<div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:85%">
<center>	
<%	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Prepare Order");
	buttonMethod.add("prepareCart()");
	
	//buttonName.add("Back");
	//buttonMethod.add("setBack()");
	
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body> 
</Html> 