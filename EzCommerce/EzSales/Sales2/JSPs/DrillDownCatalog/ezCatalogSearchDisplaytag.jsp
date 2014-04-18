<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ page import="ezc.ezparam.*" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ page import="ezc.ezdisplay.*" contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCartList.jsp" %>

<%
	int pageSize = 0; 
	int retObjcount = 0;
	try{
		if(request.getParameter("pageSize") != null)
		{
			pageSize = Integer.parseInt(request.getParameter("pageSize"));
		}
		else
		{
			pageSize = 5;
		}
	}catch(Exception ex) 
	{
		pageSize = 5; 
	}	
	
	java.util.StringTokenizer catalogSt = null; 
		
	String catalogStr    = request.getParameter("catalogStr");
	String catalogNumber = "";
	String catalogType   = "";
	String catalogDesc   = ""; 
	String isCatUser     = (String)session.getValue("IsCatUser");
	
	
	String syskey        = (String)session.getValue("SalesAreaCode");   
	String clearSession  = "Y";     
	int countToken=0;
	String noDataStatement ="No Data to Display";      
	
	String searchStr   = request.getParameter("searchStr");       
	String searchType  = request.getParameter("searchType");
	String prodCode    = request.getParameter("ProdDesc1");
	String prodDesc1   = request.getParameter("ProdDesc1");
	String vendCatalog = request.getParameter("vendCatalog");  
	String itemNo      = request.getParameter("itemNo");
	
	
	if(itemNo!=null)
	itemNo = itemNo.replaceAll("@@@","#");  
	
	
	
	
	
	String itemDesc    = request.getParameter("itemDesc"); 
	String globProdStr = request.getParameter("gProdStr");   
	String tempGlobProdStr="";
	String itemNo1  ="";
	String itemDesc1="";
	String pageNo = request.getParameter("d-49520-p");
	
	if(globProdStr!=null)
	 globProdStr = globProdStr.replaceAll("@@@","#");   
	 
	
	
	if(request.getParameter("d-49520-p") != null || request.getParameter("d-49520-o")!=null){
		clearSession = "N";
	}
	
	
	if(catalogStr!=null) 
	{
		catalogSt	= new java.util.StringTokenizer(catalogStr,"$$");

		countToken=catalogSt.countTokens();

		while(catalogSt.hasMoreTokens())
		{
			catalogNumber	 = catalogSt.nextToken();
			if(countToken>1)
			{
			   catalogDesc	 = catalogSt.nextToken();
			   catalogDesc   = catalogDesc.replace('@','&');
			    
			   catalogType   = catalogSt.nextToken();
			}
		}
	}
	
	pageContext.setAttribute("tableclass", "its");

	
	if("Y".equals(clearSession)){
		session.removeAttribute("DISOBJ");
	}
	
	if(searchStr==null || "null".equals(searchStr)){
		searchStr="";
	}else{
		searchStr=searchStr.trim();
		searchStr = "*"+searchStr+"*";
	}	
		
	if(searchType==null || "null".equals(searchType))
		searchType="";
	else
		searchType=searchType.trim();
	
	if("IN".equals(searchType))
	{
		searchStr=searchStr.replace('*','%');
		prodCode=searchStr;
	}
	
        else if("ID".equals(searchType))
        {
                searchStr=searchStr.replace('*','%');
        }
        else if("AS".equals(searchType))
        {
            itemNo1   = "%"+itemNo+"%";
            itemDesc1 = "%"+itemDesc+"%";
            
            itemNo1=itemNo1.replace('*','%');
            itemDesc1=itemDesc1.replace('*','%'); 
        
        }
        else if("GCP".equals(searchType)) 
        {
	    if(globProdStr==null || "null".equals(globProdStr)){
	       globProdStr ="";
	    }else{
	       tempGlobProdStr = globProdStr;
	       globProdStr = "%"+globProdStr+"%";  
	    }
        }
	if(prodCode == null || "null".equals(prodCode) || "".equals(prodCode)){
		prodCode = "";
	}else{
		prodCode = prodCode.trim();
		prodCode = "*"+prodCode+"*";
		prodCode=prodCode.replace('*','%');
	}
	
	ReturnObjFromRetrieve retObj = null;
	EzCatalogParams catalogParams = new ezc.ezparam.EzCatalogParams();
	EzWebCatalogSearchParams searchParams = new EzWebCatalogSearchParams();
		
	if(!"".equals(prodCode) && "".equals(searchType)){ 
		searchParams.setSearchType("CP");
		searchParams.setCatalogType(catalogType);
		searchParams.setCatalogCode(catalogNumber);
		searchParams.setProductCode(prodCode);
	}
	else if(!"".equals(searchType) && "IN".equals(searchType))
	{
	        searchParams.setSearchType("P");
	        searchParams.setProductCode(prodCode);
	}
	else if(!"".equals(searchType) && "ID".equals(searchType))
	{
	       searchParams.setSearchType("P");
	       searchParams.setSearchWebDesc(searchStr);
	}
	else if(!"".equals(searchType) && "AS".equals(searchType))
	{
	      if("".equals(prodCode)){ 
		       searchParams.setSearchType("AS");
		       searchParams.setCatalogCode(vendCatalog);
		       searchParams.setProductCode(itemNo1);
		       searchParams.setSearchWebDesc(itemDesc1);
	      }
	      else{
		       searchParams.setSearchType("CP");
		       searchParams.setCatalogType(catalogType);
		       searchParams.setCatalogCode(catalogNumber);
		       searchParams.setProductCode(prodCode);
	      }
	}
	else if(!"".equals(globProdStr) && !"".equals(searchType) && "GCP".equals(searchType))
	{
	       if("".equals(prodCode)){
	      	    searchParams.setSearchType("GCP");
	       	    searchParams.setCatalogType(catalogType);
	            searchParams.setCatalogCode(catalogNumber);
	            searchParams.setProductCode(globProdStr);
	       }
	       else{
		    searchParams.setSearchType("CP");
		    searchParams.setCatalogType(catalogType);
		    searchParams.setCatalogCode(catalogNumber);
		    searchParams.setProductCode(prodCode);
	       }
	} 
	else{
	       searchParams.setSearchType("C");
	       searchParams.setCatalogType(catalogType);
	       searchParams.setCatalogCode(catalogNumber); 
	}
	catalogParams.setSysKey(syskey);
	catalogParams.setLanguage("EN");
	catalogParams.setObject(searchParams);
	Session.prepareParams(catalogParams);
	
	ResultSet rSet = null;
	int rSetSize=0;
	
        if(session.getAttribute("DISOBJ")==null){
		retObj =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(catalogParams);
		if(retObj!=null && retObj.getRowCount()>0){
			String rFields[] = new String[]{"EMM_NO","EMD_DESC","EMM_CATALOG_NO","EMM_MANUFACTURER","EMM_UNIT_PRICE","EMM_UNIT_OF_MEASURE","EMM_IMAGE_PATH","EMM_ID","EMM_EAN_UPC_NO"}; 
			rSet = new ResultSet();
			rSet.addObject(retObj,rFields);
			session.setAttribute( "DISOBJ", rSet); 
		}	
	}else{
		rSet = (ResultSet)session.getAttribute("DISOBJ");     	
	}
	
