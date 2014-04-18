
<script>
	function openWindow()
	{
		newWindow = window.open("ezDSSFrameSet.jsp?CreatedBy=<%= CreatedBy %>&webOrNo=<%= WebOrNo %>&SoldTo=<%= SoldTo %>&sysKey=<%=sdHeader.getFieldValueString(0,"SALES_AREA")%>","Mywin","resizable=no,left=20,top=10,height=500,width=750,status=no,toolbar=no,menubar=no,location=no")
	}
</script>

<%

	if( NEW )
	{
			buttonName.add("Save");
			buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"NO\")");
	   		//buttonName.add("Post To SAP");
			//buttonMethod.add("confirmEditOrder(\"ezEditSaveSales.jsp\",\"TRANSFERED\")");
	}
%>
