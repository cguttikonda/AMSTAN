<html>
<head>
<link rel="stylesheet" href="Legend.css" type="text/css"/>   
</head>
<body>
<form name="myForm" method="post">

<table width="100%">
	
	<tr>
		<td width="40%" valign="top">
			<div>
				<fieldset>
				<legend>Address :</legend>
				<table align="center">
				<tbody align="center">
					
					   <Tr>
					   	<Td align="right">Name:</Td>
					   	<Td><input type="text" name="Nam"></Td>
					   </Tr>
					   <Tr>
					      	<Td align="right">Street/House No:</Td>
					      	<Td><input type="text" name="SHno"></Td>
					   </Tr>
					   <Tr>
					      	<Td align="right">Postal Code:</Td>
					      	<Td><input type="text" name="pc"></Td>
					   </Tr>
					   <Tr>
					      	<Td align="right">Country</Td>
					      	<Td><input type="text" name="country"></Td>
					   </Tr>
					   <Tr>
					      	<Td align="right">Region:</Td>
					      	<Td><input type="text" name="reg"></Td>
					   </Tr>
					   
					   
					   <Tr>
					      	<Td align="right">Telephone No:</Td>
					      	<Td><input type="text" name="TNo"></Td>
					   </Tr>
					   <Tr>
					         <Td align="right">Mobile No:</Td>
					         <Td><input type="text" name="MNo"></Td>
					   </Tr>
					   <Tr>
					      	<Td align="right">Fax</Td>
					      	<Td><input type="text" name="fax"></Td>
					   </Tr>
					   <Tr>
					         <Td align="right">E-mail</Td>
					         <Td><input type="text" name="email"></Td>
  					 </Tr>
					
				</tbody>
				</table>
							
				</fieldset>
			</div>
		</td>
</tr>
</table>
<br>
<table width="100%">
<tr>
		<td  valign="top" width="40%" >
			<div>
				<fieldset>
				<legend>Excise Details:</legend>
				<table align="center">
				<tbody align="center">
					
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
   
				</tbody>
				</table>   
				</fieldset>
				
			</div>
		</td>
		
	</tr>
	</tbody>
</table>
<br>
<table width="100%">
<tr>
	<td width="20%" valign="top">
					<div>
						<fieldset>
						<legend>Control  Details:</legend>
						<table align="center">
						<tbody align="center">
							
							 <Tr>
							               	<Td>VAT Reg No:</Td>
							               	<Td><input type="text" name="VATREGNUM"></Td>
							         </Tr>
       
						</tbody>
						</table>
									
						</fieldset>
					</div>
		</td>
</tr>
</table>
<br>
<table width="100%">
	<tbody>
	<tr>
		
		<td  valign="top" width="20%">  
			<div>
				<fieldset>
				<legend>Bank Details:</legend>
				<table align="center">
				<tbody align="center">
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
   	
					
				</tbody>
				</table>
				</fieldset>
				
			</div>
		</td>
	</tr>
</table>
<br>
<table width="100%">
<tr>
		<td  valign="top" width="20%">  
			<div>
				<fieldset>
				<legend>Personal Details:</legend>
				<table align="center">
				<tbody align="center">
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
				</tbody>
				</table>    
				</fieldset>
				
			</div>
		</td>	
	
</tr>

</table>
<br>
<center><input type="Button" value="Update" onClick="update();"></center>
</form>
</body>
</html>