<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusKart | My Listings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root { 
            --primary: #14b8a6; 
            --primary-light: #f0fdfa;
            --secondary: #64748b;
            --success: #22c55e;
            --danger: #ef4444;
            --warning: #f59e0b;
            --card-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background: #f8fafc; 
            color: #1e293b;
        }

        .navbar { 
            background: rgba(255,255,255,0.9) !important; 
            backdrop-filter: blur(12px); 
            border-bottom: 1px solid #e2e8f0;
        }

        .page-header {
            background: white;
            padding: 2rem 0;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 2rem;
        }

        /* Table Card Styles */
        .table-section {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            margin-bottom: 2.5rem;
            overflow: hidden;
        }

        .section-header {
            padding: 1.25rem 1.5rem;
            background: white;
            border-bottom: 2px solid #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-header h4 {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-header h4 i {
            color: var(--primary);
            font-size: 1.5rem;
        }

        .badge-count {
            background: var(--primary-light);
            color: var(--primary);
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-left: 0.75rem;
        }

        .table-responsive-custom {
            overflow-x: auto;
            padding: 0 1.5rem 1.5rem 1.5rem;
        }

        .custom-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 0.75rem;
            margin: 0;
        }

        .custom-table tbody tr {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            transition: all 0.2s ease;
        }

        .custom-table tbody tr:hover {
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.06);
            transform: translateY(-2px);
        }

        .custom-table td {
            padding: 1rem;
            vertical-align: middle;
            border: none;
            background: #fafbfc;
        }

        .custom-table td:first-child {
            border-top-left-radius: 16px;
            border-bottom-left-radius: 16px;
            padding-left: 1.5rem;
        }

        .custom-table td:last-child {
            border-top-right-radius: 16px;
            border-bottom-right-radius: 16px;
            padding-right: 1.5rem;
        }

        .product-image-cell {
            width: 80px;
        }

        .product-image {
            width: 70px;
            height: 70px;
            border-radius: 12px;
            object-fit: cover;
            border: 2px solid white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .product-info h6 {
            font-weight: 700;
            margin-bottom: 0.25rem;
            color: #1e293b;
        }

        .product-info .description {
            font-size: 0.875rem;
            color: #64748b;
            display: block;
            margin-bottom: 0.25rem;
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .price-badge {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--primary);
            background: var(--primary-light);
            padding: 0.35rem 1rem;
            border-radius: 50px;
            display: inline-block;
        }

        .price-badge.sold {
            color: var(--secondary);
            background: #f1f5f9;
        }

        .price-badge.removed {
            color: var(--danger);
            background: #fef2f2;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .btn-table {
            padding: 0.5rem 1rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.875rem;
            transition: all 0.2s;
            border: 1px solid transparent;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .btn-table i {
            font-size: 1rem;
        }

        .btn-outline-success {
            border-color: #22c55e;
            color: #22c55e;
            background: white;
        }

        .btn-outline-success:hover {
            background: #22c55e;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(34, 197, 94, 0.2);
        }

        .btn-outline-primary {
            border-color: var(--primary);
            color: var(--primary);
            background: white;
        }

        .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(20, 184, 166, 0.2);
        }

        .btn-outline-danger {
            border-color: var(--danger);
            color: var(--danger);
            background: white;
        }

        .btn-outline-danger:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(239, 68, 68, 0.2);
        }

        .btn-outline-warning {
            border-color: var(--warning);
            color: var(--warning);
            background: white;
        }

        .btn-outline-warning:hover {
            background: var(--warning);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(245, 158, 11, 0.2);
        }

        .btn-sell {
            background: var(--primary);
            border: none;
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            box-shadow: 0 4px 6px -1px rgba(20, 184, 166, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s;
        }

        .btn-sell:hover {
            background: #0d9488;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(20, 184, 166, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 4rem 1.5rem;
            background: #f8fafc;
            border-radius: 16px;
        }

        .empty-state i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 1.5rem;
        }

        .empty-state p {
            color: #64748b;
            margin-bottom: 1.5rem;
        }

        /* Modal Styles */
        .modal-content {
            border: none;
            border-radius: 24px;
            box-shadow: var(--card-shadow);
        }

        .modal-header {
            border-bottom: 2px solid #f1f5f9;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.375rem;
        }

        .form-control, .form-select {
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            padding: 0.6rem 1rem;
            font-size: 0.95rem;
            transition: all 0.2s;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(20, 184, 166, 0.1);
        }

        .image-preview {
            background: #f8fafc;
            border-radius: 12px;
            padding: 0.75rem;
            border: 1.5px dashed #e2e8f0;
            margin-top: 0.5rem;
        }

        .image-preview img {
            border-radius: 8px;
            border: 2px solid white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            max-height: 120px;
            width: auto;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header .d-flex {
                flex-direction: column;
                gap: 1.5rem;
                text-align: center;
            }
            
            .btn-sell {
                width: 100%;
                justify-content: center;
            }

            .section-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .action-buttons {
                justify-content: flex-start;
            }

            .custom-table td {
                display: block;
                width: 100%;
                text-align: left;
                padding: 0.75rem 1rem;
            }

            .custom-table td:first-child {
                padding-top: 1.5rem;
            }

            .custom-table td:last-child {
                padding-bottom: 1.5rem;
            }

            .product-image-cell {
                width: 100%;
            }

            .product-info .description {
                max-width: 100%;
                white-space: normal;
            }
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <jsp:include page="components/Navbar.jsp"></jsp:include>

    <!-- HEADER SECTION -->
    <div class="page-header mt-5">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="fw-bold mb-1">My Listings</h1>
                    <p class="text-muted mb-0">Manage and track your items for sale</p>
                </div>
                <a href="sell" class="btn btn-sell">
                    <i class="bi bi-plus-lg"></i> Sell New Item
                </a>
            </div>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="container mb-5">

        <!-- Available Products Section -->
        <div class="table-section">
            <div class="section-header">
                <h4>
                    <i class="bi bi-box-seam"></i> Available Products
                    <span class="badge-count">${availableProducts.size()}</span>
                </h4>
            </div>
            
            <div class="table-responsive-custom">
                <c:choose>
                    <c:when test="${not empty availableProducts}">
                        <table class="custom-table">
                            <tbody>
                                <c:forEach var="p" items="${availableProducts}">
                                    <tr>
                                        <td class="product-image-cell">
                                            <img src="/uploads/${p.image1}" class="product-image" alt="${p.title}">
                                        </td>
                                        <td>
                                            <div class="product-info">
                                                <h6>${p.title}</h6>
                                                <span class="description">${p.shortDescription}</span>
                                                <span class="price-badge">₹${p.price}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="markSold?id=${p.id}" class="btn-table btn-outline-success" title="Mark as Sold">
                                                    <i class="bi bi-check-circle"></i> <span class="d-none d-md-inline">Sold</span>
                                                </a>
                                                <a href="openEditProduct?id=${p.id}" class="btn-table btn-outline-primary" title="Edit">
                                                    <i class="bi bi-pencil-square"></i> <span class="d-none d-md-inline">Edit</span>
                                                </a>
                                                <a href="removeProduct?id=${p.id}" class="btn-table btn-outline-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this item?')">
                                                    <i class="bi bi-trash"></i> <span class="d-none d-md-inline">Delete</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h5>No available products</h5>
                            <p>Start selling by clicking the "Sell New Item" button above.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Sold Products Section -->
        <div class="table-section">
            <div class="section-header">
                <h4>
                    <i class="bi bi-tags"></i> Sold Products
                    <span class="badge-count">${soldProducts.size()}</span>
                </h4>
            </div>
            
            <div class="table-responsive-custom">
                <c:choose>
                    <c:when test="${not empty soldProducts}">
                        <table class="custom-table">
                            <tbody>
                                <c:forEach var="p" items="${soldProducts}">
                                    <tr>
                                        <td class="product-image-cell">
                                            <img src="/uploads/${p.image1}" class="product-image" alt="${p.title}">
                                        </td>
                                        <td>
                                            <div class="product-info">
                                                <h6>${p.title}</h6>
                                                <span class="description">${p.shortDescription}</span>
                                                <span class="price-badge sold">₹${p.price}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="undoToAvailable?id=${p.id}" class="btn-table btn-outline-warning" title="Restore to Available">
                                                    <i class="bi bi-arrow-return-left"></i> <span class="d-none d-md-inline">Undo</span>
                                                </a>
                                                <a href="removeProduct?id=${p.id}" class="btn-table btn-outline-danger" title="Delete" onclick="return confirm('Are you sure you want to delete this item?')">
                                                    <i class="bi bi-trash"></i> <span class="d-none d-md-inline">Delete</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h5>No sold products yet</h5>
                            <p>When you mark items as sold, they'll appear here.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Removed Products Section -->
        <div class="table-section">
            <div class="section-header">
                <h4>
                    <i class="bi bi-archive"></i> Removed Products
                    <span class="badge-count">${removedProducts.size()}</span>
                </h4>
            </div>
            
            <div class="table-responsive-custom">
                <c:choose>
                    <c:when test="${not empty removedProducts}">
                        <table class="custom-table">
                            <tbody>
                                <c:forEach var="p" items="${removedProducts}">
                                    <tr>
                                        <td class="product-image-cell">
                                            <img src="/uploads/${p.image1}" class="product-image" alt="${p.title}">
                                        </td>
                                        <td>
                                            <div class="product-info">
                                                <h6>${p.title}</h6>
                                                <span class="description">${p.shortDescription}</span>
                                                <span class="price-badge removed">₹${p.price}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="undoToAvailable?id=${p.id}" class="btn-table btn-outline-success" title="Restore to Available">
                                                    <i class="bi bi-arrow-repeat"></i> <span class="d-none d-md-inline">Restore</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="bi bi-inbox"></i>
                            <h5>No removed products</h5>
                            <p>Deleted items will appear here and can be restored.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <c:if test="${editProduct != null}">
        <script>
            window.onload = function() {
                var myModal = new bootstrap.Modal(document.getElementById('editModal'));
                myModal.show();
            }
        </script>
    </c:if>

    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="fw-bold mb-0">
                        <i class="bi bi-pencil-square me-2" style="color: var(--primary);"></i>
                        Edit Product
                    </h5>
                    <a href="/myProducts"><button type="button" class="btn-close" data-bs-dismiss="modal"></button></a>
                </div>
                <div class="modal-body">
                    <form action="updateProduct" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${editProduct.id}">

                        <!-- Title -->
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" name="title" value="${editProduct.title}" class="form-control" required>
                        </div>

                        <!-- Short Description -->
                        <div class="mb-3">
                            <label class="form-label">Short Description</label>
                            <input type="text" name="shortDescription" value="${editProduct.shortDescription}" class="form-control" required>
                        </div>

                        <!-- Full Description -->
                        <div class="mb-3">
                            <label class="form-label">Full Description</label>
                            <textarea name="description" class="form-control" rows="3" required>${editProduct.description}</textarea>
                        </div>

                        <div class="row">
                            <!-- Price -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Price (₹)</label>
                                <input type="number" name="price" value="${editProduct.price}" class="form-control" required>
                            </div>

                            <!-- Category -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category</label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach var="cat" items="${categories}">
                                        <c:if test="${cat.status == 'ACTIVE'}">
                                            <option value="${cat.id}" ${cat.id == editProduct.category.id ? 'selected' : ''}>
                                                ${cat.name}
                                            </option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Condition -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Condition</label>
                                <select name="productCondition" class="form-select">
                                    <option ${editProduct.productCondition == 'Brand New' ? 'selected' : ''}>Brand New</option>
                                    <option ${editProduct.productCondition == 'Like New' ? 'selected' : ''}>Like New</option>
                                    <option ${editProduct.productCondition == 'Good Condition' ? 'selected' : ''}>Good Condition</option>
                                    <option ${editProduct.productCondition == 'Fair' ? 'selected' : ''}>Fair</option>
                                </select>
                            </div>

                            <!-- Brand -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Brand</label>
                                <input type="text" name="brand" value="${editProduct.brand}" class="form-control">
                            </div>
                        </div>

                        <!-- Images -->
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Primary Image</label>
                                <div class="image-preview text-center">
                                    <img src="/uploads/${editProduct.image1}" class="mb-2" style="max-width: 100%; max-height: 120px;">
                                </div>
                                <input type="file" name="imageFile1" class="form-control mt-2" accept="image/png, image/jpeg">
                                <small class="text-muted">Leave empty to keep current image</small>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Secondary Image</label>
                                <div class="image-preview text-center">
                                    <img src="/uploads/${editProduct.image2}" class="mb-2" style="max-width: 100%; max-height: 120px;">
                                </div>
                                <input type="file" name="imageFile2" class="form-control mt-2" accept="image/png, image/jpeg">
                                <small class="text-muted">Leave empty to keep current image</small>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-sell w-100 mt-3">
                            <i class="bi bi-check-circle"></i> Update Product
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="components/Footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Delete confirmation for all delete links -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add confirmation to all delete links
            document.querySelectorAll('a[href*="removeProduct"]').forEach(link => {
                link.addEventListener('click', function(e) {
                    if (!confirm('Are you sure you want to delete this item? This action can be undone from the Removed section.')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>