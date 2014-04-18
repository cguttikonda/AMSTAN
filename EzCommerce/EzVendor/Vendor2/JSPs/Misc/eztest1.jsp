
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
  });
  
function validate()
{

if(document.myForm.Nam!=null && document.myForm.Nam.value=="")
{
alert("Name should not be empty");
document.myForm.Nam.focus();
return;
}

}
</script>
</head>
<body>
<form name="myForm">
 <center>
 <h1><i>Vendor Registration</i></h1>
<div id="tabs" style="width:850px" height="500px" align="center">
  <ul>
    <li><a href="#tabs-1">Address</a></li>
    <li><a href="#tabs-2">Excise Details</a></li>
    <li><a href="#tabs-3">Bank Details</a></li>
    <li><a href="#tabs-4">Control  Details</a></li>
    <li><a href="#tabs-5">Personal Details</a></li>
  </ul>
<BR><BR>  
  <div id="tabs-1">
  <fieldset>
  <legend>Personalia:</legend>
  <table>
 
  
   <Tr>
   	<Td>Name:</Td>
   	<Td><input type="text" name="Nam"></Td>
   </Tr>
   <Tr>
      	<Td>Street/House No:</Td>
      	<Td><input type="text" name="SHno"></Td>
   </Tr>
   <Tr>
      	<Td>Postal Code:</Td>
      	<Td><input type="text" name="pc"></Td>
   </Tr>
   <Tr>
      	<Td>Country</Td>
      	<Td><input type="text" name="country"></Td>
   </Tr>
   <Tr>
      	<Td>Region:</Td>
      	<Td><input type="text" name="reg"></Td>
   </Tr>
   
   
   <Tr>
      	<Td>Telephone No:</Td>
      	<Td><input type="text" name="TNo"></Td>
   </Tr>
   <Tr>
         <Td>Mobile No:</Td>
         <Td><input type="text" name="MNo"></Td>
   </Tr>
   <Tr>
      	<Td>Fax</Td>
      	<Td><input type="text" name="fax"></Td>
   </Tr>
   <Tr>
         <Td>E-mail</Td>
         <Td><input type="text" name="email"></Td>
   </Tr>
   
</fieldset>	    
  </table>
   
  </div>
  <div id="tabs-2">
   <fieldset>
  <legend>Personalia:</legend>
  <table>
      <Tr>
         	<Td>Excise No:</Td>
         	<Td><input type="text" name="Eno"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Reg No:</Td>
            	<Td><input type="text" name="ERno"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Range:</Td>
            	<Td><input type="text" name="er"></Td>
         </Tr>
         <Tr>
            	<Td>Excise Division :</Td>
            	<Td><input type="text" name="ed"></Td>
         </Tr>
         <Tr>
            	<Td>PAN No:</Td>
            	<Td><input type="text" name="panno"></Td>
         </Tr>
   </table>
       
   </feildset>
  </div>
  <div id="tabs-3">
     <fieldset>
  <legend>Personalia:</legend>
  	<table>
       <Tr>
               	<Td>VAT Reg No:</Td>
               	<Td><input type="text" name="vatRgNo"></Td>
         </Tr>
       </table>
   </feildset>
  </div>
  <div id="tabs-4">
    <fieldset>
  <legend>Personalia:</legend>
  <table>
    <Tr>
               	<Td>Country</Td>
               	<Td><input type="text" name="coun"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Key</Td>
               	<Td><input type="text" name="bk"></Td>
            </Tr>
            <Tr>
               	<Td>Bank Account</Td>
               	<Td><input type="text" name="ba"></Td>
            </Tr>
            <Tr>
               	<Td>A/C holder</Td>
               	<Td><input type="text" name="acholder"></Td>
         </Tr>
   </table>
   </feildset>
  </div>
  <div id="tabs-5">
       <fieldset>
  <legend>Personalia:</legend>
  <table>
         <Tr>
	               	<Td>First Name:</Td>
	               	<Td><input type="text" name="fn"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Last Name:</Td>
	               	<Td><input type="text" name="ln"></Td>
	            </Tr>
	            <Tr>
	               	<Td>Region:</Td>
	               	<Td><input type="text" name="reg"></Td>
         </Tr>
  </table>       
   </feildset>
  </div>
</div>
 <div>
 <br>
 <center><input type="button" value="submit"  onClick="validate()"</center>
 </div>
 </center>
 </form>
</body>
</html>