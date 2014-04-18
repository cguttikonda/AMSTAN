<%@ include file="../../Library/Globals/errorPagePath.jsp"%>
<%@ include file="../../../Includes/Lib/AdminBean.jsp"%>

<html>
<head>

<Title>Choose Catalog</Title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%></head>
<body>
<Table  width="40%" border="0" align="center">
  <Tr align="center"> 
    <Td class="displayheader">Choose Catalog Type</Td>
  </Tr>
</Table>
<br>
<form name=myForm method=post action="ezSaveChooseCatalog.jsp">

  <Table  width="60%" border="0" hspace="20" align="center">
    <Tr> 
      <Th width="100%" colspan="2"> Select the Catalog type you want to create</Th>
    </Tr>
    <Tr align="left"> 
      <Td>
        <input type="radio" name="ChooseCatalog" value="Customer" checked>
        Catalog</Td>
    </Tr>
    <Tr align="left"> 
      <Td>
        <input type="radio" name="ChooseCatalog" value="Vendor">
        Vendor Catalog</Td>
    </Tr>
  </Table>
  <div align="center"><br>
    <input type="submit" name="Submit" value="Continue">
  </div>
</form>
</body>
</html>