<%@ page import = "java.io.*,java.util.*,java.net.*" %>
<%
// This JSP displays a simple table with session details that can be used to determine if session replication is working across nodes.

String state = "UNKNOWN";
String date = (new Date()).toString();

String cookieSession = null;
if (request.getCookies() != null) {
    for (Cookie c : request.getCookies()) {
        if (c.getName().equals("JSESSIONID")) {
            cookieSession = c.getValue();
        }
    }
}

// get session creation and last access times
Date createTime = new Date(session.getCreationTime());
Date lastAccessTime = new Date(session.getLastAccessedTime());

String hostname = "unknown";
try {
    InetAddress addr = InetAddress.getLocalHost();
    hostname = addr.toString();
} catch (UnknownHostException e) {
    e.printStackTrace();
}

// initialize attributes first time in
if (session.isNew() ){
    session.setAttribute("hostname", hostname);
    session.setAttribute("visits", new Integer(0));
    state = (cookieSession != null) ? "FAILED" : "CREATED";
} else {
    state = "FOUND";
}

// increment visit count
Integer visitCount = (Integer)session.getAttribute("visits");
visitCount = visitCount + 1;
session.setAttribute("visits", visitCount);

String sourceHost = (String)session.getAttribute("hostname");

System.out.println("session " + session.getId() + " = " + state);
%>
<html>
    <head>
    <title>Session Details</title>
    <style>
        h1 { text-align: center; }
        h1, th, td { font-family: consolas, monospace; }
        table { border: 0px; }
        th { background-color: black; color: white; padding: 10px; font-weight: bold;}
        td { background-color: lightgray; ; padding: 10px;}
        .UNKNOWN { color: gray; }
        .FAILED { color: red; }
        .CREATED { color: green; }
    </style>
    </head>
    <body>
        <h1 class="<%= state %>">Session <%= state %></h1>
        <table align="center"> 
            <tr bgcolor = "#9494FF">
                <th>Key</th><th>Value</th>
            </tr> 
            <tr>
                <td>Current Session</td><td><%= session.getId() %></td>
            </tr> 
            <tr>
                <td>Prior Session</td><td><%= cookieSession %></td>
            </tr> 
            <tr>
                <td>Created Time</td><td><%= createTime %></td>
            </tr> 
            <tr>
                <td>Last Accessed</td><td><%= lastAccessTime %></td>
            </tr> 
            <tr>
                <td>Current Host</td><td><%= hostname %></td>
            </tr> 
            <tr>
                <td>Source Host</td><td><%= sourceHost %></td>
            </tr> 
            <tr>
                <td>Visits</td><td><%= visitCount %></td>
            </tr> 
        </table> 
    </body>
</html>