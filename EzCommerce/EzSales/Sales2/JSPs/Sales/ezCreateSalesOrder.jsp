<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ page import="ezc.ezparam.*,ezc.ezutil.FormatDate,java.util.*"%>
<%@ include file="../../../Includes/JSPs/Lables/iAddSales_Lables.jsp" %>
<jsp:useBean id="log4j" class="ezc.ezcommon.EzLog4j" scope="session" />
<%@ include file="../../../Includes/JSPs/BusinessCatalog/iCatalog.jsp"%>
<%@ include file="../../../Includes/JSPs/Sales/iHeaderDefaultValues.jsp" %>
<%@ include file="../../../Includes/JSPs/Sales/iShippingTypes.jsp" %>             
<%
	ReturnObjFromRetrieve retprodfav = null;
	EzcPersonalizationParams ezget = new EzcPersonalizationParams();
	EziPersonalizationParams izget = new EziPersonalizationParams();
	izget.setLanguage("EN");
	ezget.setObject(izget);
	Session.prepareParams(ezget);
	retprodfav = (ReturnObjFromRetrieve) EzcPersonalizationManager.getProdFavDesc(ezget);
	//retprodfav.toEzcString();
	int retprodfavCount=retprodfav.getRowCount();

	Enumeration enum1S =  ezShippingTypes.keys(); 
	String enum1Key=null;
	String enum1Desc=null;
		
	String pGroupNumber = "";
	int cnt = ret.getRowCount(); 
		
	String[] shippingTypeDesc	= new String[2];
	String shippingType = request.getParameter("shippingType");

	if("null".equals(shippingType)||shippingType==null ||"".equals(shippingType)|| shippingType=="")
	 {
		shippingTypeDesc[0]="";
		shippingTypeDesc[1]="";
	 }
	else
	{ 
		shippingTypeDesc	= shippingType.split("#"); 	

	}
	
	if(cnt==1)
	{
		pGroupNumber = (String)ret.getFieldValue(0,PROD_GROUP_NUMBER);	
	}
	else
	{
		pGroupNumber = request.getParameter("ProductGroup");
		if(pGroupNumber==null)
		{
			for(int i=0;i<cnt;i++)
			{
				if("ACTIVE".equals(ret.getFieldValueString(i,PROD_GROUP_WEB_DESC)))
				{
					pGroupNumber = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
					break;
				}
				else
				{
					pGroupNumber = (String)ret.getFieldValue(0,PROD_GROUP_NUMBER);
				}
			}
		}
	}	
	
	if(forkey==null) forkey ="/";
	
