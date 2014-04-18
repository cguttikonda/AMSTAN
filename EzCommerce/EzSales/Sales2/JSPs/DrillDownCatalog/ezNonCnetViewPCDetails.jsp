<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezcnetconnector.params.*" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="ezc.ezdisplay.*" contentType="text/html" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCartList.jsp" %>
<%@ include file="../../../Includes/Lib/ezCatalogBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:useBean id="CnetManager" class="ezc.ezcnetconnector.client.EzCnetConnectorManager" />                

<%@ include file="../../../Includes/JSPs/DrillDownCatalog/iNonCnetViewPCDetails.jsp"%>  
<%@ include file="../../../Includes/JSPs/Discounts/igetNonCnetDisCreatedBy.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetNonCnetConfigDiscount.jsp" %>   

 <html>
 <head>
 <%@ include file="../../../Includes/Lib/ezSpChar.jsp"%>   
   <title>Display tag</title>    
   <meta http-equiv="Expires" content="-1" /> 
   <meta http-equiv="Pragma" content="no-cache" />
   <meta http-equiv="Cache-Control" content="no-cache" />
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" />    
   <style type="text/css" media="all">
          @import url("/AST/css/maven-base.css");
          @import url("/AST/css/maven-theme.css"); 
          @import url("/AST/css/screen.css");  
          
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

   </style>
   <Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
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
	
	
	
		var url="";
		var strVal="";
		if(stat=="VC")
		{
			url=location.protocol+"//<%=request.getServerName()%>/AST/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartNew.jsp";
			strVal="matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&mydate="+ new Date();
		}
		else if(stat=="CNET")
		{
			url=location.protocol+"//<%=request.getServerName()%>/AST/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartNonCnet.jsp";
			//strVal="matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&listPrice="+listPrice.value+"&discPer="+discPer.value+"&discCode="+discCode.value+"&orgPrice="+orgPrice.value+"&mydate="+ new Date();
			strVal="matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&discPer="+discPer.value+"&discCode="+discCode.value+"&mydate="+ new Date();
		}
		//document.write(url)
		
				
		/*if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}*/
	
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("POST", url, true);
			req.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			req.send(strVal);
		}
	}
	
	function Process() 
	{
		if (req.readyState == 4)
		{
			var resText     = req.responseText;	 	        	
						
			if (req.status == 200)
			{
				
				if(stat=="VC" || stat=="CNET")
				{
					var resultText	= resText.split("#");
					var cartQty	= resultText[2];

					top.menu.document.msnForm.cartHolder.value = resultText[1]; 
					alert("Product has been successfully added to cart")
					eval("document.myForm.cartQty_"+globalIndex).value=cartQty;
				}
			}
			else
			{
				if(req.status == 500)	 
				alert("Error");
			}
		}
	}
        
   	function addToCart(objNumber,type) 
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
		
			SendQuery(type);
		}
   		
   	}
     
