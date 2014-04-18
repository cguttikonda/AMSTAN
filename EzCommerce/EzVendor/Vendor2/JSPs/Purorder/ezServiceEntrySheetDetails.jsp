<%@ page import ="ezc.ezparam.*,ezc.ezpurchase.params.*,java.util.*" %>
<%@ include file="../../../Includes/Lib/PurchaseBean.jsp"%>
<jsp:useBean id="PoManager" class="ezc.client.EzPurchaseManager" scope="page"></jsp:useBean>
<%@ include file="../../../Includes/Jsps/Purorder/iServiceEntrySheets.jsp"%>
<Html>
<Head>
<Script>
	var tabHeadWidth=95
	var tabHeight="57%"
</Script>
<script src="../../Library/JavaScript/ezTabScroll.js"></Script>
<Script>
	function showHeaderText()
	{
		document.myForm.target = "PopUp";
		document.myForm.action= "ezShowHeaderText.jsp";
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
		document.myForm.target = "_self";
	}
	
	function showItemText(indx)
	{
		document.myForm.target = "PopUp";
		document.myForm.myIndx.value=indx;
		document.myForm.action= "ezShowItemText.jsp?myIndx="+indx;
		newWindow=window.open("","PopUp","width=550,height=300,left=280,top=200,resizable=no,scrollbars=yes,toolbar=no,menubar=no,minimize=no,status=no");
		document.myForm.onsubmit = newWindow;
		document.myForm.submit();
		document.myForm.target = "_self";
	}
</Script>
<title>Serive Entry Sheets</title>
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp" %>
</Head>
<Body bgcolor="#FFFFF7"  onLoad="scrollInit();" onResize="scrollInit()" scroll=no>
<Form name="myForm">
<%
	String display_header="Serive Entry Sheet Details";
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<table width="80%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=5 cellSpacing=1 >
	<tr> 
		<th align="right">Entry Sheet</th>
		<td >
		<%=docNo%>
		<input type="hidden" name="myIndx">
		</td>
		<th align="right">Created By</th>
		<td ><%=createdBy%></td>
		
		<th align="right">Created On</th>
		<td ><%=createdOn%> </td>
		
		
	</tr>	
	<tr>
		<th align="right">Net Value</th>
		<td ><%=netVal%></td>
		<th align="right">Currency</th>
		<td ><%=curr%> </td>
		<th align="right">Text</th>
		<td>
		<input type="hidden" name="hText" value="<%=mySerHText%>">
		<a href="javascript:onClick=showHeaderText()">
		<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
		</a>
		</td>
		
	</tr>
</table>
<%
	if(sheetSerObjCount==0){
%>
		<br><br><br>
		<table width="60%" align="center" border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
		<tr align="center">
		<th>No Services Exist</th>
		</tr>
		</table>
		<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("JavaScript:history.go(-1);");	
			out.println(getButtons(butNames,butActions));
%>
		</Div>
<%
	}else{
%>
		
		<Br>
				
		<Div id="theads">
			<Table  id="tabHead" width="95%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1 >
				<Tr align="center" valign="middle">
					<Th width="10%">Pckg.No</Th>
					<Th width="4%">Line</Th>
					<Th width="16%">Short Text</Th>
					<Th width="10%">Sub Pckg.No</Th>
					<Th width="10%">GL Account</Th>
					<Th width="10%">Cost Center</Th>
					<Th width="8%">Quantity</Th>
					<Th width="4%">UOM</Th>
					<Th width="4%">PUnit</Th>
					<Th width="10%">Price</Th>
					<Th width="10%">Value</Th>
					<Th width="4%">Text</Th>
					
				</Tr>
			</Table>
		</Div>
		
		
		
		
		
		
		
		
		
		
		
		
		<Div id="InnerBox1Div" style="overflow:auto;position:absolute;width:95%;height:57%;left:2%">
		<Table id="InnerBox1Tab" width="100%" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=5 cellSpacing=1>
<%
			
			Vector types = new Vector();
			types.addElement("currency");
			types.addElement("currency");
			EzGlobal.setColTypes(types);
			Vector names = new Vector();
			names.addElement("GR_PRICE");
			names.addElement("NET_VALUE");
			EzGlobal.setColNames(names);
			ezc.ezparam.ReturnObjFromRetrieve ret = EzGlobal.getGlobal((ezc.ezparam.ReturnObjFromRetrieve)sheetSerObj);
			
			for(int i=0;i<sheetSerObjCount;i++){
			
				String pckg_no=sheetSerObj.getFieldValueString(i,"PCKG_NO");
				String line_no=sheetSerObj.getFieldValueString(i,"LINE_NO");
				
				String newLine="";
				try{
					newLine=""+Integer.parseInt(line_no);
				}catch(Exception err){newLine=line_no;}
				String keyStr=pckg_no+line_no;
				String text_line=(String)poSerTextHT.get(keyStr);
				
				String glAcc="";
				String costCenter="";
				
				for(int j=0;j<accAssignObjCount;j++){
					if(pckg_no.equals(accAssignObj.getFieldValueString(j,"PCKG_NO")) && line_no.endsWith(accAssignObj.getFieldValueString(j,"SERIAL_NO"))){
						glAcc=accAssignObj.getFieldValueString(j,"GL_ACCOUNT");
						costCenter=accAssignObj.getFieldValueString(j,"COSTCENTER");
					}
					
				}
				
				
				
				
				
				if(text_line==null||"null".equals(text_line))text_line="";
%>
				<Tr>
				<Td width="10%" align="center"><%=sheetSerObj.getFieldValueString(i,"PCKG_NO")%>&nbsp;</Td>
				<Td width="4%" align="center"><%=newLine%>&nbsp;</Td>
				<Td width="16%" align="left"><%=sheetSerObj.getFieldValueString(i,"SHORT_TEXT")%>&nbsp;</Td>
				<Td width="10%" align="center"><%=sheetSerObj.getFieldValueString(i,"SUBPCKG_NO")%>&nbsp;</Td>
				<Td width="10%" align="center"><%=glAcc%>&nbsp;</Td>
				<Td width="10%" align="center"><%=costCenter%>&nbsp;</Td>
				<Td width="8%" align="right"><%=sheetSerObj.getFieldValueString(i,"QUANTITY")%>&nbsp;</Td>
				<Td width="4%" align="center"><%=sheetSerObj.getFieldValueString(i,"BASE_UOM")%>&nbsp;</Td>
				<Td width="4%" align="center"><%=sheetSerObj.getFieldValueString(i,"PRICE_UNIT")%>&nbsp;</Td>
				<Td width="10%" align="right"><%=ret.getFieldValueString(i,"GR_PRICE")%>&nbsp;</Td>
				<Td width="10%" align="right"><%=ret.getFieldValueString(i,"NET_VALUE")%>&nbsp;</Td>
				<Td width="4%" align="center">
				
				<input type="hidden" name="iText" value="<%=text_line%>">
				<a href="javascript:onClick=showItemText('<%=i%>')">
					<img   src="../../Images/Buttons/<%=ButtonDir%>/edit-button.gif" border="none" valign=bottom style="cursor:hand">
				</a>
				
				</Td>
				</Tr>
<%
			}
%>
		
		</Table>
		</Div>
		<Div id="ButtonDiv" align=center style="position:absolute;top:91%;visibility:visible;width:100%">
<%
			butNames.add("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");   
			butActions.add("JavaScript:history.go(-1);");	
			out.println(getButtons(butNames,butActions));
%>
		</Div>
		
<%
		
	
	}
%>
</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>