%>

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

   </style>
   <Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
   <Script>
   
        var req;
        var matId;
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
			url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartNew.jsp?matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&mydate="+ new Date();
		else if(stat=="V")
			url=location.protocol+"//<%=request.getServerName()%>/CRI/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezVCAddProductsPer.jsp?FavGroup="+favGroup+"&GroupDesc="+groupDesc+"&chkProds="+chkPrds;
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
					alert("New product(s) have been successfully added to catalog")
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
   		product     = eval("document.myForm.product_"+objNumber);
   		productDesc = eval("document.myForm.productDesc_"+objNumber);
   		quantity    = eval("document.myForm.quantity_"+objNumber);
   		catalog     = eval("document.myForm.catalog_"+objNumber);
   		cartQty     = eval("document.myForm.cartQty_"+objNumber);
   		
   		var qtyVal  = quantity.value;
		
		if(qtyVal=="")
		{
			alert("Please enter quantity");
			quantity.focus();
		}
		else if(isNaN(qtyVal) && qtyVal!="")
		{
			alert("Please enter valid quantity");
			quantity.value="";
			quantity.focus();
		}
		else if(qtyVal<1)
		{
		        alert("Quantity should be greater than or equal to one");
			quantity.focus();
		}
		else if(qtyVal.indexOf('.')!=-1)
		{
			alert("Please enter valid quantity");
			quantity.value="";
			quantity.focus();
		}
		else
		{
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
		document.myForm.action="ezCatalogSearchDisplaytag.jsp";
		document.myForm.submit();
	   }
		
     }
     
