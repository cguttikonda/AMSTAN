<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iProductSearch_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iProductSearchForSales.jsp"%>
<html>
<head>
	<title>Product Search</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<base target='_self' />
</head>
<script LANGUAGE="JavaScript">

	var o 	= new Object();

	function gotoHome()
	{
		document.forms[0].action="ezProductSearchForSales.jsp"
		document.forms[0].submit();
	}

	function goClose()
	{
		o.retProd = "CLOSE"
		window.returnValue = o;
		window.close();
	}
	function ezBack(flg)
	{	
		if(flg=="DVC")
		{
			document.forms[0].action="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp"
			document.forms[0].submit();
		}	
		else
		{
			document.forms[0].action="../ShoppingCart/ezViewCart.jsp"
			document.forms[0].submit();
		}	
	}
	function trim( inputStringTrim)
	{
		fixedTrim = "";
		lastCh = " ";
		for( x=0;x < inputStringTrim.length; x++)
		{
			ch = inputStringTrim.charAt(x);
			if ((ch != " ") || (lastCh != " "))
			{ fixedTrim += ch; }
			lastCh = ch;
		}
		if (fixedTrim.charAt(fixedTrim.length - 1) == " ")
		{
			fixedTrim = fixedTrim.substring(0, fixedTrim.length - 1);
		}
		return fixedTrim
	}
	function checkDesc()
	{
	
		var pdesc = document.forms[0].ProdDesc.value;
		pdesc = trim(pdesc);

		if ( pdesc == '')
		{

			alert('<%=prodDescNotEmpty_A%>');
			document.forms[0].ProdDesc.focus();
			return ;
		}
		else 
		{
			for(i=0;i<document.forms[0].sType.length;i++)
			{
				if(document.forms[0].sType[i].checked)
					document.forms[0].SearchType.value = document.forms[0].sType[i].value;

			}
			obj = "ezProductSearchForSales.jsp";
			document.forms[0].ProdDesc.value	= document.forms[0].ProdDesc.value
			document.Search.action=obj;
			document.Search.submit();
		}
	}
	function setFocus()
	{
		if(document.Search.ProdDesc!=null)
			document.Search.ProdDesc.focus();
	}
	var req;
	function funSelect()
	{
	
		var code="",desc="",uom="",upc="",groupId="",reqDt="",reqQty="";
		var prodObj = document.Search.prodCode;
		
		var len = 0;
		if(prodObj!=null)
			len = prodObj.length;
			
		var chk_len = 0;
		
		if(isNaN(len))
		{
			
			if(document.Search.prodCode.checked)
			{
				
				chk_len++;
				
			}
		}
		else
		{
			for (var i=0;i<len;i++)
			{
				if(document.Search.prodCode[i].checked)
					chk_len++;
			}
		}
		
		if(chk_len == 0)
		{
			alert("select atleast one product or click close");
		}
		else
		{
			
			var chkCount = 0;
			if(isNaN(len))
			{
				if(document.Search.prodCode.checked)
				{
					code	= document.Search.prodCode.value;
					desc	= document.Search.matDesc.value;
					uom	= document.Search.uom.value;
					upc	= document.Search.upcNo.value;
					reqDt	= document.Search.desiredDate.value;
					reqQty	= document.Search.desiredQty.value;
					groupId	= document.Search.groupId.value;
					
				}
			}
			else
			{

				for (var i=0;i<len;i++)
				{
					if(document.Search.prodCode[i].checked)
					{

						if(code!="")
						{
							code	= code+","+document.Search.prodCode[i].value;
							desc	= desc+","+document.Search.matDesc[i].value;
							uom	= uom+","+document.Search.uom[i].value;
							upc	= upc+","+document.Search.upcNo[i].value;
							groupId	= groupId+","+document.Search.groupId[i].value;
							reqDt	= reqDt+","+document.Search.desiredDate[i].value;
							reqQty	= reqQty+","+document.Search.desiredQty[i].value;


							document.Search.product[chkCount].value 	= document.Search.prodCode[i].value 
							document.Search.desiredQty[chkCount].value 	= document.Search.desiredQty[i].value
							document.Search.desiredDate[chkCount].value 	= document.Search.desiredDate[i].value
							//document.Search.groupId[chkCount].value 	= document.Search.groupId[i].value
							document.Search.upcNo[chkCount].value 		= document.Search.upcNo[i].value


						}
						else
						{
							code	= document.Search.prodCode[i].value;
							desc	= document.Search.matDesc[i].value;
							uom	= document.Search.uom[i].value;
							upc	= document.Search.upcNo[i].value;
							groupId	= document.Search.groupId[i].value;
							reqDt	= document.Search.desiredDate[i].value;
							reqQty	= document.Search.desiredQty[i].value;

							document.Search.product.value 		= document.Search.prodCode[i].value 
							document.Search.desiredQty.value 	= document.Search.desiredQty[i].value
							document.Search.desiredDate.value 	= document.Search.desiredDate[i].value
							//document.Search.groupId.value 		= document.Search.groupId[i].value
							document.Search.upcNo.value 		= document.Search.upcNo[i].value

						}
						chkCount++;
					}
				}
			}		


			SendQuery(code,groupId,reqDt,reqQty,upc);
			
			o.retProd	= code;
			o.retDesc	= desc;
			o.retUom	= uom;
			o.retUpc	= upc;
			o.count		= chkCount;
			window.returnValue=o;
			
			
			window.close();	
		}
	}
	
	function Process()
	{
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
	
	function SendQuery(code,groupId,reqDt,reqQty,upc)
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
		
		//var url=location.protocol+"//<%=request.getServerName()%>/j2ee/EzCommerce/EzSales/Sales2/JSPs/Sales/ezUpdateCartProducts.jsp?productNo="+code+"&groupId="+groupId+"&reqDt="+reqDt+"&reqQty="+reqQty+"&upc="+upc+"&pageFlag=ADD"+"&date="+new Date();
		var url=location.protocol+"//<%=request.getServerName()%>/EZP/EzCommerce/EzSales/Sales2/JSPs/Sales/ezUpdateCartProducts.jsp?productNo="+code+"&groupId="+groupId+"&reqDt="+reqDt+"&reqQty="+reqQty+"&upc="+upc+"&pageFlag=ADD"+"&date="+new Date();
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);
		}
	}
	function selectAll(obj)
	{
		if(obj.checked==true)
		{
			
			if('<%=remainCount%>' == 1)
				document.Search.prodCode.checked = true;
			else
			{
				for(var i=0;i<<%=remainCount%>;i++)
				{
					document.Search.prodCode[i].checked=true;
				}
			}
		}
		else
		{
			
			if('<%=remainCount%>' == 1)
				document.Search.prodCode.checked = false;
			else
			{
				for(var i=0;i<<%=remainCount%>;i++)
				{
					document.Search.prodCode[i].checked=false;
				}
			}
		}
	}
	
