   
<%--
      Copyright Notice =====================================*
    * This file contains proprietary information of Answerthink Inc.
    * Copying or reproduction without prior written approval is prohibited.
    * Copyright (c) 2005 ===================================*
--%>

<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<%@ include file="../../../Includes/Lib/ezShoppingCartBean.jsp"%>
<%@ include file="iSearchMaterialsList.jsp"%>
<%@ include file="iViewCart.jsp"%>
<%@ include file="../../../Includes/JSPs/Misc/ezATPSearchInc.jsp"%>

<Html>
<Head>
<Title>Materials List...</Title>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<Script>
	   var tabHeadWidth=75
 	   var tabHeight="45%"
</Script>
<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
<Script src="../../Library/JavaScript/ezDocURL.js"></Script>
<Script>
	function CheckSelect() {
		var pCount=0;
		var selCount=0;
		var pCount = <%=retMaterialListCount%>;
		var i = 0;
		for ( i = 0 ; i < pCount; i++ ) {
			if(document.myForm.elements['CheckBox_' + i].checked){
				selCount = selCount + 1;
			}
		}
		if(selCount<1){
			alert("Select Items To Add Cart");
			document.myForm.alert.value="0"
			return false
		}else{
			document.myForm.alert.value="1"
			return true
		}
	}
	
	function getATP(index)
	{
		
		var myObject=document.myForm.product;
		var len=myObject.length;
		var matNo="";
		var matDesc="";
		var uom="";
		var requiredQty="";
		var requiredDate="";
		 
		 
		if(isNaN(len)){
			
			 matNo=document.myForm.product.value;
			 matDesc=document.myForm.productDesc.value
			 uom="EA";
			 requiredDate=document.myForm.reqDate.value
			 requiredQty="0";
			 
			 
		}else{
			 matNo=eval("document.myForm.product["+index+"]").value;
			 matDesc=eval("document.myForm.productDesc["+index+"]").value
			 uom="EA";
			 requiredDate=document.myForm.reqDate.value
			 requiredQty="0";
			
		}
		var retValue = window.showModalDialog("../Sales/ezGetATPResult.jsp?matNo="+matNo+"&uom="+uom+"&requiredQty="+requiredQty+"&requiredDate="+requiredDate+"&matDesc="+matDesc,window.self,"center=yes;dialogHeight=28;dialogWidth=30;help=no;titlebar=no;status=no;minimize:yes")	
		
		
		
	}

	function viewCart()
	{

		document.myForm.alert.value="0"
		//document.CatalogFinalLevel.onceSubmit.value=1
		document.body.style.cursor="wait"
		document.myForm.action="../ShoppingCart/ezViewCart.jsp"
		document.myForm.submit();
		
		
	}

	function addtocart()
	{
		if(CheckSelect())
		{
			document.myForm.action="ezAddCart.jsp"
			document.myForm.submit();
		}	
	}
	function goBack()
	{

		document.myForm.action="ezSearchMaterials.jsp"
		document.myForm.submit();
	}
	
	
	
	
	
</Script>
<Head>
<Body onLoad="scrollInit();" scroll=no onresize="scrollInit()">
<Form method="post"  name="myForm">
<input type="hidden" name="from" value="ezSearchMaterialsList.jsp">
<input type="hidden" name="className" value="<%=className%>">

<%
		for(int i=0;i<selClassCharacter.length;i++){
%>
		<input type="hidden" name="selectedClassCharacter" value="<%=selClassCharacter[i]%>">
<%
		}

		for(int i=0;i<selValues.length;i++){
%>
		<input type="hidden" name="selectedValues" value="<%=selValues[i]%>">
<%
		}
%>


<Div id =titleDiv>
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
    <td height="35" class="displayheaderback" width="40%">&nbsp;</td>
    <td height="35" class="displayheader"  width="40%">Material List</td>
    <td height="35" class="displayheaderback" width="20%">Shopping Cart Items:<%=cartCount%></td>

</tr>
</table>
</Div>
<%

