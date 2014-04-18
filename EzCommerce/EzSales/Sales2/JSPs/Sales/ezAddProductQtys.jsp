<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%@ include file="../../Library/Globals/ezCheckValidUser.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iPlaceOrder_Lables.jsp"%>
<%@ include file="../../../Includes/JSPs/Lables/iTermsConditions_Lables.jsp"%>
<%@ page import = "ezc.ezutil.FormatDate,java.util.*" %>
<%@ include file="ezGetProducts.jsp"%>
<%
	int cartcount=0;
	if(Cart != null)
		cartcount= Cart.getRowCount();

	String PONO 		  = request.getParameter("poNo");
	String PODate 		  = request.getParameter("poDate");
	String requiredDate 	  = request.getParameter("requiredDate");
	String ShipToValue	  = request.getParameter("shipTo");
	String SoldToName  	  = request.getParameter("soldToName");

	StringTokenizer shipTo_St = new StringTokenizer(ShipToValue,"¥");
	log4j.log("shipTo_StshipTo_StshipTo_StshipTo_StshipTo_StshipTo_St4"+ShipToValue,"W");

	String ShipTo="",ShipToName="";
	while (shipTo_St.hasMoreTokens()) 
	{
		ShipTo     = shipTo_St.nextToken();
		ShipToName = shipTo_St.nextToken();
	}
	log4j.log("shipTo_StshipTo_StshipTo_StshipTo_StshipTo_StshipTo_St5"+shipTo_St,"W");


	if(session.getAttribute("getprices")==null)
	{
%>		<%@ include file="../../../Includes/JSPs/Sales/iGetMaterials.jsp" %>
<%
		Hashtable selMet= new Hashtable();
		if(cartcount>0)
		{
			int tMetCount=retpro.getRowCount();
	    		for(int i=0;i<cartcount;i++)
	    		{
				for(int m=0;m<tMetCount;m++)
				{
					if((Cart.getMaterialNumber(i)).equals(retpro.getFieldValueString(m,"MATNO")))
					{
						String Upc_No = retpro.getFieldValueString(m,"UPC_NO");
						if(Upc_No!=null)
							Upc_No = Upc_No.trim();
						selMet.put(retpro.getFieldValueString(m,"MATNO"),retpro.getFieldValueString(m,"GROUP_ID")+"¥"+Upc_No);						
					}
				}
	    		}
		}		
		session.putValue("SELECTEDMET",selMet);
	}	
%>	
<Html>
<Head>
<Title>Create Sales Order -- Powered by Answerthink Ind Ltd</Title>
	<%@ include file="../../../Includes/JSPs/Misc/iShowCal.jsp"%>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>		
	<Script>
		function getPrices()
		{
			document.body.style.cursor="wait"
			document.myForm.action="ezPreSaveSalesOrder.jsp";
		  	document.myForm.submit();
		}
		function setBack()
		{
			history.go(-1);
		}
	</Script>	
</Head>

<Body scroll=no>
<Form name="myForm" method="post">
<input type="hidden" name="cartCount" value="<%=cartcount%>">
<%
	String display_header = COrderFor_L+" "+SoldToName;
%>
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
	<Div id="div1" align="center" style="visibility:visible;width:100%">
	<Table width='80%' valign='top'  align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0 >
	     <Tr>
			<th class="labelcell" align="left"><%=pono_L%></th>
			<td><input type="hidden" name="poNo"  value="<%=PONO%>"><%=PONO%></td>
			<th class="labelcell" align="left"><%=podate_L%></th>
			<td><input type="hidden" name="poDate" value="<%=PODate%>"><input type="hidden" name="orderDate" value="<%=PODate%>"><%=PODate%></td>
			<th class="labelcell" align="left"><%=rDate_L%></th>
			<td><input type="hidden" name="requiredDate" value="<%=requiredDate%>"><%=requiredDate%></td>
	     </Tr>
	     <Tr>
			<Th class="labelcell" align="left"><%=soldto_L %> </Th>	
			<Td>
				<input type="hidden" name="soldTo" value="<%=SoldTo%>">
				<input type="hidden" name="soldToName" value="<%=SoldToName%>">
				<%=SoldToName%>
			</Td>
			<Th class="labelcell" align="left"><%=shipto_L%></Th>
				<Td colspan=3>
				<input type="hidden" name="shipTo" value="<%=ShipTo%>">
				<input type="hidden" name="shipToName" value="<%=ShipToName%>">
				<%=ShipToName%>
			</Td>
	     </Tr>
	</Table>
	</Div>		
	<Div id='theads'>
	<Table width='85%' id='tabHead' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
	<Tr align="center" valign="middle">
		<Th width="15%" valign="top" nowrap>Product Code</Th>
		<Th width="30%" valign="top" nowrap>Product Desc</Th>
		<Th width="10%" valign="top"><%=uom_L%></Th>
		<Th width="15%" valign="top"><%=qty_L%>[Case Lot]</Th>
	</Tr>
	</Table>
	</Div>
	<Div id='InnerBox1Div' style='overflow:auto;position:absolute;width:100%;height:45%;'>
	<Table id='InnerBox1Tab' width='85%' align=center border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0>
