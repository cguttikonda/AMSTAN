<%
	String[] shippingTypeDesc	= new String[2];
	String shippingType 		= request.getParameter("shippingType");
		
	if("null".equals(shippingType)||shippingType==null ||"".equals(shippingType)|| shippingType=="")
	{
		shippingTypeDesc[0]="05";
		shippingTypeDesc[1]="Truck";
	}
	else
	{ 
		shippingTypeDesc	= shippingType.split("#"); 	

	}

	Enumeration enum1S =  ezShippingTypes.keys();
	String enum1Key=null;
	String enum1Desc=null;
	
	String mBack 	      = request.getParameter("mBack");
	String pono_porder    = (String)session.getAttribute("pono_porder");
	String reqdate_porder = (String)session.getAttribute("reqdate_porder");
	String carname_porder = (String)session.getAttribute("carname_porder");
	java.util.HashSet shipToSet = new java.util.HashSet(); 
	if(mBack != null && !"null".equals(mBack) && "C".equals(mBack))
	{}
	else if( pono_porder == null ||  pono_porder.equals("null") || "null".equals(pono_porder) )
	{}
	else
		PONO = pono_porder;
		
	if(mBack != null && !"null".equals(mBack) && "C".equals(mBack))
	{	
		reqdate_porder = REQDate;	
	}
	else if( reqdate_porder == null ||  reqdate_porder.equals("null") || "null".equals(reqdate_porder) )
	{
		reqdate_porder = "";	
	}
	
	if(mBack != null && !"null".equals(mBack) && "C".equals(mBack))
	{}
	else if( carname_porder == null ||  carname_porder.equals("null") || "null".equals(carname_porder) )
	{}
	else
		carrierName = carname_porder;	


%>

<%
	String display_header = ""; 
	
	if(("S").equals( RefDocType ))
		display_header="Create Sales Order for Ag.No:"+SCDoc;
	else
	        display_header=creOrder_L;
	
%>
<%@ include file="../../../Sales2/JSPs/Misc/ezDisplayHeader.jsp"%>

<Div style="width:100%;">
<Table  align="center" valign="top" style="width:90%;" align=center border=0 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
      <Tr> 
      		<th class="labelcell" align="left"><%=poNo_L%></th>
      		<td><input type="text" class=InputBox name="poNo" value="<%=PONO%>" maxlength="20" size="15"></td>
      		<th class="labelcell" align="left"><%=poDate_L%></th>
        	<td><input type="text" class=InputBox name="poDate" value="<%=PODate%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImage("poDate")%></td>
      		<th class="labelcell" align="left">Req.Deliv.Date</th>
      		<td><input type="text" class=InputBox name="requiredDate" value="<%=reqdate_porder%>" readonly onClick="blur()" onFocus="blur()" size="12"><%=getDateImageFromToday("requiredDate")%></td>
      </Tr>
      <Tr>
 		<th class="labelcell" align="left"><%=soldto_L%><input type="hidden" name="orderDate" value="<%=OrderDate%>"></th>
<%
		if(!("S").equals( RefDocType ))
		{

			if(BackOrder!=null && !"null".equals(BackOrder) && !"".equals(BackOrder) && "Y".equals(BackOrder))
			{

				out.println("<td>");
				String   name="";
				for(int j=0;j<retsoldto.getRowCount();j++)
				{	
					if(retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO").trim().equals(SoldTo))
					{
						name = retsoldto.getFieldValueString(j,"ECA_NAME").trim();
						out.println("<input type='hidden'  name='soldTo' value='"+SoldTo+"'>");
						out.println("<input type='hidden'  name='soldToName' value='"+name+"'>");
						break;
					}

				}//end of for
				out.println(name+"</Td>");
			
			}
			else if(("").equals(SoldTo) || (! sessionAgentCode.equals(SoldTo)))
			{
%>				<Td><select name="soldTo" onChange='fun("include")'>
				<option value="">Select Sold To</option>
<%
				for(int j=0;j<retsoldto.getRowCount();j++)
				{
					String name   = retsoldto.getFieldValueString(j,"ECA_NAME").trim();
%>	             			<option value="<%= retsoldto.getFieldValueString(j,"EC_ERP_CUST_NO") %>"><%=name%></option>	
<%				}//end of for
%>				</select>	
				<input type="hidden" name="soldToName" >
			        </Td>
<%			}
			else
		        {
	       			out.println("<td>");
			 	String   name="";
				for(int j=0;j<retsoldto.getRowCount();j++)
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
%>
<%		}
		else
		{
			out.println("<td colspan=3>");
			String name="";
			for(int j = 0;j < retsoldto.getRowCount();j++)
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
%>		<th class="labelcell" align="left"><%=shipto_L%></th>
<%		if(!("").equals(SoldTo))
		{
			for(int k = 0;k < listShipTos.getRowCount(); k++ )	
			{
				shipToSet.add(listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim());
			}
			if(shipToSet.size() >1)
			{
%>				<td>
				<select name="shipTo"  onChange="setShipName()">
				<option value="">Select Ship To</option>
<%				for(int k = 0;k < shipToSet.size(); k++ )	
				{
					String shipToNo=listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim();
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					//if(!shipToSet.contains(shipToNo))
					//{
						//shipToSet.add(shipToNo);
					
%>				   	<option value="<%= listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim() %>"><%=name%></option>	
<%				
					//}
				} //  for loop 
%>			      	</select>
				
				<input type="hidden" name="shipToName">
		      		</Td>
<%			}
			else //end of if row count
		  	{
%>				<Td>
<%				for ( int k = 0 ; k < listShipTos.getRowCount(); k++ )	
				{
					String name = listShipTos.getFieldValueString(k,"ECA_NAME").trim();
					out.println("<input type='hidden' name='shipToName' value='"+name+"'>");	
					out.println(name);
				}
%>				<input type="hidden" name="shipTo" value="<%= listShipTos.getFieldValueString(0,"EC_PARTNER_NO").trim() %>">
				</Td>
<%			}
%>
<%		}
		else
		{	//end of if soldto not null 
%>			<Td>Please Select SoldTo</Td>
<%		}
%>	
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
%>					<option value="<%=enum1Key+"#"+enum1Desc%>" selected><%=enum1Desc%></Option>
<%	                        }
				else
				{
%>					<option value="<%=enum1Key+"#"+enum1Desc%>"><%=enum1Desc%></Option>
<%				}
			}
%>
			<option value="SP#Special">Special</Option>
		
		   </select>
		</Td>
	</Tr>
	<Tr>
		<Th colspan=6 style="text-align:left;width:100%">Special Shipping Instructions</Th>
	</Tr>
	<Tr>
		<Td colspan=6 width="100%">
		<textarea name="specialShIns" style="width:100%" rows="3" cols="*"></textarea>
		
		</Td>
	</Tr>
	
</table>
</Div>




