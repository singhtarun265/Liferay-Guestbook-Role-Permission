<%@include file="../init.jsp"%>
<%@ page import="com.liferay.docs.guestbook.web.internal.security.permission.resource.GuestbookPermission" %>

<%
GuestbookPermission gp= new GuestbookPermission();
long guestbookId = Long.valueOf((Long) renderRequest
        .getAttribute("guestbookId"));
System.out.println("Started view"+gp.toString());

boolean check=gp.contains(permissionChecker, scopeGroupId, "ADD_ENTRY");
System.out.println(check); 
%>


<%-- <aui:nav cssClass="nav-tabs">

    <%
        List<Guestbook> guestbooks = GuestbookLocalServiceUtil.getGuestbooks(scopeGroupId);

            for (int i = 0; i < guestbooks.size(); i++) {

                Guestbook curGuestbook = guestbooks.get(i);
                String cssClass = StringPool.BLANK;

                if (curGuestbook.getGuestbookId() == guestbookId) {
                    cssClass = "active";
                }

                if (GuestbookModelPermission.contains(
                    permissionChecker, curGuestbook.getGuestbookId(), "VIEW")) {

    %>

    <portlet:renderURL var="viewPageURL">
        <portlet:param name="mvcPath" value="/guestbook/view.jsp" />
        <portlet:param name="guestbookId"
            value="<%=String.valueOf(curGuestbook.getGuestbookId())%>" />
    </portlet:renderURL>


    <aui:nav-item cssClass="<%=cssClass%>" href="<%=viewPageURL%>"
        label="<%=HtmlUtil.escape(curGuestbook.getName())%>" />

    <%  
                }

            }
    %>

</aui:nav>
 --%>
<c:if test='<%= GuestbookPermission.contains(permissionChecker, scopeGroupId, "ADD_ENTRY") %>'>
<aui:button-row cssClass="guestbook-buttons">

    <portlet:renderURL var="addEntryURL">
        <portlet:param name="mvcPath" value="/guestbook/edit_entry.jsp" />
        <portlet:param name="guestbookId"
            value="<%=String.valueOf(guestbookId)%>" />
    </portlet:renderURL>

    <aui:button onClick="<%=addEntryURL.toString()%>" value="Add Entry"></aui:button>
</aui:button-row>
</c:if>

<liferay-ui:search-container total="<%=GuestbookEntryLocalServiceUtil.getGuestbookEntriesCount()%>">
<liferay-ui:search-container-results
    results="<%=GuestbookEntryLocalServiceUtil.getGuestbookEntries(scopeGroupId.longValue(),
                    guestbookId, searchContainer.getStart(),
                    searchContainer.getEnd())%>" />

<liferay-ui:search-container-row
    className="com.liferay.docs.guestbook.model.GuestbookEntry" modelVar="entry">

    <liferay-ui:search-container-column-text property="message" />

    <liferay-ui:search-container-column-text property="name" />

    <liferay-ui:search-container-column-jsp align="right" path="/guestbook/entry_actions.jsp" />
     
   <%--   <liferay-ui:search-container-column-jsp  align="right" path="/entry_actions.jsp" />
 --%>
</liferay-ui:search-container-row>

<liferay-ui:search-iterator />

</liferay-ui:search-container>