<%	
	   for(int i=0;i<cartcount;i++)
	   {
	   	    String matCode 	= Cart.getMaterialNumber(i);
		    String prodDesc 	= Cart.getMaterialDesc(i);
		    prodDesc		= prodDesc.replace('\'',' ');
		    prodDesc		= prodDesc.replace('\"',' ');
		    String prodUom 	= Cart.getUOM(i);		    
		    String matQty	= Cart.getOrderQty(i);			    
		    String reqDate	= Cart.getReqDate(i);
		    String matDate 	="";
		    String toolTip 	="";
		    
		   
		   String prodCaseLot= "";
		   
		   Hashtable selectdMet =(Hashtable)session.getAttribute("SELECTEDMET");
		   if(selectdMet!=null)
		   { 				
			String metGroup=(String)selectdMet.get(matCode);
     			java.util.StringTokenizer stoken=new java.util.StringTokenizer(metGroup,"¥");
   			metGroup=(String)stoken.nextElement();
   			log4j.log("RameshRameshRameshRameshRameshRamesh2"+metGroup,"W");
   			try
			{
				prodCaseLot=(String)stoken.nextElement();
   			}
   			catch(Exception e){}
		   }
		   if(reqDate.equals("1.11.1000"))
		    	matDate =FormatDate.getStringFromDate(new Date(),".",FormatDate.MMDDYYYY) ;
		   else
	            	matDate =reqDate;  
	            	
	           matQty	=((matQty == null)||("0").equals(matQty))?"":matQty;
		   matDate	=(matDate == null)?"":matDate;			    
        	   try{
        		toolTip=Integer.parseInt(matCode)+"-->"+prodDesc;
           	   }catch(Exception e)
           	   {
           		toolTip  = matCode+"-->"+prodDesc;
           	   }    
%>
		   <Tr align="center">
		    		<Td width="15%" align="left" title="<%=toolTip%>"><%=matCode%>&nbsp;
				<Td width="30%" align="left" title="<%=toolTip%>"><%=prodDesc%>&nbsp;

					<input type="hidden" name="prodDesc" value="<%=prodDesc%>">
					<input type="hidden" name="product" value="<%=matCode%>">
					<input type="hidden" name="desiredDate" value="<%=matDate%>">
					<input type="hidden" name="pack" value="<%=prodUom%>">
					<input type="hidden" name="del_sch_qty" value="0">
					<input type="hidden" name="del_sch_date">
					<input type="hidden" name="ItemCat" value="">
					
				</Td>
				<Td width="10%"  align="center"><%=prodUom%>&nbsp;</Td>
				<Td width="15%" align="center" nowrap>
					<input type="text" class=InputBox size="10" maxlength="15" style="text-align:right" name="desiredQty" value="<%=matQty%>">&nbsp;[<%=prodCaseLot%>]
				</Td>
		    </Tr>
<%	   }
%>
	</Table>
	</Div>
	
	<Div id="buttonDiv"  style="position:absolute;left:0%;width:100%;top:93%">
	<center>
<%
			buttonName = new java.util.ArrayList();
			buttonMethod = new java.util.ArrayList();
			buttonName.add("Back");
			buttonMethod.add("setBack()");
			buttonName.add("Get Prices");
			buttonMethod.add("getPrices()");	
			out.println(getButtonStr(buttonName,buttonMethod));

%>	</center>
	</Div>

</Form>
<Div id="MenuSol"></Div>
</Body>
</Html>

