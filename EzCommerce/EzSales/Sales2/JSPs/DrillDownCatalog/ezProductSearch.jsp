<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%//@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCart.jsp" %>


<html>
<head>
<title>ezCatalogFinalLevel</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=70
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<%boolean flag = false;%>	

<script language="Javascript">

function Prepare()
{
	document.CatalogFinalLevel.action="../Sales/ezAddSalesSh.jsp"
	document.CatalogFinalLevel.submit();
}

function goBack()
{
	
	parent.document.location.href="../Misc/ezWelcome.jsp";
}
</script>

<Script>
var chkValue	  = "";
var qtyValue	  = "";
var matDes	  = "";
var matUom	  = "";
var count	  = 0;

function matList()
{

	var chkObj 	  = document.CatalogFinalLevel.chkmatno;
	var qtyObj 	  = document.CatalogFinalLevel.matQty;
	var matd 	  = document.CatalogFinalLevel.matDesc;
	var uomObj 	  = document.CatalogFinalLevel.Uom;

	count	  = 0;
	if(chkObj!=null)
	{

	var chkLen	  = chkObj.length;
		
		

		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				if(chkObj[i].checked)
				{
					if(qtyObj[i].value=="")
					{
						alert("Please enter required quantity for product "+document.CatalogFinalLevel.chkmatno[i].value)
						return;	
					}	
					
					if(count == 0)
					{
						chkValue = chkObj[i].value;
						qtyValue = qtyObj[i].value;
						matDes   = matd[i].value;
						matUom   = uomObj[i].value;
						
					}	
					else
					{
						chkValue = chkValue+"$"+chkObj[i].value;
						qtyValue = qtyValue+"$"+qtyObj[i].value;
						matDes   = matDes+"$"+matd[i].value;
						matUom   = matUom+"$"+uomObj[i].value;

					}	
						count++;													
				}

			}
		}
		else
		{
			if(chkObj.checked)
			{					
				
				if(qtyObj.value=="")
				{
					alert("Please enter required quantity for product "+document.CatalogFinalLevel.chkmatno.value)
					return;	
				}
				chkValue = chkValue+chkObj.value;
				qtyValue = qtyValue+qtyObj.value;
				matDes   = matDes+matd.value;
				matUom   = matUom+uomObj.value;

				count++;
			}
		}
		
		if(count==0)
		{
				alert("Please select atleast one product")
		}
		else
		{
			//alert("chkValue  "+chkValue);
			//alert("count  "+count);
			SendQuery(chkValue,"AC");
		}	
		

	}
	else
	{
		alert("Please select atleast one product")
	}

}
		


function checkNum(Object)
{
	
	var num;
	
	try{
		num= parseFloat(Object.value)
	}
	catch(Exception)
	{}
	if(isNaN(num)){
	alert("Please enter valid quantity")
	this.focus();
	}
}
		
var showTotalDiv = false;
var errorid=0;
var globalid;
var sid;

var req;


function Initialize()
{
	try
	{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req = null;
		}
	}
	if(! req&&typeof XMLHttpRequest != "undefined")
	{
		req = new XMLHttpRequest();
	}

}

