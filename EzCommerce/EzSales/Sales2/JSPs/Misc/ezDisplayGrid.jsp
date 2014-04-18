<Div align=center style="width:100%;">
<br>
	<Div  id="GridBoxDiv" align=center style="background-color:whitesmoke;width:80%;border:1px solid;border-color:lightgrey;padding:2px;">
		<Div id="gridbox" height="300px" width="100%" style="overflow:hidden;visibility:hidden;"></Div>	
	</Div>		
	<Div id="dataRetrieve" width="100%" height="40px" style="overflow:hidden;visibility:visible;position:absolute;top:40%;left:<%=allignLeft%>">
		<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<!--<Td style="background:transparent" align='center'><br><b>Loading data, please wait...</b><br><br><img src="../../Images/ImagesGrid/loading.gif"/></Td>-->
				<Td style="background:transparent" align='center'>&nbsp;</Td>
			</Tr>
		</Table>
	</Div>   
	<Div id="NoData" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:40%;left:<%=allignLeft%>">
		<Table align=center border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td style="background:transparent" align='center'><br><b><%=noDataStatement%></b></Td>
			</Tr>
		</Table>
	</Div> 
	<Div id="ServerBusy" width="100%" height="40px" style="overflow:hidden;visibility:hidden;position:absolute;top:35%;left:<%=allignLeft%>">
		<Table align=center height="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
			<Tr>
				<Td style="background:transparent" align='right'><img border=0 src="../../Images/sbusy.gif" ></Td>
				<Td style="background:transparent" align='center'><font color="CC0000"><b>System Error.<BR> Please try again but if the error message reappears then contact us.</b></font></Td>
			</Tr>
		</Table>
	</Div> 
</Div>