<HTML>
    <HEAD>
       
	   
	   <h3><TITLE>Login Page</TITLE></h3>

    </HEAD>
<BODY vLink=#00000b link=#00000b bgcolor="#fce9c5" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
    <BODY>
	
        <center><br><br><br><H2>LOGIN FORM</H2>
			</table>
        <%
        String myname =  (String)session.getAttribute("username");
       
        if(myname!=null)
            {
             out.println("Welcome  "+myname+"  , <a href=\"logout.jsp\" >Logout</a>");
            }
        else 
            {
            %>
            <form action="checkLogin.jsp">
               <table  border=1  rules=none align=center   topmargin=0 cellspacing=0 cellpadding=1 borderColor="#D98242" >
                    <tr>
                        <td> Username  : </td><td> <input name="username" size=15 type="as password" /> </td> 
                    </tr>
                    <tr>
                        <td> Password  : </td><td> <input name="password" size=15 type="text" /> </td> 
                    </tr>
                </table>
                <input type="submit" value="login" /></center>
            </form>
		
            <% 
            }
        
            
            %>
        
    </BODY>
</HTML>

