<%@include file="../init.jsp"%>
<%@ page import="com.liferay.docs.guestbook.web.internal.security.permission.resource.GuestbookEntryPermission" %>
<%
String mvcPath = ParamUtil.getString(request, "mvcPath");

ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);
GuestbookEntry entry = (GuestbookEntry)row.getObject(); 

GuestbookEntryPermission gep= new GuestbookEntryPermission();
System.out.println("Edit entry check ");

boolean chek=gep.contains(permissionChecker, entry.getEntryId(), ActionKeys.UPDATE);
System.out.println("Edit entry check "+chek);
%>

<liferay-ui:icon-menu>

		<c:if
            test="<%= GuestbookEntryPermission.contains(permissionChecker, entry.getEntryId(), ActionKeys.UPDATE) %>">
        <portlet:renderURL var="editURL">
            <portlet:param name="entryId" value="<%= String.valueOf(entry.getEntryId()) %>" />
            <portlet:param name="mvcPath" value="/guestbook/edit_entry.jsp" />
        </portlet:renderURL>

        <liferay-ui:icon image="edit" message="Edit" url="<%=editURL.toString() %>" />
		 </c:if>
		 
		 
		 <c:if
        test="<%=GuestbookEntryPermission.contains(permissionChecker, entry.getEntryId(), ActionKeys.PERMISSIONS) %>">

            <liferay-security:permissionsURL
                modelResource="<%= GuestbookEntry.class.getName() %>"
                modelResourceDescription="<%= entry.getMessage() %>"
                resourcePrimKey="<%= String.valueOf(entry.getEntryId()) %>"
                var="permissionsURL" />

            <liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />

        </c:if>
		 
		 
		  <c:if
            test="<%=GuestbookEntryPermission.contains(permissionChecker, entry.getEntryId(), ActionKeys.DELETE) %>">
		 
        <portlet:actionURL name="deleteEntry" var="deleteURL">
            <portlet:param name="entryId"  value="<%= String.valueOf(entry.getEntryId()) %>" />
            <portlet:param name="guestbookId"  value="<%= String.valueOf(entry.getGuestbookId()) %>" />
        </portlet:actionURL>

        <liferay-ui:icon-delete url="<%=deleteURL.toString() %>" />
       
    </c:if>
</liferay-ui:icon-menu>