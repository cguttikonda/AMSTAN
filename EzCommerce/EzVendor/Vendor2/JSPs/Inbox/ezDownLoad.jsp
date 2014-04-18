<%@ page import="java.util.*,java.io.*"%>
<%
        System.out.println("inside download jsp");
       String FolderName=request.getParameter("FolderName");
       String msgId=request.getParameter("MessageId");
       String fName=request.getParameter("FileName");
        int msg=Integer.parseInt(msgId);

        ezc.ezmail.EzMail downloadFile=new ezc.ezmail.EzMail();
        ezc.ezmail.EzcMailParams mailParams=new ezc.ezmail.EzcMailParams();

        mailParams.setHost("192.168.1.3");
        mailParams.setProtocol("imap");
        mailParams.setPort(""+143);
        mailParams.setUserId("siva");
        mailParams.setPassword("siva");
        mailParams.setFolderName(FolderName);
        mailParams.setMessageId(""+msg);
        mailParams.setFileName(fName);


	InputStream isStream=downloadFile.getAttachmentFile(mailParams);
        System.out.println("input stream created :"+isStream);

        BufferedReader br=new BufferedReader(new InputStreamReader(isStream));
        File f1=new File(fName);
        BufferedWriter bw=new BufferedWriter(new FileWriter(f1));
        String line=br.readLine();
        while(line!=null)
	{
             bw.write(line,0,line.length());
	     bw.newLine();
	   line=br.readLine();
	}
        br.close();
        bw.close();
        isStream.close();

       System.out.println("end of input stream");
       String fileName=f1.getName();
	File f = new File (fName);
	response.setHeader ("Content-Disposition", "attachment;filename="+fileName);
	String name = f.getName().substring(f.getName().lastIndexOf("\\") + 1,f.getName().length());
	InputStream in = new FileInputStream(f);
	ServletOutputStream outs = response.getOutputStream();
	int bit = 256;
	int i = 0;
    		try {
        	     while ((bit) >= 0) 
                     {
        				bit = in.read();
        				outs.write(bit);
                     }
           	    } 
                    catch (IOException ioe) 
                    {
                 	System.out.println("Got exception  : "+ioe);
                    }

            //System.out.println( "\n" + i + " bytes sent.");
            //System.out.println( "\n" + f.length() + " bytes sent.");
            outs.flush();
            outs.close();
           isStream.close();// in.close();	
System.out.println("end of download page");

%>
<Div id="MenuSol"></Div>

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
     
     