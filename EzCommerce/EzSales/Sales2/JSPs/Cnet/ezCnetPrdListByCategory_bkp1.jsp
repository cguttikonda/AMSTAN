<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import="ezc.ezdisplay.*" contentType="text/html" %>
<%@ include file="../../../Includes/JSPs/Cnet/iCnetPrdListByCategory.jsp"%>   
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCartList.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetDiscountCreatedBy.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetConfigDiscount.jsp" %>
 <html> 
 <head>
   <title>Display tag</title>    
   <meta http-equiv="Expires" content="-1" /> 
   <meta http-equiv="Pragma" content="no-cache" />
   <meta http-equiv="Cache-Control" content="no-cache" />
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 
   <style type="text/css" media="all">
          @import url("/CRI/css/maven-base.css");
          @import url("/CRI/css/maven-theme.css"); 
          @import url("/CRI/css/screen.css"); 
          
          .inputbox 
           {
          		font-size: 10px; 
          		border-right:#00385D 1px inset;
          		border-top: white 1px inset;
          		border-left: white 1px inset;
          		border-bottom: #00385D 1px inset;
          		font-family: arial,sans-serif
   	  }       
         .tx {
		font-family: verdana, arial;  
		border:0;
		background-color:transparent;
		font-size: 9px;
		text-align:left; 
		color: #00385D
		
		  
	 }
	.Ntable {  
		font-family: arial,sans-serif;
		font-size: 10px; 
		font-style: normal; 
		color: #00385D
	}
	.Nth {  
		color: #FFFFFF;
		font-family: arial,sans-serif; 
		font-size: 11px;
		text-decoration: none;
		background-color: #116FAF
	}
	.Ntr {  
		font-family: arial,sans-serif;
		font-size: 11px; 
		font-style: normal; 
		line-height: normal; 
		font-weight: normal; 
		color: #00385D
	}
	.Ntd {
		color: #000000;
		font-family: arial,sans-serif;
		font-size: 11px;
		background-color: #DDEEFF
	}
	 

   </style>
   <Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script> 
   <Script src="../../Library/JavaScript/popup.js"></Script>
   <Script>
   
        var req;
        var matId;
        var discPer;
        var discCode;
        var orgPrice;
        var listPrice;
        var product;
	var productDesc;
	var quantity;
	var catalog  ;
	var cartQty  ;
	var globalIndex;
	var isCatUser = "<%=isCatUser%>"
	var favGroup;
	var groupDesc;
	var chkPrds;
	var chkValue = "";
	var stat = "";
	
	
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
	
	function SendQuery(obj)
	{
	
		stat = obj
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
		//alert(req)
	
	
		var url="";
		if(stat=="C")
			url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartCnet.jsp?matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&listPrice="+listPrice.value+"&discPer="+discPer.value+"&discCode="+discCode.value+"&orgPrice="+orgPrice.value+"&mydate="+ new Date();
		else if(stat=="V")
			url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezCnetAddProductsPer.jsp?FavGroup="+favGroup+"&GroupDesc="+groupDesc+"&chkProds="+chkPrds;
		//alert(url)
				
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
			var resText     = req.responseText;	 	        	
						
			if (req.status == 200)
			{
				
				if(stat=="C")
				{
					var resultText	= resText.split("#");
					var cartQty	= resultText[2];
					if(isCatUser!='Y')
						top.menu.document.msnForm.cartHolder.value = resultText[1]; 
					alert("Product has been successfully added to cart")
					eval("document.myForm.cartQty_"+globalIndex).value=cartQty;
				}
				else if(stat=="V")
				{
					alert("New product(s) have been successfully added to My Favourites")
				}
			}
			else
			{
				if(req.status == 500)	 
				alert("Error");
			}
		}
	}
        
   	function addToCart(objNumber) 
   	{
   		 
   		globalIndex = objNumber;
   		matId	    = eval("document.myForm.matId_"+objNumber);
   		discPer	    = eval("document.myForm.discPer_"+objNumber);
   		discCode    = eval("document.myForm.discCode_"+objNumber);
		orgPrice    = eval("document.myForm.orgPrice_"+objNumber);
   		listPrice   = eval("document.myForm.listPrice_"+objNumber);
   		product     = eval("document.myForm.product_"+objNumber);
   		productDesc = eval("document.myForm.productDesc_"+objNumber);
   		quantity    = eval("document.myForm.quantity_"+objNumber);
   		catalog     = eval("document.myForm.catalog_"+objNumber);
   		cartQty     = eval("document.myForm.cartQty_"+objNumber); 
   		
   		var qtyVal  = quantity.value;
   		
   		if(parseFloat(eval(listPrice).value)==0)
   		{
   			alert('Zero value product cannot be added to cart')
   			return
   		}
		/*else if(qtyVal=="")
		{
			alert("Please enter quantity");
			quantity.focus();
		}*/
		else if(isNaN(qtyVal) && qtyVal!="")
		{
			alert("Please enter valid quantity");
			quantity.value="";
			quantity.focus();
		}
		else if(qtyVal!="" && qtyVal<1)
		{
		        alert("Quantity should be greater than or equal to one");
			quantity.focus();
		}
		else if(qtyVal!="" && qtyVal.indexOf('.')!=-1)
		{
			alert("Please enter valid quantity");
			quantity.value="";
			quantity.focus();
		}
		else
		{
			if(qtyVal=="")
				quantity.value = 1;
		
			SendQuery('C');
		}
   	}
   	function checkDesc()
	{
	   
	   var pdesc = document.myForm.ProdDesc1.value;
	   if ( pdesc == '')
	   {
		alert('Please enter data');
		document.myForm.ProdDesc1.focus();
		return ;
	   }
	   else  
	   {
		document.myForm.atrvalstr.value = ""
		document.myForm.mfrID.value = ''
		document.myForm.mfrDesc.value = ''
		
		document.myForm.STYPE.value="BY_CAT_PRDORDESC"
		document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
		document.myForm.submit();
	   }
     }
     
