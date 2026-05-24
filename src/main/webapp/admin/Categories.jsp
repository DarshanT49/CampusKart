<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart Admin | Manage Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { 
            --primary-color: #4361ee;
            --bg-light: #f8fafc; 
        }
        body { 
            background: var(--bg-light); 
            font-family: 'Inter', -apple-system, sans-serif;
            color: #1e293b;
        }
        .main-wrapper { 
            transition: all 0.3s; 
            padding-top: 100px; 
            margin-top : 40px ;
            min-height: 100vh;
        }
        @media (min-width: 992px) { .main-wrapper { margin-left: 280px; } }
        
        .card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.02); overflow: hidden; }
        .table thead th { 
            background: #f8fafc; text-transform: uppercase; font-size: 0.7rem; 
            letter-spacing: 0.05em; font-weight: 700; color: #94a3b8; padding: 1.25rem 1rem;
        }
        .table tbody td { padding: 1.25rem 1rem; border-bottom: 1px solid #f8fafc; }
        
        .btn-action {
            width: 36px; height: 36px; display: inline-flex; align-items: center; 
            justify-content: center; border-radius: 10px; transition: 0.2s;
        }
        .modal-content { border: none; border-radius: 24px; }
        .badge-soft { font-weight: 600; padding: 0.5em 0.8em; border-radius: 8px; }
    </style>
</head>
<body>

    <%@ include file="components/AdminNavbar.jsp" %>
    <%@ include file="components/AdminSidebar.jsp" %>

    <main class="main-wrapper p-3 p-md-4 p-lg-5">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-5 gap-3">
            <div>
                <h2 class="fw-bold mb-1">Categories</h2>
                <p class="text-muted mb-0">Organize and manage the product taxonomy for the marketplace.</p>
            </div>
            <button class="btn btn-primary fw-bold px-4 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="bi bi-plus-lg me-2"></i> Add New Category
            </button>
        </div>

        <div class="card">
            <div class="card-header bg-white py-4 px-4 border-0 d-flex flex-column flex-sm-row align-items-center justify-content-between gap-3">
                <h5 class="fw-bold mb-0">All Categories</h5>
                <div class="input-group input-group-sm w-auto">
                    <span class="input-group-text bg-light border-0"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control bg-light border-0 px-3" placeholder="Filter categories...">
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Category Name</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td class="ps-4 text-muted small">#${cat.id}</td>
                                <td><span class="fw-bold">${cat.name}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${cat.status == 'ACTIVE'}">
                                            <span class="badge bg-success bg-opacity-10 text-success badge-soft">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger bg-opacity-10 text-danger badge-soft">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <a href="openEditCategory?categoryId=${cat.id}" class="btn-action btn btn-outline-primary me-1">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="toggleCategoryStatus?id=${cat.id}" 
                                       class="btn-action btn ${cat.status == 'ACTIVE' ? 'btn-outline-danger' : 'btn-outline-success'}">
                                        <i class="bi ${cat.status == 'ACTIVE' ? 'bi-trash3' : 'bi-arrow-repeat'}"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Category Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg">
                <div class="modal-header border-0 p-4 pb-0">
                    <h5 class="fw-bold">${editCategory != null ? 'Edit Category' : 'Create New Category'}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="${editCategory != null ? 'updateCategory' : 'addCategory'}" method="post">
                        <c:if test="${editCategory != null}">
                            <input type="hidden" name="id" value="${editCategory.id}">
                        </c:if>
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Category Name</label>
                            <input type="text" name="name" value="${editCategory.name}"
                                   class="form-control bg-light border-0 p-3" placeholder="e.g. Study Material" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary fw-bold p-3 rounded-3 shadow-sm">
                                ${editCategory != null ? 'Update Category' : 'Save Category'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${editCategory != null}">
        <script>window.onload = function() { new bootstrap.Modal(document.getElementById('addCategoryModal')).show(); }</script>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>