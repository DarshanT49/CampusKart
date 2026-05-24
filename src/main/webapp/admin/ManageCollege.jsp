<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | Manage Colleges</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { --primary-color: #4361ee; --bg-light: #f8fafc; }
        body { background: var(--bg-light); font-family: 'Inter', sans-serif; color: #1e293b; }
        .main-wrapper { transition: all 0.3s; margin-top : 40px ;	 padding-top: 100px; min-height: 100vh; }
        @media (min-width: 992px) { .main-wrapper { margin-left: 280px; } }
        
        .card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); overflow: hidden; }
        .table thead th { 
            background: #f8fafc; text-transform: uppercase; font-size: 0.7rem; 
            letter-spacing: 0.05em; font-weight: 700; color: #94a3b8; padding: 1.25rem 1rem;
        }
        .table tbody td { padding: 1.25rem 1rem; border-bottom: 1px solid #f8fafc; }
        .college-avatar { 
            width: 44px; height: 44px; display: flex; align-items: center; justify-content: center; 
            border-radius: 12px; font-weight: bold; background: rgba(67, 97, 238, 0.1); color: var(--primary-color); 
        }
        .badge-soft { font-weight: 600; padding: 0.5em 0.8em; border-radius: 8px; }
    </style>
</head>
<body>

    <%@ include file="components/AdminNavbar.jsp" %>
    <%@ include file="components/AdminSidebar.jsp" %>
    
    <main class="main-wrapper p-3 p-md-4 p-lg-5">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5 gap-3">
            <div>
                <h2 class="fw-bold mb-1">Colleges</h2>
                <p class="text-muted mb-0">Oversee campus registrations and student request validation.</p>
            </div>
            <button class="btn btn-primary fw-bold px-4 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#addCollegeModal">
                <i class="bi bi-plus-lg me-2"></i> Register New Campus
            </button>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success border-0 shadow-sm rounded-4 mb-4 p-3">
                <i class="bi bi-check-circle-fill me-2"></i> Operation completed successfully!
            </div>
        </c:if>

        <!-- Pending Requests Section -->
        <h5 class="fw-bold mb-4 d-flex align-items-center">
            <span class="bg-warning p-1 rounded-2 me-2" style="width: 8px; height: 24px; display: inline-block;"></span>
            Pending Approval
        </h5>
        <div class="row g-4 mb-5">
            <c:forEach var="req" items="${pendingRequests}">
                <div class="col-md-6 col-xl-4">
                    <div class="card p-4 h-100 border border-warning border-opacity-10">
                        <div class="d-flex align-items-center mb-3">
                            <div class="college-avatar me-3">${req.collegeName.substring(0,1)}</div>
                            <div>
                                <h6 class="fw-bold mb-0 text-truncate" style="max-width: 180px;">${req.collegeName}</h6>
                                <small class="text-muted">Requested by User #${req.userId}</small>
                            </div>
                        </div>
                        <p class="small text-muted mb-4"><i class="bi bi-geo-alt me-1"></i> ${req.address}, ${req.pincode}</p>
                        <div class="d-flex gap-2">
                            <form action="openApproveForm" method="get" class="flex-grow-1">
                                <input type="hidden" name="requestId" value="${req.id}">
                                <button type="submit" class="btn btn-warning text-dark fw-bold btn-sm w-100 rounded-pill">Approve</button>
                            </form>
                            <button class="btn btn-light border btn-sm flex-grow-1 rounded-pill fw-bold">Reject</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty pendingRequests}">
                <div class="col-12"><p class="text-muted small">No pending requests found.</p></div>
            </c:if>
        </div>

        <!-- Registered Campuses Table -->
        <div class="card mt-4">
            <div class="card-header bg-white py-4 px-4 border-0 d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">
                <h5 class="fw-bold mb-0">Registered Campuses</h5>
                <div class="input-group input-group-sm w-auto">
                    <span class="input-group-text bg-light border-0"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control bg-light border-0 px-3" placeholder="Search campuses...">
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">College</th>
                            <th>Code</th>
                            <th>Pincode</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="college" items="${colleges}">
                            <tr>
                                <td class="ps-4">
                                    <div class="fw-bold">${college.name}</div>
                                    <small class="text-muted">${college.address}</small>
                                </td>
                                <td><span class="badge bg-primary bg-opacity-10 text-primary badge-soft">${college.shortName}</span></td>
                                <td><span class="text-muted small">${college.pincode}</span></td>
                                <td>
                                    <span class="badge ${college.status == 'ACTIVE' ? 'bg-success' : 'bg-danger'} bg-opacity-10 ${college.status == 'ACTIVE' ? 'text-success' : 'text-danger'} badge-soft">
                                        ${college.status}
                                    </span>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="openEditCollege?collegeId=${college.id}" class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1">Edit</a>
                                    <a href="toggleCollegeStatus?id=${college.id}" class="btn btn-sm ${college.status == 'ACTIVE' ? 'btn-outline-danger' : 'btn-outline-success'} rounded-pill px-3">
                                        ${college.status == 'ACTIVE' ? 'Disable' : 'Enable'}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Modal for Add/Edit College -->
    <div class="modal fade" id="addCollegeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg">
                <div class="modal-header border-0 p-4 pb-0">
                    <h5 class="fw-bold">${not empty editCollege ? 'Update Campus' : 'Register New Campus'}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form method="post" action="${not empty editCollege ? 'updateCollege' : (not empty approveRequest ? 'approveCollege' : 'addCollege')}">
                        <c:if test="${not empty editCollege}"><input type="hidden" name="collegeId" value="${editCollege.id}"></c:if>
                        <c:if test="${not empty approveRequest}"><input type="hidden" name="requestId" value="${approveRequest.id}"></c:if>
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted">COLLEGE NAME</label>
                            <input type="text" class="form-control bg-light border-0 p-3" name="name" 
                                   value="${not empty editCollege ? editCollege.name : (not empty approveRequest ? approveRequest.collegeName : '')}" required>
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">CITY</label>
                                <input type="text" class="form-control bg-light border-0 p-3" name="address" 
                                       value="${not empty editCollege ? editCollege.address : (not empty approveRequest ? approveRequest.address : '')}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold text-muted">PINCODE</label>
                                <input type="text" class="form-control bg-light border-0 p-3" name="pincode" 
                                       value="${not empty editCollege ? editCollege.pincode : (not empty approveRequest ? approveRequest.pincode : '')}" required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted">SHORT CODE</label>
                            <input type="text" class="form-control bg-light border-0 p-3" name="shortName" 
                                   value="${not empty editCollege ? editCollege.shortName : ''}" placeholder="e.g. COEP" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary fw-bold p-3 rounded-3 shadow-sm">
                                ${not empty editCollege ? 'Update College' : (not empty approveRequest ? 'Approve & Save' : 'Register Campus')}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty approveRequest or not empty editCollege}">
        <script>window.onload = function() { new bootstrap.Modal(document.getElementById('addCollegeModal')).show(); }</script>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>