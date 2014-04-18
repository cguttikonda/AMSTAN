<html>
<head>
<Title>Add User Data</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
</head>
<body>
<form method="post" action="ezSaveAuthDesc.jsp" name="AddAuth">
<br>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
	<Tr> 
	<Td class = "displayheader">Authorizations</Td>
  	</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    	<Tr> 
	      	<Td colspan="2">Please enter the following authorization information:</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="100%" colspan="2"> 
	        <div align="center">Language:
		        <input type=text class = "InputBox" name=Lang >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center">Authorizations</div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center">Description</div>
	      	</Td>
    	</Tr>
<%
	int Count = 6;
	for ( int i = 0 ; i < Count; i++ )
		{		
%>		
	      	<Tr align="center" valign="middle"> 
	      		<Td>
		      	<input type=text class = "InputBox" name= "BaseERPSoldTo_<%=i%>" size="18" value="" >
	      		</Td>
	      	</Tr>
<%	      	
		}//End for
%>		
	      <input type="hidden" name="TotalCount" value="<%=Count%>" >
   	<Tr> 
      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key0 >
	        </div>
      	</Td>
      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc0 >
	        </div>
	     	</Td>
 	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key1 >
	        </div>
	      	</Td>
	    	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc1 >
	        </div>
	      	</Td>
   	</Tr>
   	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key2 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc2 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key3 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc3 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key4 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc4 >
	        </div>
	      	</Td>
    	</Tr>
	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key5 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc5 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key6 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc6 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key7 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc7 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key8 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	      	<div align="center"> 
	        <input type=text class = "InputBox" name=Desc8 >
	        </div>
	      	</Td>
    	</Tr>
    	<Tr> 
	      	<Td width="46%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=key9 >
	        </div>
	      	</Td>
	      	<Td width="54%"> 
	        <div align="center"> 
	        <input type=text class = "InputBox" name=Desc9 >
	        </div>
	      	</Td>
    	</Tr>
</Table>
<br>
<center>
	<input type="image" src= "../../Images/Buttons/<%=ButtonDir%>/addauthorization.gif" name="Submit" value="Add Authorization" alt = "Add Authorization">	
</center>
</form>
</body>
</html>