function setPageSize()
{ 
         
          var catalogStr  = "<%=catalogStr%>"
	  var searchStr   = "<%=searchStr%>"
	  var searchType  = "<%=searchType%>"
	  var vendCatalog = "<%=vendCatalog%>"
	  var itemNo      = "<%=itemNo%>"
	  var itemDesc    = "<%=itemDesc%>"
	  var gProdStr    = "<%=tempGlobProdStr%>"
	  var prodDesc1   = "<%=prodDesc1%>"
	 
	 var pageSizeVal = document.myForm.pageSize.value;

	  if(pageSizeVal>0)
	  {
	  	document.location.href="ezCatalogSearchDisplaytag.jsp?catalogStr="+catalogStr+"&searchStr="+searchStr+"&searchType="+searchType+"&vendCatalog="+vendCatalog+"&itemNo="+itemNo+"&itemDesc="+itemDesc+"&gProdStr="+gProdStr+"&pageSize="+pageSizeVal+"&ProdDesc1="+prodDesc1;
	  	//document.myForm.action="ezCatalogSearchDisplaytag.jsp";
		//document.myForm.submit(); 
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
function showATP(prodCode)
{
	 alert(prodCode);
}
function showATPDetails(prodCode,prdDesc,vcode,matId,upc) 
{
	
	prodCode = prodCode.replace('#','@@@');   
	prdDesc  = prdDesc.replace('"','`');   
	
	myurl ="../Sales/ezGetATPDetails.jsp?matId="+matId+"&vendCode="+vcode+"&upc="+upc+"&ProductCode="+prodCode+"&prdDesc="+prdDesc
	
	retVal=window.open(myurl,"ATP","modal=yes,resizable=no,left=200,top=200,height=400,width=500,status=no,toolbar=no,menubar=no,location=no")
}

function openPopup(fileName) 
{
	attach=window.open(fileName,"UserWindow","width=450,height=500,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=no,menubar=no");
	
}
function addCatalog()
{

	y=chkChkBox();

	if(eval(y))
	{
		var argsVariable = "";
		var retVal = window.showModalDialog("../BusinessCatalog/ezSelectPersonalCatalog.jsp",argsVariable,"dialogWidth:500px; dialogHeight:180px; center:yes");
		if(retVal!="")
		{
			var retArr = retVal.split("~~")
			favGroup  = retArr[0];
			groupDesc = retArr[1];
			chkPrds   = document.myForm.chkVal.value;
			//alert(favGroup+"**"+groupDesc+"**"+chkPrds)

			SendQuery("V");
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
		chkValue = chkValue+checkObj.value;
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

     
     
   </Script>
   
 <link rel="stylesheet" href="./css/print.css" type="text/css" media="print" /> 
 </head>
 <body scroll="yes">
 <Form name="myForm" method="post">
 <input type="hidden" name="catalogStr" value="<%=catalogStr%>">
 <input type="hidden" name="searchStr" value="<%=searchStr%>">
 <input type="hidden" name="searchType" value="<%=searchType%>">
 <input type="hidden" name="vendCatalog" value="<%=vendCatalog%>">
 <input type="hidden" name="itemNo" value="<%=itemNo%>">
 <input type="hidden" name="itemDesc" value="<%=itemDesc%>">
 <input type="hidden" name="gProdStr" value="<%=tempGlobProdStr%>">
 <input type="hidden" name="chkVal" >
 
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
		String wid         ="45";
		
		if("Y".equals(isCatUser))
			wid="40";
		
		
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
<%//@ include file="ezGetATP.jsp" %>           
 
			
	<table border="0" cellpadding="0" cellspacing="0" align=center style="border:0" class='blankcell'>
	<tr class='blankcell'>
		<td valign='center' align="center" width="100%" colspan=2 height="1%">
			<Strong><font color="#6699CC">Search&nbsp;<font color="red"><%=catalogDesc%></font>&nbsp;by Product Id or Description&nbsp;:&nbsp;</font>
			<input type=text name='ProdDesc1' class='inputbox' size=20 align=center>&nbsp;
			<Img src="../../Images/Common/search-icon.gif" style="cursor:hand" border="none" onClick="checkDesc()" onMouseover="window.status=''; return true" onMouseout="window.status=' '; return true">
		</td>
	</tr>
	
	<tr class='blankcell'>
		
		<td align="left" width="80%" height="1%" valign='center' class='blankcell'> 
			<font color="#6699CC"><b>Page size&nbsp;:&nbsp;</b></font>
			<input type=text name='pageSize' class='inputbox' size=5 align=center value='<%=pageSize%>'>&nbsp;
			<img src='../../../../EzCommon/Images/Common/down_arrow.gif' onClick='setPageSize();'  height="20" width="20" border=0  style='cursor:hand'>&nbsp;&nbsp;
		</td> 
		<td valign='right' width="20%" height="1%" align="right" class='blankcell'>&nbsp;
<%
		if(!"Y".equals(isCatUser))
		{
%>
			<a title="Click here to Add Products into Personal Catalog" href="JavaScript:addCatalog()"><font color="red"><b>Add To My Catalog</b></font></a>
<%
		}
%>
		</td>
		
		
	</tr>
	</table>
		
		
		<display:table name="sessionScope.DISOBJ"  id="list" pagesize="<%=pageSize%>"  class="<%=tableclass%>">  defaultsort="1" defaultorder="descending">
<%
 			rsData = (ezc.ezdisplay.ResultSetData)pageContext.getAttribute("list");
			rowNum = (pageContext.getAttribute("list_rowNum")).toString();
			prodT =(rsData.getColumn1()).toString();
                        imgPath=(rsData.getColumn7()).toString();
                        prdCode = prodT;  
                        prodDescT = (rsData.getColumn2()).toString();
                        prodDescT = prodDescT.replaceAll("\"","`");
                        
                        matIdTemp = (rsData.getColumn8()).toString();
			try{
				//prodT = ""+Integer.parseInt(prodT);
			}catch(Exception err){}
			
			if(cartMat!=null){
				cartQty =(String)cartMat.get(matIdTemp);
				if(cartQty == null || "".equals(cartQty)|| "null".equals(cartQty)) 
					cartQty="0";
			}  

		if(!"Y".equals(isCatUser))
		{
%>
			<display:column  style="width:5%;text-align:left">
			<input type='checkbox' name='chkProds' value='<%=rsData.getColumn1()%>~~<%=rsData.getColumn3()%>~~<%=matIdTemp%>' unchecked>
			</display:column>
<%
		}
%>

			<display:column title="Item Number/ Description"     style="width:<%=wid%>%;height:50;text-align:left" sortable="true" headerClass="sortable">
			
			<b> <a title="Click here to view Product details" href="JavaScript:popUp('<%=prdCode%>','<%=rsData.getColumn3()%>','<%=rsData.getColumn8()%>')"> <%=prodT%></a></b>   
			<%=rsData.getColumn2()%> <br>$<%=rsData.getColumn5()%> (List Price) 
			<br>
			<!--<a title="Click here to Upload Images" href="JavaScript:uploadDocs('<%=prdCode%>','<%=rsData.getColumn3()%>','<%=matIdTemp%>')">Upload Docs</a>-->
			<input type ="hidden" name="matId_<%=rowNum%>" value="<%=rsData.getColumn8()%>">
			<input type ="hidden" name="product_<%=rowNum%>" value="<%=rsData.getColumn1()%>">
			<input type ="hidden" name="productDesc_<%=rowNum%>" value="<%=rsData.getColumn2()%>">
			
			
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
			<display:column title="Manufacturer"        		     style="width:16%;height:50;text-align:left">
			<%=(rsData.getColumn4()).toString()%>  
			
			<input type ="hidden" name="catalog_<%=rowNum%>" value="<%=rsData.getColumn3()%>">
			</display:column>          
			
			<display:column title="Quantity"    style="width:10%;height:50;text-align:left" ><input type="text" name="quantity_<%=rowNum%>" class=InputBox size="5" value=''/"></display:column>
			<display:column title="Add to Cart" style="width:15%;height:50;text-align:left;cursor:hand"><image src="/CRI/img/addCart.JPG" title="Click here to Add To Cart" onClick="addToCart('<%=rowNum%>')"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<image src="/CRI/img/cart2.jpg" title="Cart Quantity" />&nbsp;:&nbsp;<input type ="text" class="tx" size="5" name="cartQty_<%=rowNum%>" value="<%=cartQty%>" readonly>
			</display:column>  
			

			
		</display:table> 
 <script>
 
 <%
    if(prodDesc1!=null && !"null".equals(prodDesc1) && ("".equals(searchType) || "GCP".equals(searchType) || "AS".equals(searchType)))
    {
 %>
    	document.myForm.ProdDesc1.value="<%=prodDesc1%>"                   
    
 <% } %>
 
</script>

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
 