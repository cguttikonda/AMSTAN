<%@ include file="../../../Includes/Lib/AdminConfig.jsp"%>

<html>
<head>

<%!
// Start Declarations

final String DEFAULTS_KEY = "EUDD_KEY";
final String DEFAULTS_SYS_KEY = "EUDD_SYS_KEY";
final String DEFAULTS_LANG = "EUDD_LANG";
final String DEFAULTS_DESC = "EUDD_DEFAULTS_DESC";

//End Declarations
%>

<%
// Key Variables
ReturnObjFromRetrieve retfixed = null;

String systype = request.getParameter("SysType");

// System Configuration Class
EzSystemConfig ezc = new EzSystemConfig();

//Get Fixed Defaults
retfixed = ezc.getErpMasterDefaults(systype);
retfixed.check();

%>

</head>

<BODY bgcolor="#FFFFF7">
<Table  width="40%" border="0" align="center">
  <Tr align="center" bgcolor="#B16798"> 
    <Td>List of Site Defaults</Td>
  </Tr>
</Table>
<form name=myForm method=post action="">
  <Table  width="75%" border="2" align="center" bordercolor="#610A61">
    <Tr align="center" valign="middle" bgcolor="#BDBDFF" bordercolor="#FFFFF7"> 
      <Td width="100%" colspan="2">These are the Site
        Defaults independent of Catalog Area</Td>
    </Tr>
    <Tr align="center" valign="middle" bgcolor="#0D6ABF" bordercolor="#FFFFF7"> 
      <Td width="45%"> Defaults 
        Key </Td>
      <Td width="55%"> Defaults 
        Description </Td>
    </Tr>
    <br>
    <%
int defRows = 0;
defRows = retfixed.getRowCount();
if ( defRows > 0 ) {
	for ( int i = 0 ; i < defRows; i++ ){		

String defDescription = (String)retfixed.getFieldValue(i,"ESTD_DEFAULT_DESC");

		out.println("<Tr align=\"center\" bgcolor=\"#CCCCCC\">");
		out.println("<Td>"); 
		
	      out.println(retfixed.getFieldValue(i,"ESTD_DEFAULT_KEY")); 
        	out.println("</A>");		
        	out.println("</Td>");		

		out.println("<Td>"); 
		
		if ( defDescription != null){
		      out.println(defDescription); 
		}
        	
        	out.println("</Td>");		
		out.println("</Tr>");
	}//End for
}//End If
%> 
  </Table>
</form>
</body>
</html>