function setPageSize()  
{ 
         
	 var pageSizeVal = document.myForm.pageSize.value;
	 var catalogStr = "<%=catalogStr%>";
	  if(pageSizeVal>0)
	  {
	  	document.location.href="ezViewPCDetails.jsp?pageSize="+pageSizeVal+"&catalogStr="+catalogStr+"&pgSizeCh=Y";
	  	document.myForm.submit();
	  } 
	  else
	  {
	      alert("Please enter valid page size"); 
	      document.myForm.pageSize.value = "";
	      document.myForm.pageSize.focus();
	      return false;
	  }
}
function popUp(prdCode,vendCatalog,matId)
{
	 prdCode = prdCode.replace('#','@@@'); 
	 
	 var qryString = "ezProdDetails.jsp?matId="+matId+"&prdCode="+prdCode+"&vendCatalog="+vendCatalog;  
	 retVal= window.open(qryString,"Product","resizable=no,left=280,top=120,height=400,width=600,status=no,toolbar=no,menubar=no,location=no")
}
function uploadDocs(prdCode,vendCatalog,matId)
{
	 prdCode = prdCode.replace('#','@@@');  
	 var qryString = "ezMaterialSpecs.jsp?prdCode="+prdCode+"&vendCatalog="+vendCatalog+"&matId="+matId;   
	 retVal= window.open(qryString,"Product","resizable=no,left=280,top=120,height=400,width=600,status=no,toolbar=no,menubar=no,location=no")
}
function openPopup(fileName) 
{
	attach=window.open(fileName,"UserWindow","width=450,height=500,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	
}
function openDetails(prodID,imagePath)
{
	var argsVariable =  prodID+ "##"+imagePath
	var ret = window.showModalDialog("../NonCnet/ezNonCnetProdDetails.jsp?prodID="+prodID+"&imagePath="+imagePath,argsVariable,"dialogWidth:600px; dialogHeight:500px; center:yes");
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
function delProducts()
{

	y=chkChkBox();

	if(eval(y))
	{
		document.myForm.action="../BusinessCatalog/ezCnetDelFavProducts.jsp"
		document.myForm.submit()
	
	
	}
}
function deleteFav(val)
{
	document.myForm.chkVal.value=val
	document.myForm.action="../BusinessCatalog/ezCnetDelFavProducts.jsp"
	document.myForm.submit()

}
   </Script>
   
 <link rel="stylesheet" href="./css/print.css" type="text/css" media="print" /> 
 </head>
 <body scroll="yes">
 <Form name="myForm" method="post">
 <input type="hidden" name="catalogStr" value="<%=catalogStr%>">
 <center>
 <br>
 
<%
	if(rSet!=null){
		String prodT       ="";
		String imgPath     ="";
		String rowNum      ="";
		String prdCode     ="";
		String atpMatKey   =""; 
		String cartQty     ="0";
		String atpStatus   ="";
		String atpQty      ="";
		String atpLeadTime ="";
		String atpDispStr  ="";
		String atpLinkStatus ="";
		String matIdTemp     ="";
		String prodDescT     ="";
		String type          ="";
		String tableclass = (pageContext.getAttribute("tableclass")).toString();       
		ezc.ezdisplay.ResultSetData rsData=null;
		int widthTab = 45;
		
		
		Hashtable cartMat= new Hashtable();
		
		
		
		if(cartRows>0)
		{
		   for(int i=0;i<cartRows;i++){ 
		   	cartMat.put(Cart.getMatId(i),Cart.getOrderQty(i)); 
		   }
			
		}
		if("Y".equals(isCatUser))
			widthTab = 40;
%>
<%@ include file="../NonCnet/ezGetNonCnetImages.jsp" %>
<%@ include file="../NonCnet/ezGetNonCnetPrice.jsp" %>   
	<input type="hidden" name="favGroup" value="<%=favGroup%>">
	<input type="hidden" name="favGrpDesc" value="<%=favGrpDesc%>">
	<input type="hidden" name="chkVal" value="">
	<table border="0" cellpadding="0" cellspacing="0" align=center style="border:0" class='blankcell'>
 	<tr class='blankcell'>
 		<td valign='center' align="left" width="100%" height="1%" class='blankcell'>
<%
		if(!"Y".equals(isCatUser))
		{
%>
 		<!--<b><a href="javascript:delProducts()"><font color=red>Delete</font></a>&nbsp;&nbsp;/&nbsp;&nbsp;</b>-->
<%
		}
%>
		<font color="#6699CC"><b>Page size&nbsp;:&nbsp;</b></font>
		<input type=text name='pageSize' class='inputbox' size=5 align=center value='<%=pageSize%>'>
		<img src='../../../../EzCommon/Images/Common/go_button_blk.gif' onClick='setPageSize();' border=0  style="vertical-align:bottom;cursor:hand" >&nbsp;&nbsp;

 		</td>
 	</tr>
	</table>
		
		
		<display:table name="sessionScope.PCOBJ"  id="list" pagesize="<%=pageSize%>"  class="<%=tableclass%>">  defaultsort="1" defaultorder="descending">
<%
 			rsData = (ezc.ezdisplay.ResultSetData)pageContext.getAttribute("list"); 
			rowNum = (pageContext.getAttribute("list_rowNum")).toString();
			prodT =(rsData.getColumn1()).toString();
                        imgPath=(rsData.getColumn7()).toString();
                        type=(rsData.getColumn10()).toString();
                        prdCode = prodT;  
                        prodDescT = (rsData.getColumn2()).toString();
                        prodDescT = prodDescT.replaceAll("\"","`");
                        if("VC".equals(type))   
                        	matIdTemp = (rsData.getColumn8()).toString();
                        else if("CNET".equals(type))
                        	matIdTemp = rsData.getColumn3().toString()+rsData.getColumn1().toString(); 
			if(cartMat!=null){
				cartQty =(String)cartMat.get(matIdTemp);
				//ezc.ezcommon.EzLog4j.log("cartQty>>"+cartQty,"I");
				if(cartQty == null || "".equals(cartQty)|| "null".equals(cartQty)) 
					cartQty="0";
 				else
 				{
 					try
 					{
 						cartQty = (new java.math.BigDecimal(cartQty.trim())).setScale(0,java.math.BigDecimal.ROUND_HALF_UP).toString();
 					}
 					catch(Exception e){
 						//out.println("eeee>>"+e);
 					}
 				}
			}  
%>
			
<%
			if("VC".equals(type))   
			{
%>
			<display:column title="Item Number/ Description"     style="width:45%;height:50;text-align:left" sortable="true" headerClass="sortable">
			<b> <a title="Click here to view Product details" href="JavaScript:popUp('<%=prdCode%>','<%=rsData.getColumn3()%>','<%=rsData.getColumn8()%>')"> <%=prodT%></a></b>   
			<%=rsData.getColumn2()%> <br>$<%=rsData.getColumn5()%> (List Price) 
			<br>
			<input type ="hidden" name="matId_<%=rowNum%>" value="<%=rsData.getColumn8()%>">
			<input type ="hidden" name="product_<%=rowNum%>" value="<%=rsData.getColumn1()%>">
			<input type ="hidden" name="productDesc_<%=rowNum%>" value="<%=rsData.getColumn2()%>">
			<input type="hidden" name="catalog_<%=rowNum%>" value="<%=rsData.getColumn3()%>">
			</display:column> 
			<display:column title="Image"       		     style="width:14%;height:50;text-align:left" >
<%                      
			if(imgPath!=null && !"".equals(imgPath))                 
			{
				imgPath=imgPath.replaceAll("\\\\","/");
%>
				<a href="javascript:openPopup('/WebStore/CatalogImages/<%=imgPath%>')"><img src="/WebStore/CatalogImages/<%=imgPath%>"   height="50" width="65" border=none></a>
				
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
<%
			}
			else if("CNET".equals(type))
			{
				log4j.log("getConfigDiscount >>>>>getConfigDiscount>>>"+type,"I");       
				imgPath = (String)imageHash.get(prdCode);
				
				String MfrPartNo = (rsData.getColumn9()).toString();
				
				String prodCat = (rsData.getColumn3()).toString();
				String manfId = (rsData.getColumn11()).toString();
				String agentCode = (String)session.getValue("AgentCode");
				String listPrice = "0";

				String listPrFrmHash = (String)cnetPriceHash.get(prdCode);
				if(listPrFrmHash==null)
					listPrice = "0";
				else
					listPrice = listPrFrmHash;

				String discPer = "";
				String discCode = "";
				if(applyDisc_C)
				{
					try
					{
						String returnValue = getConfigDiscount(Session,manfId,prodCat,agentCode,discCreated_C);

						discPer = returnValue.split("¥")[0];
						discCode = returnValue.split("¥")[1];         
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
			
			<display:column title="Item Number/ Description"     style="width:<%=widthTab%>%;height:50;text-align:left" sortable="true" headerClass="sortable">
 			<a href="#" title="Click here to view Product details" onClick="openDetails('<%=prdCode%>','<%=imgPath%>')" ><b><%=prdCode%></b></a><br>
 			Mfr Part No - <b><%=MfrPartNo%></b><br><%=prodDescT%><br>$<%=orgPrice%>&nbsp;(List Price)
<%
 			if("DP".equals(priceType))
 			{
%>
 			| $<%=listPriceVal%>&nbsp;(Discount Price)
<%
			}
			session.putValue(prodT,orgPrice+"@"+listPriceVal);
%>
 			<input type="hidden" name="discPer_<%=rowNum%>" value="<%=discPer%>">
 			<input type="hidden" name="discCode_<%=rowNum%>" value="<%=discCode%>"> 
			<input type="hidden" name="orgPrice_<%=rowNum%>" value="<%=orgPrice%>">
 			<input type="hidden" name="listPrice_<%=rowNum%>" value="<%=listPriceVal%>">			
			<input type ="hidden" name="matId_<%=rowNum%>" value="<%=rsData.getColumn3()%><%=rsData.getColumn1()%>">
			<input type ="hidden" name="product_<%=rowNum%>" value="<%=rsData.getColumn1()%>">
			<input type ="hidden" name="productDesc_<%=rowNum%>" value="<%=rsData.getColumn2()%>">
			<input type="hidden" name="catalog_<%=rowNum%>" value="<%=rsData.getColumn3()%>">
			</display:column> 
 			<display:column title="Image"  style="width:9%;height:50;text-align:left" > 
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
<%
			}
%>
			<display:column title="Manufacturer" style="width:16%;height:50;text-align:left"> 
			<%=(rsData.getColumn4()).toString()%>  
			</display:column>          
			
			<display:column title="Quantity"    style="width:10%;height:50;text-align:left" ><input type="text" name="quantity_<%=rowNum%>" class=InputBox size="5" value=''/"></display:column>
			<display:column title="Add to Cart" style="width:15%;height:50;text-align:left;cursor:hand"><image src="/AST/img/addCart.JPG" title="Click here to Add To Cart" onClick="addToCart('<%=rowNum%>','<%=type%>')"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<image src="/AST/img/cart2.jpg" title="Cart Quantity" />&nbsp;:&nbsp;<input type ="text" class="tx" size="5" name="cartQty_<%=rowNum%>" value="<%=cartQty%>" readonly>
			</display:column>  
<%			
			if(!"Y".equals(isCatUser))
			{
%>
			
			<display:column title="Delete" style="width:5%;height:50;text-align:center">
			<a href="#" onClick="deleteFav('<%=rsData.getColumn1()%>~~<%=rsData.getColumn3()%>~~CNET')"><img style="valign:bottom" src="../../Images/Common/delete_icon.gif" height="20" width="20" border=0  style='cursor:hand'></a>
			</display:column>
<%
			}
%>

			
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
