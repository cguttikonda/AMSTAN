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
    <Td><font face="Tw Cen MT" size="4" color="#FFFFFF">List of Site Defaults</font></Td>
  </Tr>
</Table>
<form method="post" action="" name="ListDef">
  <Table  width="75%" border="2" align="center" bordercolor="#610A61">
    <Tr align="center" valign="middle" bgcolor="#BDBDFF" bordercolor="#FFFFF7"> 
      <Td width="100%" colspan="2"><font face="Tw Cen MT">These are the Site
        Defaults independent of Catalog Area</font></Td>
    </Tr>
    <Tr align="center" valign="middle" bgcolor="#0D6ABF" bordercolor="#FFFFF7"> 
      <Td width="45%"> <font face="Trebuchet MS" size="2" color="#FFFFFF">Defaults 
        Key</font> </Td>
      <Td width="55%"> <font face="Trebuchet MS" size="2" color="#FFFFFF">Defaults 
        Description</font> </Td>
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
		out.println(" <font size=\"2\" face=\"Trebuchet MS\" color=\"#000066\">");
	      out.println(retfixed.getFieldValue(i,"ESTD_DEFAULT_KEY")); 
        	out.println("</A></font>");		
        	out.println("</Td>");		

		out.println("<Td>"); 
		out.println(" <font size=\"2\" face=\"Trebuchet MS\" color=\"#000066\">");
		if ( defDescription != null){
		      out.println(defDescription); 
		}
        	out.println("</font>");		
        	out.println("</Td>");		
		out.println("</Tr>");
	}//End for
}//End If
%> 
  </Table>
</form>
</body>
</html>