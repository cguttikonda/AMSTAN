<%@ page import ="java.util.*,ezc.ezutil.*,ezc.ezparam.*" %>
<%@ include file="../../Library/Globals/ezErrorPagePath.jsp"%>
<%
	String display_header = "Edit Bill To"; 
	
%>
<Html>
<Head>
	<%@ include file="../../../Includes/Lib/ezAddButtonDir.jsp" %>
	
</Head>
<Body scroll=no>
<Form  name="myForm" method="post">
<%@ include file="../Misc/ezDisplayHeader.jsp"%>
<Br>

	        <Table align="center" width="90%" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=1 >
		<Tr>
		   <td>
		        <table>
				 <tr><th>Supplier Name</th> <td> </td></tr>
				 <tr><th>City </th> <td> </td></tr>
				 <tr><th>Zip/Postal Code </th> <td> </td></tr>
				 <tr><th>Contact </th> <td><input type="text" name="contact" value=""> </td></tr>
				 <tr><th>Extension </th> <td><input type="text" name="extn" value=""> </td></tr>
				 <tr><th>Notes </th> <td><input type="textarea" name="notes" value=""> </td></tr>
		        </table>
		   </td>	
		   <td>   
		        <table>
				 <tr><th>Address</th> <td> </td></tr>
				 <tr><th>Sate/Province </th> <td> </td></tr>
				 <tr><th>Terms </th> <td> </td></tr>
				 <tr><th>Phone </th> <td> </td></tr>
				 <tr><th>Fax </th> <td> </td></tr>
		        </table>
		   </td>
		</Tr>
		<Tr>
		   <td>
			<table>
				 <tr><th>Account Number</th> <td> </td></tr>
				 <tr><th>Company </th> <td> </td></tr>
				 <tr><th>Address2 </th> <td> </td></tr>
				 <tr><th>State/Province </th> </tr>
				 <tr><th>Country </th> </tr>
				 <tr><th>Phone </th></tr>
				 <tr><th>Fax </th></tr>
				 <tr><th>E-Mail </th></tr>
			</table>
		   </td>	
		   <td>   
			<table>
				 <tr><th>Address1</th> <td> </td></tr>
				 <tr><th>City </th> <td> </td></tr>
				 <tr><th>Zip/Postal Code </th> <td> </td></tr>
				 <tr><th>Contact </th> <td> </td></tr>
				 <tr><th>Extension </th> <td> </td></tr>
				 <tr><th>Resales Number </th> <td> </td></tr>
				 <tr><th>DUNS Number </th> <td> </td></tr>
			</table>
		   </td>
		</Tr>
		</Table>
			

</Form>
</Body>
</Html>