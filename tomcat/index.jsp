<%@ page import = "java.io.*,java.util.*,java.net.*" %>
<%
   // This JSP displays a simple table with session details that can be used to determine if session replication is working across nodes.

   String date = (new Date()).toString();

    Cookie[] cookies = request.getCookies();
    if(cookies != null)
    {
        for (int i = 0; i < cookies.length; i++) {
            String name = cookies[i].getName();
            String value = cookies[i].getValue();
            System.out.println(date + " cookie: " + name + " = " + value);
        }
    }
 
    // get session creation and last access times
    Date createTime = new Date(session.getCreationTime());
    Date lastAccessTime = new Date(session.getLastAccessedTime());

    String title = "Session Details";

    String hostname = "unknown";
    try {
        InetAddress addr = InetAddress.getLocalHost();
        hostname = addr.toString();
    } catch (UnknownHostException e) {
        e.printStackTrace();
    }
    
    // initialize attributes first time in
    if (session.isNew() ){
        System.out.println(date + " creating session");
        title += " - NEW";
        session.setAttribute("hostname", hostname);
        session.setAttribute("visits", new Integer(0));
    } else {
        System.out.println(date + " session existed");
    }

    // increment visit count
    Integer visitCount = (Integer)session.getAttribute("visits");
    visitCount = visitCount + 1;
    session.setAttribute("visits", visitCount);

    String sourceHost = (String)session.getAttribute("hostname");
%>

<html>
   <head>
      <title><%= title %></title>
      <style>
      h1, th, td { font-family: consolas, monospace; }
      table { border: 0px; }
      th { background-color: black; color: white; padding: 10px; font-weight: bold;}
      td { background-color: lightgray; ; padding: 10px;}
      </style>
   </head>
   
   <body>
      <center>
         <h1><%= title %></h1>
      </center>
      
      <table align = "center"> 
         <tr bgcolor = "#9494FF">
            <th>Key</th>
            <th>Value</th>
         </tr> 
         <tr>
            <td>ID</td>
            <td><%= session.getId() %></td>
         </tr> 
         <tr>
            <td>Creation Time</td>
            <td><%= createTime %></td>
         </tr> 
         <tr>
            <td>Last Accessed</td>
            <td><%= lastAccessTime %></td>
         </tr> 
         <tr>
            <td>Source Host</td>
            <td><%= sourceHost %></td>
         </tr> 
         <tr>
            <td>Current Host</td>
            <td><%= hostname %></td>
         </tr> 
         <tr>
            <td>Visits</td>
            <td><%= visitCount %></td>
         </tr> 
      </table> 
   
   </body>
</html>