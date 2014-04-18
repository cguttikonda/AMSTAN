
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iGetShoppingCart.jsp"%>
<Html>
<Head>
<title>Create Sales Order -- Powered by EzCommerce Inc</title>
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

		if((caseLotObj.value != 0) && (caseLotObj.value !="")&&(!isNaN(caseLotObj.value)))
		{
			if((fValue%caseLotObj.value)!=0)
			{
				alert("Quantity of "+ prodDescObj.value +" is  : " + fValue  +"\nSolution :Please enter multiple of "+ caseLotObj.value)
				field.value=0;
				field.focus();
			}
		}
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
		eleWidth[1]  = "50%";	eleAlign[1] = "left";
		eleWidth[2]  = "10%";	eleAlign[2] = "center";
		eleWidth[3]  = "20%";	eleAlign[3] = "left";
		var initCount=50;
		for(i=0;i<initCount;i++){
			eleVal[0] ='<input type="text" size="18" class="InputBox" name="product" tabindex='+myCount+'  onBlur="entryOut(this.value,\''+rowCountValue+'\');" onKeyUp="SendQuery(this.value,\'prod'+rowCountValue+'\',\'A\',\''+rowCountValue+'\')" value="" autocomplete="off" id=\'prod'+rowCountValue+'\'>';
			eleVal[1] ='<input type="text" size="75" class="tx" name="productDesc" value="" readonly>';
			eleVal[2] ='<input type="text" size="6" class="tx" name="uom" value="" readonly>';
			eleVal[3] ='<input type="text" size="10" class="InputBox" name="qty" style="text-align:right" onBlur="verifyQty1(this,\''+rowCountValue+'\')" value="" tabindex='+(myCount+1)+'>&nbsp;[<input type="text" size="4" class="tx" name="caseLot" value="" style="text-align:center" readonly>]';
			if(i==(initCount-1)){
				
				eleVal[3] +='<Div id="addLineDiv'+(rowCountValue+1)+'" style="overflow:auto;position:absolute;visibility:visible"><a href="javascript:addLine()" title="Click here to add more lines"  style="text-decoration:none"><font size="2" color="red" ><b>&nbsp;[+]</font></b></a><Div>';
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
	with(ezProdEntryDiv)
	{
		id="ezProdEntryDiv"
		style.position="absolute"
		style.top="0px"
		style.visibility="hidden";
		style.background="#F5F5F5";
	}
	
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



				var url=location.protocol+"//<%=request.getServerName()%>/KissUSA/EzCommerce/EzSales/Sales2/JSPs/Sales/ezProductSearchResult.jsp?productNo="+key+"&myReqType="+myReqType+"&date="+new Date();	
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
					
			productDesc.value="";
			uom.value="";
			qty.value="";
			caseLot.value="";
			
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
				ezProdEntryDiv.style.top=60+"px"
				ezProdEntryDiv.style.left=270+"px";
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
						qty.focus();
					}
			 		
					
				}
				
			}
			
			 
		}  
	}
}


	
</Script>

<Script>
	  var tabHeadWidth=80
	  var tabHeight="60%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
</head>
<Body  onLoad='ezMakeDivs();scrollInit();'  onresize="scrollInit();" scroll=no>
<Form name="myForm" method="post">
<input type="hidden" name="productNo">
<input type="hidden" name="myReqType">

<%
	String display_header = "Manual Sales Order Entry";
	String From=request.getParameter("From");
	
	
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Div id="theads">
	<Table  width="80%"  id="tabHead" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Th width="20%">Product</Th>
		<Th width="50%">Description</Th>
		<Th width="10%">UOM</Th> 
		<Th width="20%">Quantity [master case]</Th>
	</Table>
</Div>
<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:98%;height:60%;left:2%">
<Table id="InnerBox1Tab" align=center  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">
<%
	int initCount=50;
	int count=1;
	int cartCount=0;
	java.util.Hashtable mySelProds=null;
	if("Cart".equals(From) && Cart!=null && Cart.getRowCount()>0){
		cartCount=Cart.getRowCount();
		int tempCount=0;
		tempCount=cartCount/initCount;
		tempCount=tempCount*50;
		if(cartCount%50>0)tempCount=tempCount+50;
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
	
	
	if(cartCount>0&& i<cartCount ){
	
		     myMatCode=Cart.getMaterialNumber(i);
		     myMatDesc=Cart.getMaterialDesc(i);
		     myMatUOM=Cart.getUOM(i);
		     myMatQty=Cart.getOrderQty(i);
		     myCaseLot=	(String)mySelProds.get(myMatCode.toLowerCase());
		     
		     try
		     {
		     	tempMatCode = Integer.parseInt(myMatCode)+"";
		     }
		     catch(Exception e)
		     {
		     	tempMatCode = myMatCode;
		     }
	}
%>
	<Tr>
		<Td width="20%" align="center" >
		<input type="text" size="18" class="InputBox" name="product" value="<%=tempMatCode%>" tabindex=<%=count%>  onBlur="entryOut(this.value,'<%=i%>');" onKeyUp="SendQuery(this.value,'prod<%=i%>','A','<%=i%>')"  autocomplete="off" id='prod<%=i%>'>
		</Td>
		<Td width="50%"><input type="text" size="75" class="tx" name="productDesc" value="<%=myMatDesc%>"  readonly></Td>
		<Td width="10%" align="center"><input type="text" size="6" class="tx" name="uom" value="<%=myMatUOM%>" readonly></Td>
		<Td width="20%" align="left">
		<input type="text" size="10" class="InputBox" name="qty" style="text-align:right" value="<%=myMatQty%>" tabindex=<%=count+1%> onBlur="verifyQty1(this,'<%=i%>')">
		[<input type="text" size="4" class="tx" name="caseLot" value="<%=myCaseLot%>" style="text-align:center" readonly>]
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
<div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:75%">
<center>	
<%	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();
	
	buttonName.add("Prepare Order");
	buttonMethod.add("prepareCart()");
	buttonName.add("Back");
	buttonMethod.add("setBack()");
	out.println(getButtonStr(buttonName,buttonMethod));
%>
</Div>
</Form>
<Div id="MenuSol"></Div>
</Body> 
</Html> 