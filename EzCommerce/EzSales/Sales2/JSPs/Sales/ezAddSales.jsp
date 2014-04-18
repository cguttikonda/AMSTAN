<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import ="ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*"%>
<%@ include file="../../../Includes/Lib/ezSessionBean.jsp"%>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iHeaderDefaultValues.jsp" %>
<%
	int count =retpro.getRowCount();
	int half = count/2;
	if(count%2 !=0)
		half=half+1;

	String[] prodCode = request.getParameterValues("prodCode");
	String webOrNo    = request.getParameter("webOrNo");
	
	if(session.getAttribute("SELECTEDMET")!=null)
		session.removeAttribute("SELECTEDMET");

	String country = request.getParameter("shipToCountry");
	if(!("").equals(SoldTo))
	{
		if(listShipTos.getRowCount() == 1)
			country = listShipTos.getFieldValueString(0,"ECA_COUNTRY");
		if(listShipTos.getRowCount() > 1)
		{
			if("null".equals(ShipTo) || ShipTo==null)
			{
				ShipTo = listShipTos.getFieldValueString(0,"EC_PARTNER_NO").trim();
				country = listShipTos.getFieldValueString(0,"ECA_COUNTRY").trim();
			}
		}
	}
	country = (country == null)?"":country.trim();
%>
<html>
<head>
	<title>Create Sales Order -- Powered by Answerthink Ind Ltd</title>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
	<script>
		var scCountry 	="<%=country%>";
		UserRole	="<%=UserRole%>";
		var SoldTo 	="<%=SoldTo%>";
		var shipRowCount="<%=listShipTos.getRowCount()%>";
		var RefDocType 	="<%=RefDocType%>";

<%--*********This part of code is to get ShipTo,Soldto Addresses and materials in to Script arrays **********--%>
<%@ include file="../../../Includes/JSPs/Sales/iGetScriptArrays.jsp" %>
<%--*********End of this part of code to get ShipTo,Soldto Addresses and materials in to Script arrays*******--%>


		function onLoadSelect()
		{
			//this part is to select shipto and soldTo values in to the select boxes on load
			<%@ include file="../../../Includes/JSPs/Sales/iHeaderSelect.jsp"%>
			//to select chkboxes of materials on load
			selectChkBox();
			document.generalForm.poNo.focus();
		}

		function selectChkBox()
		{
			if(document.generalForm.prodCode != null)
			{
				var chkbox = document.generalForm.prodCode.length;
				if(isNaN(chkbox))
				{
					aV=document.generalForm.prodCode.value
					one=aV.split(",");
					if(one[0] == prodCode[0])
					document.generalForm.prodCode.checked=true;
				}
				else
				{
					for(a=0;a<chkbox;a++)
					{
						for(b=0;b<prodCode.length;b++)
						{
							aV=document.generalForm.prodCode[a].value
							one = aV.split(",");
							if(prodCode[b] == one[0])
							{
								document.generalForm.prodCode[a].checked=true;
								break;
							}	
						}
					}
				}
			}
		}

		var MValues = new Array();

		MValues[0] =new EzMList("poNo","PO Number");
		MValues[1] =new EzMList("poDate","PO Date");
		MValues[2] =new EzMList("requiredDate","Required Date");

		function EzMList(fldname,flddesc)
		{
			this.fldname=fldname;
			this.flddesc=flddesc;
		}

		function chk()
		{
			for(c=0;c<MValues.length;c++)
			{
				if(funTrim(eval("document.generalForm."+MValues[c].fldname+".value")) == "")
				{
					alert("<%=plzEnter_A%> "+MValues[c].flddesc);
					if(c=="0")
			   			eval("document.generalForm."+MValues[c].fldname+".focus()")
					return false;
				}
			}
			for(var a=0;a<MSelect.length;a++)
			{
				res=mselect(MSelect[a]);
				if(!res)
				{
					return false;
				}
			}	
			if(document.generalForm.prodCode !=null)
			{
				var chkbox = document.generalForm.prodCode.length;
				chkcount=0;
				if(isNaN(chkbox))
				{
					if(document.generalForm.prodCode.checked)
					{
						chkcount++;
					}
				}
				else
				{
					for(a=0;a<chkbox;a++)
					{
						if(document.generalForm.prodCode[a].checked)
						{
							chkcount++;
							break;
						}
					}
				}
				if(chkcount == 0)
				{
					alert("<%=plzSelPDesc_A%>");
					return false;
				}
			}
			else
			{
				alert("<%=sorryCannotOrd_A%>");
				return false;
			}
      			return true;
		}	
		
		function prodFocus()
		{
			document.generalForm.chk.focus();
		}

		function fun(obj)
		{
			y="";
			if(obj=="ezAddSalesOrder.jsp")
			{
				y=chk(obj);
				if(eval(y))
				{
					if(document.generalForm.soldTo.selectedIndex==0)
					{
						alert("<%=plzSoldTo_A%>");
						document.generalForm.soldTo.focus();
					 	y="false";
					}
				}	
			}
			else if(obj=="shipsubmit")
			{
				pp1 = document.generalForm.shipTo.options[document.generalForm.shipTo.selectedIndex].value;
				for(i=0;i<ShipAdd.length;i++)
				{
					if(funTrim(pp1) == funTrim(ShipAdd[i].shipTo))
					{
						document.generalForm.shipToName.value=ShipAdd[i].shipToname;
						document.generalForm.shipToCountry.value=ShipAdd[i].country;
						if(funTrim(ShipAdd[i].country) != funTrim(scCountry))
							y = "true";
						else
							y="false"
					}
				}
		 		obj="ezAddSales.jsp"
			}
			else
			{
				if(obj=="include")
		       			obj="ezAddSales.jsp"
				y="true";
			}
			if(eval(y))
			{
				document.body.style.cursor="wait"
		  		document.forms[0].action=obj;
		  		document.forms[0].submit();
			}
		}
		function setBack()
		{		
			document.location.replace("../Misc/ezWelcome.jsp");
		}
		var tabHeadWidth=85
 	   	var tabHeight="55%"
 	   	//the variables declared are used in ezMandatorySelectHeader.js 
 	   	var PleaseselectShipTo 	="<%=plzSelShipTo_A%>"
		var PleaseselectSoldTo	="<%=plzSoldTo_A%>"
	</Script>
	<Script src="../../Library/JavaScript/Scroll/ezSalesScroll.js"></Script>
	<script src="../../Library/JavaScript/ezMandatorySelectHeader.js"></script>
	<script src="../../Library/JavaScript/ezSelSelect.js"></script>
	<script src="../../Library/JavaScript/ezChangeAddressText.js"></script>
	
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<script src="../../Library/JavaScript/Misc/ezTrim.js"></script>
	<script src="../../Library/JavaScript/Misc/ezChangeAddress.js"></script>
