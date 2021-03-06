<%@page import="java.security.Principal"%>
<html>
<HEAD>
<TITLE>Palakkad App</TITLE>
<%@ page import="javax.servlet.http.HttpUtils,java.util.Enumeration"%>
<%@ page import="java.lang.management.*"%>
<%@ page import="java.util.*"%>
</HEAD>
<body>

	<div align="center">
		<h1>Welcome to Palakkad</h1>
		<br />
		<%
			try {
				String name = "unauthenticated";
				StringBuffer roles = new StringBuffer();
				String role = null;
				List<String> rolesList = Arrays.asList("Lars", "Simon", "testgroup", "everyone", "individual",
						"okta-rlm-test-group", "offline_access", "uma_authorization", "testrole","testrole2");

				Iterator<String> rolesIterator = rolesList.iterator();
				while (rolesIterator.hasNext()) {
					role = rolesIterator.next();
					if (request.isUserInRole(role)) {
						roles.append(", ");
						roles.append(role);
					}
				}

				Principal p = request.getUserPrincipal();
				if (p != null) {
					name = p.getName();
				}
		%>

		Welcome to the Palakkad,
		<%=name%>

		<br /> Here is your Request Details: <a href="/palakkad/logout.jsp">Click to
			LogOut</a>

	</div>


	<h2>Hello World!</h2>

	<H2>User</H2>
	<TABLE>
		<TR>
			<TH align=right>Principal Name:</TH>
			<TD><%=name%></TD>
		</TR>
		<TR>
			<TH align=right>Roles:</TH>
			<TD><%=roles.toString()%></TD>
		</TR>
	</TABLE>


	<H2>Request information</H2>

	<TABLE>
		<TR>
			<TH align=right>Requested URL:</TH>
			<TD><%=HttpUtils.getRequestURL(request)%></TD>
		</TR>
		<TR>
			<TH align=right>Request method:</TH>
			<TD><%=request.getMethod()%></TD>
		</TR>
		<TR>
			<TH align=right>Request URI:</TH>
			<TD><%=request.getRequestURI()%></TD>
		</TR>
		<TR>
			<TH align=right>Request protocol:</TH>
			<TD><%=request.getProtocol()%></TD>
		</TR>
		<TR>
			<TH align=right>Servlet path:</TH>
			<TD><%=request.getServletPath()%></TD>
		</TR>
		<TR>
			<TH align=right>Path info:</TH>
			<TD><%=request.getPathInfo()%></TD>
		</TR>
		<TR>
			<TH align=right>Path translated:</TH>
			<TD><%=request.getPathTranslated()%></TD>
		</TR>
		<TR>
			<TH align=right>Query string:</TH>
			<TD>
				<%
					if (request.getQueryString() != null)
							out.write(request.getQueryString().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
				%>
			</TD>
		</TR>
		<TR>
			<TH align=right>Content length:</TH>
			<TD><%=request.getContentLength()%></TD>
		</TR>
		<TR>
			<TH align=right>Content type:</TH>
			<TD><%=request.getContentType()%></TD>
		<TR>
		<TR>
			<TH align=right>Server name:</TH>
			<TD><%=request.getServerName()%></TD>
		<TR>
		<TR>
			<TH align=right>Server port:</TH>
			<TD><%=request.getServerPort()%></TD>
		<TR>
		<TR>
			<TH align=right>Remote user:</TH>
			<TD><%=request.getRemoteUser()%></TD>
		<TR>
		<TR>
			<TH align=right>Remote address:</TH>
			<TD><%=request.getRemoteAddr()%></TD>
		<TR>
		<TR>
			<TH align=right>Remote host:</TH>
			<TD><%=request.getRemoteHost()%></TD>
		<TR>
		<TR>
			<TH align=right>Authorization scheme:</TH>
			<TD><%=request.getAuthType()%></TD>
		<TR>
	</TABLE>

	<%
		Enumeration e = request.getHeaderNames();
			if (e != null && e.hasMoreElements()) {
	%>
	<H2>Request headers</H2>

	<TABLE>
		<TR>
			<TH align=left>Header:</TH>
			<TH align=left>Value:</TH>
		</TR>
		<%
			while (e.hasMoreElements()) {
						String k = (String) e.nextElement();
		%>
		<TR>
			<TD><%=k%></TD>
			<TD><%=request.getHeader(k)%></TD>
		</TR>
		<%
			}
		%>
	</TABLE>
	<%
		}
	%>


	<%
		e = request.getParameterNames();
			if (e != null && e.hasMoreElements()) {
	%>
	<H2>Request parameters</H2>
	<TABLE>
		<TR valign=top>
			<TH align=left>Parameters:</TH>
			<TH align=left>Value:</TH>
			<TH align=left>Multiple values:</TH>
		</TR>
		<%
			while (e.hasMoreElements()) {
						String k = (String) e.nextElement();
						String val = request.getParameter(k);
						String vals[] = request.getParameterValues(k);
		%>
		<TR valign=top>
			<TD><%=k.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></TD>
			<TD><%=val.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></TD>
			<TD>
				<%
					for (int i = 0; i < vals.length; i++) {
									if (i > 0)
										out.print("<BR>");
									out.print(vals[i].replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
								}
				%>
			</TD>
		</TR>
		<%
			}
		%>
	</TABLE>
	<%
		}
	%>


	<%
		e = request.getAttributeNames();
			if (e != null && e.hasMoreElements()) {
	%>
	<H2>Request Attributes</H2>
	<TABLE>
		<TR valign=top>
			<TH align=left>Attribute:</TH>
			<TH align=left>Value:</TH>
		</TR>
		<%
			while (e.hasMoreElements()) {
						String k = (String) e.nextElement();
						Object val = request.getAttribute(k);
		%>
		<TR valign=top>
			<TD><%=k.replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></TD>
			<TD><%=val.toString().replaceAll("<", "&lt;").replaceAll(">", "&gt;")%></TD>
		</TR>
		<%
			}
		%>
	</TABLE>
	<%
		}
	%>


	<%
		e = getServletConfig().getInitParameterNames();
			if (e != null && e.hasMoreElements()) {
	%>
	<H2>Init parameters</H2>
	<TABLE>
		<TR valign=top>
			<TH align=left>Parameter:</TH>
			<TH align=left>Value:</TH>
		</TR>
		<%
			while (e.hasMoreElements()) {
						String k = (String) e.nextElement();
						String val = getServletConfig().getInitParameter(k);
		%>
		<TR valign=top>
			<TD><%=k%></TD>
			<TD><%=val%></TD>
		</TR>
		<%
			}
		%>
	</TABLE>
	<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>
