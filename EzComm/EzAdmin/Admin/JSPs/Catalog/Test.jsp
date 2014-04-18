<%
	String product_code = request.getParameter("productCode");
	out.println(product_code);
	String type = request.getParameter("type");
	out.println(type);
	String status = request.getParameter("status");
	out.println(status);
	String webSKU = request.getParameter("webSKU");
	out.println(webSKU);
	String upcCode = request.getParameter("upcCode");
	out.println(upcCode);
	String brand = request.getParameter("brand");
	out.println(brand);
	String model = request.getParameter("model");
 	out.println(model);

%>
 
 	<%
		String product_code = request.getParameter("productCode");
		out.println(product_code);
		String type = request.getParameter("type");
		out.println(type);
		String status = request.getParameter("status");
		out.println(status);
		String webSKU = request.getParameter("webSKU");
		out.println(webSKU);
		String upcCode1 = request.getParameter("upcCode");
		out.println(upcCode);
		String brand = request.getParameter("brand");
		out.println(brand);
		String model = request.getParameter("model");
	 	out.println(model);
	
	%>
	 		var = xmlhttp;
			function saveProduct(product_code,type,status,webSKU,upcCode1,brand,model)
			{
	
				xmlhttp = GetXmlHttpObject();
	
				if(xmlhttp==null)
				{
					alert ("Your browser does not support Ajax HTTP");
					return;
				}
	
				Popup.showModal('modal');
	
				var url="../Catalog/ezAddProductsAjax.jsp";
				url=url+"?col1="+product_code+"&col2="+type+"&col3="+status+"&col4="+webSKU+"&col5="+upcCode1+"&col6="+brand+"&col7="+model;
	
				if(xmlhttp!=null)
				{
					xmlhttp.onreadystatechange=Process;
					xmlhttp.open("GET",url,true);
					xmlhttp.send(null);
				}
				else
					Popup.hide('modal');
			}
			function Process()
			{
				if(xmlhttp.readyState==4)
				{
					var resText = xmlhttp.responseText;
					var resultText	= resText.split("##");
					var addSuccess	= resultText[2];
					alert("::"+resText+"::");
	
					Popup.hide('modal');
				}
		}
		
		$(function(){
		 
		    // add multiple select / deselect functionality
		    $("#selectAll").click(function () {
		          $('.att').attr('checked', this.checked);
		    });
		 
		    // if all checkbox are selected, check the selectall checkbox
		    // and viceversa
		    $(".att").click(function(){
		 
		        if($(".att").length == $(".att:checked").length) {
		            $("#selectAll").attr("checked", "checked");
		        } else {
		            $("#selectAll").removeAttr("checked");
		        }
		 
		    });
});