</head>

<body  onLoad='onLoadSelect();scrollInit()' onresize="scrollInit()" scroll=no>
<form method="post" action="ezAddSalesOrder.jsp" name="generalForm">
<input type="hidden" name="chkVersion" value="0">
<%
	String display_header = creOrder_L;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>

<Table width=75% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<Tr>
        <th class="labelcell" align="left"><%=poNo_L%></th>
        <td>
		<input type="text" class=InputBox name="poNo" maxlength="20" size="13" value="<%= ("null".equals(PONO)||PONO==null)?"":PONO%>" >
		<input type="hidden" name="shipToCountry">
        </td>
        <th class="labelcell" align="left" ><%=poDate_L%></th>
        <td nowrap><input type="text" class=InputBox name="poDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%=PODate%>"><%=getDateImage("poDate")%></td>
<%
        if(("CU").equalsIgnoreCase(UserRole))
        {
%>
		</tr>
		<tr>
		<th class="labelcell" align="left" ><%=rDate_L%></th>
		<td nowrap><input type="text" class=InputBox name="requiredDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%= ("null".equals(REQDate)||REQDate==null)? "" : REQDate%>"><%=getDateImageFromToday("requiredDate")%></td>
		<th class="labelcell" align="left"><%=shipto_L%> </th>
<%
		  if(!("").equals(SoldTo))
		  {
			if((listShipTos.getRowCount() > 1))
			{
%>				<Td>
				<select name="shipTo" onchange='fun("shipsubmit")'>
				<option value=""><%=selShip_L%></option>
<%				for(int k = 0;k<listShipTos.getRowCount();k++)
				{
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
%>					<option value="<%= listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim() %>"><%= name %></option>
<%				}
%>		     		</select><input type="hidden" name="shipToName" >
		     		</Td>
<%     			}
			else
			{
%>				<Td>
<%				for ( int k = 0 ; k < listShipTos.getRowCount(); k++ )
				{
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					String code=listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim();
					out.println("<input type=hidden name=shipToName  value='"+ name +"'>");
					out.println("<input type=hidden name=shipTo  value='"+ code +"'>");
					out.println(name);
				}
%>				</Td>
<%			}
		}
		else
		{
%>			<Td><%=noShipTo_L%></Td>
<%		}	
		out.println("</tr>"); 
	}//end of if customer

	if(!("CU").equalsIgnoreCase(UserRole))
	{
	//out.println(sessionAgentCode);
	//SoldTo  = Integer.parseInt(SoldTo)+"";
	//retsoldto.toEzcString();
%>
	     <th class="labelcell" align="left" ><%=rDate_L%></th>
	     <td nowrap><input type="text" class=InputBox name="requiredDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%= ("null".equals(REQDate)||REQDate==null)? "" : REQDate%>"><%=getDateImage("requiredDate")%></td>
	     </tr>
	     <Tr>
	     <th class="labelcell" align="left"><%=soldto_L%><input type="hidden" name="orderDate" value="<%=OrderDate%>"> </th>
<%		
		if(("").equals(SoldTo) || (!sessionAgentCode.equals(SoldTo)))
		{
%>			<td>
			<select name="soldTo" onChange='fun("include")'>
			<option value=""><%=selSold_L%></option>
<%			int retSoldCount = retsoldto.getRowCount();
			for ( int j = 0 ; j < retSoldCount; j++ )
			{
				String name = retsoldto.getFieldValueString(j,"ECA_NAME").trim();
%>             			<option value="<%= retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO") %>"><%= name %></option>
<%			}//end of for
%>			</select>
			<input type="hidden" name="soldToName">
	        	</Td>
<%		}
		else
	        {
			out.println("<td>");
			String   name="";
			int retSoldCount = retsoldto.getRowCount();
			for (int j = 0;j < retSoldCount;j++)
			{
			 
				if(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").equals(SoldTo))
				{
			 		 name = retsoldto.getFieldValueString(j,"ECA_NAME");			 		
					 out.println("<input type='hidden'  name='soldTo' value='"+SoldTo+"'>");
					 out.println("<input type='hidden'  name='soldToName' value='"+name+"'>");
					 break;
				}

			}//end of for
			out.println(name+"</Td>");
	    }
%>	    <th class="labelcell" align="left"><%=shipto_L%> </th>
<%	    if(!("").equals(SoldTo))
	    {
	    	    if(listShipTos.getRowCount() >1)
		    {
%>				<td colspan=3>
				<select name="shipTo"  onchange='fun("shipsubmit")'>
				<option value=""><%=selShip_L%></option>
<%				for(int k = 0;k<listShipTos.getRowCount();k++)
				{
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
%>				   	<option value="<%= listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim() %>"><%= name %></option>
<%				} //  for loop
%>			      	</select>
				<input type="hidden" name="shipToName">
	      		</Td>
<%
			}
			else //end of if row count
			{
%>				<Td colspan=3>
<%				for(int k = 0;k < listShipTos.getRowCount();k++)
				{
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					out.println("<input type='hidden' name='shipToName' value='"+name+"'>");
					out.println(name);
				}
%>				<input type="hidden" name="shipTo" value="<%= listShipTos.getFieldValueString(0,"EC_PARTNER_NO").trim() %>">
				</Td>
<%		}
		}
		else
		{	//end of if soldto not null
%>			<Td colspan=3><%=plzSelSoldTo_L%></Td>
<%		}
%>     		</Tr>
<%	}
%>
<%-- end of if not cu for user role --%>
   	</table>
