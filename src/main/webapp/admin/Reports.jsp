<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | User Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { --primary-color: #4361ee; --bg-light: #f8fafc; }
        body { background: var(--bg-light); font-family: 'Inter', sans-serif; color: #1e293b; }
        .main-wrapper { transition: all 0.3s; margin-top : 40px ; padding-top: 100px; min-height: 100vh; }
        @media (min-width: 992px) { .main-wrapper { margin-left: 280px; } }
        
        .card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); overflow: hidden; }
        .table thead th { 
            background: #f8fafc; text-transform: uppercase; font-size: 0.7rem; 
            letter-spacing: 0.05em; font-weight: 700; color: #94a3b8; padding: 1.25rem 1rem;
        }
        .table tbody td { padding: 1.25rem 1rem; border-bottom: 1px solid #f8fafc; }
        .badge-soft { font-weight: 600; padding: 0.5em 0.8em; border-radius: 8px; }
    </style>
</head>
<body>

    <%@ include file="components/AdminNavbar.jsp" %>
    <%@ include file="components/AdminSidebar.jsp" %>

    <main class="main-wrapper p-3 p-md-4 p-lg-5">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5 gap-3">
            <div>
                <h2 class="fw-bold mb-1">Moderation Hub</h2>
                <p class="text-muted mb-0">Review user reports and maintain community guidelines.</p>
            </div>
            <div class="dropdown">
                <button class="btn btn-white shadow-sm border rounded-pill px-4 dropdown-toggle fw-bold" data-bs-toggle="dropdown">
                    Filter: ${activeStatus}
                </button>
                <ul class="dropdown-menu shadow border-0 p-2 rounded-3">
                    <li><a class="dropdown-item rounded-2" href="reports?status=ALL">All Reports</a></li>
                    <li><a class="dropdown-item rounded-2" href="reports?status=PENDING">Pending</a></li>
                    <li><a class="dropdown-item rounded-2" href="reports?status=REVIEWED">Reviewed</a></li>
                    <li><a class="dropdown-item rounded-2" href="reports?status=RESOLVED">Resolved</a></li>
                </ul>
            </div>
        </div>

        <div class="card">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Reporter / Target</th>
                            <th>Reason</th>
                            <th>Status</th>
                            <th>Timeline</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reports}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center mb-2">
                                        <div class="small fw-bold me-2">From:</div>
                                        <div class="small text-primary fw-semibold">${userMap[r.reporterId].name}</div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="small fw-bold me-2">Target:</div>
                                        <div class="small text-danger fw-semibold">${userMap[r.reportedId].name}</div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border fw-bold mb-1">${r.reason}</span>
                                    <div class="small text-muted text-truncate" style="max-width: 250px;" title="${r.details}">${r.details}</div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'PENDING'}"><span class="badge bg-warning bg-opacity-10 text-warning badge-soft">PENDING</span></c:when>
                                        <c:when test="${r.status == 'REVIEWED'}"><span class="badge bg-info bg-opacity-10 text-info badge-soft">REVIEWED</span></c:when>
                                        <c:when test="${r.status == 'RESOLVED'}"><span class="badge bg-success bg-opacity-10 text-success badge-soft">RESOLVED</span></c:when>
                                    </c:choose>
                                </td>
                                <td><small class="text-muted">${r.createdAt}</small></td>
                                <td class="text-end pe-4">
                                    <div class="d-flex justify-content-end gap-1">
                                        <form action="reports/updateStatus" method="post" class="d-inline">
                                            <input type="hidden" name="reportId" value="${r.id}"><input type="hidden" name="status" value="REVIEWED">
                                            <button type="submit" class="btn btn-sm btn-outline-info rounded-pill" ${r.status != 'PENDING' ? 'disabled' : ''}>Review</button>
                                        </form>
                                        <form action="reports/suspendUser" method="post" class="d-inline">
                                            <input type="hidden" name="userId" value="${r.reportedId}"><input type="hidden" name="reportId" value="${r.id}">
                                            <button type="submit" class="btn btn-sm btn-danger rounded-pill" ${userMap[r.reportedId].status == 'SUSPENDED' ? 'disabled' : ''}>Suspend</button>
                                        </form>
                                        <form action="reports/updateStatus" method="post" class="d-inline">
                                            <input type="hidden" name="reportId" value="${r.id}"><input type="hidden" name="status" value="RESOLVED">
                                            <button type="submit" class="btn btn-sm btn-success rounded-pill" ${r.status == 'RESOLVED' ? 'disabled' : ''}>Resolve</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reports}">
                            <tr><td colspan="5" class="text-center py-5 text-muted small"><i class="bi bi-shield-check fs-2 d-block mb-2"></i> No active reports.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>