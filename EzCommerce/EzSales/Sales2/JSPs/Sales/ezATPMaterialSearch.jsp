<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<html>
<head>
<title>ezCatalogFinalLevel</title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	var tabHeadWidth=70
	var tabHeight="50%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
<script language="Javascript">

var showTotalDiv = false;
var errorid=0;
var globalid;
var sid;
var svalue; 

var chkValue	  = "";
var qtyValue	  = "";
var descValue	  = "";
var count	  = 0;


function matDetails(code,desc)
{
	window.open("../MaterialSearch/ezURLs.jsp?objectKey="+code+"&objectDesc="+desc,"multi","resizable=no,left=50,top=50,height=400,width=800,status=no,toolbar=no,menubar=no,location=no")
}
function viewCart()
{

	 
	document.body.style.cursor="wait"
	document.myForm.action="../ShoppingCart/ezViewCart.jsp?back=2"
	document.myForm.submit();

}

function addToCart()
{

	var chkObj 	  = document.myForm.chk;
	var matDescObj= document.myForm.matDesc;
	count	  = 0;
	sid="AC"
	if(chkObj!=null)
	{

		var chkLen	  = chkObj.length;
		if(!isNaN(chkLen))
		{
			for(i=0;i<chkLen;i++)
			{
				if(chkObj[i].checked)
				{
					
					
					if(count == 0)
					{
						chkValue = chkObj[i].value;
						qtyValue="0";
						descValue=matDescObj[i].value;
					}	
					else
					{
						chkValue = chkValue+"$"+chkObj[i].value;
						qtyValue=qtyValue+"$"+"0";
						descValue=descValue+"$"+matDescObj[i].value;
						
					}
					
						count++;													
				}

			}
		}
		else
		{
			if(chkObj.checked)
			{					
				chkValue = chkValue+chkObj.value;
				qtyValue = "0";
				descValue=matDescObj.value;
				count++;
			}
		}
		
		if(count==0)
		{
				alert("Please select atleast one product")
		}
		else
		{
			
			SendQuery(chkValue,"AC");
		}	
		

	}
	else
	{
		alert("Please select atleast one product")
	}

}

