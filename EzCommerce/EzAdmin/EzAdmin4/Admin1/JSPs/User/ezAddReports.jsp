<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/CatalogArea.jsp"%>
<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>
<jsp:useBean id="sysManager" class="ezc.client.EzSystemConfigManager" scope="session" />
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />

<%
	ReturnObjFromRetrieve retSystems = null;
	EzcSysConfigParams mySparams = new EzcSysConfigParams();
	EzcSysConfigNKParams mySnkparams = new EzcSysConfigNKParams();
	mySnkparams.setLanguage("EN");
	mySparams.setObject(mySnkparams);
	Session.prepareParams(mySparams);
	retSystems = (ReturnObjFromRetrieve)sysManager.getSystemDesc(mySparams);
	
	ReturnObjFromRetrieve ret = null;

	EzcSysConfigParams sparams = new EzcSysConfigParams();
	EzcSysConfigNKParams snkparams = new EzcSysConfigNKParams();
	snkparams.setLanguage("EN");
	sparams.setObject(snkparams);
	Session.prepareParams(sparams);
	
	ret = (ReturnObjFromRetrieve) sysManager.getCatalogAreas(sparams);
	
	String[] sortArr={"ESKD_SYS_KEY"};	

%>


<html>
<head>
<Script type="text/javascript">

function saveSubmit(x)
{
	if(document.myForm.BusArea.value=="")
	{
		alert("Please select Business Area")
		return;
	}
	
	if(document.myForm.Desc.value=="")
	{
		alert("Please Enter Description")
		return;
	}
	
	if(document.myForm.RepType.value=="")
	{
		alert("Please select Report Type")
		return;
	}
		
	if(document.myForm.xaxis.value=="")
	{
		alert("Please select the Parameter for X Axis")
		return;
	}
	
	if(document.myForm.yaxis.value=="")
	{
		alert("Please select the Parameter for Y Axis")
		return;
	}
	if(document.myForm.xaxis.value==document.myForm.yaxis.value)
	{
	alert("X axis and Y axis cannot be equal")
	return;
	}
		
	document.myForm.action="ezSaveReport.jsp";
	document.myForm.submit();

}

</Script>
<Script src="../../Library/JavaScript/CheckFormFields.js"></Script>

<Title>Add System Data</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body OnLoad="document.myForm.RepType.focus()">


<form name=myForm method=post >

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr align="center">
    	<Td class="displayheader">Add Report</Td>
  	</Tr>
	</Table>

<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">
	<Tr>
      	<Th colspan="2">
        <div align="center"> Please Enter Report Information</div>
      	</Th>
    	</Tr>
    	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Report Type:</div>
		</Td>
		<Td width="63%">

			<select name="RepType" id=ListBoxDiv>
			<option value=''>--Select Report Type--</option>
			<option value='Weekly Sales'>Weekly Sales</option>
			<option value='Top Products'>Top Products</option>
			<option value='Sales Analytics'>Sales Analytics</option>
			<option value='Customer Analytics'>Customer Analytics</option>

			</select>

		</Td>
    	</Tr>    		
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Description:</div>
		</Td>
		<Td width="37%">
		<input type=text class = "InputBox" name=Desc maxlength="100" style="width:37%">
		</Td>
    	</Tr>
    	<Tr>
	      	<Td width="37%" class="labelcell">
	        <div align="right">Business Area:</div>
	      	</Td>
	      	<Td width="63%">
	      	
	      	<select name="BusArea" id=ListBoxDiv>
		<option value='all'>ALL</option>
