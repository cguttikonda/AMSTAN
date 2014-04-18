
<Html>
<Head>
	<%@ include file="../../../Includes/Lib/AddButtonDir.jsp"%>
	<Script>
		function funCheck()
		{
			var fName = document.myForm.fileName.value

			if(fName == null || fName == "")
			{
				alert("Please choose file to Synchronize");
			}
			else
			{
				document.myForm.action="ezCustPostSynch.jsp"
				document.myForm.submit();
			}
		}
	</Script>
</Head>
<Body>
<Form name=myForm>

	<br><br>
	<Table align=center width=50%>
	<Tr>
		<Th>
			Please choose file to synchronize
		</Th>
	</Tr>
	<Tr>
		<Td align=center class="blankcell">
			<input type=file name=fileName>
		</Td>
	</Tr>
	</Table><br><br><br><br><center>

		<Img   src="../../Images/Buttons/<%= ButtonDir%>/synchronize.gif"   onClick="funCheck()" style="cursor:hand">
		<Img   src="../../Images/Buttons/<%= ButtonDir%>/back.gif"   onClick="history.go(-1)" style="cursor:hand">

</Form>
</Body>
</Html>