if(retMaterialListCount>0)
{



	//All display columns setting here
	java.util.Hashtable myValues	= new java.util.Hashtable();
	java.util.ArrayList dispColumns	= new ArrayList();
	java.util.ArrayList dispSizes  	= new java.util.ArrayList();
	java.util.ArrayList dispAlign  	= new java.util.ArrayList();
	
	dispColumns.add("CHECKBOX");		dispSizes.add("'10%'");		dispAlign.add("center");	
	dispColumns.add("OBJECT");		dispSizes.add("'20%'");		dispAlign.add("Left");	
	dispColumns.add("OBJECTTEXT");		dispSizes.add("'50%'");		dispAlign.add("Left");	
	dispColumns.add("UOM");			dispSizes.add("'10%'");		dispAlign.add("Center");	
	dispColumns.add("ATP");			dispSizes.add("'10%'");		dispAlign.add("Center");	
	
%>
	<Div id="theads">
		<Table  width="75%" align=center id="tabHead"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
		<Tr>
			<Th width="10%" >M</th>
			<Th width="20%" >Material</th>
			<Th width="50%" >Material Desc</th>
			<Th width="10%" >UOM</th>
			<Th width="10%" >ATP</th>
		</Tr>	
		</Table>
	</Div>
	
	<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:85%;height:45%;left:8%">
	<Table align=center id="InnerBox1Tab"  border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width="100%">

<%
	String hiddenFields="",onjTemp="",onjtextTemp="";
	java.util.Date myDateObj=new Date();
	myDateObj.setDate(myDateObj.getDate()+1);
	String myDate= ezc.ezutil.FormatDate.getStringFromDate(myDateObj,".",ezc.ezutil.FormatDate.MMDDYYYY);
	%>
		<input type='hidden' name='reqDate' value='<%=myDate%>'>
	<%
	for (int i=0;i<retMaterialListCount;i++)
	{
		
		onjTemp  = retMaterialList.getFieldValueString(i,"OBJECT");
		onjtextTemp  =retMaterialList.getFieldValueString(i,"OBJECTTEXT");
		
		hiddenFields = "<input type='hidden' name='product' value='"+onjTemp+"'>";
		hiddenFields += "<input type='hidden' name='productDesc' value='"+onjtextTemp.replace('"',' ')+"'>";
		
		if(selectedItems.contains(onjTemp)){
			myValues.put("CHECKBOX",hiddenFields+"<input type='checkbox' name='CheckBox_"+i+"' name='prodCode' value="+onjTemp+"¥"+onjtextTemp+"' checked>");
		}else{
			myValues.put("CHECKBOX",hiddenFields+"<input type='checkbox' name='CheckBox_"+i+"' name='prodCode' value="+onjTemp+"¥"+onjtextTemp+"'>");
		}
		
		//myValues.put("OBJECT","<a style='text-decoration:none'  href=\"Javascript:matDetails(\'"+onjTemp+"\',\'"+onjtextTemp+"\')\">"+onjTemp+"</a>");
		//myValues.put("OBJECTTEXT","<a style='text-decoration:none'  href=\"Javascript:matDetails(\'"+onjTemp+"\',\'"+onjtextTemp+"\')\">"+onjtextTemp+"</a>");
		myValues.put("OBJECT",onjTemp);
		myValues.put("OBJECTTEXT",onjtextTemp);
		
		myValues.put("UOM","EA");
		
		myValues.put("ATP","&nbsp;");
%>	
		<Tr>
<%
			for(int k=0;k<dispColumns.size();k++)
			{
				if("ATP".equals((String)dispColumns.get(k))){
				%>
					<Td align='center' width='20%'>
					<a href="javascript:getATP('<%=i%>');" >ATP

					
					</a>
					</Td>
				<%
				}else{
					out.println("<Td width=" + dispSizes.get(k) + " align=" + dispAlign.get(k) + ">" + myValues.get(dispColumns.get(k)) + "&nbsp;</Td>");
				}	
			}
%>
		</Tr>
<%
	}
%>
		</Table>
	</Div>	

	<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
		<Table align="center" width="100%" >
			<Tr><Td class="blankcell" align="center">
				<!-- <a style="text-decoration:none"  class=subclass href='Javascript:addtocart()'><img  src='../../Images/Buttons/<%= ButtonDir%>/addtocart.gif'  title="Click here to add to Cart" alt="Click here to add to Cart" border='none' onMouseover=";window.status=' '; return true" onClick=";window.status=' '; return true"></a>
				<a style="text-decoration:none"  class=subclass href='Javascript:viewCart()'><img  src='../../Images/Buttons/<%= ButtonDir%>/viewcart.gif' border='none'  title='Click here to view Cart' alt='Click here to view Cart' onMouseover=";window.status=' '; return true" onClick=";window.status=' '; return true"></a>
				<a style="text-decoration:none"  class=subclass href='Javascript:goBack()'><img  src='../../Images/Buttons/<%= ButtonDir%>/back.gif' border='none'  title='click here To go Back' alt='click here To go Back' onMouseover=";window.status=' '; return true" onClick=";window.status=' '; return true"></a> -->
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Add To Cart");
			buttonMethod.add("addtocart()");
			buttonName.add("View Cart");
			buttonMethod.add("viewCart()");
			buttonName.add("Back");
			buttonMethod.add("goBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>				
				
			     </Td>
			</Tr>
		</Table>
	</Div>
<%
	}else
	{
%>
		<Br><Br><Br><Br>
		<Table align=center><Tr>
			<Td class=displayalert>
				No Materials For this selection Please reselect
			</Td></Tr>
		</Table>
		<Div id="buttonDiv" style="position:absolute;top:90%;width:100%" align="center">
			<Table width="100%" align=center>
			<Tr><Td class="blankcell"  align=center>
			<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			
			if(cartCount>0)
			{
			
				buttonName.add("View Cart");
				buttonMethod.add("viewCart()");
		
			}
			
			buttonName.add("Back");
			buttonMethod.add("goBack()");
			
			
			out.println(getButtonStr(buttonName,buttonMethod));
			%>
			</Td>	
			</Tr>
			</Table>
		</Div>
<%
	}
%>	

<input type="hidden" name="alert">
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>