%>
<Html>
<Head>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>

	<link rel="STYLESHEET" type="text/css" href="../../Library/Styles/dhtmlXGrid.css">
	<Script src="../../Library/JavaScript/Grid/dhtmlXCommon.js"></Script>
	<script src="../../Library/JavaScript/Grid/dhtmlXGrid.js"></script>		
	<script src="../../Library/JavaScript/Grid/dhtmlXGridCell.js"></script>
	<Script src="../../Library/JavaScript/Misc/ezTrim.js"></Script>
	<Script>
		var serverName = "<%=request.getServerName()%>";
	</Script>
	<Script src="../../Library/JavaScript/Sales/ezCarrierAjax.js"></Script>
	<Script>
	
		var MValues = new Array();

		MValues[0] =new EzMList("poNo","PO Number");
		MValues[1] =new EzMList("poDate","PO Date");
		MValues[2] =new EzMList("requiredDate","Req Deliv Date");
		MValues[3] =new EzMList("shipToVal","Ship To");

		function EzMList(fldname,flddesc)
		{
			this.fldname=fldname;
			this.flddesc=flddesc;
		}
		function chk()
		{
			for(c=0;c<MValues.length;c++)
			{
				if(funTrim(eval("document.myForm."+MValues[c].fldname+".value")) == "")
				{
					alert("<%=plzEnter_A%>"+MValues[c].flddesc);
					if(c=="0")
			   			eval("document.myForm."+MValues[c].fldname+".focus()")
					return false;
				}
				fd = eval("document.myForm."+MValues[1].fldname+".value");
				td = eval("document.myForm."+MValues[2].fldname+".value");

				a=fd.split("<%=forkey%>");
				b=td.split("<%=forkey%>");
				
				fd1=new Date(a[2],a[0]-1,a[1])
				td1=new Date(b[2],b[0]-1,b[1])
				
				if(fd1 > td1)
				{
					alert("PO Date date must be less than Req.Deliv. Date");
					return false;
				}				
			}
			return true;
			
		}	
	
	
		function ShowCatalog()
		{
			if(document.myForm.grpNum.value!="")
			{
				document.myForm.ProductGroup.value =  document.myForm.grpNum.value		
				document.myForm.action ="ezCreateSalesOrder.jsp";
				document.myForm.submit();
			}
			else
			{
				alert("Please Select Product Catalog");
			}
		}

		function prepareOrder()
		{
			var gridCount = mygrid.getRowsNum();
			var selectedIds = "";
			var selChkCount =0;
			var prodCodeHTML ="";
			var rowId="";
			
			for(var i=0;i<gridCount;i++)
			{
				if(mygrid.cells(mygrid.getRowId(i),'0').isChecked())	
				{
					if(selectedIds!="")
						selectedIds = selectedIds+","+mygrid.getRowId(i);				
					else
						selectedIds = mygrid.getRowId(i);
						
					rowId = mygrid.getRowId(i);
					
					rowId=rowId.split("¥")
					
					prodCodeHTML += "<input type='hidden' name='prodCode' value='"+rowId[0]+"'>";	
					prodCodeHTML += "<input type='hidden' name='vendCatalog' value='"+rowId[1]+"'>";	
					prodCodeHTML += "<input type='hidden' name='matId' value='"+rowId[2]+"'>";	
					
					selChkCount++; 	
					
					
				}	
				

			}	
			
						
			prodCodeDiv.innerHTML = prodCodeHTML;
			if(chk())
			{
				if(selChkCount>0)
				{
					document.body.style.cursor="wait"
					document.myForm.action="ezAddSalesOrder.jsp"; 
		  			document.myForm.submit();
		  		}
		  		else
		  		{
		  			alert("Please select atlease one Material")
		  			return false;
		  		}	
			}
		}
		
		
		function setBack()
		{
			document.location.replace("../Misc/ezWelcome.jsp");
		}
		
		function selectAll() 
		{
			id = document.myForm.selAllImg.value;
			var gridCount = mygrid.getRowsNum();
			if(id==0)
			{
				document.getElementById('imgCheck').src="../../Images/Grid/item_chk1.gif"
				document.myForm.selAllImg.value = "1";
				for(var i=0;i<gridCount;i++)
				{
					mygrid.cells(mygrid.getRowId(i),'0').setChecked(true);
				}
			}	
			else
			{
				document.getElementById('imgCheck').src="../../Images/Grid/item_chk0.gif"
				document.myForm.selAllImg.value = "0";
				for(var i=0;i<gridCount;i++)
				{
					mygrid.cells(mygrid.getRowId(i),'0').setChecked(false);
				}
			}	
		}
		
		function doOnLoad()
		{
			gridDiv=document.getElementById("gridBase")
			if(gridDiv!=null)
			{
				var selAllChk;
				var headerFlds;
				selAllChk = "<img src='../../Images/Grid/item_chk0.gif' id='imgCheck' onclick='selectAll()' style='cursor:hand' alt='Select/Deselect All'>";
				headerFlds = selAllChk+",Product Code,Product Description,Brand,List Price($),UOM";				
				
				mygrid = new dhtmlXGridObject('gridbox');			
				mygrid.imgURL = "../../Images/Grid/";
				
				mygrid.setHeader(headerFlds);
				mygrid.setNoHeader(false)
				mygrid.setInitWidthsP("5,20,35,20,15,5")
				mygrid.setColAlign("center,left,left,left,right,left")
				mygrid.setColTypes("ch,ro,ro,ro,ro,ro");
				mygrid.setColSorting("str,str,str,str,str,str")
				mygrid.setStyle('background-Color:#000000;font-weight:600;',"","","")
				mygrid.enableBuffering(300);
				mygrid.init();
				mygrid.loadXML("ezMaterialDynload.jsp?ProductGroup=<%=pGroupNumber%>");	 		
			}	
				
		}
		function doOnUnLoad()
		{
			gridDiv=document.getElementById("gridBase")
			if(gridDiv!=null)
			{
				if(mygrid) 
					mygrid=mygrid.destructor();
			}		
		}
		function createGroup()
		{
			document.myForm.action ="../BusinessCatalog/ezAddGroup.jsp";
			document.myForm.submit();
		}
		function addProducts(aGroup,aDesc)
		{
			document.myForm.addProduct.value="Y"
			document.myForm.FavGroup.value=aGroup
			document.myForm.GroupDesc.value=aDesc
			document.body.style.cursor="wait"			
			document.myForm.action ="../DrillDownCatalog/ezDrillDownVendorCatalog.jsp";
			document.myForm.submit();		
		}
		function selShipTo()
		{
			var shipToVal = document.myForm.shipToVal.value
			var shipToValArray = shipToVal.split("¥")
			document.myForm.shipTo.value 	 = shipToValArray[0]
			document.myForm.shipToName.value = shipToValArray[1]
		}
	</Script>
	<Script>
		  var tabHeadWidth=90
		  var tabHeight="45%"
	</Script>
	
