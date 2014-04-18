<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<%@ page import ="ezc.ezparam.*,java.util.*,ezc.ezpreprocurement.params.*" %>
<%@ page import ="ezc.sapconnection.*,com.sap.mw.jco.*,com.sap.mw.jco.JCO" %>




<%
	String searchType=request.getParameter("searchType");
	String matDescription = request.getParameter("matDesc");
	String selPlant = request.getParameter("selPlant");
	String myIndex = request.getParameter("myIndex");
	String material = request.getParameter("matCode");
	String maxRows = request.getParameter("maxRows");
	String SAP = request.getParameter("SAP");
	
	if(maxRows==null || "null".equals(maxRows)|| "".equals(maxRows))
	maxRows="10";
	
	String systemKey 		= (String)session.getValue("SYSKEY");
	String site = (String)session.getValue("Site");
	String connStr 		= "642~999";
	if(systemKey!=null)
		connStr = site+"~"+systemKey.substring(0,3);
	
	
	
	int materialsCount = 0;
	ReturnObjFromRetrieve retMaterialsList =null;
	EzcParams ezContainer  = new EzcParams(true);
	 
	String MATN0="MAT_CODE";
	String MATDESC="MAT_DESC";
	retMaterialsList=new ReturnObjFromRetrieve(new String[]{"MAT_CODE","MAT_DESC"});

	JCO.Function function = null;
	JCO.Client client = null;
	try
	{

		function = EzSAPHandler.getFunction("BAPI_MATERIAL_GETLIST",connStr);
		client = EzSAPHandler.getSAPConnection(connStr);
		JCO.ParameterList sapPreProc = function.getImportParameterList();
		JCO.ParameterList sapTabParam = function.getTableParameterList();
		JCO.Table ScrSelection = sapTabParam.getTable("MATNRSELECTION");
		JCO.Table DescSelection = sapTabParam.getTable("MATERIALSHORTDESCSEL");
		JCO.Table PlantSelection = sapTabParam.getTable("PLANTSELECTION");

		if(maxRows != null)
		    sapPreProc.setValue(maxRows, "MAXROWS");
		
		PlantSelection.appendRow();
		PlantSelection.setValue("I", "SIGN");
		PlantSelection.setValue("EQ", "OPTION");
		PlantSelection.setValue(selPlant, "PLANT_LOW");
		    
		if("DESC".equals(searchType))
		{
			DescSelection.appendRow();
			DescSelection.setValue("I", "SIGN");
			DescSelection.setValue("CP", "OPTION");
			DescSelection.setValue("*"+matDescription+"*", "DESCR_LOW");
		
		
		}
		else
		{
			ScrSelection.appendRow();
			ScrSelection.setValue("I", "SIGN");
			ScrSelection.setValue("CP", "OPTION");
			ScrSelection.setValue("*"+material+"*", "MATNR_LOW");
			//ScrSelection.appendRow();
			//ScrSelection.setValue("I", "SIGN");
			//ScrSelection.setValue("CP", "OPTION");
			//ScrSelection.setValue(material, "MATNR_LOW");
		}
		try
		{
			client.execute(function);
		}catch(Exception e){
			System.out.println("Exception while executing RFC call BAPI_MATERIAL_GETLIST"+e);
		}			


		JCO.ParameterList expParam = function.getExportParameterList();
		JCO.Table retOut = function.getTableParameterList().getTable("MATNRLIST");
		int count = retOut.getNumRows();
		//out.println("selPlant>>>>"+selPlant+retOut.toString());

		if(count>0)
		{
			do
			{
				retMaterialsList.setFieldValue("MAT_CODE",retOut.getValue("MATERIAL"));
				retMaterialsList.setFieldValue("MAT_DESC",retOut.getValue("MATL_DESC"));
				retMaterialsList.addRow();
			}
			while(retOut.nextRow());
		}



	}
	catch(Exception e1)
	{
		System.out.println("Exception while preparing RFC call BAPI_MATERIAL_GETLIST"+e1);
	}
	finally
	{
		if (client!=null)
		{
			System.out.println("R E L E A S I N G   C L I E N T .... ");
			JCO.releaseClient(client);
			client = null;
			function=null;
		}
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
	var SAP = '<%=SAP%>'
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
    
		var matNoObj=eval("opener.window.document.myForm.matNumber"+myIndex);
		var matDescObj=eval("opener.window.document.myForm.matDesc"+myIndex);
		var casObj=eval("opener.window.document.myForm.casNum"+myIndex);
		var venObj=eval("opener.window.document.myForm.vendor"+myIndex);
		var itmPrice=eval("opener.window.document.myForm.valPrice"+myIndex);
		if(SAP!='Y')
		{
			if(casObj!=null)
				casObj.value = ''
			if(venObj!=null)
				venObj.value = ''
		}
		matNoObj.value=matArr[0];
		matDescObj.value=matArr[1];
		var selPlant = '<%=selPlant%>'
		SendQuery(matArr[0],selPlant);
		//window.close();
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
			myForm.action="ezReturnableContainerMtrlSearch.jsp";
			myForm.submit();
		}	
	}
	function setEmpty()
	{
		myForm.maxRows.value="";
	}
	
	
	var req;
	function Initialize()
	{
		req = '';
		reqType = '';

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

	function SendQuery(material,plant)
	{
		Initialize()

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

		var url=location.protocol+"//"+location.host+"/EZP/EzCommerce/EzVendor/Vendor2/JSPs/PRs/ezGetMatGrpAndUom.jsp?material="+material+"&plant="+plant+"&date="+new Date();	
		//document.write(url)
		if(req!=null)
		{
			req.onreadystatechange = Process;
			req.open("GET", url, true);
			req.send(null);

		}
	}

	function Process()
	{
		if(req.readyState == 4)
		{
		
			if(req.status == 200)
			{
				var resText=req.responseText;

				if(resText.indexOf("¥")!=-1)
				{
					
					var detArr = resText.split("¥")
					var myIndex1=document.myForm.myIndex.value;
					var prUOMObj=eval("opener.window.document.myForm.prUOM"+myIndex1);
					var prMatGrpObj=eval("opener.window.document.myForm.matGroup"+myIndex1);
					if(prUOMObj!=null)
						prUOMObj.value = detArr[1]
					if(prMatGrpObj!=null)
						prMatGrpObj.value = detArr[0]
					window.close()
					
					//alert(prMatGrpObj.value)

				}

			}
			else
			{

				alert("Error while validating the data.. Please try again")
			}
		}
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
		

		<Div id="ButtonDiv" style="position:absolute;top=90%;width=100%" align="center" >
		<Table align="center">
		<Tr>
			<td class="TDCommandBarBorder">
			<table border="0" cellspacing="3" cellpadding="5">
			<tr>
				<td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:history.go(-1)" >
				<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
				</td>

			</tr>
			</table>
		</td>
		<td class="TDCommandBarBorder">
			<table border="0" cellspacing="3" cellpadding="5">
			<tr>
				<td nowrap class="TDCmdBtnOff" onMouseDown="changeClass(this,'TDCmdBtnDown')" onMouseUp="changeClass(this,'TDCmdBtnUp')" onMouseOver="changeClass(this,'TDCmdBtnUp')" onMouseOut="changeClass(this,'TDCmdBtnOff')" onClick="javascript:window.close()" >
				<b>&nbsp;&nbsp;&nbsp;&nbsp;Close&nbsp;&nbsp;&nbsp;&nbsp;</b>
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
			if(matDesc!=null)
				matDesc = matDesc.replaceAll("'","`");
			
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
<input type="hidden" name="selPlant" value="<%=selPlant%>">


</form>
<Div id="MenuSol"></Div>
</body>
</html>