<%			
	      	
	      	ret.sort(new String[]{SYSTEM_KEY_DESCRIPTION},true);
		for(int i=0;i<ret.getRowCount();i++)
		{
%>			
		<option value=<%=ret.getFieldValue(i,SYSTEM_KEY)%>  > <%=ret.getFieldValue(i,SYSTEM_KEY_DESCRIPTION)%> (<%=ret.getFieldValue(i,SYSTEM_KEY)%>)</option>
					        
		
		
<%		}
%>
		</select>
	      	</Td>
    	</Tr>
    	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Assign To:</div>
		</Td>
		<Td width="63%">	

			<select name="AssTo" id=ListBoxDiv>
			<option value='I' selected>Internal Only</option>
			<option value='E'>External Only</option>
			<option value='B'>Both</option>



			</select>	
		</Td>
    	</Tr>
	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Default Graph Type:</div>
		</Td>
		<Td width="63%">	

			<select name="DefGrf" id=ListBoxDiv>
			<option value='BAR' selected>BAR</option>
			<!--<option value='PIE'>PIE</option>-->
			<option value='LINE'>LINE</option>
			<option value='COLUMN'>COLUMN</option>


			</select>	
		</Td>
    	</Tr>
    	<Tr>
		<Td width="37%" class="labelcell">
		<div align="right">Description on Report Gadget:</div>
		</Td>
		<Td width="37%">
		<input type=text class = "InputBox" name=DescRep maxlength="100" style="width:37%">
		</Td>
    	</Tr>
    	
</Table>
<br>
<table border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="80%">

<td>
	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%">
	<Tr>
      	<Th colspan="4">
        <div align="center">Parameters</div> 
      	</Th>
    	</Tr>
    	
	<Tr>
		<Td  class="labelcell">
		<div align="right">X Axis:</div>
		</Td>
		<Td >	

			<select name="xaxis" id=ListBoxDiv  size=4 >
			<option value='ESDH_SOLD_TO'>Cutomer</option>
			<option value='ESDI_MATERIAL_GROUP'>Material Group</option>
			<option value='ESDI_REQ_QTY'>Required Qty</option>
			<option value='ESDI_COMMITED_PRICE'>Commited Price</option>

			</select>	
		</Td>
		
		<Td  class="labelcell">
		<div align="right">Y Axis:</div>
		</Td>
		<Td >	

			<select name="yaxis" id=ListBoxDiv  size=4 >
			<option value='ESDH_SOLD_TO'>Cutomer</option>
			<option value='ESDI_MATERIAL_GROUP'>Material Group</option>
			<option value='ESDI_REQ_QTY'>Required Qty</option>
			<option value='ESDI_COMMITED_PRICE'>Commited Price</option>

		</select>	
		</Td>
    	</Tr>
	
    	</Table>
    </td>
    
    <td>
    	<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="100%" >
    	<Tr>
          	<Th colspan="4">
            <div align="center">Conditions</div>
          	</Th>
        	</Tr>
        	
    		<Tr>
			<Td width="15%" class="labelcell">
				<div align="right">Prod Group:</div>
			</Td>
			<Td width="40%">	    
				<select name="prodgroups" id=ListBoxDiv  size=4>
				<option value='BASIC'>BASIC</option>
				<option value='ECONOMY'>ECONOMY</option>
				<option value='LUXURY'>LUXURY</option>
				<option value='GRAND LUXURY'>GRAND LUXURY</option>
				<option value='COMMERCIAL'>COMMERCIAL</option>     
				</select>	
			</Td>

			<Td width="15%" class="labelcell">
				<div align="right">State:</div>
			</Td>
			<Td width="50%">	
				<select name="custstate" id=ListBoxDiv  size=4>
				<option value='TX'>Texas &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<option value='GA'>Georgia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<option value='FL'>Florida&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<option value='VA'>Virginia&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				<option value='IN'>Indiana&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
				</select>	
			</Td>
        	</Tr>
        	</Table>
    </td>
    
</table>
<br>
<div align="center">
    	<!--<input type="image" src="../../Images/Buttons/<%= ButtonDir%>/save.gif">--> 
    	<a href="javascript:saveSubmit('x')"><img src="../../Images/Buttons/<%= ButtonDir%>/save.gif" border=none  ></a>
    	<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>

</div>

</form>
</body>
</html>
