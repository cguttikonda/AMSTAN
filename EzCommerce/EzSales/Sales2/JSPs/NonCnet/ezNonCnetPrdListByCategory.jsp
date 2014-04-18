<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>

<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ page import="ezc.ezdisplay.*" contentType="text/html" %>
<%@ include file="../../../Includes/JSPs/NonCnet/iNonCnetPrdListByCategory.jsp"%>                 
<%@ include file="../../../Includes/JSPs/ShoppingCart/iViewCartList.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetNonCnetDisCreatedBy.jsp" %>
<%@ include file="../../../Includes/JSPs/Discounts/igetNonCnetConfigDiscount.jsp" %>        
<%
	java.util.Date myDateObj_A=new Date();
	myDateObj_A.setDate(myDateObj_A.getDate());
	String myDate_A= ezc.ezutil.FormatDate.getStringFromDate(myDateObj_A,".",ezc.ezutil.FormatDate.MMDDYYYY);	
%>
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

	.inputbox {
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
	
	
		var url="",strVal="";
		if(stat=="C")
		{
			url=location.protocol+"//<%=request.getServerName()%>/AST/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezAjaxAddCartNonCnet.jsp";
			strVal = "matId="+matId.value+"&product="+product.value+"&quantity="+quantity.value+"&catalog="+catalog.value+"&cartQty="+cartQty.value+"&discPer="+discPer.value+"&discCode="+discCode.value+"&mydate="+ new Date();
		}
		else if(stat=="V")
		{
			url=location.protocol+"//<%=request.getServerName()%>/AST/EzCommerce/EzSales/Sales2/JSPs/ShoppingCart/ezCnetAddProductsPer.jsp";
			strVal = "FavGroup="+favGroup+"&GroupDesc="+groupDesc+"&chkProds="+chkPrds;
		}
		//alert(url)
				
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
				document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"; 
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
				document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"      
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

	function openDetails(prodID,imagePath)
	{
		var argsVariable =  prodID+ "##"+imagePath
		var ret = window.showModalDialog("ezNonCnetProdDetails.jsp?prodID="+prodID+"&imagePath="+imagePath,argsVariable,"dialogWidth:600px; dialogHeight:500px; center:yes");
	}
	function goToCatDef()
	{
		document.myForm.atrvalstr.value = ""
		document.myForm.mfrID.value = ''
		document.myForm.mfrDesc.value = ''
		document.myForm.STYPE.value="BY_CAT"
		document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp" 
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
	
	function globalSearch()
	{
		document.myForm.action = "../NonCnet/ezNonCnetSearch.jsp?itemCat=<%=categoryID%>"; 
		document.myForm.submit()
	}
	function searchInCat()
	{
		var pcOrDesc = document.myForm.ProdDesc1;
		var tempPCorDesc = funTrim(pcOrDesc.value);
		tempPCorDesc = replaceAll(tempPCorDesc," ","");
	 
		if(document.myForm.ProdDesc1.value=='')
		{
			alert('Please enter search value')
			document.myForm.ProdDesc1.focus()
			return
		}
		else if(parseInt((tempPCorDesc).length)<4)
		{
			alert("Please enter minimum 4 characters");
			pcOrDesc.focus()
			return;
		}
		else
		{
			var chk = isSplChar(tempPCorDesc);
			if(!chk)
			{
				pcOrDesc.focus();
				return;
			}
			else
			{
				document.myForm.STYPE.value = 'BY_CAT_PRDORDESC' 
				document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"
				document.myForm.submit();
			}
		}
	}
	function replaceAll(source,toFind,toReplace)
	{
		var temp = source;
		var index = temp.indexOf(toFind);
		
		while(index!=-1)
		{
			temp = temp.replace(toFind,toReplace);
			index = temp.indexOf(toFind);
		}
		return temp;
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
		document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"
		document.myForm.submit();

	}
	function removeSearch()
	{
		document.myForm.ProdDesc1.value = ''
		document.myForm.STYPE.value = 'BY_CAT' 
		document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"
		document.myForm.submit();
	}
	function removeMfr()
	{
		document.myForm.mfrID.value = ''
		document.myForm.mfrDesc.value = ''
		document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp"
		document.myForm.submit();
	}
	function getProducts(page)
	{
		document.myForm.pageNum.value = page;
		document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp";
		document.myForm.pgSizeCh.value = 'Y'
		document.myForm.submit();
	}
	function getATP1(index)
	{
		var matNo="";
		var matDesc="";
		var uom="";
		var requiredQty="";
		var requiredDate="";
		var mfrId="";
		var mfrPrNo="";
		var mfrName="";
		
		var product_final = eval("document.myForm.product_"+index);
		var productdesc_final = eval("document.myForm.productDesc_"+index);
		var manfId_final = eval("document.myForm.manfId_"+index);
		var MfrPartNo_final = eval("document.myForm.MfrPartNo_"+index);
		var mfrName_final = eval("document.myForm.mfrName_"+index);
		
		matNo=product_final.value;
		matDesc=productdesc_final.value
		uom="EA";
		requiredDate='<%=myDate_A%>'
		requiredQty="0";
		/*mfrId=manfId_final.value;
		mfrPrNo=MfrPartNo_final.value;
		mfrName=mfrName_final.value;*/
		
		var retValue = window.showModalDialog("../Sales/ezPickATP.jsp?matNo="+matNo+"&uom="+uom+"&requiredQty="+requiredQty+"&requiredDate="+requiredDate+"&matDesc="+matDesc+"&mfrId="+mfrId+"&mfrPrNo="+mfrPrNo+"&mfrName="+mfrName,window.self,"center=yes;dialogHeight=28;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
			
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
<input type="hidden" name="pageNum" value="">
<input type="hidden" name="retCatCnt" value="<%=retCatCnt%>">
<%
	String maxPageSize = (String)session.getValue("PAGESIZE");
%>
<input type="hidden" name="maxPgSize" value="<%=maxPageSize%>">

<center>   

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
		String imgPathStr     ="";
		String imgPathURL     ="";
		String wid         ="44";
		
		if("Y".equals(isCatUser))
			wid="49";
 		
 		String tableclass = (pageContext.getAttribute("tableclass")).toString();
 		ezc.ezdisplay.ResultSetData rsData=null;
 		Hashtable cartMat= new Hashtable();
		if(cartRows>0)
		{
			for(int i=0;i<cartRows;i++)
			{ 
				cartMat.put(Cart.getMatId(i),Cart.getOrderQty(i)); 
			}
		}
%>
<%@ include file="ezGetNonCnetImages.jsp" %>  
<%@ include file="ezGetNonCnetPrice.jsp" %>  
<table border="0" cellpadding="0" cellspacing="0" align=center style="background-color:#EEEEEE;border:0" >
<tr height="7px">
	<td style="vertical-align:bottom" align="center" width="30%" colspan=2 >
		<b><font color="#116FAF">Category : </font>&nbsp;<a href="#" onClick="goToCatDef()"><font color="red"><%=catDescDisp%></font></a></b>
	</td>
	<td style="vertical-align:bottom;text-align:right" width="70%" colspan=2 nowrap>
<%

	//out.println("STYPE:::"+STYPE);
	if(mfrList!=null && mfrList.size()!=0 && !(mfrID!=null && !"null".equalsIgnoreCase(mfrID.trim()) && !"".equalsIgnoreCase(mfrID.trim())))
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
				mfrKey  = mfrData.split("¥")[1];
				mfrVal  = mfrData.split("¥")[0];
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
	
	<td style="vertical-align:bottom" align="center" width="30%" colspan=2>
		<a title="Click here to Compare Products" href="JavaScript:compareProds()"><font color="red"><b>Compare Selected</b></font></a>	
	</td>-->
	
	<td style="vertical-align:bottom" align="center" width="35%" >
	
<%
	if(!"Y".equals(isCatUser))
	{
%>
		<a title="Click here to Add Products into My Favourites" href="JavaScript:addCatalog()"><font color="red"><b>Add To My Favourites</b></font></a>
<%
	}
%> 			
	</td>
	<td style="vertical-align:bottom" align="center" width="30%" colspan=2> 
		&nbsp;		
	</td>
	<td style="vertical-align:bottom;text-align:right" align="right" width="35%" nowrap>
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
 		<!--<td style="vertical-align:bottom" align="center" width="30%" colspan=2 >
 			<a title="Click here to Filter Products" href="Javascript:filterByModel('<%=categoryID%>','A00601','Model','0')"><font color="red"><b>Filter By Model</b></font></a>	
 		</td>
 		<td style="vertical-align:bottom" align="center" width="35%">&nbsp;
 			<a title="Click here to Filter Products" href="JavaScript:filterByProductLine('<%=categoryID%>','A00600','Product Line','1')"><font color="red"><b>Filter By ProductLine</b></font></a>	
 		</td>-->
 		<td style="vertical-align:bottom" align="right" width="30%">&nbsp;
		 			
 		</td>
 		<td style="vertical-align:bottom" align="right" width="35%">&nbsp;
				 			
 		</td>
 		<td style="vertical-align:bottom" align="right" width="35%">&nbsp;
						 			
 		</td>
 		<td style="vertical-align:bottom;text-align:right" align="right" width="35%" nowrap>
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
<%
	int pgSizeSet = 0;
	
	if(!"BY_CAT_PRDORDESC".equals(STYPE))	//!"ALL".equals(categoryID)
	{
		int startCnt = (pageMaxNo-pageSize)+1;
		
		if(pageMaxNo<pageSize)
			startCnt = 1;
		
		int endCnt = pageMaxNo;

		int numLinksCnt = itemsCnt/pageSize;
		int numLinksDiv = itemsCnt%pageSize;

		boolean allItems = false;

		if((numLinksCnt==1 && numLinksDiv>0) || numLinksCnt>1)
			allItems = true;

		if(itemsCnt>0)
		{
%>
		<table border="0" cellpadding="0" cellspacing="0" align=center style="background-color:#EEEEEE;border:0" >
		<tr height="7px">
			<td style="text-align:center" align="center" width="30%">
				<%=retCatCnt%> item(s) found, displaying <%=startCnt%> to <%=endCnt%>.
			</td>
		</tr>
		<tr height="7px" align="center">
			<td style="text-align:center" align="center" width="30%">
<%
			int pLast = pageNum_T+4;
			int pFirst = pLast-4;

			if(pLast>numLinksCnt)
			{
				pLast = numLinksCnt+1;

				if(pLast>5)
					pFirst = pLast-4;
			}

			if(pLast<=5)
				pFirst = 1;

			int prev = pFirst-1;
			int next = pLast+1;

			if(allItems)
			{
				if(pFirst==1)
				{
%>
					[First/Prev]&nbsp;
<%
				}
				else
				{
%>
					[<a href="javascript:getProducts(1)">First</a>/<a href="javascript:getProducts(<%=prev%>)">Prev</a>]&nbsp;
<%
				}
			}
			else
			{
				pLast = numLinksCnt;
			}
			
			if(numLinksCnt<3 )
				pLast=pLast+1;

			for(int i=pFirst;i<pLast;i++)
			{
%>
				<a href="javascript:getProducts(<%=i%>)">
<%
				if(i==pageNum_T)
				{
%>
					<b><%=i%></b>
<%
				}
				else
				{
%>
					<%=i%>
<%
				}
%>
				</a>&nbsp;
<%
			}

			if(allItems)
			{
				if(pLast>numLinksCnt)
				{
%>		
					[Next/Last]
<%
				}
				else
				{
%>
					[<a href="javascript:getProducts(<%=next%>)">Next</a>/<a href="javascript:getProducts(<%=(numLinksCnt+1)%>)">Last</a>]
<%
				}
			}
%>
		</td>
		</tr>
		</table>
<%
		}
	}
	else
	{
		pgSizeSet = pageSize;	
	}
	//out.println("pgSizeSet::"+pgSizeSet);
%>
<display:table name="sessionScope.DISOBJCNET"  id="list" pagesize="<%=pgSizeSet%>" class="<%=tableclass%>"  defaultsort="2" >  
<%
	rsData = (ezc.ezdisplay.ResultSetData)pageContext.getAttribute("list"); 
	CatID = (rsData.getColumn5()).toString();

	if(!"Y".equals(isCatUser))
	{
%>
		<display:column title="<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='selAllChk' onClick='selectAll()' />" style="width:9%;text-align:center">
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
		imgPathStr = (String)imageHash.get(ProdID);
		imgPathURL="/AST/img/NonCnetImg/";
		imgPath=imgPathURL+imgPathStr+".jpg";

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
		String MfrPartNo = (rsData.getColumn1()).toString();
		String prodCat = (rsData.getColumn5()).toString();
		String manfId = (rsData.getColumn4()).toString();
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
		<a href="#" title="Click here to view Product details" onClick="openDetails('<%=ProdID%>','<%=imgPath%>')" ><b><%=ProdID%></b></a><br>
		
		Mfr Part No - <b><%=MfrPartNo%></b><br><%=ProdIDDesc%><br>$<%=orgPrice%>&nbsp;(List Price)
<%
		if("DP".equals(priceType))
		{
%>
			| $<%=listPriceVal%>&nbsp;(Discount Price)
<%
		}
		session.putValue(ProdID,orgPrice+"@"+listPriceVal);
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
		
		if(imgPathStr!=null && !"".equals(imgPathStr))                  
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
	<%=(rsData.getColumn4()).toString()%>  
	</display:column>          
	<display:column title="Quantity"    style="width:10%;height:50;text-align:left" >
	<input type="text" name="quantity_<%=rowNum%>" class=InputBox size="5" value=''/">
	</display:column>
	<display:column title="Add to Cart" style="width:15%;height:50;text-align:left;cursor:hand"><image src="/AST/img/addCart.JPG" title="Click here to Add To Cart" onClick="addToCart('<%=rowNum%>')"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<image src="/AST/img/cart2.jpg" title="Cart Quantity" />&nbsp;:&nbsp;<input type ="text" class="tx" size="5" name="cartQty_<%=rowNum%>" value="<%=cartQty%>" readonly>
	</display:column>  
	<display:column title="ATP"   style="width:5%;height:50;text-align:left" >
	<a href="#" title="Click here to view ATP" onClick="getATP1('<%=rowNum%>')" ><image src="/AST/EzCommerce/EzSales/Sales2/Images/atp.gif" /></a>
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

 