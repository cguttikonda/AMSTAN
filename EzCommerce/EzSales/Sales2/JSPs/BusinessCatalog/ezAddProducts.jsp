<%//@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddProducts_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iAddProducts.jsp"%>
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<html>
<head>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<script>
function formSubmit(obj)
{
     if(document.form1.onceSubmit.value!=1){
	
	if("ezAddProductPer.jsp"==obj)
	{
		y=chkChkBox();
	}
	else
	{
		y="true"
	}
	if(eval(y))
	{
		document.form1.alert.value="1"
		document.body.style.cursor="wait"
		document.form1.action=obj
		document.form1.onceSubmit.value=1 
		document.form1.submit()
	}
     }
}
function giveAlert()
{
	if(document.form1.alert.value == "1")
	{
		alert("<%=prodAddGroup_A%>")
	}
}
function setBack()
{
     if(document.form1.onceSubmit.value!=1){
	document.form1.alert.value="0"
	document.body.style.cursor="wait"
	document.form1.action="ezFavGroupFinalLevel.jsp"
	document.form1.onceSubmit.value=1 
	document.form1.submit()
     }
	
}
function chkChkBox()
{
	var chkbox = document.form1.product.length;

	chkCount=0
	if(isNaN(chkbox))
	{
		if(document.form1.product.checked)
		{
			chkCount++;
		}
	}
	else
	{
		for(a=0;a<chkbox;a++)
		{	
			if(document.form1.product[a].checked)
			{
				chkCount++;
				break;
			}
		}
	}		
	if(chkCount == 0)
	{
		alert("Please select atleast one product to add to your group");
		return false;
	}

		return true;
}
	
function selectAll(obj,num)
{
	
	
	
	var count = document.form1.elements['pro_'+num].length
	if(obj.checked==true)
	{
		if(isNaN(count))
		{
			document.getElementById("pr_"+num+"_"+0).checked=true;
		}
		else
		{
			for(var i=0;i<count;i++)
			{
				document.getElementById("pr_"+num+"_"+i).checked=true;
			}
		}
	}
	else
	{
		if(isNaN(count))
		{
			document.getElementById("pr_"+num+"_"+0).checked=false;
		}
		else
		{
			for(var i=0;i<count;i++)
			{
				document.getElementById("pr_"+num+"_"+i).checked=false;
			}
		}	
	}
}

</script>
</head>
<body onLoad="giveAlert()" scroll="no" >
<form name="form1" onSubmit='return false()' method="post">
<table align=center border="0" cellpadding="0" class="displayheaderback" cellspacing="0" width="100%">
<tr>
     <td height="35" class="displayheaderback" align=center width="100%">Add Products</td>
</tr>
</table>
<DIV id="headDiv" align=center style="overflow:auto;position:absolute;width:60%;left:21%;height:70%;">
	<Table  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 width=100%>
