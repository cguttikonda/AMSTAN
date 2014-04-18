<%!
	public String funSubStr(String str)
	{
		 int index;
		 String substr = "";
		 index=str.indexOf(".");
		 if(index!=-1)
		 substr=str.substring(0,index);
		 return substr;
		 
	}
	
%>

<%
     	ezc.ezcommon.EzLog4j log4j = new ezc.ezcommon.EzLog4j(); 
	String[] prodUnitQty= new String[cartcount];
	String[] prodCaseLot= new String[cartcount];
	Hashtable selectdMet =(Hashtable)session.getAttribute("SELECTEDMET");

	log4j.log("selectdMetselectdMetselectdMet:"+selectdMet,"W");

	if(cartcount > 0)
	{
   		for(int i=0;i<cartcount;i++)
   		{
   			if(session.getAttribute("SELECTEDMET")!=null)
   			{
     				String metGroup=(String)selectdMet.get(Cart.getMaterialNumber(i));

   				java.util.StringTokenizer stoken=new java.util.StringTokenizer(metGroup,"¥");
   				metGroup=(String)stoken.nextElement();
				try
				{
					prodCaseLot[i]=(String)stoken.nextElement();
   					prodUnitQty[i]=(String)stoken.nextElement();
				}catch(Exception e){
					prodUnitQty[i]="0";
				}
			}
			String prodCode = Cart.getMaterialNumber(i);
			prodCode	= prodCode.trim();
			String prodDesc = Cart.getMaterialDesc(i);
			String vendorCatalog =Cart.getVendorCatalog(i);
			String matId  = Cart.getMatId(i);
			String mfrNr  = Cart.getBrand(i);
			String eanupc = Cart.getUPCNumber(i); 
			
			prodDesc=prodDesc.replace('\'',' ');
			prodDesc=prodDesc.replace('\"',' ');
			String prodUom  = Cart.getUOM(i);
			String prodcaseLot =prodCaseLot[i];
			String prodDate ="" ;
			String prodQty	= Cart.getOrderQty(i);
			String tPCode="";
			String itemBrand=Cart.getBrand(i);
			String itemListPrice=Cart.getUnitPrice(i);
			
			
			prodQty	= funSubStr(prodQty);
			
			
			String prodUQ	= prodUnitQty[i].trim();	
			String d	= Cart.getReqDate(i);
			if( d.equals("1.11.1000") )	//please dn't remove this hard codded value as it has many referencess in many files 
				prodDate =FormatDate.getStringFromDate(new Date(),".",FormatDate.DDMMYYYY) ;
			else
		            prodDate =d ;  
		
			prodQty =((prodQty == null) || ("0").equals(prodQty)) ?"":prodQty;
			prodDate=(prodDate == null) ?"":prodDate;
			
			
               	
        		String a = "";
		        try{
        			a=Integer.parseInt(prodCode)+"-->"+prodDesc;
           		}catch(Exception e)
		        {
           			a=prodCode +"--->"+prodDesc;
           		}
           		
           		try
           		{
           		    tPCode =Integer.parseInt(prodCode)+"";
           		}
           		catch(Exception e)
           		{
           		    tPCode = prodCode;
           		}

			if(session.getAttribute("getprices")==null)
	  		{
%>
				<tr align="center">
					<Td width="5%" 	 align="left" title="<%= a %>"><input type='checkbox' name='chk' value='<%=prodCode%>'></Td>
					<Td width="15%"  align="left" title="<%= a %>">&nbsp;<%=tPCode%></Td>
					<Td width="30%"  align="left" title="<%= a %>">&nbsp;
						<%=prodDesc%>
						<input type="hidden" name="prodDesc" value="<%=prodDesc%>">
						<input type="hidden" name="product" value="<%=prodCode%>">
						<input type="hidden" name="desiredDate" value="<%= prodDate%>">
						<input type="hidden" name="pack" value="<%= prodUom %>">
						<input type="hidden" name="del_sch_qty" value="0">
						<input type="hidden" name="del_sch_date">
						<input type="hidden" name="UomQty" value="<%= prodUnitQty[i] %>">
						<input type="hidden" name="ItemCat" value="">
						<input type="hidden" name="desiredPrice"  value="0">
						<input type="hidden" name="commitedQty" value="0" >
						<input type="hidden" name="lineValue" value="0" >
						<input type="hidden" name="prodsForDelete" value=''>
						<input type="hidden" name="datesForDelete" value=''>
						<input type="hidden" name="qtysForDelete" value=''>
						<input type="hidden" name="vendorCatalog" value="<%=vendorCatalog%>">
						<input type="hidden" name="matId" value="<%=matId%>">
						<input type="hidden" name="mfrNr" value="<%=mfrNr%>">
						<input type="hidden" name="eanupc" value="<%=eanupc%>">
						
					</Td>
					<Td width="20%" align=center>&nbsp;<%=itemBrand%></Td>
					<Td width="10%" align=center>&nbsp;<%=itemListPrice%></Td>
					<Td width="7%" align=center>&nbsp;<%=prodUom%></Td>
					<Td width="13%" nowrap align=left><input type="text" class=InputBox size="10" maxlength="15" STYLE="text-align:right" name="desiredQty" tabIndex="<%=i+1%>"  onBlur=verifyQty(this,'<%=prodcaseLot%>','<%=prodCode%>') value="<%=prodQty%>"></Td>
				</tr>
<%			}
			else
			{
%>				<tr>
<%				String RefDocItem ="";
				String pric="";
				if( (SCDocNr != null) && (!"null".equals(SCDocNr)) && (SCDocNr.trim().length() !=0) && (session.getAttribute("itemNo") != null) )
				{
					Hashtable itemNo = (Hashtable)session.getAttribute("itemNo");
					StringTokenizer stpro = new StringTokenizer((String)itemNo.get(prodCode),",");	
					try{
						RefDocItem = stpro.nextToken();
						pric=stpro.nextToken();
					}catch(Exception e){out.println(e);}	
					if(RefDocItem == null)
					RefDocItem = "";
				}else
				{
					 pric = (String)getprices.get(prodCode);	
				}
				String foc="";//(String)getFOC.get(prodCode);
				foc="0";//( foc==null || "null".equals(foc)||foc.trim().length()=0)?"0":foc;
				pric=(pric==null||"null".equals(pric)||pric.trim().length()==0 || "NAN".equals(pric))?"0":pric;

				java.math.BigDecimal bUprice = new java.math.BigDecimal(pric);
				java.math.BigDecimal bPrice = null;
				java.math.BigDecimal bQty = new java.math.BigDecimal(prodQty.toString());
				bPrice = bQty.multiply(bUprice);
				grandTotal=new Double(grandTotal.doubleValue()+bPrice.doubleValue());
				String priceCurr = myFormat.getCurrencyString(bUprice.doubleValue());
				String valueCurr = myFormat.getCurrencyString(bPrice.doubleValue());	
%>
				<Td width="30%" align="left" title="<%=a%>">
					&nbsp;<input type="text" name="prodDesc" size="29" class="tx" readonly value="<%=prodDesc%>">
					<input type="hidden" name="lineValue" value="<%= bPrice %>" >
					<input type="hidden" name="product" value="<%= prodCode%>">
					<input type="hidden" name="desiredPrice"  value="<%=bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP)%>">
					<input type="hidden" name="desiredQty" value="<%=prodQty %>" > 
					<input type="hidden" name="desiredDate" value="<%=requiredDate%>">
					<input type="hidden" name="refDocItem" value="<%= RefDocItem %>">
					<input type="hidden" name="pack" value="<%= prodUom %>">
					<input type="hidden" name="ItemCat" value="">
					<input type="hidden" name="vendorCatalog" value="<%=vendorCatalog%>">
				</Td>
				<Td width="6%" align="left">&nbsp;<%=prodUom%> <input type="hidden" name="uom" value="<%=prodUom%>"></Td>
				<Td width="14%" align="right"><input type="hidden" name="del_sch_qty" value="<%=prodQty%>"><%=myFormat.getCurrencyString(prodQty)%>
					<input type="hidden"  name="focVal" >
				</Td>
				<Td width="16%" align="right">
<% 				if(bUprice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
                		{
					out.println("&nbsp;");	
				}
				else
				{
					out.println(priceCurr);
				}
%>				</Td>
				<Td width="16%" align="right">
<% 				if(bPrice.setScale(2,java.math.BigDecimal.ROUND_HALF_UP).doubleValue()==0)
				{
					out.println("&nbsp;");
				}
				else
				{
					out.println(valueCurr);
				}
%>				</Td>
				<Td width="18%" align="center"  id="DesiredDate[<%=i%>]" >
					<input type="hidden" name="del_sch_date" value="<%=requiredDate%>" >
					<a name="DD_<%= i %>" href="JavaScript:void(0)" onClick='openNewWindow("ezAddDatesEntry.jsp?ind=<%= i %>&unitQty=<%=prodUQ%>","<%=i%>")'>
<% 					if(i == 0) 
					{
%>						<span id="selectG" style="display:''"><%=requiredDate%></span>
<% 					}else{
%>						<%=requiredDate%>
<%					}
%>					</a>
				</Td>
<%			}
%>		</tr>
<%		}
   	}
	else
	{
		if(session.getAttribute("getprices")==null)
		{
			out.println("<Tr><Td colspan='5' align='center'>"+noItemsCart_L+"</Td></Tr>");
		}
		else
		{
			out.println("<Tr><Td colspan='6' align='center'>"+noItemsCart_L+"</Td></Tr>");
		}
		
	}
%>