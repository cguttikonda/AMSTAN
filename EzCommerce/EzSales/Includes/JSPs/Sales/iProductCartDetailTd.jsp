<%

log4j.log("RameshRameshRameshRameshRameshRameshsessiongetValuesgetValuesgetValues"+session.getAttribute("getValues"),"W");

log4j.log("cartcountcartcount:"+cartcount,"W");

if(cartcount > 0)
{
   for(int i=0;i<cartcount;i++)
   {		
	String prodCode	     = Cart.getMaterialNumber(i);
	String prodDesc      = Cart.getMaterialDesc(i);
	String vendorCatalog = Cart.getVendorCatalog(i);
	String matId	     = Cart.getMatId(i);
	String mfrNr         = Cart.getBrand(i);
	String eanupc        = Cart.getUPCNumber(i);
	
	
	prodDesc	= prodDesc.replace('\'',' ');
	prodDesc	= prodDesc.replace('\"',' ');
		
	String prodUom 	= Cart.getUOM(i);
	String prodDate = "" ;
	String prodQty	= "";	
	String produpcNo= upcNo[i];
	if("".equals(produpcNo) || produpcNo==null)
		produpcNo="1";
	String d=Cart.getReqDate(i);
	if( d.equals("1.11.1000") )//please dn't remove this hard codded value as it has many referencess in many files 
	prodDate =FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) ;
	else
            prodDate =d ;  

	prodQty = Cart.getOrderQty(i);
	
	if( (prodQty == null) || ("0").equals(prodQty)) 
               	prodQty= "";	
	if( prodDate == null) 
               	prodDate= "";	
               	
        String minQ =(String)selMet.get(Cart.getMaterialNumber(i));
	if(minQ == null || "".equals(minQ)|| "null".equals(minQ))
		minQ="1";    
		
	try
	{
		prodQty = prodQty.substring(0,prodQty.indexOf('.'));
	}
	catch(Exception e)
	{ 
	}
	String tPNo= "";
	try
	{
		tPNo = Integer.parseInt(prodCode)+"";
	}
	catch(Exception e)
	{ 
		tPNo = prodCode;
	}
	
	String a = "";
	try{
		a=Integer.parseInt(prodCode)+"-->"+prodDesc;
	}catch(Exception e)
	{
		a=prodCode +"--->"+prodDesc;
	}
	log4j.log("prodQtyprodQtyprodQtyprodQtyprodQtyprodQtyprodQty"+prodQty,"W");

%>
	<%if(session.getAttribute("getprices")==null)
	  {
	  
  %>
	<Tr align="center">
		<Td width="5%" 	 align="left" title="<%= a %>"><input type='checkbox' name='chk' value='<%=prodCode%>'></Td>
		<Td width="15%" align="left">&nbsp;<%=tPNo%></Td>
		<Td width="30%"  align="left">&nbsp;
				<%=prodDesc%>
				<input type="hidden" name="prodDesc" value="<%=prodDesc%>">
				<input type="hidden" name="waste" value="<%=prodDesc%>">
				<input type="hidden" name="product" value="<%=prodCode%>">
				<input type="hidden" name="desiredDate" value="<%= prodDate%>">
				<input type="hidden" name="pack" value="<%=prodUom%>">
				<input type="hidden" name="produpcNo" value="<%=produpcNo.trim()%>">
				<input type="hidden" name="vendorCatalog" value="<%=vendorCatalog%>">
				<input type="hidden" name="matId" value="<%=matId%>">
				<input type="hidden" name="mfrNr" value="<%=mfrNr%>">
				<input type="hidden" name="eanupc" value="<%=eanupc%>"> 
				
		</Td>
		<Td width="20%" align="center">&nbsp;<%=Cart.getBrand(i)%></Td>
		<Td width="10%" align="right">&nbsp;<%="$"+Cart.getUnitPrice(i)%></Td>
		<Td width="7%" align="center">&nbsp;<%=prodUom%></Td>
		<Td width="13%" align="left" ><input type="text" class=InputBox size="8" maxlength="10" STYLE="text-align:right" name="desiredQty" tabIndex="<%=i+1%>" onBlur='verifyField(this,"Quantity");verifyQty1(this,"<%=minQ.trim()%>","<%=prodDesc.trim()%>")'  value="<%=prodQty%>"></Td>
	</Tr>
	<%}else{%>
	<Tr>
		
		
		<%
		String RefDocItem ="";
		String pric="";
		if( (SCDocNr != null) && (!"null".equals(SCDocNr)) && (SCDocNr.trim().length() !=0) && (session.getAttribute("itemNo") != null) )
		{
			Hashtable itemNo = (Hashtable)session.getAttribute("itemNo");
			StringTokenizer stpro = new StringTokenizer((String)itemNo.get(prodCode),",");	
			try{
				RefDocItem = stpro.nextToken();
				pric=stpro.nextToken();
			//out.println("RefDocItem"+RefDocItem+"****pric"+pric);
			}catch(Exception e){out.println(e);}	
			if(RefDocItem == null)
				RefDocItem = "";
		}else
		{
			 pric = (String)getprices.get(prodCode);
			///out.println("pric"+pric);
		}
		String foc="";//(String)getFOC.get(prodCode);
		
		foc=((foc==null)||(("").equals(foc))||(("null").equals(foc))||(foc==""))?"0":foc;
		pric=((pric==null)||(("").equals(pric))||(("null").equals(pric))||(pric==""))?"0":pric;


		java.math.BigDecimal bUprice = new java.math.BigDecimal( pric );
		java.math.BigDecimal bPrice = null;
		java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());
		bPrice = bQty.multiply(bUprice);
		ezc.ezbasicutil.EzCurrencyFormat myFormat = new	ezc.ezbasicutil.EzCurrencyFormat();
		String priceCurr = myFormat.getCurrencyString(bUprice.doubleValue());
		String valueCurr = myFormat.getCurrencyString(bPrice.doubleValue());
		%>
		<Td width="30%" align="left" title="<%=prodDesc%>---><%= prodCode%>" >
			&nbsp;<input type="text" name="prodDesc" size="30" class="tx" readonly value="<%=prodDesc%>">
			<input type="hidden" name="lineValue" value="<%= bPrice %>" >
			 <input type="hidden" name="desiredPrice"  value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
			<input type="hidden" name="desiredQty" value="<%=prodQty %>" > 
			<input type="hidden" name="desiredDate">
			<input type="hidden" name="refDocItem" value="<%= RefDocItem %>">
<!-- value="=prodDate " -->
		</Td>
		<Td width="6%" align="left">&nbsp;<%=prodUom%> <input type="hidden" name="pack" value="<%=prodUom%>">
		
		<input type="hidden" name="vendorCatalog" value="<%=vendorCatalog%>">
		<input type="hidden" name="matId" value="<%=matId%>"> 
		
		</Td>
		
		<Td width="14%" align="right"><input type="hidden" name="del_sch_qty" value="<%=prodQty%>"><%=myFormat.getCurrencyString(prodQty)%>
		<input type="hidden"  name="focVal" >
		</Td>
		 <!--<Td width="8%" align="right" nowrap><input type="text" class=InputBox size="4" maxlength="2" STYLE="text-align:right" name="focVal" tabIndex="<%=i+2%>" onBlur='verifyField(this,"focVal")'> % </Td> -->
		
		<%if("CM".equals(UserRole)){%>
		
			<Td width="10%" align="right">
				<% if(bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
				   {
						out.println("&nbsp;");	
				   }else
				   {
						out.println(priceCurr);
				   }
			    %>
			</Td>
			<Td width="13%" align="right">
				 <% if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
				    {
						out.println("&nbsp;");
				    }else
				    {
						out.println(valueCurr);
				    }
				  %>

			</Td>
			<Td width="13%" align="center"  id="DesiredDate[<%=i%>]" class=labelcell>
				<input type="hidden" name="del_sch_date">

				<a name="DD_<%= i %>" href="JavaScript:void(0)" onClick='openNewWindow("ezAddDatesEntry.jsp?ind=<%= i %>","<%=i%>")'>
				<% if(i == 0) {%>
				<span id="selectG" style="display:''"><img src="../../Images/Buttons/<%= ButtonDir%>/select.gif" style="cursor:pointer;cursor:hand" border="none"></span>
				<% }else{%>
					select
				<%}%>
				</a>
			</td>
			<Td width="6%"  align=center><a style="text-decoration:none"  class=subclass href='Javascript:showATP(<%= i+1 %>)' ><img src="../../Images/Buttons/<%= ButtonDir%>/atp.gif" border="none" valign="center" ></a></td>
		<%}else{%>
				<Td width="11%" align="right">
					<% if(bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
					   {
							out.println("&nbsp;");	
					   }else
					   {
							out.println(priceCurr);
					   }
				    %>
				</Td>
				<Td width="15%" align="right">
					 <% if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
					    {
							out.println("&nbsp;");
					    }else
					    {
							out.println(valueCurr);
					    }
					  %>

				</Td>
				<Td width="16%" align="center"  id="DesiredDate[<%=i%>]" class=labelcell>
					<input type="hidden" name="del_sch_date">

					<a name="DD_<%= i %>" href="JavaScript:void(0)" onClick='openNewWindow("ezAddDatesEntry.jsp?ind=<%= i %>","<%=i%>")'>
					<% if(i == 0) {%>
					<span id="selectG" style="display:''"><img src="../../Images/Buttons/<%= ButtonDir%>/select.gif" style="cursor:hand" border="none"></span>
					<% }else{%>
						select
					<%}%>
					</a>
				</td>
		<%}%>			
	</Tr>

	<%}%>
<%
   }//end of for loop
}else     //end of if prodCode.length != 0
{
	
	
	if(session.getAttribute("getprices")==null)
	{
		//out.println("<Tr><Td colspan='5' align='center'>"+noItemsCart_L+"</Td></Tr>");
%>
		<Tr><Td colspan='5' align='center'>This order contains invalid product codes</Td></Tr>
<%
	}
	else
	{
		out.println("<Tr><Td colspan='6' align='center'>"+noItemsCart_L+"</Td></Tr>");
	}
	
}


%>