</script>

<body  scroll=no onLoad=setFocus()>
<form method="post" name="Search" action="javascript:checkDesc()">
<input type="hidden" name="SearchType">
<input type="hidden" name="SearchTypeDc" 	>
<input type="hidden" name="from"  		value="<%=request.getParameter("from")%>">
<input type="hidden" name="CatalogDescription"  value="<%=request.getParameter("CatalogDescription")%>">
<input type="hidden" name="GroupDesc"  		value="<%=request.getParameter("GroupDesc")%>">
<input type="hidden" name="ProductGroup"  	value="<%=request.getParameter("ProductGroup")%>">
<input type="hidden" name="FavGroup"  		value="<%=request.getParameter("FavGroup")%>">
<input type="hidden" name="back"  		value="<%=request.getParameter("back")%>">
<input type="hidden" name="retVal"  		value="<%=retVal%>">


<%
	if(searchType==null || "null".equals(searchType) || "".equals(searchType))
	{
%>

		<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
		<tr>
			<td colspan=2 height="35" class="displayheader" align=center width="100%"><%=prodSearch_L%></td>
		</tr>
		<tr>
			<td >&nbsp;</td>
			<td class="graytxt"  align="center">Please specify the search criterion</td>
		</tr>
		</table>
		<br>
		<table width="60%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=0  >
		  <tr>
		    <th width="40%" height="22" align="left"><input type="radio" name="sType" value='NO' checked>Product No</th>
		    <td  width="60%" height="22" rowspan="2" align="left">
		    <table width="100%">
		     <tr>
		     <td colspan=2 width=50%>
			<input type="text" name="ProdDesc" class=InputBox size="20" maxlength="100">

		     </td>
		     <td  width="50%" height="22" rowspan="2" align="left">
			<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Go");
				buttonMethod.add("checkDesc()");
				out.println(getButtonStr(buttonName,buttonMethod));
			%>
		     </td>
		     </tr>
		     </table>
		    </td>

		  </tr>
		  <tr>
		    <th width="40%" align="left"><input type="radio" name="sType" value='DESC' >Product Description</th>
		  </tr>
		</table>
		<center>
<%
		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Close");
		buttonMethod.add("goClose()");
		out.println(getButtonStr(buttonName,buttonMethod));
%>
		</center>
<%
	}
	else
	{
		if(remainCount>0)
		{
	
	
%>
 		<DIV id="theads">	
			<Table width="72%" border="1" id="tabHead" align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>
				<%--<Th class=innerhead width='5%'><input type="checkbox" name="select" onClick="selectAll(this)" title="Select/Deselect All"></Th>--%>
				<Th class=innerhead width='5%'>&nbsp;</th>
				<Th class=innerhead width='25%'>Product</Th>
				<Th class=innerhead width='70%'>Product Description</Th>	
			</Tr>						
			</Table>
			
		</Div>	
 		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:73%;height:50%;left:14%">
		<Table width="100%" id="InnerBox1Tab" border=1 align=center borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
<%			
			String prodCode = "";
			for(int i=0;i<remainCount;i++)
			{
				prodCode = remainPrds.getFieldValueString(i,"MATNO").trim();
%>	
				<Tr>
					<Td align='center' width='5%'><input type="checkbox" name="prodCode" value='<%=prodCode%>' unchecked></Td>
					<Td align='left'   width='25%'><%=prodCode%></Td>
					<Td align='left'   width='70%'><%=remainPrds.getFieldValueString(i,"MATDESC")%></Td>
					<input type='hidden' name='matDesc' 	value="<%=remainPrds.getFieldValueString(i,"MATDESC")%>">
					<input type='hidden' name='uom' 	value='<%=remainPrds.getFieldValueString(i,"UOM")%>'>
					<input type='hidden' name='upcNo' 	value='<%=remainPrds.getFieldValueString(i,"UPCNO")%>'>
					<input type='hidden' name='groupId' 	value='<%=remainPrds.getFieldValueString(i,"GROUP_ID")%>'>
					<input type='hidden' name='desiredQty' value=''>
					<input type='hidden' name='desiredDate' value=''>
					<input type='hidden' name='desiredQty' 	value=''>
					<input type='hidden' name='desiredDate' value=''>
					<input type='hidden' name='product' 	value=''>
				</Tr>
<%			
			}
%>
		</table>
		</Div>
		<div id="buttonDiv" align="center" style='position:Absolute;Top:90%;width:100%'>
		<table align=center cellPadding=0 cellSpacing=0>
		<tr>
			<td>	
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				buttonName.add("Select");
				buttonMethod.add("funSelect()");
				buttonName.add("Close");
				buttonMethod.add("goClose()");
				buttonName.add("Back");
				buttonMethod.add("gotoHome()");
				out.println(getButtonStr(buttonName,buttonMethod));		
%>				
			</td>
		</tr>
		</table>
		</div>
<%
		}
		else
		{
%>	
			<br><br><br><br><br><br>
			<center>
				<table  align=center border=0>
					<tr>
						<td class=displayalert align ="center" colspan ="4">No Products available that match your search criteria. Change your criteria and search again</td>
					</tr>
					<tr>
						<td align='center' style='background-color:white'>	
<%
							buttonName = new java.util.ArrayList();
							buttonMethod = new java.util.ArrayList();
							buttonName.add("Back");
							buttonMethod.add("gotoHome()");
							out.println(getButtonStr(buttonName,buttonMethod));		
%>				
						</td>
					</tr>	
				</table >
			</center>	
			
<%	
		}

	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>