</Head>

<Body onLoad="doOnLoad();" onUnLoad="doOnUnLoad()" scroll=no>
<Form method="post" name="myForm">
<input type="hidden" name=ProductGroup value="<%=pGroupNumber%>">
<input type="hidden" name=GroupDesc value="">
<input type="hidden" name=FavGroup value="">
<input type="hidden" name=selAllImg value="0">
<input type="hidden" name=addProduct>
<%
	String display_header = creOrder_L;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<%
	int Rows = ret.getRowCount();
	if(Rows>0)
	{
%>
		<Div id="Base" align=center style="width:100%;">
		<Div  id="HeaderDiv" align=center style="background-color:whitesmoke;width:90%;border:1px solid;border-color:lightgrey;padding:2px;">
		<Table width=100% align=center border=1  borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
		<Tr>
		     	<Th class="labelcell" align="left"><%=poNo_L%></Th>
		        <Td>
				<input type="text" class=InputBox name="poNo" maxlength="20" size="13" value="<%=("null".equals(PONO)||PONO==null)?"":PONO%>">
				<input type="hidden" name="orderDate" value="<%=OrderDate%>">
	       		</Td>
	        	<Th class="labelcell" align="left" ><%=poDate_L%></Th>
	        	<Td nowrap>
	        		<input type="text" class=InputBox name="poDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%=PODate%>">&nbsp;<%=getDateImage("poDate")%>        		
	        	</Td>
	        	<Th class="labelcell" align="left" >Req. Deliv. Date</Th>
			<Td nowrap>
				<input type="text" class=InputBox name="requiredDate" id="requiredDate" readonly onClick="blur()" onFocus="blur()" size="12" value="<%= ("null".equals(REQDate)||REQDate==null)? "" : REQDate%>">&nbsp;<%=getDateImageFromToday("requiredDate")%>				
			</Td>
		</Tr>	
	        	
	     	<Tr>
		<Th class="labelcell" align="left"><%=soldto_L%><input type="hidden" name="orderDate" value="<%=OrderDate%>"></Th>
<%		if(("").equals(SoldTo)||(!sessionAgentCode.equals(SoldTo)))
		{
%>			<Td>
			<select name="soldTo">
			<option value=""><%=selSold_L%></option>
<%			int retSoldCount = retsoldto.getRowCount();
			for(int j = 0;j<retSoldCount;j++)
			{
				String soldToCode = retsoldto.getFieldValueString(0,"EC_ERP_CUST_NO").trim();
				String soldToName = retsoldto.getFieldValueString(0,"ECA_NAME").trim();
				String soldValue  = soldToCode+"¥"+soldToName;
%>	             		<option value ="<%=soldValue%>"><%=soldToName%></option>
<%			}
%>			</select>
			</Td>
<%		}
		else
		{
			out.println("<td>");
			String   soldToCode="",soldToName="";
			int retSoldCount = retsoldto.getRowCount();
			for(int j = 0;j < retSoldCount;j++)
			{
				if(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").equals(SoldTo))
				{
					soldToCode = retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").trim();
					soldToName = retsoldto.getFieldValueString(j,"ECA_NAME").trim();
					String soldValue  = soldToCode+"¥"+soldToName;
					break;
				}
			}//end of for
			out.println(soldToName+"</Td>");
%>			<input type="hidden" name="soldTo" 	value="<%=soldToCode%>">
			<input type="hidden" name="soldToName" 	value="<%=soldToName%>">
<%		}
%>		<Th class="labelcell" align="left"><%=shipto_L%> 
		<input type="hidden" name="carrierName" value="">				 
		</Th>
<%		if(!("").equals(SoldTo))
		{
			java.util.Set shipToSet = new java.util.HashSet();
			for(int k = 0 ;k < listShipTos.getRowCount();k++)
			{
				shipToSet.add(listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim());
			}
		
			if(shipToSet.size()>1)
			{
				
%>				<Td>
				<select name="shipToVal" onchange='selShipTo()'>
				<option value=""><%=selShip_L%></option>
<%				for(int k = 0 ;k < shipToSet.size();k++)
				{
					String shipToNo   = listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim();
					String shipToName = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					String shipVal 	  = shipToNo+"¥"+shipToName;
					//if(!shipToSet.contains(shipToNo))
					//{
%>						<option value="<%=shipVal%>"><%=shipToName%></option>
<%						//shipToSet.add(shipToNo);		
					//}

				}				
%>				</select>
				<input type="hidden" name="shipTo">
				<input type="hidden" name="shipToName">
	      			</Td>
<%			}
			else //end of if row count
			{
%>				<Td>
<%				String name = "";
				for(int k = 0;k < listShipTos.getRowCount();k++)
				{
					name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					out.println("<input type='hidden' name='shipToName' value='"+name+"'>");
					out.println(name);
				}
				String shipTo = listShipTos.getFieldValueString(0,"EC_PARTNER_NO").trim();
				String shipToValue = shipTo+"¥"+name;
%>				<input type="hidden" name="shipTo" value="<%=shipTo%>">
				<input type="hidden" name="shipToVal" value="<%=shipTo%>">

				</Td>
<%			}
			
		}
		else
		{	//end of if soldto not null
%>			<Td><%=plzSelSoldTo_L%></Td>
<%		}
%>		<!-- <Th class="labelcell" align="left" >Carrier Name</Th>
			<Td nowrap>
				<input type="text" class=InputBox name="carrierName" id="carrierName" size="18" value="<%=carrierName%>" onBlur="SendQuery(this.value,'O');" onKeyUp="SendQuery(this.value,'I');"  autocomplete="off">				 
			</Td> -->
			
			
		<Th class="labelcell" align="left" >Shipping Type</Th>
			<Td nowrap>
				<Select name =shippingType style="width:100%" id=FullListBox>
				<option value="">-select-</Option>
<%
				while(enum1S.hasMoreElements())
				{
					enum1Key = (String)enum1S.nextElement();
					enum1Desc = (String)ezShippingTypes.get(enum1Key);
					if(shippingTypeDesc[0].equals(enum1Key))
					{
%>						<option value="<%=enum1Key+"#"+enum1Desc%>" selected><%=enum1Desc%></Option>
<%	               		         }
					else
					{
%>						<option value="<%=enum1Key+"#"+enum1Desc%>"><%=enum1Desc%></Option>
<%					}
				}
%>            			</select>
			</Td>
			
			
	     	</Tr>

	     	<Tr>
		<Th width =50% class="labelcell" align="left" colspan=3>Personalized Catalog</th>
				<Td width =50% nowrap colspan=3>
				<Div id="ListBoxDiv1">
				<select  name ="grpNum" style="width:100%" id=CalendarDiv onChange="ShowCatalog()">
				<option value="" selected>-Select-</option>
<%		
				String GroupNum="", GroupDescription="";
				for (int i = 0;i<Rows;i++)
				{
					GroupNum 	 = (String)ret.getFieldValue(i,PROD_GROUP_NUMBER);
					GroupDescription = (String)ret.getFieldValue(i,PROD_GROUP_WEB_DESC);
					if(GroupNum.equalsIgnoreCase(pGroupNumber))
					{
%>						<option value="<%=GroupNum%>" selected><%=GroupDescription%></option>
<%					}
					else
					{
%>						<option value="<%=GroupNum%>"><%=GroupDescription%></option>
<%					}
				}
%>				</select>
				</Div>
			</td>
	     </Tr>
</Table>


















	
		</Div></Div> 
		
<%	
		if(pGroupNumber!=null)
		{
%>			<Div id="gridBase" align=center style="width:100%;">
				<Div  id="GridBoxDiv" align=center style="background-color:whitesmoke;width:90%;border:1px solid;border-color:lightgrey;padding:2px;">
					<Div id="gridbox" height="300px" width="100%" style="overflow:hidden;visibility:hidden;"></Div>	
				</Div>		
				<Div id="dataRetrieve" width="100%" height="40px" style="overflow:hidden;visibility:visible;position:absolute;top:40%;left:2%">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/ImagesGrid/loading.gif"/></Td>
						</Tr>
					</Table>
				</Div> 
				<Div id="NoData" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:30%;left:2%">
					<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='center'><br><b>No Catalogs to list</b></Td>
						</Tr>
					</Table>
				</Div> 
				<Div id="ServerBusy" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:35%;left:2%">
					<Table align=center height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
						<Tr>
							<Td style="background:transparent" align='right'><img border=0 src="../../Images/sbusy.gif" ></Td>
							<Td style="background:transparent" align='center'><font color="CC0000"><b>Server is Busy,Please try after some time</b></font></Td>
						</Tr>
					</Table>
				</Div> 
			</Div>

			<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:93%">
			<center>
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Prepare Order");
				buttonMethod.add("prepareOrder()");
				
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>
			</center>
			</Div>
<%
		}
		else
		{
%>			<br><br><br><br>
			<Table align=center border=0 >
			<Tr>
				<Td class=displayalert  valign=middle align=center>
					Please select Catalog
				</Td>
			</Tr>
			</Table>
			<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:85%">
			<center>
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>
			</center>
			</Div>
<%
		}
	}
	else
	{
		if(retprodfavCount>0)
		{
%>			<br><br><br><br>
			<Table align=center border=0 >
				<Tr>
					<Td class=displayalert  valign=middle align=center>						
						No Products in your Custom Groups<br>
						Please click on "Add Products" to Add Products in your Custom Groups.						
					</Td>
				</Tr>
			</Table>
			<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:85%">
			<center>
<%
				String epg_no   = retprodfav.getFieldValueString(0,"EPG_NO");
				String epg_desc = retprodfav.getFieldValueString(0,"EPGD_DESC");
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Add Products");
				buttonMethod.add("addProducts(\""+epg_no+"\",\""+epg_desc+"\")");
				
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>			</center>
			</Div>
<%		}
		else
		{
%>			<br><br><br><br>
			<Table align=center border=0 >
				<Tr>
					<Td class=displayalert  valign=middle align=center>
						You don't have any Personalized Catalogs created.<br> 
						Please click on "Create Personalized Catalog" to create
					</Td>
				</Tr>
			</Table>
			<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:85%">
			<center>
<%
				buttonName = new java.util.ArrayList();
				buttonMethod = new java.util.ArrayList();
				
				buttonName.add("Create Personalized Catalog");
				buttonMethod.add("createGroup()");
				
				//buttonName.add("Back");
				//buttonMethod.add("setBack()");
				out.println(getButtonStr(buttonName,buttonMethod));
%>			</center>
			</Div>
<%		}
	}
%>
<Div id="MenuSol"></Div> 
<Div id="prodCodeDiv" ></DIV>