function getATP(index)
{
	
	var myObject=document.myForm.matNo;
	var len=myObject.length;
	var matNo="";
	var matDesc="";
	var uom="";
	var requiredQty="";
	var requiredDate="";
	 
	 
	if(isNaN(len)){
		
		 matNo=document.myForm.matNo.value;
		 matDesc=document.myForm.matDesc.value
		 uom=document.myForm.uom.value
		 requiredDate=eval("document.myForm.reqDate"+index).value
		 requiredQty=document.myForm.quantity.value	
		 if(uom=="")
		 {
			alert("Please enter Uom for "+matNo);
			document.myForm.uom.focus();
			return;
		 }
		 
	}else{
		 matNo=eval("document.myForm.matNo["+index+"]").value;
		 matDesc=eval("document.myForm.matDesc["+index+"]").value
		 uom=eval("document.myForm.uom["+index+"]").value
		 requiredDate=eval("document.myForm.reqDate"+index).value
		 requiredQty=eval("document.myForm.quantity["+index+"]").value	
		 if(uom=="")
		 {
			alert("Please enter Uom for "+matNo);
			document.myForm.uom[index].focus();
			return;
		 }
	}
		
	if(requiredQty=="")
	{
		alert("Please enter the required quantity for "+matNo)
		return;		
	}		
	
	if(requiredDate=="")
		alert("Please enter the required date for "+matNo)
	else	
		var retValue = window.showModalDialog("ezGetATPResult.jsp?matNo="+matNo+"&uom="+uom+"&requiredQty="+requiredQty+"&requiredDate="+requiredDate+"&matDesc="+matDesc,window.self,"center=yes;dialogHeight=28;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
	
	
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
function check()
{

		
		var Mno   = document.myForm.searchBy[0]
		var Mdesc = document.myForm.searchBy[1]
		var MPNo = document.myForm.searchBy[2]
		var sKey  = document.myForm.searchKey
		 //alert("---"+sKey.value+"---")		
		if(Mno.checked)
		{
			
			sid="M"
		}
		else if(Mdesc.checked) 
		{
			sid="D"
		}else if(MPNo.checked) 
		{
			sid="P"
		}
		
		if(sKey.value!="")
		{
			svalue = sKey.value;
			if(sid=="P" && svalue.indexOf('*')!=-1 ){
				alert("Wild card search is not allowed for Manufacturer Part Number");
				sKey.focus();
				return;
			}
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
			SendQuery(svalue,sid)						
		}	
		else
			alert("please enter a valid format");		
}


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

	if(!req&&typeof XMLHttpRequest!="undefined")
	{
		req = new XMLHttpRequest();
	}
	//alert("req----->"+req)
	globalid = id;
	//alert("idid"+id)

	var url="";
	if("AC"==globalid){
		url=location.protocol+"//<%=request.getServerName()%>/EZP/EzCommerce/EzSales/Sales2/JSPs/DDShoppingCart/ezAjaxAddCart.jsp?Count="+count+"&pValue="+chkValue+"&pdValue="+descValue+"&qValue="+qtyValue+"&From=PS&date="+new Date();
	}else{
		url=location.protocol+"//<%=request.getServerName()%>/EZP/EzCommerce/EzSales/Sales2/JSPs/Sales/ezATPMaterialSearchResult.jsp?searchBy="+id+"&searchKey="+key+"&date="+new Date();
	}
	
	//alert("urlurl------->"+url)
	if(req!=null)
	{
		
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
			if(sid=='AC'){
				alert("Products have been successfully added to cart");
				return;
			}else{
						
				try
				{
					var temp = resultText[0].split("µ");
					rcount = parseInt(temp[1]);
				}catch(Exception){}	

				
				if(rcount==0)
				{	


						document.getElementById("theads").style.visibility="hidden";
						document.getElementById("matspan").style.display="none"
						document.getElementById("nmatspan").style.display="block"
						document.getElementById("ImgDiv").style.visibility="hidden";
						document.getElementById("SP0").style.display="none"
						alert("Sorry no match found")

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


</script>
</head>
  
<body onLoad="Initialize();document.myForm.searchKey.focus();" onresize="scrollInit()"  scroll=NO >
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" align="center" width="40%">Product Search&nbsp;</td>
</tr>
</table>
<form method="post" name="myForm" action="javaScript:check();">
	<Table width="50%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'F3F3F3'" valign=middle>
				<Table border="0" align="center" valign=middle width="100%" cellpadding=0 cellspacing=0 class=welcomecell>
				<Tr>
					<td rowspan=2  style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='30%' align=center valign=center>  Search By</td>
					<td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;' width='30%' align=left valign=center>
						<input type="radio"  name="searchBy" onClick="document.myForm.searchKey.value=''" value="M" checked>Product No<br>
						<input type="radio"  name="searchBy" onClick="document.myForm.searchKey.value=''" value="D">Product Description<br>
						<input type="radio"  name="searchBy" onClick="document.myForm.searchKey.value=''" value="P">Manufacturer Part Nr<br>
	
					</td>
					<Td style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;align:center' width='30%' align=center>
						<input type="text" id="searchpatt" name="searchKey" class="InputBox" size=15 maxlength=40 >
				 
					</Td>
					<Td rowspan=2  style='background:#F3F3F3;font-size=11px;color:#00355D;font-weight:bold;align:center' width='10%' align=center>
						<Img src="../../../../EzCommon/Images/Body/left_arrow.gif" onClick="check()" style="cursor:hand" border="none" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
					</Td>
				</Tr>
				
				</Table>
			</Td>
			<Td width="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif" ></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
	</Table>
	<br>
	<DIV id="theads" style="visibility:hidden;">
		<Table width="70%" border="1" id="tabHead" align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>   					

			<Th class=innerhead width='5%'>&nbsp;</Th>
			<Th class=innerhead width='20%'>Product</Th>
			<Th class=innerhead width='45%'>Description</Th>	
			<Th class=innerhead width='10%'>UOM</Th>	
			<!--
				<Th class=innerhead width='20%'>Required Date</Th>
				<Th class=innerhead width='15%'>Required Qty</Th>
			-->
			<Th class=innerhead width='20%'>ATP</Th>
			
 
		</Tr>
		</Table>
	</Div>
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:73%;height:50%;left:14%">
		
		
			<td id="TD0"><span id="SP0" style="display:none;"></span></td>
		
	</Div>
	
	<DIV id="ImgDiv" style="visibility:hidden;left:40%;width:100%">
			<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
				<Tr>
					<Td align='center' style="background:transparent" ><br><b>Loading data, please wait...</b><br><br><img src="../../Images/Buttons/<%= ButtonDir%>/loading.gif"/></Td>
				</Tr>
			</Table>			
	</Div>
	
	<div id="buttonDiv"  align="center" style="visibility:visible;position:absolute;top:90%;width:100%">
	<Table width="100%" align=center>
			<Tr>
			<Td class="blankcell" width="45%" align="center">

				<span id="matspan" style="display:none;">
					
<%
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					buttonName.add("Back");
					buttonMethod.add("history.go(-1)");
					buttonName.add("Add To Cart");
					buttonMethod.add("addToCart()");
					buttonName.add("View Cart");
					buttonMethod.add("viewCart()");
				
					out.println(getButtonStr(buttonName,buttonMethod));
%>	
				</span>				
				<span id="nmatspan" style="display:block;">
<%
					buttonName = new java.util.ArrayList();
					buttonMethod = new java.util.ArrayList();
					buttonName.add("Back");
					buttonMethod.add("history.go(-1)");
					buttonName.add("View Cart");
					buttonMethod.add("viewCart()");
					out.println(getButtonStr(buttonName,buttonMethod));
%>	
				</span>	
			</Td>	
			</Tr>	
	</Table>
		
	</div>
</form>
<Div id="MenuSol"></Div>
</body>
</html>