function SendQuery(key,id)
{


	try
	{
		req = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch(e)
	{
		try
		{
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch(oc)
		{
			req = null;
		}
	}



	globalid = id;

	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req = new XMLHttpRequest();
	}



	var url="";
	//alert("&pValue="+chkValue+"&qValue="+qtyValue+"matdes  "+matDes);
//alert(location.href)
	if(id=='C')
		url=location.protocol+"//<%=request.getServerName()%>:/EZP/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/searchAjax.jsp?MatNo="+key+"&date="+new Date();
	if(id=='AC')
		url=location.protocol+"//<%=request.getServerName()%>/EZP/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCart.jsp?Count="+count+"&pValue="+chkValue+"&qValue="+qtyValue+"&date="+new Date();
	
	//alert(url)



	if(req!=null)
	{
		sid=id;
		req.onreadystatechange = Process;
		req.open("GET", url, true);
		req.send(null);
	}


}

function Process()
{
	if (req.readyState == 4)
	{
		var resText = req.responseText;	 	        	
		var resultText	= resText.split("¥");
		
		if (req.status == 200)
		{
			
			var rcount ;
			
			if(globalid=='C')
			{

				try
				{
					var temp = resultText[0].split("µ");
					rcount = parseInt(temp[1]);
				}catch(Exception){}	

			}


			if(resultText[0]=="")
				HideDiv("SP"+resultText[1]);
			else if(rcount==0)
			{	

				if(globalid=='C')
				{
					document.getElementById("theads").style.visibility="hidden";
					document.getElementById("matspan").style.display="none"
					document.getElementById("nmatspan").style.display="block"
					document.getElementById("ImgDiv").style.visibility="hidden";
					
					
					//document.getElementById("TD0").style.display="none"
					document.getElementById("SP0").style.display="none"
					alert("Sorry no match found")
				}	
			}
			else
			{

				var spid = "SP"+resultText[1];
				if(resultText[1]==0)
				{
					document.getElementById("theads").style.visibility="visible";
					document.getElementById("matspan").style.display="block"
					document.getElementById("nmatspan").style.display="none"
					document.getElementById("ImgDiv").style.visibility="hidden";
					
					showSpan(0)
					document.getElementById("SP0").innerHTML =resultText[0];
					
					scrollInit();

				}	
			}
			
			
			if(sid=='AC')
			{
				document.getElementById("matspan").style.display="none"
				document.getElementById("nmatspan").style.display="none"
				document.getElementById("addspan").style.display="block"
			
				alert("Products have been successfully added to cart")
				
			}	
			
			
		}
		else
		{
			if(req.status == 500)	
				document.getElementById("SP0").innerHTML ="<center><font color=red>There was a problem while retrieving data</font></center>";		
		}
		
		
	}
}

function showSpan(spid)
{



	spObj	=document.getElementById("SP"+spid);	
	//tdObj	=document.getElementById("TD"+spid);	

	if (spObj!=null)
	{
		if(spObj.style.display=="none")
		{
			//alert("IF")
			spObj.style.display="block";
			//tdObj.style.display="block";
		}	
		else if(spObj.style.display=="block")
		{
			spObj.style.display="block";
			//tdObj.style.display="block";
		}	
		
	}


}

function check()
{

		
		var code = document.CatalogFinalLevel.MatCode.value
		if(code.length>0)
		{
			if(document.getElementById("SP0").style.display=="block")
			{
				//alert("IF")
				document.getElementById("SP0").style.display="none";
				//document.getElementById("TD0").style.display="none";
			}
			if(document.getElementById("theads").style.visibility=="visible")
			{
				document.getElementById("theads").style.visibility="hidden"
							
			}
			document.getElementById("ImgDiv").style.visibility="visible";
			SendQuery(code,"C")							

		}	
		else
		{
			alert("Enter a valid code");
			document.CatalogFinalLevel.MatCode.focus()
			return;
		}

}

function verifyQty1(field,val,prd)
{

	var fValue=field.value
	if((val != 0) && (val!="")&&(!isNaN(val)))
	{
		if((fValue%val)!=0)
		{
			alert("quantity of "+ prd +" is  : " + fValue  +"\nSolution :Please enter multiple of "+ val)
			field.value=0;
			field.focus();
		}
	}

}

function selectAll(obj)
{
	var chkObj 	  = document.CatalogFinalLevel.chkmatno;
			
	if(obj.checked==true)
	{
		if(chkObj!=null)
		{
		
			var chkLen  = chkObj.length;
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj[i].checked=true
				}
			}
			else
				chkObj.checked=ture
			
		}	
		
	}
	else
	{
		if(chkObj!=null)
		{

			var chkLen  = chkObj.length;
			if(!isNaN(chkLen))
			{
				for(i=0;i<chkLen;i++)
				{
					chkObj[i].checked=false
				}
			}
			else
				chkObj.checked=false
					
		}	
	}
}


