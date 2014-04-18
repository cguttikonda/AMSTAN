<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/JSPs/Catalog/iChangeProdDesc.jsp"%>
<%@ include file="../../../Includes/Lib/ServerFunctions.jsp"%>
<html>

<head>
<Title>Powered By EzCommerceInc.</Title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
	<script src="../../Library/JavaScript/Catalog/ezChangeProdDesc.js"></Script>
</head>

<BODY leftborder=0 topborder=0 rightborder=0 onLoad='scrollInit()' onresize='scrollInit()' scroll="no">
<form name=myForm method=post action="ezSaveChangeProdDesc.jsp" onSubmit="return submitForm()">
	
<%
	if ( ret != null )
	{
		if (ret.getRowCount() > 0)
		{
%>
			<Table  border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0   width="96%">
			<Tr align="center">
				<Td class="displayheader">Product Description</Td>
			</Tr>
			</Table>
			<div id="theads">
			<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
			<Tr>
				<Th width="5%" title="Select/Deselect All"><input type='checkbox' name='chk1Main' onClick="selectAll()"></Th>
				<Th width="20%"> Product </Th>
				<Th width="33%"> Description </Th>
				<Th width="32%"> Web Description</Th>
				<Th width="10%"> Case Lot</Th>
			</Tr>
			</Table>
			</div>
			<div id="InnerBox1Div">
			<Table id="InnerBox1Tab" align="center" border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0>
<%
			String spec1=null,spec2=null,spec3=null,spec4=null;
			ret.sort(new String[]{MATD_DESC},true);
			for ( int i = 0 ; i <ret.getRowCount(); i++ )
			{
				/* 
				spec1 = ret.getFieldValueString(i,MATD_SPECS1);
				spec2 = ret.getFieldValueString(i,MATD_SPECS2);
				spec3 = ret.getFieldValueString(i,MATD_SPECS3);
				spec4 = ret.getFieldValueString(i,MATD_SPECS4);
				spec1 = (spec1 == null)?"":replaceChar('"', "&quot", spec1);
				spec2 = (spec2 == null)?"":replaceChar('"', "&quot", spec2);
				spec3 = (spec3 == null)?"":replaceChar('"', "&quot", spec3);
				spec4 = (spec4 == null)?"":replaceChar('"', "&quot", spec4);
				*/
%>
    		<Tr align="center" >
    		<label for="cb_<%=i%>">
          		<Td width="5%">
             			<input type="checkbox" name="CheckBox" id="cb_<%=i%>" value="<%=ret.getFieldValueString(i,MAT_NUMBER)%>">
          		</Td>
          		<Td width="20%" align = "left">
	 		<%=ret.getFieldValue(i,MAT_NUMBER)%>
         		</Td>
         		<Td width="33%" align = "left">
		  		<%=ret.getFieldValue(i,MATD_DESC)%>
          		</Td>
          		<Td width="32%">
				<input type=text class = "InputBox" size="34" maxlength="120"  name="WebDesc" value="<%=ret.getFieldValue(i,MATD_WEB_DESC)%>" >
          		</Td>
          		<Td width="10%" align = "right">
				<%=ret.getFieldValue(i,"EMM_EAN_UPC_NO")%>
          		</Td>          		
    		</label>
    		</Tr>
<%
			}//End for
%>
				<input type="hidden" name="Language" value="EN" >
				<input type="hidden" name="ProdGroup" value=<%=Prod_Group%> >
				<input type="hidden" name="SysKey" value=<%=Sys_Key%> >
		</Table>
		</div>
		<div id="ButtonDiv" align="left" style="position:absolute;top:90%;width:100%">
    		<input type=image src = "../../Images/Buttons/<%= ButtonDir%>/save.gif" name="ChangeDesc" value="Update">
    		<a href="javascript:void(0)"><img src="../../Images/Buttons/<%= ButtonDir%>/reset.gif" border=none onClick="document.myForm.reset()" ></a>
    		<img src = "../../Images/Buttons/<%= ButtonDir%>/close.gif" style = "cursor:hand" onClick = "javascript:window.close()">
  	</div>
	</center>
<%
		}
		else
		{
%>
		<br><br><br><br>
		<div align="center">There are no product descriptions</div>
		<center>
		 	<a href="JavaScript:history.go(-1)"><img src="../../Images/Buttons/<%= ButtonDir%>/back.gif" border=none></a>
	        </center>
<%
		}
	}	
	String saved = request.getParameter("saved");
	if ( saved != null && saved.equals("Y") )
	{
%>
		<script language="JavaScript">
			alert('Product description(s) changed successfully');
		</script>
<%
	} //end if
%>
</form>
</body>
</html>
