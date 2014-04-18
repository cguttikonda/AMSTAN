<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCacheControl.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<jsp:useBean id="webCatalogObj" class="ezc.client.EzWebCatalogManager" scope="page"></jsp:useBean>
<%@ include file="../../../Includes/JSPs/NonCnet/iNonCnetSearch.jsp"%>
<html>
<head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>   
<Script>
	function funSearch()
	{
		
		var pcOrDesc = document.myForm.prdCodeOrDesc;
		var itemCat = document.myForm.itemCat;
		var mfrNo = document.myForm.mfrNo;

		var tempPCorDesc = funTrim(pcOrDesc.value);
		tempPCorDesc = replaceAll(tempPCorDesc," ","");
		
		if(pcOrDesc.value=='')
		{ 
			alert("Please enter Product Code / Desc"); 
			pcOrDesc.focus()
			return;
		} 
		/*
		else if(itemCat.value=='')
		{
			alert("Please select Item Category");
			itemCat.focus()
			return;
		}
		*/
		else if(parseInt((tempPCorDesc).length)<4)
		{
			alert("Please enter minimum 4 characters");
			pcOrDesc.focus()
			return;
		}
		else
		{
			/*var chk = isSplChar(pcOrDesc);
			if(!chk)
			{
				pcOrDesc.focus();
				return;
			}
			else
			{*/
				if(itemCat.value=='' && mfrNo.value!='')
				{
					itemCat.value = 'ALL¥All'
				}

				if(mfrNo!=null)
				{
					var mfrData = (mfrNo.value).split("¥")
					document.myForm.mfrID.value = mfrData[0]
					document.myForm.mfrDesc.value = mfrData[1]
				}
				var itemCatData = (itemCat.value).split("¥")

				document.myForm.categoryID.value = itemCatData[0]
				document.myForm.categoryDesc.value = itemCatData[1]
				document.myForm.ProdDesc1.value = pcOrDesc.value

				buttonsSpan=document.getElementById("EzButtonsSpan")
				buttonsMsgSpan=document.getElementById("EzButtonsMsgSpan")
				if(buttonsSpan!=null)
				{
					buttonsSpan.style.display="none"
					buttonsMsgSpan.style.display="block"
				}
				document.myForm.action="ezNonCnetPrdListByCategoryWait.jsp";
				document.myForm.submit();
			//}
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
	function changeItemCat()
	{
		if(document.myForm.itemCat.value!='')
		{
			document.myForm.action="ezNonCnetSearch.jsp";
			document.myForm.submit();  
		}
	} 
	function funICList()
	{
		document.myForm.action="ezListNonCnetCategories.jsp";
		document.myForm.submit();
	}
</Script>
<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>

</head>
<body scroll=no>
<form method="post" name="myForm">
<%
	String display_header = "Search";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%> 
<br><br>
<input type="hidden" name="categoryID" value="">
<input type="hidden" name="categoryDesc" value="">
<input type="hidden" name="STYPE" value="BY_CAT_PRDORDESC">
<input type="hidden" name="mfrID" value="">
<input type="hidden" name="mfrDesc" value="">
<input type="hidden" name="ProdDesc1" value="">
	<Div align=center>
	<Table  width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
	<Tr>
		<Th width = "50%" align="right">Product Code / Desc *</Th>
		<Td width = "50%"><input type = "text" class = "InputBoxTest" name = "prdCodeOrDesc" size = 25 value="<%=prdCodeOrDesc%>">
		</Td>
	</Tr>
		<Tr>
			<Th width = "50%" align="right">Item Category</Th>
			<Td width = "50%">
<%
			if(retCatCnt>0)
			{
				String selStrAll="";
				if("ALL".equals(itemCat))selStrAll="selected";
%>
				<select name= "itemCat" onChange="changeItemCat()" id=listBoxDiv1 style="border:1px solid">
					<option value="">--Select--</option>
					<option value="ALL¥All" <%=selStrAll%>>All</option>   
<%
				retCat.sort(new String[]{"EMM_TYPE"},true);
				String catID = "",catDesc="",catDesc1="";
				
				for(int i=0;i<retCatCnt;i++)
				{
					catID = retCat.getFieldValueString(i,"EMM_TYPE");
					catDesc = retCat.getFieldValueString(i,"EMM_FAMILY");
					
					catDesc1 = replaceString(catDesc,"&","@");
					catDesc1 = replaceString(catDesc1,"'","`");
					if(catID.equals(itemCat))
					{
%>
						<option value="<%=catID%>¥<%=catDesc1%>" selected><%=catDesc%></option>
<%
					}
					else
					{
%>
						<option value="<%=catID%>¥<%=catDesc1%>"><%=catDesc%></option>
<%
					}
				}
				
%>
				</select>
<%
			}
			else
			{
%>
				No Item Catagories available
				<input type="hidden" name="itemCat" value="">
<%
			}
%>
			</Td>
		</Tr>
		<Tr>      
			<Th width = "50%" align="right">Manufacturer</Th>
			<Td width = "50%">
<%
			if(retMfrCnt>0)
			{
%>						
				<select name="mfrNo" id=listBoxDiv2 style="border:1px solid" >
					<option value="">--Select--</option>
<%				
				String mfrNo = "",mfrDesc = "",mfrDesc1="";
				
				for(int i=0;i<retMfrCnt;i++)
				{
					mfrNo = retMfr.getFieldValueString(i,"EMM_MANUFACTURER");
					mfrDesc = retMfr.getFieldValueString(i,"EMM_MANUFACTURER");
					
					mfrDesc1 = replaceString(mfrDesc,"&","@");
					mfrDesc1 = replaceString(mfrDesc1,"'","`"); 
					
					
%>						
					<option value="<%=mfrNo%>¥<%=mfrDesc1%>"><%=mfrDesc%></option>
<%
				}
%>				
				</select>
<%			
			}
			else    
			{
%>
				<select name="soldTo" id=listBoxDiv style="border:1px solid" >
					<option value="">--Select--</option>
				</select>
<%
			}
%>
			</Td>
		</Tr>
	    </Table>
	</Div>

	<Div id="ButtonDiv" align="center" style="position:absolute;top:90%;width:100%"> 
	<span id="EzButtonsSpan">
<%
	buttonName = new java.util.ArrayList();
	buttonMethod = new java.util.ArrayList();

	buttonName.add("Search");
	buttonMethod.add("funSearch()");

	buttonName.add("List Categories");
	buttonMethod.add("funICList()");

	out.println(getButtonStr(buttonName,buttonMethod));
%>
	</span>
	<span id="EzButtonsMsgSpan" style="display:none">
	<Table align=center>
	<Tr>
		<Td class="labelcell">Your request is being processed. Please wait</Td>
	</Tr>
	</Table>
	</span>
	</Div>
</form>
</body>
<Div id="MenuSol"></Div>
</html>