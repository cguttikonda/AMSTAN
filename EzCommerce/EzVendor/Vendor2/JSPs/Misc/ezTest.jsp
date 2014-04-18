<%
	String nam="";
	nam=request.getParameter("Nam");
	if(nam==null || "null".equals(nam)) nam="";
 
 %>

<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp"%>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Vendor Details</title>
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
  <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
  <script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
  
<script>
  $(function() {
    $( "#tabs" ).tabs();
  $("#tabs").tabs({disabled: [1,2,3,4]});
   $("#next").click(function() {
   	alert("Tab activation");
    	$("#tabs2").tabs("option" , disabled , false);
	});
  });
 

function validate()
{

	if(document.myForm.Nam!=null && document.myForm.Nam.value=="")
	{
		alert("name shoul not be empty");
		document.myForm.action="ezTest.jsp#tabs-1";
		document.myForm.submit();
		document.myForm.Nam.focus();
		return ;
	}
	if(document.myForm.SHno!=null && document.myForm.SHno.value=="")
	{
		alert("Street/House No should not be empty");
		document.myForm.action="ezTest.jsp#tabs-1";
		document.myForm.submit();
		document.myForm.Nam.focus();

	}
}


</script>
</head>
<body>
<form name="myForm">
 <center>
 <h1><i>Vendor Registration</i></h1>
<div id="tabs" style="width:850px" align="center">
  <ul>
    <li><a href="#tabs-1">Address</a></li>
    <li><a href="#tabs-2">Excise Details</a></li>
    <li><a href="#tabs-3">Bank Details</a></li>
    <li><a href="#tabs-4">Control  Details</a></li>
    <li><a href="#tabs-5">Personal Details</a></li>
  </ul>
<BR><BR>  
  <div id="tabs-1">
  <table>
 
  
   <Tr>
   	<Td>Title:</Td>
   	<Td><select>
   	<option value="" selected>--select--</option>
  	<option value="MR">MR</option>
  	<option value="MS">MS</option>
  	<option value="MRS">MRS</option>

  	</select></Td>
  	
   </Tr>
   <Tr>
         	<Td>Name:</Td>
         	<Td><input type="text" name="NAME"></Td>
   </Tr>
   <Tr>
      	<Td>Street/House No:</Td>
      	<Td><input type="text" name="HOUSE NUM"></Td>
   </Tr>
   <Tr>
      	<Td>Postal Code:</Td>
      	<Td><input type="text" name="POSTAL CODE"></Td>
   </Tr>
   <Tr>
      	<Td>Country</Td>
      	<Td><input type="text" name="COUNTRY" value="India" readonly></Td>
   </Tr>
   <Tr>
      	<Td>Region:</Td>
      	<Td><input type="text" name="REGION"></Td>
   </Tr>
   
   
   <Tr>
      	<Td>Telephone No:</Td>
      	<Td><input type="text" name="TELE NUM"></Td>
   </Tr>
   <Tr>
         <Td>Mobile No:</Td>
         <Td><input type="text" name="MOBILE NUM"></Td>
   </Tr>
   <Tr>
      	<Td>Fax</Td>
      	<Td><input type="text" name="FAX"></Td>
   </Tr>
   <Tr>
         <Td>E-mail</Td>
         <Td><input type="text" name="EMAIL"></Td>
   </Tr>
   <Tr>
            <Td align="center"><input type="button" name="next" id="next" value="Next"></Td>
   </Tr>
	    
  </table>
   
  </div>
  <div id="tabs-2">
    <table>
      <Tr>
         	<Td>Excise No:</Td>
         	<Td><input type="text" name="EXCISENUM"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Reg No:</Td>
            	<Td><input type="text" name="EXREGNUM"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Range:</Td>
            	<Td><input type="text" name="EXRANGE"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Division :</Td>
            	<Td><input type="text" name="EXDIV"></Td>
         </Tr>
         <Tr>
            	<Td>PAN No:</Td>
            	<Td><input type="text" name="PANNUM"></Td>
         </Tr>
   
       
   </table>
  </div>
  <div id="tabs-3">
    <table>
       <Tr>
               	<Td>VAT Reg No:</Td>
               	<Td><input type="text" name="VATREGNUM"></Td>
         </Tr>
       
   </table>
  </div>
  <div id="tabs-4">
     <table>
    <Tr>
               	<Td>Country</Td>
               	<Td><input type="text" name="COUNTRY"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Key</Td>
               	<Td><input type="text" name="BANKKEY"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Account</Td>
               	<Td><input type="text" name="BANKACNT"></Td>
            </Tr>
            <Tr>
               	<Td>A/C holder</Td>
               	<Td><input type="text" name="ACHOLDER"></Td>
         </Tr>
   
   </table> 
  </div>
  <div id="tabs-5">
      <table>
         <Tr>
	               	<Td>First Name:</Td>
	               	<Td><input type="text" name="FIRSTNAME"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Last Name:</Td>
	               	<Td><input type="text" name="LASTNAME"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Region:</Td>
	               	<Td><input type="text" name="REGION"></Td>
         </Tr>
         
   </table>
  </div>
</div>
 <div>
 <br>
  </div>
 </center>
 <script>
 document.myForm.Nam.value='<%=nam%>';
 </script>
 
 </form>
</body>
</html>