function openWindow(pid)
{
  var win = window.open("ezProductInfo.jsp?ProductNumber="+pid+"&win=C","UserWindow","width=500,height=350,left=10,top=10,resizable=no,scrollbars=no,toolbar=no,menubar=no,minimize=no");
}		
</script>
</head>
<body  onLoad="Initialize();document.CatalogFinalLevel.MatCode.focus();" onresize="scrollInit()" scroll=NO >
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" align="center" class="displayheaderback"  width="100%">Product Search</td>
</tr>
</table>
<form method="post" name="CatalogFinalLevel" action="javaScript:check();">
<input type="hidden" name="alert">

<br>

<input type="hidden" name="urlPage">
<input type='hidden' name='bkpflg'  value='prsearch'>

<Div style="overflow:auto;position:absolute;width:55%;left:23%">
<Table border=1 align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr> 
	<Th>	
		Product No
	</Th>
	<Td>
		<div id="search">
			<div class="in">
				<input type=text class=input-search maxlength="30" size="18" name="MatCode" tabindex=0>
			</div>
		</div>
	</Td>
	<Td>
	<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Find");
			buttonMethod.add("check()");
			out.println(getButtonStr(buttonName,buttonMethod));			
	%>		
	</Td>
	</Tr>
</Table>	
</Div>

<br><br>

	
	<DIV id="theads" style="visibility:hidden;">	
			<Table width="70%" border="1" id="tabHead" align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>   					

				<Th class=innerhead width='5%'><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></Th>
				<Th class=innerhead width='18%'>Product</Th>
				<Th class=innerhead width='44%'>Description</Th>	
				<Th class=innerhead width='5%'>Uom</Th>
				<Th class=innerhead width='18%'>Quantity [Case Lot]</Th>
			</Tr>
			
				
			
			</Table>
			
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:73%;height:50%;left:10%">
				<span id="SP0" style="display:none;"></span>
	</Div>
			
		
	
	
	<DIV id="ImgDiv" style="visibility:hidden;left:40%;width:100%">
		<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/Buttons/<%= ButtonDir%>/loading.gif"/></Td>
			</Tr>
		</Table>			
	</Div>
	<br>	
	
	<div id="buttonDiv" align='center' style='Position:Absolute;width:100%;top:88%;'>
		<Table width="100%" align=center>
			<Tr>
			<Td class="blankcell" width="45%" align="center">
		
				<span id="matspan" style="display:none;">
<%
				int cartRows = Cart.getRowCount();
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Add To Cart");
				buttonMethod.add("matList()");
				
				if(cartRows>0)
				{
					buttonName.add("Prepare Order");
					buttonMethod.add("Prepare()");
				}
				out.println(getButtonStr(buttonName,buttonMethod));

				buttonName.clear();
				buttonMethod.clear();
%>			
				</span>	
				
				
				<span id="addspan" style="display:none;">
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Add To Cart");
				buttonMethod.add("matList()");

				
					buttonName.add("Prepare Order");
					buttonMethod.add("Prepare()");
				
				out.println(getButtonStr(buttonName,buttonMethod));

				buttonName.clear();
				buttonMethod.clear();
%>			
				</span>	
				<span id="nmatspan" style="display:block;">
<%
				buttonName.clear();
				buttonMethod.clear();
				if(cartRows>0)
				{
					buttonName.add("Prepare Order");
					buttonMethod.add("Prepare()");
				}	
				out.println(getButtonStr(buttonName,buttonMethod));
%>
				</span>	
<%
				
%>
				
			</Td>	
			</Tr>	
	</Table>
	<Table align=center>
			<Tr>
				<Td align="center" class="blankcell"><font color="blue">Please press Prepare Order to create order if there are items in the shopping cart</font></Td>
			</Tr>
	</Table>
	</Div>
	
	
	<input type='hidden' name='soldTo'  value='0010006806'></td>


</form>
<Div id="MenuSol"></Div>
</body>
</html>

