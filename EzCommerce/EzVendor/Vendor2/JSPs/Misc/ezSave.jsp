<%@ page import="java.util.Enumeration,javax.servlet.*,javax.servlet.http.*,java.io.*,java.io.File,java.io.IOException,java.util.*" %>
<%@ page import="ezc.ezupload.MultipartRequest" %>

<%

	String  sessionId=request.getParameter("sessionId");
	//String  maxVendId=request.getParameter("maxVendId");
	
	String inboxPath="",finalPath="";
	ResourceBundle site=null;

	site= ResourceBundle.getBundle("Site");
	inboxPath=site.getString("UPLOADTEMPDIR");
	finalPath=site.getString("UPLOADFILEPATHDIR");
	
    	
    	File bfile =new File(finalPath+maxVendId);
    	if((bfile.exists()) && (bfile.isFile()))
	{
	}
	else
	{
		boolean dir=bfile.mkdir();
		System.out.println("directory created:"+dir);
	}
	
	String filename="";
	InputStream inStream = null;
	OutputStream outStream = null;
	 
	try
	{
		File folder = new File(inboxPath+session.getId());
		File[] listOfFiles = folder.listFiles();
		if(listOfFiles != null)
		{
			for (int i = 0; i < listOfFiles.length; i++)
			{
				if (listOfFiles[i].isFile()) 
				{

					File afile =new File(inboxPath+session.getId()+"\\"+listOfFiles[i].getName());
					File cfile =new File(finalPath+maxVendId+"\\"+listOfFiles[i].getName());

					inStream = new FileInputStream(afile);
					outStream = new FileOutputStream(cfile);

					byte[] buffer = new byte[1024];

					int length;
					//copy the file content in bytes 
					while ((length = inStream.read(buffer)) > 0)
					{
						outStream.write(buffer, 0, length);
					}

					inStream.close();
					outStream.close();

					//delete the original file
					afile.delete();
				} 
				else if (listOfFiles[i].isDirectory()) 
				{
					//System.out.println("Directory " + listOfFiles[i].getName());
				}
			}
		}
	}
	catch(IOException e)
	{
		e.printStackTrace();
	}
%>