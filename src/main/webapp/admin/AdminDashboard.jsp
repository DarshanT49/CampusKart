<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { 
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --success-color: #4cc9f0;
            --info-dark: #0dcaf0; 
            --bg-light: #f8fafc; 
        }
        body { 
            background: var(--bg-light); 
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
        }
        .main-wrapper { 
            transition: all 0.3s; 
            padding-top: 80px; 
            margin-top : 40px ;
            min-height: 100vh;
        }
        @media (min-width: 992px) { 
            .main-wrapper { margin-left: 280px; } 
        }
        
        /* Stats Cards */
        .stat-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.05);
        }
        .stat-icon { 
            width: 60px; 
            height: 60px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            border-radius: 16px; 
            font-size: 1.75rem; 
        }
        
        /* Table Styling */
        .card-table {
            border: none;
            border-radius: 20px;
            background: #fff;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
        }
        .table thead th { 
            background: #f8fafc; 
            text-transform: uppercase; 
            font-size: 0.7rem; 
            letter-spacing: 0.05em; 
            font-weight: 700; 
            color: #94a3b8; 
            padding: 1.25rem 1rem;
            border-bottom: 1px solid #f1f5f9;
        }
        .table tbody td { 
            padding: 1.25rem 1rem; 
            vertical-align: middle;
            border-bottom: 1px solid #f8fafc;
        }
        
        /* Badges */
        .badge-soft {
            font-weight: 600;
            padding: 0.5em 0.8em;
            border-radius: 8px;
        }
        .badge-soft-info { background: rgba(13, 202, 240, 0.1); color: #0dcaf0; }
        .badge-soft-success { background: rgba(25, 135, 84, 0.1); color: #198754; }
        .badge-soft-warning { background: rgba(255, 193, 7, 0.1); color: #ffc107; }
        .badge-soft-primary { background: rgba(67, 97, 238, 0.1); color: #4361ee; }

        .product-img {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: 12px;
        }
        
        .request-item {
            transition: background 0.2s;
            border-radius: 15px !important;
            margin-bottom: 10px;
            border: 1px solid #f1f5f9 !important;
        }
        .request-item:hover {
            background-color: #f8fafc;
        }

        .refresh-btn {
            cursor: pointer;
            transition: transform 0.3s;
        }
        .refresh-btn:hover {
            transform: rotate(180deg);
        }
    </style>
</head>
<body>

    <%@ include file="components/AdminNavbar.jsp" %>
    <%@ include file="components/AdminSidebar.jsp" %>

    <main class="main-wrapper p-3 p-md-4 p-lg-5">
        <div class="row align-items-center mb-5">
            <div class="col-md-6">
                <h2 class="fw-bold mb-1">Command Center</h2>
                <p class="text-muted mb-0">Live overview of your campus marketplace ecosystem.</p>
            </div>
            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                <div class="d-inline-flex align-items-center gap-3">
                    <button onclick="window.location.reload()" class="btn btn-white shadow-sm border rounded-pill px-3">
                        <i class="bi bi-arrow-clockwise refresh-btn d-inline-block me-1"></i> Refresh
                    </button>
                    <div class="bg-white p-2 px-3 rounded-pill shadow-sm border">
                        <i class="bi bi-calendar3 text-primary me-2"></i>
                        <span class="small fw-semibold">
                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy" />
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-uppercase fw-bold text-muted mb-1" style="font-size: 0.7rem;">Total Users</p>
                            <h3 class="fw-bold mb-0">${totalUsers}</h3>
                        </div>
                        <div class="stat-icon bg-primary bg-opacity-10 text-primary">
                            <i class="bi bi-people"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <span class="text-success small fw-bold"><i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i> Active Now</span>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-uppercase fw-bold text-muted mb-1" style="font-size: 0.7rem;">Live Listings</p>
                            <h3 class="fw-bold mb-0">${activeProducts}</h3>
                        </div>
                        <div class="stat-icon bg-success bg-opacity-10 text-success">
                            <i class="bi bi-shop"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <span class="text-muted small">Items available for trade</span>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-uppercase fw-bold text-muted mb-1" style="font-size: 0.7rem;">New College Requests</p>
                            <h3 class="fw-bold mb-0">${pendingColleges}</h3>
                        </div>
                        <div class="stat-icon bg-warning bg-opacity-10 text-warning">
                            <i class="bi bi-building-up"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="ManageCollege.jsp" class="text-decoration-none small fw-bold text-warning">Action Required →</a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-xl-3">
                <div class="card stat-card p-4">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-uppercase fw-bold text-muted mb-1" style="font-size: 0.7rem;">Total Volume</p>
                            <h3 class="fw-bold mb-0">₹ <fmt:formatNumber value="${totalSales}" maxFractionDigits="1" /></h3>
                        </div>
                        <div class="stat-icon bg-info bg-opacity-10 text-info">
                            <i class="bi bi-currency-exchange"></i>
                        </div>
                    </div>
                    <div class="mt-3">
                        <span class="text-muted small">Value of sold products</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Recent Products -->
            <div class="col-lg-8">
                <div class="card card-table h-100">
                    <div class="card-header bg-transparent py-4 px-4 border-0 d-flex align-items-center justify-content-between">
                        <h5 class="fw-bold mb-0">Recent Activity</h5>
                        <a href="Products.jsp" class="btn btn-sm btn-light border rounded-pill px-3 fw-bold text-muted">View Ledger</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Product Details</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${recentProducts}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <img src="${not empty product.image1 ? 'uploads/' : 'https://placehold.co/100'}${product.image1}" 
                                                     class="product-img me-3" alt="Product">
                                                <div>
                                                    <div class="fw-bold small">${product.title}</div>
                                                    <div class="text-muted" style="font-size: 0.75rem;">@${product.seller.name} • ${product.brand}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td><span class="badge badge-soft badge-soft-primary">${product.category.name}</span></td>
                                        <td class="fw-bold">₹ ${product.price}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.status == 'AVAILABLE'}">
                                                    <span class="badge badge-soft badge-soft-success">Available</span>
                                                </c:when>
                                                <c:when test="${product.status == 'SOLD'}">
                                                    <span class="badge badge-soft badge-soft-info">Sold</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-soft-warning">${product.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <a href="Products.jsp" class="btn btn-sm btn-outline-primary rounded-pill px-3">Review</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty recentProducts}">
                                    <tr>
                                        <td colspan="5" class="text-center py-5 text-muted">No recent products found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Pending Colleges -->
            <div class="col-lg-4">
                <div class="card card-table h-100">
                    <div class="card-header bg-transparent py-4 px-4 border-0 d-flex align-items-center justify-content-between">
                        <h5 class="fw-bold mb-0">College Requests</h5>
                        <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-2 rounded-pill fw-bold" style="font-size: 0.7rem;">${pendingColleges} PENDING</span>
                    </div>
                    <div class="card-body px-4 pt-0">
                        <div class="list-group list-group-flush">
                            <c:forEach var="req" items="${pendingRequests}">
                                <div class="list-group-item request-item p-3 border-0 shadow-sm">
                                    <div class="d-flex align-items-start mb-3">
                                        <div class="bg-warning bg-opacity-10 text-warning rounded-circle p-2 me-3" style="width: 45px; height: 45px; display: flex; align-items: center; justify-content: center;">
                                            <i class="bi bi-bank fs-5"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="fw-bold mb-1 small">${req.collegeName}</h6>
                                            <p class="text-muted mb-0" style="font-size: 0.7rem;">${req.address}, ${req.pincode}</p>
                                        </div>
                                    </div>
                                    <div class="d-flex gap-2 justify-content-end">
                                        <a href="ManageCollege.jsp" class="btn btn-primary btn-sm rounded-pill px-3 fw-bold">Review</a>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty pendingRequests}">
                                <div class="text-center py-5">
                                    <div class="text-muted mb-3"><i class="bi bi-check2-circle fs-1"></i></div>
                                    <p class="text-muted small">All caught up!</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>