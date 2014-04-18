<%@page import="ezc.sapconnection.*"%>
<%@page import="com.sap.mw.jco.*"%>
<%@ include file="../../../Includes/JSPs/Inbox/iGetUploadTempDir.jsp" %>
<%!
	public static byte[] getBytesFromFile(File file) throws IOException 
	{
        	InputStream is = new FileInputStream(file);
    	        long length = file.length();
        	byte[] bytes = new byte[(int)length];
    	        int offset = 0;
    		int numRead = 0;
    		while (offset < bytes.length && (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) 
    		{
            		offset += numRead;
        	}
    	        if (offset < bytes.length) 
    	        {
            		throw new IOException("Could not completely read file "+file.getName());
        	}
    	        is.close();

		return bytes;
    	}
%>
<%
	byte[] zDocString_U = null;
	String fileName_U = tempAttachFile_U;
	String docNumber_U = tempDocNo_U;
	String docType_U = "SO";

	ArrayList multiDocs_A = new ArrayList();

	JCO.Client client_U = null;
	JCO.Function function_U = null;

	String site_S = (String)session.getValue("Site");
	String skey_S = "999";

	try
	{
		java.util.StringTokenizer filesStk = null;
		String fileName = "";

log4j.log("fileName_U======>"+fileName_U, "D");

		if(fileName_U!=null)
		{
			filesStk = new java.util.StringTokenizer(fileName_U,"$$");
			while(filesStk.hasMoreElements())
			{
				fileName = filesStk.nextToken();

				if(!multiDocs_A.contains(fileName))
					multiDocs_A.add(fileName);
			}
		}

log4j.log("multiDocs_A======>"+multiDocs_A, "D");

		for(int md=0;md<multiDocs_A.size();md++)
		{
			fileName_U = (String)multiDocs_A.get(md);

			String tempUploadDir = inboxPath+session.getId();
			String tempFilePath = tempUploadDir+"\\"+fileName_U;

			String filePath_U = (String)session.getValue("FILEPATH");
			if(filePath_U!=null && "Y".equals(filePath_U))
			{
				tempUploadDir = uploadFilePathDir;
				tempFilePath = tempUploadDir+fileName_U.split("§")[0];
				fileName_U = fileName_U.split("§")[1];
			}
log4j.log("tempUploadDir::"+tempUploadDir,"I");
log4j.log("tempFilePath::"+tempFilePath,"I");
			byte[] fileBytes = getBytesFromFile(new File(tempFilePath));
			log4j.log("fileBytes::"+fileBytes,"I");
			//out.println("fileBytes::"+fileBytes);

			client_U = EzSAPHandler.getSAPConnection(site_S+"~"+skey_S);
			function_U = EzSAPHandler.getFunction("Z_EZ_DOCATT_UPLOAD",site_S+"~"+skey_S);
			JCO.ParameterList docDetail = function_U.getImportParameterList();

			docDetail.setValue(fileBytes,"Z_STRING");
			docDetail.setValue(fileName_U,"FILENAME");//fileName_U
			docDetail.setValue(docNumber_U,"DOC_NUMBER");
			docDetail.setValue(docType_U,"DOC_TYPE");

			//out.println("Z_STRING::::::::::::::"+docDetail.getValue("Z_STRING"));

			client_U.execute(function_U);
		}
	}
	catch(Exception e){}
	finally
	{
		if(client_U!=null)
		{
			JCO.releaseClient(client_U);
			client_U = null;
			function_U=null;
		}
	}
%>