<Tr align="center" valign="middle">
<%
     if(session.getAttribute("getprices")!=null)
     {
%>
	<th width="15%" valign="top">Product Code</th>
	<th width="35%" valign="top" nowrap><%=prodDesc_L%></th>
	<th width="5%" valign="top"><%=uom_L%></th>
	<th width="15%" valign="top"><%=qty_L%></th>
	<th width="15%" valign="top"><%=price_L%> [<%=Currency%>]</th>
        <Th width="15%" valign="top"><%=val_L%> [<%=Currency%>]</Th>	
 <%}else{%>
 	<th width="5%">&nbsp;</th>
	<th width="15%" valign="top">Product</th>
 	<th width="30%" valign="top">Description</th>
 	<th width="20%" valign="top">Manufacturer</th>
 	<th width="10%" valign="top">List Price</th>
	<th width="7%" valign="top"><%=uom_L%></th>
	<th width="13%" valign="top"><%=qty_L%></th>							
<%}%>
  </Tr>