function setPageSize()
{ 
	var pageSizeVal = document.myForm.pageSize.value;
	var maxPgSizeVal = document.myForm.maxPgSize.value;

	if(pageSizeVal>0)
	{
		if(parseInt(pageSizeVal)>parseInt(maxPgSizeVal))
		{
			alert("Page size cannot be greater than "+maxPgSizeVal);
			document.myForm.pageSize.value = "";
			document.myForm.pageSize.focus();
			return false;
		}
		else
		{
			document.myForm.action="ezCnetPrdListByCategoryWait.jsp"; 
			document.myForm.pgSizeCh.value = 'Y' 
			document.myForm.submit();
		}
	}
	else
	{
		alert("Please enter valid page size");
		document.myForm.pageSize.value = "";
		document.myForm.pageSize.focus();
		return false;
	}
}

function openPopup(fileName) 
{
	attach=window.open(fileName,"UserWindow","width=450,height=500,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	
}
function selAttVal(catID,atrID,atrDesc,id)
{
	//alert(cat+"**"+attr+"**"+attrDesc+"**"+id)
	var url = "ezSelectAttVal.jsp?catID="+catID+"&atrID="+atrID+"&atrDesc="+atrDesc+"&id="+id;
	window.open(url,"SelectAttributeValue","width=450,height=500,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
}
function searchPrds()
{
	var cnt = document.myForm.attrCnt.value
	var selCnt = 0
	var atrValStr = "";
	if(!isNaN(cnt))
	{
		for(i=0;i<parseInt(cnt);i++)
		{
			atrValID = eval("document.myForm.atrValID"+i).value 
			atrID = eval("document.myForm.atrID"+i).value
			if(atrValID!="")
			{
			
				if(atrValStr=="")
					atrValStr = atrID+"*"+atrValID;
				else
					atrValStr = "#"+atrID+"*"+atrValID;     
					
				selCnt++
			}
		}
		if(selCnt==0)
		{
			alert('Please select atleast one value') 
			return
		}
		else
		{
			
			document.myForm.atrvalstr.value = atrValStr 
			document.myForm.mfrID.value = ''
			document.myForm.mfrDesc.value = ''
			document.myForm.STYPE.value="BY_CAT_ATRVAL"
			document.myForm.action="ezCnetPrdListByCategoryWait.jsp" 
			Popup.hide('modal')
			document.myForm.submit();
		}
	}
	else
	{
		alert('Search not possible')    
		return
	}

}
function filterProducts(id)
{
	atrValID = eval("document.myForm.atrValID"+id).value 
	atrID = eval("document.myForm.atrID"+id).value
	atrValStr = atrID+"*"+atrValID;
	document.myForm.atrvalstr.value = atrValStr 
	document.myForm.mfrID.value = ''
	document.myForm.mfrDesc.value = ''
	document.myForm.STYPE.value="BY_CAT_ATRVAL"
	document.myForm.action="ezCnetPrdListByCategoryWait.jsp" 
	document.myForm.submit();
}
function filterByModel(catID,atrID,atrDesc,id)
{
	var url = "ezSelectAttVal.jsp?catID="+catID+"&atrID="+atrID+"&atrDesc="+atrDesc+"&id="+id+"&autoSub=Y";
	//window.open(url,"SelectAttributeValue","width=450,height=500,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	var ret = window.showModalDialog(url,"SelectAttributeValue","dialogWidth:450px; dialogHeight:500px; center:yes");
	if(ret!='')
	{
		retArr = ret.split("##")
		eval("document.myForm.atrValID"+id).value = retArr[0]
		eval("document.myForm.atrValDesc"+id).value = retArr[1]
		filterProducts(id)
	}
}
function filterByProductLine(catID,atrID,atrDesc,id)
{
	var url = "ezSelectAttVal.jsp?catID="+catID+"&atrID="+atrID+"&atrDesc="+atrDesc+"&id="+id+"&autoSub=Y";
	var ret = window.showModalDialog(url,"SelectAttributeValue","dialogWidth:450px; dialogHeight:500px; center:yes");
	if(ret!='')
	{
		retArr = ret.split("##")
		eval("document.myForm.atrValID"+id).value = retArr[0]
		eval("document.myForm.atrValDesc"+id).value = retArr[1]
		filterProducts(id)
	}
}

function openDetails(prodID,imagePath)
{
	var argsVariable =  prodID+ "##"+imagePath
	var ret = window.showModalDialog("ezCnetProdDetails.jsp?prodID="+prodID+"&imagePath="+imagePath,argsVariable,"dialogWidth:600px; dialogHeight:500px; center:yes");
}
function goToCatDef()
{
	document.myForm.atrvalstr.value = ""
	document.myForm.mfrID.value = ''
	document.myForm.mfrDesc.value = ''
	document.myForm.STYPE.value="BY_CAT"
	document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
	document.myForm.submit();
}
function addCatalog()
{

	y=chkChkBox();

	if(eval(y))
	{
		favGroup  = "<%=usrFavGrp%>";
		groupDesc = "<%=usrFavDesc%>";
		chkPrds   = document.myForm.chkVal.value;
		SendQuery("V");

		/*
		var argsVariable = "";
		var retVal = window.showModalDialog("../BusinessCatalog/ezSelectPersonalCatalog.jsp",argsVariable,"dialogWidth:500px; dialogHeight:180px; center:yes");
		if(retVal!="")
		{
			var retArr = retVal.split("~~")
			favGroup  = retArr[0];
			groupDesc = retArr[1];
			chkPrds   = document.myForm.chkVal.value;
			SendQuery("V");
		}
		*/
	}
}
function chkChkBox()
{
	var selCount=0;
	var checkObj =document.myForm.chkProds;
	var len = checkObj.length;
	if(isNaN(len))
	{
	    if(document.myForm.chkProds.checked)
	    {
		chkValue = checkObj.value;
		selCount++;
	    }       
	}
	else
	{    
	    for(i=0;i<len;i++)
	    {
		if(document.myForm.chkProds[i].checked)
		{

		   if(selCount==0)
		   {
		      chkValue = checkObj[i].value;
		   }
		   else
		   {
		      chkValue = chkValue+"$$"+checkObj[i].value;
		   }
		   selCount++;
		}
	    }   

	}
	if(selCount<1)
	{
	   alert("Please select atleast one product");
	   return false;
	}
	else
	{
	  document.myForm.chkVal.value=chkValue;
	  return true;
	}
}
function selectAll()
{
	var selAll = document.myForm.selAllChk.checked;
	var y = false;
	
	if(eval(selAll))
		y = true;

	var checkObj =document.myForm.chkProds;
	var len = checkObj.length;

	if(isNaN(len))
	{
		document.myForm.chkProds.checked=y;
	}
	else
	{
		for(i=0;i<len;i++)
		{
			document.myForm.chkProds[i].checked=y;
		}
	}
}
function chkChkBox1()
{
	var selCount=0;
	var checkObj =document.myForm.chkProds;
	var len = checkObj.length;
	if(isNaN(len))
	{
	   alert("Comparision cannot be done with single product");
	   return false;
	}
	else
	{    
	    for(i=0;i<len;i++)
	    {
		if(document.myForm.chkProds[i].checked)
		{
                   var chkArr = (checkObj[i].value).split('~~')

		   if(selCount==0)
		   {
			chkValue = chkArr[0];
		   }
		   else
		   {
		        chkValue = chkValue+"@@"+chkArr[0];
		   }
		   selCount++;
		}
	    }   

	}
	if(selCount<2)
	{
	   alert("Please select atleast two products");
	   return false;
	}
	if(selCount>5)
	{
	   alert("Please select a maximum of 5 products");
	   return false;
	}
	else
	{
	  document.myForm.chkVal.value=chkValue;
	  return true;
	}
}
function compareProds()
{
	y=chkChkBox1();

	if(eval(y))
	{
		var argsVariable = "";
		//var retVal = window.showModalDialog("ezCompareCnetProds.jsp?chkVal="+document.myForm.chkVal.value,argsVariable,"dialogWidth:600px; dialogHeight:600px; center:yes");
		window.open("ezCompareCnetProds.jsp?chkVal="+document.myForm.chkVal.value,"CompareProducts","width=600,height=600,left=200,top=50,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");

	}
}
function globalSearch()
{
	document.myForm.action = "../Cnet/ezCnetSearch.jsp?itemCat=<%=categoryID%>"; 
	document.myForm.submit()
}
function searchInCat()
{
	
	
	if(document.myForm.ProdDesc1.value=='')
	{
		alert('Please enter search value')
		document.myForm.ProdDesc1.focus()
		return
	}
	else
	{
		document.myForm.STYPE.value = 'BY_CAT_PRDORDESC'
		document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
		document.myForm.submit();
	}

}
function selectMfr()
{
	if(document.myForm.selMfr.value=='')
	{
		alert('Please select manufacturer')
		document.myForm.selMfr.focus()
		return
	}
	
	var selMfr = document.myForm.selMfr.options;
	var mfrDesc = selMfr[selMfr.selectedIndex].text;
	document.myForm.mfrID.value = document.myForm.selMfr.value
	document.myForm.mfrDesc.value = mfrDesc
	document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
	document.myForm.submit();
	
}
function removeSearch()
{
	document.myForm.ProdDesc1.value = ''
	document.myForm.STYPE.value = 'BY_CAT'
	document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
	document.myForm.submit();
}
function removeMfr()
{
	document.myForm.mfrID.value = ''
	document.myForm.mfrDesc.value = ''
	document.myForm.action="ezCnetPrdListByCategoryWait.jsp"
	document.myForm.submit();
}
     
   </Script>
 <link rel="stylesheet" href="./css/print.css" type="text/css" media="print" /> 
 </head>
 <body scroll="yes">
 <Form name="myForm" method="post">   
 <input type="hidden" name="categoryID" value="<%=categoryID%>">
 <input type="hidden" name="categoryDesc" value="<%=categoryDesc%>">
 <input type="hidden" name="STYPE" value="<%=STYPE%>">
 <input type="hidden" name="atrvalstr" value="<%=atrValStr%>">
 <input type="hidden" name="mfrID" value="<%=mfrID%>">
 <input type="hidden" name="mfrDesc" value="<%=mfrDesc%>">
 <input type="hidden" name="chkVal" >
 <input type="hidden" name="pgSizeCh" value="">
<%
	String maxPageSize = (String)session.getValue("PAGESIZE");
%>
 <input type="hidden" name="maxPgSize" value="<%=maxPageSize%>">

 <center>
  <div id="modal" style="overflow-y:scroll;position:relative;border:0px solid black; background-color:white; padding:1px; font-size:10;width:60%;height:101%; text-align:center; display:none;">
  	
<%
	attrCnt = 0;
	if(attrCnt>0)
	{
		//DDEEFF
%>
		<input type="hidden" name="attrCnt" value="<%=attrCnt%>">
		<table class="Ntable" id='attrTable' width="95%"  align=center border=0>
		<tr class="Ntr">
		<th class="Nth" width="100%" colspan=2><Strong><font color=white size=2>Advanced Search</font><Strong></th>
		</tr>
<%
		for(int a=0;a<attrCnt;a++)
		{
%>
			<tr class="Ntr">
			<td class="Ntd" width="40%" ><%=retAttr.getFieldValueString(a,"Text")%></td>
			<td class="Ntd" width="50%">
				<a href="#" onClick="selAttVal('<%=categoryID%>','<%=retAttr.getFieldValueString(a,"AtrID")%>','<%=retAttr.getFieldValueString(a,"Text")%>','<%=a%>')">Select</a>&nbsp;&nbsp;<input type="text" name="atrValDesc<%=a%>" class="tx" size=50 readonly value="">    
				<input type="hidden" name="atrValID<%=a%>" value="">
				<input type="hidden" name="atrID<%=a%>" value='<%=retAttr.getFieldValueString(a,"AtrID")%>'>
			</td>
			</tr>
<%
		}
%>
		</table>
		
		<input type="button" value="Search" onClick="searchPrds()">
		<input type="button" value="Close" onClick="Popup.hide('modal')">
		
		
<%	
	}
	else
	{
%>  	
			<input type="hidden" name="atrID0" value="A00601">
			<input type="hidden" name="atrValID0" value="">
			<input type="hidden" name="atrValDesc0" value="">
			<input type="hidden" name="atrID1" value="A00600">
			<input type="hidden" name="atrValID1" value="">
			<input type="hidden" name="atrValDesc1" value="">
			
			<br><br><br><br>
			<table  align=center border=0>
			<tr>
				<td class=displayalert align ="center" colspan ="4">No attributes present</td>
			</tr>
			</table >
			<input type="button" value="Close" onClick="Popup.hide('modal')">

<%  	
  	}
%>  	
  	<!--<input type="button" value="OK" onClick="Popup.hide('modal')">-->
  </div>

  <br>
  
 <%
 	if(rSet!=null){
 		String rowNum      ="";
 		String cartQty     ="0";
		String ProdID      ="";
		String ProdIDDesc  ="";
		String CatID	   ="";
		String MktID	   ="";
		String MktIDDesc   ="";
		String ImgID	   ="";
		String MfID        ="";
		String MfIDText	   ="";
		String MfPN        ="";
		String StatusCode  ="";		
		String imgPath     ="";
		String wid         ="44";
		
		if("Y".equals(isCatUser))
			wid="49";
 		
 		String tableclass = (pageContext.getAttribute("tableclass")).toString();
 		ezc.ezdisplay.ResultSetData rsData=null;
 		Hashtable cartMat= new Hashtable();
 		if(cartRows>0)
 		{
 		   for(int i=0;i<cartRows;i++){ 
 		   	cartMat.put(Cart.getMatId(i),Cart.getOrderQty(i)); 
 		   }
 			
 		}
 		
 %>
 <%@ include file="ezGetCnetImages.jsp" %>  
 <%@ include file="ezGetCnetPrice.jsp" %>  

 	<table border="0" cellpadding="0" cellspacing="0" align=center style="background-color:#EEEEEE;border:0" >
 	<tr height="7px">
 		<td style="vertical-align:bottom" align="center" width="30%" colspan=2 >
 			<b><font color="#116FAF">Category : </font>&nbsp;<a href="#" onClick="goToCatDef()"><font color="red"><%=catDescDisp%></font></a></b>
 		</td>
 		<td style="vertical-align:bottom;text-align:right" width="70%" colspan=2 nowrap>
<%
			if(mfrList!=null && mfrList.size()!=0 && !(mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim())) )
			{
				String mfrKey="",mfrVal="",mfrData="";
%>
				<font color="#116FAF"><b>Manufacturer&nbsp;:&nbsp;</b></font>
				<select name= "selMfr" style="border:1px solid">
					<option value="">--Select--</option>
<%

					for(int m=0;m<mfrList.size();m++)
					{
						mfrData = (String)mfrList.get(m);
						mfrKey  = mfrData.split("�")[1];
						mfrVal  = mfrData.split("�")[0];
%>
					 	<option value="<%=mfrKey%>"><%=mfrVal%></option> 
					 
<%
					}
%>

				</select>
				<img src='../../../../EzCommon/Images/Common/go_button_blk.gif' onClick='selectMfr();' border=0  style="vertical-align:bottom;cursor:hand">
<%
			}
%>
		</td>

	</tr>
 	<tr height="7px">
 			

 		<!--
 		<td style="vertical-align:bottom" align="center" width="15%" >
 			<a href="#" onclick="javascript:globalSearch()"><Strong><font color="red">Global Search</font></Strong></a>
 		</td>
 		<td style="vertical-align:bottom" align="center" width="20%" >
 			<a href="#" onclick="Popup.showModal('modal');return false;"><Strong><font color="red">Advanced Search</font></Strong></a>
 		</td>
 		-->
 		<td style="vertical-align:bottom" align="center" width="30%" colspan=2>
 			<a title="Click here to Compare Products" href="JavaScript:compareProds()"><font color="red"><b>Compare Selected</b></font></a>	
 		</td>
 		<td style="vertical-align:bottom" align="center" width="35%" >
 		&nbsp;
<%
		if(!"Y".equals(isCatUser))
		{
%>
			
			<a title="Click here to Add Products into My Favourites" href="JavaScript:addCatalog()"><font color="red"><b>Add To My Favourites</b></font></a>
			
<%
		}
%> 			
 		</td>
 		<td style="vertical-align:bottom;text-align:right" align="center" width="35%" nowrap>
			<font color="#116FAF"><b style="vertical-align:bottom">Page size&nbsp;:&nbsp;</b></font>
 			<input type=text name='pageSize' class='inputbox' size=2 maxlength=3 align=center style="vertical-align:bottom" value='<%=pageSize%>'>&nbsp;
 			<a href="#" onClick='setPageSize();'><img style="vertical-align:bottom;cursor:hand" src="../../../../EzCommon/Images/Common/go_button_blk.gif"></a>
 		</td>
 		
 	</tr>
<%
	if(!"ALL".equals(categoryID))
	{
%>
	<tr>	
 	
 		<td style="vertical-align:bottom" align="center" width="30%" colspan=2 >
 			<a title="Click here to Filter Products" href="Javascript:filterByModel('<%=categoryID%>','A00601','Model','0')"><font color="red"><b>Filter By Model</b></font></a>	
 		</td>
 		<td style="vertical-align:bottom" align="center" width="35%">&nbsp;
 			<a title="Click here to Filter Products" href="JavaScript:filterByProductLine('<%=categoryID%>','A00600','Product Line','1')"><font color="red"><b>Filter By ProductLine</b></font></a>	
 		</td>
 		<td style="vertical-align:bottom;text-align:right" align="center" width="35%" nowrap>
			<font color="#116FAF"><b style="vertical-align:bottom">Search In Category&nbsp;:&nbsp;</b></font>
 			<input type=text name='ProdDesc1' class='inputbox' size=15 maxlength=15 align=center style="vertical-align:bottom" value='<%=prodDesc1%>'>&nbsp;
 			<a href="#" onClick='searchInCat()'><img style="vertical-align:bottom;cursor:hand" src="../../../../EzCommon/Images/Common/go_button_blk.gif"></a>
 		
 		</td>
 	
 	
 	</tr>
<%
	}
	else
	{
%>
		<input type=hidden name='ProdDesc1' value="<%=prodDesc1%>">
<%
	}
	if((prodDesc1!=null && !"".equals(prodDesc1.trim())) || (mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim()))) 
	{
%>
	<!--<tr height="7px">
		<td style="vertical-align:bottom" align="center" width="100%" colspan=4>-->
<%
			//if(prodDesc1!=null && !"".equals(prodDesc1.trim()))
			//{
%>
 			<!--<Strong><font color="#116FAF">Search String : <font color="black"><%=prodDesc1%></font>&nbsp;<a href="#" onClick="removeSearch()"><img style="valign:bottom" src="../../../../EzCommon/Images/Common/remove.gif" height="10" width="10" border=0  style='cursor:hand'></a></font></Strong>&nbsp;&nbsp;-->
<%
			//}
			//if(mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim()))
			//{
%>
			<!--<Strong><font color="#116FAF">Manufacturer : <font color="black"><%=mfrDesc%></font>&nbsp;<a href="#" onClick="removeMfr()"><img style="valign:bottom" src="../../../../EzCommon/Images/Common/remove.gif" height="10" width="10" border=0  style='cursor:hand'></a></font></Strong>&nbsp;&nbsp;-->

<%
			//} 
%>					
		<!--</td>
	</tr>-->
<%
	}
%>
 	
 	</table> 
 		
 		
 		<display:table name="sessionScope.DISOBJCNET"  id="list" pagesize="<%=pageSize%>"  class="<%=tableclass%>">  defaultsort="1" defaultorder="descending">
<%
 			rsData = (ezc.ezdisplay.ResultSetData)pageContext.getAttribute("list");
 			CatID = (rsData.getColumn3()).toString();

		if(!"Y".equals(isCatUser))
		{
%>
			<display:column title="Compare<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selAllChk' onClick='selectAll()' />" style="width:9%;text-align:center">
			<input type='checkbox' name='chkProds' value='<%=rsData.getColumn1()%>~~<%=CatID%>~~CNET' unchecked>
			</display:column>
<%
		}
%>
 			<display:column title="Item Number/ Description" style="width:<%=wid%>%;height:50;text-align:left" sortable="true" headerClass="sortable">
 	 
<%
 			rowNum = (pageContext.getAttribute("list_rowNum")).toString();
 			ProdID =(rsData.getColumn1()).toString();
                        ProdIDDesc=(rsData.getColumn2()).toString();
                        ProdIDDesc = ProdIDDesc.replaceAll("\"","`");  
                        imgPath = (String)imageHash.get(ProdID);
                        //log4j.log("ProdID>>>>"+ProdID+"   MfrPartNo>>>>>>"+(rsData.getColumn9()).toString(),"I");
 			
 			if(cartMat!=null){
 				cartQty =(String)cartMat.get(CatID+ProdID);
 				if(cartQty == null || "".equals(cartQty)|| "null".equals(cartQty)) 
 					cartQty="0";
 				else
 				{
 					try
 					{
 						//cartQty = Integer.parseInt(cartQty)+"";
 						cartQty = (new java.math.BigDecimal(cartQty.trim())).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 					}
 					catch(Exception e){}
 				}
 			} 
 			
 			String MfrPartNo = (rsData.getColumn9()).toString();
 			
 			String prodCat = (rsData.getColumn3()).toString();
 			String manfId = (rsData.getColumn7()).toString();
 			String agentCode = (String)session.getValue("AgentCode");
 			String listPrice = "0";
 			
 			String listPrFrmHash = (String)cnetPriceHash.get(ProdID);
 			if(listPrFrmHash==null)
 				listPrice = "0";
 			else
 				listPrice = listPrFrmHash;
 			
 			String discPer = "";
 			String discCode = "";
 			//applyDisc_C = false;
 			if(applyDisc_C)
 			{
				try
				{
					String returnValue = getConfigDiscount(Session,manfId,prodCat,agentCode,discCreated_C);

					discPer = returnValue.split("�")[0];
					discCode = returnValue.split("�")[1];       
				}
				catch(Exception e){}
			}
 			String listPriceVal = listPrice;
 			String orgPrice = "";
 			String priceType = "LP";
 			
 			java.math.BigDecimal listPrice_bd = null;
 			java.math.BigDecimal discount_bd = null;
 			
 			try
 			{
 				listPrice_bd = new java.math.BigDecimal(listPrice);
 				listPrice_bd = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
 				orgPrice = listPrice_bd+"";
 				listPriceVal = listPrice_bd+"";
 			}
 			catch(Exception e)
 			{
				listPrice_bd = new java.math.BigDecimal("0");
				listPrice_bd = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP);
 				orgPrice = listPrice_bd+"";
 				listPriceVal = listPrice_bd+"";

 			}
 			
 			if(discPer!=null && !"".equals(discPer) && !(new java.math.BigDecimal("0.00")).equals(listPrice_bd))
 			{
				try
				{
					priceType = "DP";
					discount_bd = new java.math.BigDecimal(discPer);
					discount_bd = (listPrice_bd.multiply(discount_bd)).divide(new java.math.BigDecimal("100"),2,java.math.BigDecimal.ROUND_HALF_UP);
					listPrice_bd = listPrice_bd.subtract(discount_bd);
					listPriceVal = listPrice_bd.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)+"";
				}
				catch(Exception e){}
 			}
