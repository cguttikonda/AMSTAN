<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="PreProMgr" class="ezc.ezpreprocurement.client.EzPreProcurementManager" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezpreprocurement.params.*" %>

<%
	String searchType=request.getParameter("searchType");
	String matDescription = request.getParameter("matDesc");
	String myIndex = request.getParameter("myIndex");
	String material = request.getParameter("matCode");
	String maxRows = request.getParameter("maxRows");
	String itemIndex=request.getParameter("itemIndex");
	
	if(maxRows==null || "null".equals(maxRows)|| "".equals(maxRows))
	maxRows="10";
	
	int materialsCount = 0;
	ReturnObjFromRetrieve retMaterialsList =null;
	EzcParams ezContainer  = new EzcParams(true);
	
	
	
	 
	String MATN0="";
	String MATDESC="";
	
	if("DESC".equals(searchType)){
		MATN0="MATNR";
		MATDESC="MATDESC";
		EziGenericFMParams inputFMParam   = new EziGenericFMParams();
		inputFMParam.setObjectId("MAT_DESC_SEARCH");
		inputFMParam.setInput1(matDescription);
		ezContainer.setObject(inputFMParam);
		Session.prepareParams(ezContainer);
		retMaterialsList =  (ReturnObjFromRetrieve)PreProMgr.ezCallGenericFM(ezContainer);
		
	
	}else{
		MATN0="MAT_CODE";
		MATDESC="MAT_DESC";
		if(!material.startsWith("*"))
		material="*"+material;
	
		EziPreProcurementParams inputParam=new EziPreProcurementParams();
		inputParam.setExt1("LIST");
		inputParam.setOpenItems(maxRows);
		inputParam.setMaterial(material);	
		
		ezContainer.setObject(inputParam);
		Session.prepareParams(ezContainer);
			
		retMaterialsList=(ReturnObjFromRetrieve)PreProMgr.ezGetMaterialDetails(ezContainer);
		
	
	
	}
	if(retMaterialsList!=null)
	{
		materialsCount = retMaterialsList.getRowCount();
	}
%>



<html>
<head>
<Title>Search Result</Title>
<base target="_self">
<Script src="../../Library/JavaScript/ezTrim.js"></Script>
<Script>
	var tabHeadWidth=95
	var tabHeight="75%"
</Script>
<Script>
	function selectMaterials()
	{
		var chkLen = document.myForm.chk.length;
		indxV = 0;
		if(!isNaN(chkLen))
		{
			for(var i=0;i<chkLen;i++)
			{
				if(document.myForm.chk[i].checked)
				{
					indxV++;
				}	
			}
		}
		else
		{
			if(document.myForm.chk.checked)
				indxV++;
		}
		
		if(indxV==0)
		{
			alert("Please select one material");
			return;
		}
		
		
		
		var indx =0;		
		var chkObj = null;  
		if(!isNaN(chkLen))
		{
			for(var i=0;i<chkLen;i++)
			{
				if(document.myForm.chk[i].checked)
				{
					indx=i;
					break;
				}	
			}
			chkObj = document.myForm.chk[indx].value;
		}else
		{
			chkObj = document.myForm.chk.value;
		}
		var matArr = chkObj.split("##");
		var myIndex=document.myForm.myIndex.value;
    		var itemIndex=document.myForm.itemIndex.value;
    
		var matNoObj=eval("opener.window.document.myForm.rcMat"+myIndex);
		var matDescObj=eval("opener.window.document.myForm.rcMatDesc"+myIndex);
		var objLen=matNoObj.length;

		if(isNaN(objLen))
		{
			matNoObj.value=matArr[0];
			//matNoObj.readOnly = true;
			matDescObj.value=matArr[1];
			//matDescObj.readOnly = true;
		}else{
			matNoObj[itemIndex].value=matArr[0];
			//matNoObj[itemIndex].readOnly = true;
			matDescObj[itemIndex].value=matArr[1];
			//matDescObj[itemIndex].readOnly = true;
		}
		window.close();
	}
	function closeWin()
	{
		window.close();
	}
	function chkMaxRows()
	{
		var maxRows = myForm.maxRows.value;
		if(!isNaN(maxRows))
			return true;
		else
		{
			alert("Please Enter Number");
			myForm.maxRows.focus();
		}	
		return false;	
	}
	function submitMaxRows()
	{
		if(chkMaxRows())
		{
			myForm.action="ezMtrlSearch.jsp";
			myForm.submit();
		}	
	}
	function setEmpty()
	{
		myForm.maxRows.value="";
	}
	