<%	if("CU".equals(UserRole))
	{
		out.println("<input type='hidden' name='orderDate'  value='"+OrderDate +"'></td>");
		out.println("<input type='hidden' name='soldTo'  value='"+SoldTo +"'></td>");
		for ( int j = 0 ; j < retsoldto.getRowCount(); j++ )
		{

			if(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").equals(SoldTo))
			{
				 String  name = retsoldto.getFieldValueString(j,"ECA_NAME");
				//out.println("name"+name);
				out.println("<input type='hidden' name='soldToName'  value='"+name +"'></td>");
				 break;
			}

		}//end of for
	}
	if(!"".equals(SoldTo) )
	{
%>
		<Div id="theads">
		<Table  width="85%"  id="tabHead"   align=center border=0 cellPadding=0 cellSpacing=0 >
		<Tr>
<%		if(count != 1){
%>			<td width=49% class=blankcell>
<%		}else{
%>	 		<td width=100% class=blankcell>
<%		}
%>		<Table width="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
 		<tr>
			<Th width="10%"><%=m_L%></Th>
			<Th width="80%"><%=prodDesc_L%></Th>
			<Th width="10%"><%=uom_L%></Th> 
		</tr>
		</table>
<%		if(count!=1)
		{
%>			</td>
			<td width=2% class=blankcell>&nbsp;</td><td width=49% class=blankcell>
			<Table width="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
			<tr>
				<Th width="10%"><%=m_L%></Th>
				<Th width="80%"><%=prodDesc_L%></Th>
				<Th width="10%"><%=uom_L%></Th>
			</tr>
			</table>
<%		}
%>		</td>
   		</Tr>
		</Table>
		</Div>
		
		<DIV id="InnerBox1Div" style="overflow:auto;position:absolute;width:88%;height:45%;left:6%">
		<Table align=center id="InnerBox1Tab"  class=tableClass border=0 cellPadding=0 cellSpacing=0 width="100%">
<%
		for(int i=0; i<count;i=i+2)
		{
			String prodCode1 = retpro.getFieldValueString(i,"MATNO");
			String prodDesc1 = retpro.getFieldValueString(i,"MATDESC");
			prodDesc1=prodDesc1.replace('\"',' ');
			prodDesc1=prodDesc1.replace('\'',' ');
			String uom1=retpro.getFieldValueString(i,"UOM");
%>			<tr>
<%			if(((i+1)<count)||(i>2))
			{
%>	 			<td width=49% class=blankcell>
<%			}
			else
			{
%>	 			<td width=100% class=blankcell>
<%			}
%>			<Table width="100%"   height="100%"  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
			<Tr>	
				<Td width="10%"><input type="checkbox" id="chk_<%=i%>" name="prodCode" value="<%=prodCode1%>,<%= prodDesc1 %>,<%= uom1 %>"></Td>
				<Td width="80%"><label for="chk_<%=i%>">&nbsp;<%= prodDesc1 %> </label></Td>
				<Td width="10%"><%= uom1 %></Td>
			</tr>
			</table>
			</td>
			<td width=2% class=blankcell>&nbsp;</td>
			<td width=49% class=blankcell>
<%			if((i+1)<count)
			{
				String prodCode2 = retpro.getFieldValueString(i+1,"MATNO");
				String prodDesc2 = retpro.getFieldValueString(i+1,"MATDESC");
				prodDesc2=prodDesc2.replace('\'',' ');
				prodDesc2=prodDesc2.replace('\"',' ');
				String uom2=retpro.getFieldValueString(i+1,"UOM");
%>				<Table width="100%"  height="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
				<tr>
					<Td width="10%"><input type="checkbox" id="chk_<%=i+1 %>" name="prodCode" value="<%=prodCode2%>,<%= prodDesc2 %>,<%= uom2 %>"></Td>
					<Td width="80%"><label for="chk_<%=i+1%>">&nbsp;<%=prodDesc2%> </label></Td>
					<Td width="10%"><%=uom2%></Td>
				</tr>
				</table>
<%			}
%>			</td>
			</Tr>
<%		}
%>      	</td>
   		</Tr>
		</Table>
		</Div>

		<div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:91%">
		<center>
<%		buttonName = new java.util.ArrayList();
		buttonMethod = new java.util.ArrayList();
		buttonName.add("Back");
		buttonMethod.add("setBack()");
		buttonName.add("Prepare Order");
		buttonMethod.add("fun(\"ezAddSalesOrder.jsp\")");	
		out.println(getButtonStr(buttonName,buttonMethod));
	}
	else
	{
%>		<br><br>
		<Table align=center border=0 >
		<Tr>
			<Td class=displayalert  valign=middle align=center>
				<%=plzSelSoldTo_L%>...
			</td>
		</Tr>
		</Table>
		<div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:75%">
		<center>	
<%			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("setBack()");
			out.println(getButtonStr(buttonName,buttonMethod));
%>		</Div>
<%	
	}
%>	</center>
	</div>

	<input type="hidden" name="onceSubmit" value=0>
	<input type="hidden" name="from" value="ezAddSales">
	<input type="hidden" name="count" value="<%=count%>">
<%
	if(qtyArr != null)
	{
		for(int k=0;k<qtyArr.length;k++)
		{
%>			<input type="hidden" name="prodQty" value="<%= qtyArr[k]%>">
			<input type="hidden" name="oldprodCode" value="<%= oldQty[k]%>">
<%		}
	}
%>
</form>
<Div id="MenuSol"></Div>
</body>
</html>
<%
	if(session.getAttribute("getprices")!=null)
	{
		session.removeAttribute("getprices");
	}
%>