%>
			<a href="#" title="Click here to view Product details" onClick="openDetails('<%=ProdID%>','<%=imgPath%>')" ><b><%=ProdID%></b></a><br>
			Mfr Part No - <b><%=MfrPartNo%></b><br><%=ProdIDDesc%><br>$<%=orgPrice%>&nbsp;(List Price)
<%
			if("DP".equals(priceType))
			{
%>
			| $<%=listPriceVal%>&nbsp;(Discount Price)
<%
			}
%>
 			<input type="hidden" name="discPer_<%=rowNum%>" value="<%=discPer%>">
 			<input type="hidden" name="discCode_<%=rowNum%>" value="<%=discCode%>">
			<input type="hidden" name="orgPrice_<%=rowNum%>" value="<%=orgPrice%>">
 			<input type="hidden" name="listPrice_<%=rowNum%>" value="<%=listPriceVal%>">
 			<input type="hidden" name="matId_<%=rowNum%>" value="<%=CatID+""+ProdID%>">
 			<input type="hidden" name="product_<%=rowNum%>" value="<%=ProdID%>">
 			<input type="hidden" name="productDesc_<%=rowNum%>" value="<%=ProdIDDesc%>">
 			<input type="hidden" name="catalog_<%=rowNum%>" value="<%=CatID%>">
 			
 			</display:column>                           
 			<display:column title="Image"  style="width:10%;height:50;text-align:left" >
