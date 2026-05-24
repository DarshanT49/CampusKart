<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentURI = request.getRequestURI();
%>
<!-- Admin Sidebar -->
<div class="offcanvas-lg offcanvas-start admin-sidebar shadow-lg border-0" tabindex="-1" id="adminSidebar" aria-labelledby="adminSidebarLabel">
    <div class="offcanvas-header d-lg-none border-bottom border-white border-opacity-10">
        <h5 class="offcanvas-title text-white fw-bold d-flex align-items-center" id="adminSidebarLabel">
            <i class="bi bi-cart-check-fill text-info me-2"></i> CampusKart
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" data-bs-target="#adminSidebar" aria-label="Close"></button>
    </div>
    
    <div class="offcanvas-body flex-column p-0 h-100">
        <!-- Navigation Menu -->
        <div class="sidebar-content px-3 py-4 flex-grow-1">
            <small class="text-uppercase text-muted fw-bold mb-3 d-block ps-3" style="font-size: 0.65rem; letter-spacing: 1px;">Main Menu</small>
            <ul class="nav nav-pills flex-column gap-2 mb-auto">
                <li class="nav-item">
                    <a href="dashboard" class="nav-link admin-nav-link <%= currentURI.contains("dashboard") ? "active" : "" %>">
                        <i class="bi bi-grid-1x2-fill"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="colleges" class="nav-link admin-nav-link <%= currentURI.contains("/colleges") ? "active" : "" %>">
                        <i class="bi bi-building-fill"></i>
                        <span>Colleges</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="categories" class="nav-link admin-nav-link <%= currentURI.contains("categories") ? "active" : "" %>">
                        <i class="bi bi-tags-fill"></i>
                        <span>Categories</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="users" class="nav-link admin-nav-link <%= currentURI.contains("users") ? "active" : "" %>">
                        <i class="bi bi-people-fill"></i>
                        <span>Users</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="products" class="nav-link admin-nav-link <%= currentURI.contains("products") ? "active" : "" %>">
                        <i class="bi bi-cart-fill"></i>
                        <span>Products</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="reports" class="nav-link admin-nav-link <%= currentURI.contains("reports") ? "active" : "" %>">
                        <i class="bi bi-flag-fill"></i>
                        <span>Reports</span>
                    </a>
                </li>
            </ul>

            <small class="text-uppercase text-muted fw-bold mt-5 mb-3 d-block ps-3" style="font-size: 0.65rem; letter-spacing: 1px;">Account</small>
            <ul class="nav nav-pills flex-column gap-2">
                <li class="nav-item">
                    <a href="#" class="nav-link admin-nav-link">
                        <i class="bi bi-gear-fill"></i>
                        <span>Settings</span>
                    </a>
                </li>
            </ul>
        </div>
        
        <!-- Footer / Logout -->
        <div class="sidebar-footer p-3 border-top border-white border-opacity-10 mt-auto">
            <a href="logout" class="btn btn-logout w-100 d-flex align-items-center justify-content-center gap-2 py-2">
                <i class="bi bi-box-arrow-left"></i>
                <span class="fw-semibold">Sign Out</span>
            </a>
        </div>
    </div>
</div>

<style>
    :root {
        --sidebar-bg: #0f172a;
        --sidebar-hover: rgba(255, 255, 255, 0.05);
        --sidebar-active-bg: rgba(14, 165, 233, 0.15);
        --sidebar-active-text: #0ea5e9;
        --sidebar-text: #94a3b8;
        --sidebar-width: 280px;
        --navbar-height: 70px;
    }

    .admin-sidebar {
        width: var(--sidebar-width);
        background-color: var(--sidebar-bg) !important;
        position: fixed;
        top: var(--navbar-height);
        bottom: 0;
        left: 0;
        z-index: 1040;
        transition: transform 0.3s ease;
        border-right: 1px solid rgba(255, 255, 255, 0.05) !important;
    }

    .admin-nav-link {
        color: var(--sidebar-text) !important;
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 18px !important;
        border-radius: 12px !important;
        font-weight: 500;
        font-size: 0.95rem;
        transition: all 0.2s ease;
        border: 1px solid transparent;
    }

    .admin-nav-link i {
        font-size: 1.25rem;
        opacity: 0.7;
        transition: all 0.2s ease;
    }

    .admin-nav-link:hover {
        background-color: var(--sidebar-hover) !important;
        color: white !important;
        border-color: rgba(255, 255, 255, 0.05);
    }

    .admin-nav-link:hover i {
        opacity: 1;
        transform: translateX(2px);
    }

    .admin-nav-link.active {
        background-color: var(--sidebar-active-bg) !important;
        color: var(--sidebar-active-text) !important;
        box-shadow: inset 0 0 0 1px rgba(14, 165, 233, 0.2);
    }

    .admin-nav-link.active i {
        opacity: 1;
        color: var(--sidebar-active-text);
    }

    .btn-logout {
        background-color: rgba(239, 68, 68, 0.1);
        color: #ef4444;
        border: 1px solid rgba(239, 68, 68, 0.2);
        border-radius: 10px;
        transition: all 0.2s;
    }

    .btn-logout:hover {
        background-color: #ef4444;
        color: white;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
    }

    @media (max-width: 991.98px) {
        .admin-sidebar {
            top: 0;
            margin-top: 0;
            height: 100vh !important;
            transform: translateX(-100%);
        }
        
        .admin-sidebar.show {
            transform: translateX(0);
        }
    }

    /* Custom Scrollbar */
    .offcanvas-body::-webkit-scrollbar {
        width: 5px;
    }
    .offcanvas-body::-webkit-scrollbar-track {
        background: transparent;
    }
    .offcanvas-body::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 10px;
    }
    .offcanvas-body::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.2);
    }
</style>