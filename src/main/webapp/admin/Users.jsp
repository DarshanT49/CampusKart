<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { --primary-color: #4361ee; --bg-light: #f8fafc; }
        body { background: var(--bg-light); font-family: 'Inter', sans-serif; color: #1e293b; }
        .main-wrapper { transition: all 0.3s; margin-top : 40px; min-height: 100vh; }
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
                <h2 class="fw-bold mb-1">Users</h2>
                <p class="text-muted mb-0">Manage student accounts and verify campus permissions.</p>
            </div>
            <div class="d-flex gap-2">
                <div class="input-group input-group-sm shadow-sm" style="max-width: 250px;">
                    <span class="input-group-text bg-white border-0"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control border-0 px-3" placeholder="Search students...">
                </div>
            </div>
        </div>

        <!-- Sections Nav -->
        <ul class="nav nav-pills gap-2 mb-4" id="userTabs" role="tablist">
            <li class="nav-item"><button class="btn btn-white border rounded-pill px-4 active fw-bold" data-bs-toggle="pill" data-bs-target="#activeUsers">Active</button></li>
            <li class="nav-item"><button class="btn btn-white border rounded-pill px-4 fw-bold" data-bs-toggle="pill" data-bs-target="#pendingUsers">Pending</button></li>
            <li class="nav-item"><button class="btn btn-white border rounded-pill px-4 fw-bold" data-bs-toggle="pill" data-bs-target="#blockedUsers">Blocked</button></li>
        </ul>

        <div class="tab-content shadow-none border-0">
            <!-- Active Users -->
            <div class="tab-pane fade show active" id="activeUsers">
                <div class="card">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">User</th>
                                    <th>College</th>
                                    <th>Joined</th>
                                    <th class="text-end pe-4">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${activeUsers}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="fw-bold text-primary">${user.name}</div>
                                            <small class="text-muted">${user.email}</small>
                                        </td>
                                        <td><span class="small text-muted">${collegeMap[user.id]}</span></td>
                                        <td><small class="text-muted">${user.createdAt}</small></td>
                                        <td class="text-end pe-4">
                                            <a href="updateUserStatus?id=${user.id}&status=BLOCKED" class="btn btn-sm btn-outline-danger rounded-pill px-3">Block</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Pending Users -->
            <div class="tab-pane fade" id="pendingUsers">
                <div class="card border border-warning border-opacity-10">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <tbody>
                                <c:forEach var="user" items="${pendingUsers}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="fw-bold">${user.name}</div>
                                            <small class="text-muted">${user.email}</small>
                                        </td>
                                        <td><span class="badge bg-warning bg-opacity-10 text-warning badge-soft">PENDING</span></td>
                                        <td class="text-end pe-4">
                                            <a href="updateUserStatus?id=${user.id}&status=ACTIVE" class="btn btn-sm btn-success rounded-pill px-3 me-1">Activate</a>
                                            <a href="updateUserStatus?id=${user.id}&status=BLOCKED" class="btn btn-sm btn-outline-danger rounded-pill px-3">Block</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Blocked Users -->
            <div class="tab-pane fade" id="blockedUsers">
                <div class="card border border-danger border-opacity-10">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <tbody>
                                <c:forEach var="user" items="${blockedUsers}">
                                    <tr>
                                        <td class="ps-4">
                                            <div class="fw-bold text-muted text-decoration-line-through">${user.name}</div>
                                            <small class="text-muted">${user.email}</small>
                                        </td>
                                        <td><span class="badge bg-danger bg-opacity-10 text-danger badge-soft">BLOCKED</span></td>
                                        <td class="text-end pe-4">
                                            <a href="updateUserStatus?id=${user.id}&status=ACTIVE" class="btn btn-sm btn-outline-success rounded-pill px-3">Unblock</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>