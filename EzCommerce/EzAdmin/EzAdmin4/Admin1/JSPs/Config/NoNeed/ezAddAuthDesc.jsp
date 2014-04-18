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
  	<Tr align="center"> 
    	<Td class = "displayheader">Authorizations</Td>
  	</Tr>
</Table>
<Table  width="80%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
    	<Tr> 
      	<Th colspan="2">Please enter the following authorization information:</Th>
    	</Tr>
    	<Tr > 
      	<Td width="41%">Language:</Td>
      	<Td width="59%"> 
        	<input type=text class = "InputBox" name=Lang >
      	</Td>
    	</Tr>
    	<Tr > 
      	<Td width="41%">Authorizations:</Td>
      	<Td width="59%"> 
        <input type=text class = "InputBox" name=key >
      	</Td>
    	</Tr>
    	<Tr > 
      	<Td width="41%">Description:</Td>
      	<Td width="59%"> 
        <input type=text class = "InputBox" name=Desc >
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