<%
	int j					= 0;
	String EPC_CATALOG_NO			= "";
	String EPC_DESC 			= "";
	EzCatalogParams ezcfparams 		= new EzCatalogParams();
	EzWebCatalogSearchParams searchParams 	= new EzWebCatalogSearchParams();
	int retpro1Count			= 0;
	boolean b				= true;
	Hashtable myProducts			= new Hashtable();
	Hashtable disPlay			= new Hashtable();
	ArrayList v				= new ArrayList();
	String tempDesc				= null;
	ArrayList tempVector			= null;

	for (j=0;j<retproCount;j++)
	{
		
		EPC_CATALOG_NO 	= retpro.getFieldValueString(j,"EPC_NO");
		EPC_CATALOG_NO	= EPC_CATALOG_NO.trim();
		EPC_DESC 	= retpro.getFieldValueString(j,"EPC_NAME");
		
%>
		<Tr>
			<Th colspan="4"><input type="hidden" name="CATALOG_GROUP_<%=j%>"><b><%=EPC_DESC%></b></Th>
		</Tr>
<%
			searchParams = new EzWebCatalogSearchParams();
			ezcfparams   = new EzCatalogParams();
			
			searchParams.setSearchType("C");
			searchParams.setCatalogCode(EPC_CATALOG_NO);

			ezcfparams.setSysKey(skey);
			ezcfparams.setLanguage("EN");
			ezcfparams.setObject(searchParams);

			Session.prepareParams(ezcfparams);

			retpro1 =(ReturnObjFromRetrieve)webCatalogObj.searchByOptions(ezcfparams);
			
			if(retpro1!=null)
				retpro1Count=retpro1.getRowCount();
			
			
			if(retpro1Count==0)
			{
%>
				<Tr>
					<Td colspan=4 align="center"><%=noProd_L%></Td>
				</Tr>
<%
			}
			else
			{			
				String str[]={"EMM_NO","EMD_DESC"};
				b=retpro1.sort(str,true);
				myProducts= new Hashtable();
				disPlay= new Hashtable();
				for(int plen=0;plen<retpro1Count;plen++)
				{
					v= new ArrayList();
					v.add(retpro1.getFieldValueString(plen,"EMM_NO"));
					v.add(retpro1.getFieldValueString(plen,"EMM_UNIT_OF_MEASURE"));
					myProducts.put(retpro1.getFieldValueString(plen,"EMD_DESC").toUpperCase(),v);
					disPlay.put(retpro1.getFieldValueString(plen,"EMD_DESC").toUpperCase(),retpro1.getFieldValueString(plen,"EMD_DESC"));
				}
				TreeMap myMap = new TreeMap(myProducts);
				Set mySet= myMap.keySet();
				Iterator myIterator = mySet.iterator();
				
%>
				<Tr>
					<Th><input type="checkbox" name="gr_<%=j%>" onClick="selectAll(this,'<%=j%>')"></Th>
					<Th align="center">Product No</Th>
					<Th align="center">Description</Th>
					<Th align="center"><%=uom_L%></Th>
				</Tr>	
<%
				int i=0;
				while(myIterator.hasNext())
				{
					tempDesc=(String)myIterator.next();
					tempVector=(ArrayList)myProducts.get(tempDesc);
					String tPrNo = "";
					try
					{
						tPrNo = Long.parseLong(""+tempVector.get(0))+"";	
					}
					catch(Exception e3)
					{
						tPrNo = ""+tempVector.get(0);
					}
					
%>
					<Tr>
						<Td align=center><input type="checkbox" id="pr_<%=j%>_<%=i%>" value="<%=tempVector.get(0)%>" name="product"> </Td>						
						<input type="hidden" name="pro_<%=j%>">
						<Td><%= tPrNo %></Td>
						<Td><%= disPlay.get(tempDesc) %></Td>
						<Td><%=tempVector.get(1)%></Td>
					</Tr>
					
<%
					i++;
				}
			}
		
	}
%>
</Table>
</div>
<div id="buttonDiv" style="position:absolute;width:100%;top:90%" align=center>
<%
  		buttonName = new java.util.ArrayList();
  		buttonMethod = new java.util.ArrayList();
  		buttonName.add("Add To Catalog");
  		buttonMethod.add("formSubmit(\"ezAddProductPer.jsp\")");
  		buttonName.add("Back");
  		buttonMethod.add("setBack()");
  		out.println(getButtonStr(buttonName,buttonMethod));
%>
</div>
<input type="hidden" name="count" value="<%=j%>">
<input type="hidden" name="onceSubmit" value=0>
<input type="hidden" name="FavGroup" value="<%=FavGroup%>">
<input type="hidden" name="GroupDesc" value="<%=pGroupDesc%>">
<input type="hidden" name="ProductGroup" value="<%=FavGroup%>">
<input type="hidden" name="personalize" value="Y">
<input type="hidden" name="alert">
<input type="hidden" name="from" value="addproduct">
</form>
<Div id="MenuSol"></Div>
</body>
</html>
