<%    
  String filename = "Users\\USER\\Documents\\NetBeansProjects\\BookStore\\build\\web\\pdf\\Invoice.pdf";   
  String filepath = "c:\\";   
  response.setContentType("APPLICATION/OCTET-STREAM");   
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);          
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close();   
%>   
