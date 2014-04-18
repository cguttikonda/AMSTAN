	var prodCode 	= new Array();
	var ship	= new Array();
	var sold	= new Array();
	var ShipAdd 	= new Array();
	
	function ezShipTos(shipTo,shipToname,country)
	{
		this.shipTo 	= shipTo
		this.shipToname = shipToname
		this.country 	= country
	}
<%
     	for(int k=0;k<listShipTos.getRowCount();k++)
     	{
		String ashTo = listShipTos.getFieldValueString(k,"ECA_NAME");
		ashTo = ashTo.replace('\"','\'');
%>		ShipAdd[<%=k%>] = new ezShipTos("<%=listShipTos.getFieldValueString(k,"EC_PARTNER_NO").trim()%>","<%= ashTo%>","<%=listShipTos.getFieldValueString(k,"ECA_COUNTRY")%>");
<%   	}
	//listShipTos and retsoldtos are declared in iHeaderDefaultValues.jsp
	String tot  = request.getParameter("total");
	String[] qtyArr = null;
	String[] oldQty=null;
	if(tot != null && !"null".equals(tot) && tot.trim().length() !=0 )
	{
		int totint = Integer.parseInt(tot);
		qtyArr =  request.getParameterValues("desiredQty");
		oldQty = new String[totint];
		String[] cod = null;	
		cod = request.getParameterValues("product");
		for(int p=0;p<totint;p++)
		{
			qtyArr[p] = (qtyArr[p] == null || "null".equals(qtyArr[p]) || qtyArr[p].trim().length() ==0)?"0":qtyArr[p];
			oldQty[p] = cod[p];
%>			prodCode[<%=p%>]="<%=cod[p]%>";
<%		}
	}
	for(int k=0;k<retsoldto.getRowCount();k++)
      	{
%>		sold[<%=k%>] = "<%=retsoldto.getFieldValueString(k,"EC_ERP_CUST_NO").trim()%>^^<%=retsoldto.getFieldValueString(k,"ECA_ADDR_1")%>^^<%=retsoldto.getFieldValueString(k,"ECA_ADDR_2")%>^^<%=retsoldto.getFieldValueString(k,"ECA_CITY")%>^^<%=retsoldto.getFieldValueString(k,"ECA_STATE")%>^^<%=retsoldto.getFieldValueString(k,"ECA_PIN")%>^^<%=retsoldto.getFieldValueString(k,"ECA_COUNTRY")%>";
<%	}
%>