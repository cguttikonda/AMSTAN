<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session"></jsp:useBean>
<jsp:useBean id="EzUploadManager" class="ezc.ezupload.client.EzUploadManager" scope="session" />

<%
	ezc.ezparam.EzcParams mainParams = new ezc.ezparam.EzcParams(false);
	ezc.ezupload.params.EziAddressTable addTable = new ezc.ezupload.params.EziAddressTable();
	ezc.ezupload.params.EziAddressTableRow addTableRow = new ezc.ezupload.params.EziAddressTableRow();
	addTableRow.setNo(request.getParameter("addrNumber"));
        addTableRow.setLang(request.getParameter("Lang"));
        addTableRow.setCompanyName(request.getParameter("companyName"));
	addTableRow.setURL(request.getParameter("url"));
	addTableRow.setEMail(request.getParameter("email"));
       	addTableRow.setAddress1(request.getParameter("address1"));
       	addTableRow.setAddress2(request.getParameter("address2"));
       	addTableRow.setCity(request.getParameter("city"));
       	addTableRow.setDistrict(request.getParameter("district"));
       	addTableRow.setState(request.getParameter("state"));
       	addTableRow.setCountry(request.getParameter("country"));
       	addTableRow.setZipCode(request.getParameter("zipcode"));
       	addTableRow.setPhone1(request.getParameter("phone1"));
       	addTableRow.setPhone2(request.getParameter("phone2"));
       	addTableRow.setMobile(request.getParameter("mobile"));
       	addTableRow.setFax(request.getParameter("fax"));
       	addTableRow.setBusDomain(request.getParameter("busDomain"));
       	addTableRow.setType(request.getParameter("type"));
       	addTableRow.setExt1("");
       	addTableRow.setExt2("");
       	addTableRow.setExt2("");
       	addTable.appendRow(addTableRow);
      	
        mainParams.setObject(addTable);
	Session.prepareParams(mainParams);
	
	EzUploadManager.updateAddress(mainParams); 
	response.sendRedirect("ezListAddress.jsp");
%>
