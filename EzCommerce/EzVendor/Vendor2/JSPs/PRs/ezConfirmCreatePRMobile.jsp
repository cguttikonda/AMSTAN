<!DOCTYPE html>
    <html>
    <head>
    <title>Answerthink</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/answerthink.css">
    <script>
    function funVal()
    {
    	
    	 if(document.myForm.Material.value=="")
    	{
    		alert('Please Enter Material');
    		return;
    	}	
    	else if(document.myForm.shortText.value=="")
    	{
    		alert('Please Enter Short Text');
    		return;
    	}	
    	else  if(document.myForm.deliveryDate.value=="")
    	{
    		alert('Please Enter Delivery Date');
    		return;
    	}	
    	else  if(document.myForm.Quantity.value=="")
    	{
    		alert('Please Enter Quantity');
    		return;
    	}	
    	else  if(document.myForm.UOM.value=="")
    	{
    		alert('Please Enter UOM');
    		return;
    	}	
    	else  if(document.myForm.valPrice.value=="")
    	{
    		alert('Please Enter Value Price');
    		return;
    	}
    	else
    	{
    		document.myForm.action="ezCreateSAPPRMobile.jsp";
    		document.myForm.submit();
    	
    	}
    	
    }
</script>
<script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
    <form name="myForm">
      <div class="row">
          <div class="span12"><h2>Answerthink</h2></div>
      </div>
<div class="container-fluid">
<div class="row">
    <div class="span12"><h4>Create Purchase Requisition</h4></div>
</div>
<form class="form-inline">
    <div class="row-fluid">
          <div class="span4 offset4 panel">
                
                        <table class="table table-striped table-bordered">
                              <tbody>
                               
                                <tr>
                                  <th>Material</th>
                                  <td><input  name="Material" type="text" placeholder="Material"></td>
                                </tr>
                                <tr>
                                  <th>Short Text</th>
                                  <td><input type="text" id="shortText" name="shortText" placeholder="Short Text"></td>
                                </tr>
                                    <tr>
                                  <th>Delivery Date</th>
                                  <td><input type="text" name="deliveryDate" placeholder="Delivery Date"></td>
                                </tr>
                                <tr>
                                  <th>Quantity</th>
                                  <td><input type="text" name="Quantity" placeholder="Quantity"></td>
                                </tr>
                                <tr>
                                  <th>UOM</th>
                                  <td><input type="text" name="UOM" placeholder="UOM"></td>
                                </tr>
                                <tr>
                                  <th>Val Price</th>
                                  <td><input type="text" name="valPrice" placeholder="Val Price"></td>
                                </tr>
                              </tbody>
                        </table>
                        <div class="span4 offset4"><button class="btn btn-primary" onClick="funVal()" type="button">Create PR</button></div>
                </form>
          </div>
    </div>

    
    </form>
    </body>
    </html>