<%                      
			if(imgPath!=null && !"".equals(imgPath))                 
			{
%>
				<img src="<%=imgPath%>"   height="38" width="50" border=none>
				
<%
			}
			else 
			{
%>                        
				No Image 
<%
			}
%> 			
 			</display:column>
 			<display:column title="Manufacturer"  sortable="true" headerClass="sortable" style="width:16%;height:50;text-align:left">
 			<%=(rsData.getColumn8()).toString()%>  
 			</display:column>          
 			<display:column title="Quantity"    style="width:10%;height:50;text-align:left" >
 			<input type="text" name="quantity_<%=rowNum%>" class=InputBox size="5" value=''/">
 			</display:column>
 			<display:column title="Add to Cart" style="width:15%;height:50;text-align:left;cursor:hand"><image src="/CRI/img/addCart.JPG" title="Click here to Add To Cart" onClick="addToCart('<%=rowNum%>')"/>
 			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<image src="/CRI/img/cart2.jpg" title="Cart Quantity" />&nbsp;:&nbsp;<input type ="text" class="tx" size="5" name="cartQty_<%=rowNum%>" value="<%=cartQty%>" readonly>
 			</display:column>  
 			
 
 			
 		</display:table> 
 
 <%
 	}else{
 %>

 		<%@ include file="../Misc/ezDisplayNoData.jsp"%> 
 <%
 	}
 %>
  </center>
  
  </Form>
 
  </body>
  </html>
 