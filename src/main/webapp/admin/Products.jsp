<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | Manage Products</title>
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
        .product-img { width: 52px; height: 52px; object-fit: cover; border-radius: 14px; border: 2px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .badge-soft { font-weight: 600; padding: 0.5em 0.8em; border-radius: 8px; }
    </style>
</head>
<body>

    <%@ include file="components/AdminNavbar.jsp" %>
    <%@ include file="components/AdminSidebar.jsp" %>

    <main class="main-wrapper p-3 p-md-4 p-lg-5">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5 gap-3">
            <div>
                <h2 class="fw-bold mb-1">Products</h2>
                <p class="text-muted mb-0">Monitor marketplace inventory and ensure listing quality.</p>
            </div>
            <div class="d-flex gap-2">
                <button class="btn btn-white shadow-sm border rounded-pill px-4 fw-bold">
                    <i class="bi bi-filter me-2"></i> Filter
                </button>
                <button class="btn btn-primary fw-bold px-4 py-2 rounded-pill shadow-sm">
                    <i class="bi bi-download me-2"></i> Export Ledger
                </button>
            </div>
        </div>

        <!-- Active Inventory -->
        <div class="card mb-5">
            <div class="card-header bg-white py-4 px-4 border-0 d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">
                <h5 class="fw-bold mb-0">Active Inventory</h5>
                <div class="input-group input-group-sm w-auto">
                    <span class="input-group-text bg-light border-0"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control bg-light border-0 px-3" placeholder="Search listings...">
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Product details</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <img src="/uploads/${product.image1}" class="product-img me-3" onerror="this.src='https://placehold.co/100'">
                                        <div>
                                            <div class="fw-bold">${product.title}</div>
                                            <div class="text-muted small">Seller: @${product.seller.name}</div>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="badge bg-primary bg-opacity-10 text-primary badge-soft">${product.category.name}</span></td>
                                <td class="fw-bold text-dark">₹ ${product.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.status == 'AVAILABLE'}">
                                            <span class="badge bg-success bg-opacity-10 text-success badge-soft">Available</span>
                                        </c:when>
                                        <c:when test="${product.status == 'SOLD'}">
                                            <span class="badge bg-info bg-opacity-10 text-info badge-soft">Sold</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="/viewProduct?id=${product.id}" class="btn btn-sm btn-outline-primary rounded-pill px-3 me-1">Details</a>
                                    <a href="removeProduct?id=${product.id}" class="btn btn-sm btn-outline-danger rounded-pill px-3">Remove</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Removed Inventory Section -->
        <h5 class="fw-bold mb-4 d-flex align-items-center text-danger">
            <span class="bg-danger p-1 rounded-2 me-2" style="width: 8px; height: 24px; display: inline-block;"></span>
            Removed Items
        </h5>
        <div class="card border border-danger border-opacity-10">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <tbody>
                        <c:forEach var="product" items="${removedProducts}">
                            <tr class="bg-light bg-opacity-50">
                                <td class="ps-4">
                                    <div class="d-flex align-items-center opacity-75">
                                        <img src="/uploads/${product.image1}" class="product-img me-3 grayscale">
                                        <div>
                                            <div class="fw-bold text-muted">${product.title}</div>
                                            <small class="text-muted">ID: #${product.id}</small>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="text-muted small">${product.category.name}</span></td>
                                <td class="text-muted">₹ ${product.price}</td>
                                <td><span class="badge bg-danger bg-opacity-10 text-danger badge-soft">Removed</span></td>
                                <td class="text-end pe-4">
                                    <a href="restoreProduct?id=${product.id}" class="btn btn-sm btn-success rounded-pill px-3">Restore</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty removedProducts}">
                            <tr><td colspan="5" class="text-center py-4 text-muted small">No removed products to show.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>