<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<sql:setDataSource var="dataSource" driver="com.microsoft.sqlserver.jdbc.SQLServerDriver" 
url="jdbc:sqlserver://192.168.1.43:1433;DatabaseName=ezafwebstore;SelectMethod=cursor"
user="ezafwebstore" password="ezafwebstore"
scope="session" />
<%
  	pageContext.setAttribute("tableclass", "its");
%>

<html>
 <head>
   <title>Display tag</title>    
   <meta http-equiv="Expires" content="-1" /> 
   <meta http-equiv="Pragma" content="no-cache" />
   <meta http-equiv="Cache-Control" content="no-cache" />
   <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <style type="text/css" media="all">
          @import url("/AFS/css/maven-base.css");
          @import url("/AFS/css/maven-theme.css"); 
          @import url("/AFS/css/site.css");
          @import url("/AFS/css/screen.css"); 
          
          .inputbox 
           {
          		font-size: 10px; 
          		border-right:#00385D 1px inset;
          		border-top: white 1px inset;
          		border-left: white 1px inset;
          		border-bottom: #00385D 1px inset;
          		font-family: arial,sans-serif
   	  }       
         .tx {
		font-family: verdana, arial;  
		border:0;
		background-color:transparent;
		font-size: 9px;
		text-align:left;
		color: #00385D
		
		
	 }

   </style>
   <link rel="stylesheet" href="./css/print.css" type="text/css" media="print" /> 
 </head>  

  <body>
  

<sql:query var = "users" dataSource="${dataSource}">
select emm_id,emm_no,emd_desc,emm_unit_of_measure,emm_catalog_no,emm_manufacturer,emm_unit_price,emm_image_path,emm_ean_upc_no from web_mat_details where emm_catalog_no = '10071'
</sql:query>

<table border=1>
<c:forEach var="row" items="${users.rows}">
<tr>
<td><c:out value="${row.emm_no}"/></td>
<td><c:out value="${row.emd_desc}"/></td>
</tr>
</c:forEach>
</table>

<display:table name="${users.rows}" id="user" class="its">
    <display:column property="emm_id" sortable="true" title="Mat Id"/>
    <display:column property="emm_no" sortable="true" title="Product"/>
    <display:column property="emd_desc" sortable="true" title="Desc"/>
</display:table>


  </body>
</html>