</Script>	
<Script src="../../Library/JavaScript/ezTabScroll.js"></Script>
</head>
<body scroll="no" onLoad='scrollInit(10)' onResize='scrollInit(10)'>
<form name='myForm'>
<%
  
	if(materialsCount == 0)
	{
%>
		<br><br><br>
		<Table width="60%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
			<tr>
				<th align="center">There are no Materials to List.</th>
			</tr>
		<Table>
		<br><br><br><br>
		
		<Div id="ButtonDiv" style="position:absolute;top=94%;width=100%" align="center" >
		<Table align="center">
		<Tr>
      <td class="TDCommandBarBorder">
          <table border="0" cellspacing="3" cellpadding="5">
          <tr>
            <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:closeWin()" >
                   <b>&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;</b>
            </td>
          </tr>
          </table>
      </td>
		</Tr>
		</Table>	
		</Div>
<%
		return;
	}
%>
	<Div>
	<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="95%">
	    	<tr align="center" valign="middle">
			<Th width="70%">Materials List</Th>
			<Td  width="15%" align="center" class=blankcell>
				<input type="text" class=InputBox onFocus="setEmpty()" style="width:100%" name="maxRows"  size="11" value="Enter no of Rows">		   
			</Td>	
      <td class="TDCommandBarBorder">
          <table border="0" cellspacing="3" cellpadding="5">
          <tr>
        <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:submitMaxRows()" >
               <b>&nbsp;&nbsp;&nbsp;&nbsp;submit&nbsp;&nbsp;&nbsp;&nbsp;</b>
        </td>
        
          </tr>
          </table>
      </td>
		</tr>
 	</table>
 	</Div>

	<Div id="theads">
	<Table id="tabHead" border=0 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=5 cellSpacing=1  width="95%">
	    	<Tr align="center" valign="middle">
			<Th width="5%">&nbsp;</Th>
			<Th width="30%">Material Code</Th>
			<Th width="65%">Material Desc</Th>
	    	</Tr>
 	</table>
 	</Div>
	<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:90%;height:60%;">
	<Table align=center id="InnerBox1Tab" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 width="100%">
<%
		String matCode ="",matDesc="";
		for(int i=0;i<materialsCount;i++)
		{
			matCode = retMaterialsList.getFieldValueString(i,MATN0).trim();
			matDesc = retMaterialsList.getFieldValueString(i,MATDESC).trim();
			
			
			try
			{
				matCode = Long.parseLong(matCode)+"";
			}
			catch(Exception e)
			{
				matCode = matCode;
			}
			
			

			if(matDesc==null || "null".equals(matDesc) || "".equals(matDesc))
			{
				matDesc = "&nbsp;";
			}
			if(matCode==null || "null".equals(matCode) || "".equals(matCode))
			{
				matCode = "&nbsp;";
			}
			
%>   
			<tr>
				<td width="5%"><input type=radio name="chk" value="<%=matCode+"##"+matDesc%>"></td>
				<td width="30%" align="left"><%=matCode%></td>
				<td width="65%" align="left"><%=matDesc%></td>
			</tr>				
<%						
		}
%>
	</Table>
	</Div>
	<Div id="ButtonDiv" style="position:absolute;top=94%;width=100%" align="center" >
	<Table align="center">
	<Tr>
    <td class="TDCommandBarBorder">
        <table border="0" cellspacing="3" cellpadding="5">
        <tr>
      <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:selectMaterials()" >
             <b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
      </td>
      
        </tr>
        </table>
    </td>
    <td class="TDCommandBarBorder">
        <table border="0" cellspacing="3" cellpadding="5">
        <tr>
      <td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:closeWin()" >
             <b>&nbsp;&nbsp;&nbsp;&nbsp;Cancel&nbsp;&nbsp;&nbsp;&nbsp;</b>
      </td>
      
        </tr>
        </table>
    </td>
	</Tr>
	</Table>	
	</Div>
<input type="hidden" name="matCode" value="<%=material%>">
<input type="hidden" name="matDesc" value="<%=matDescription%>">
<input type="hidden" name="searchType" value="<%=searchType%>">
<input type="hidden" name="myIndex" value="<%=myIndex%>">
<input type="hidden" name="itemIndex" value="<%=itemIndex%>">


</form>
<Div id="MenuSol"></Div>
</body>
</html>