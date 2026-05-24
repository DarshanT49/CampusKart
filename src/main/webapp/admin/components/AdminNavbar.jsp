<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Admin Navbar -->
<nav class="navbar navbar-expand-lg fixed-top admin-navbar shadow-sm">
    <div class="container-fluid px-lg-4">
        <div class="d-flex align-items-center">
            <!-- Mobile Toggle -->
            <button class="btn btn-link text-white d-lg-none me-2 p-1" type="button" data-bs-toggle="offcanvas" data-bs-target="#adminSidebar" aria-controls="adminSidebar">
                <i class="bi bi-list fs-3"></i>
            </button>

            <!-- Brand -->
            <a class="navbar-brand d-flex align-items-center" href="dashboard">
                <div class="brand-icon me-2">
                    <i class="bi bi-cart-check-fill"></i>
                </div>
                <div class="brand-text d-none d-sm-block">
                    <span class="fw-bold fs-4 text-white">Campus</span><span class="fw-light fs-4 text-info text-opacity-75">Kart</span>
                    <span class="badge admin-badge ms-2">ADMIN</span>
                </div>
            </a>
        </div>

        <div class="d-flex align-items-center gap-3">
            <!-- Notifications (Placeholder) -->
            <div class="dropdown d-none d-md-block">
                <button class="btn nav-icon-btn position-relative" type="button" data-bs-toggle="dropdown">
                    <i class="bi bi-bell"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-2 border-dark" style="font-size: 0.6rem;">
                        3+
                    </span>
                </button>
                <div class="dropdown-menu dropdown-menu-end shadow border-0 mt-2 p-0" style="width: 300px;">
                    <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
                        <h6 class="mb-0 fw-bold text-dark">Notifications</h6>
                        <a href="#" class="small text-info text-decoration-none">Mark all as read</a>
                    </div>
                    <div class="p-2">
                        <a href="#" class="dropdown-item p-3 rounded-2 mb-1">
                            <div class="d-flex align-items-center">
                                <div class="icon-circle bg-info-subtle text-info me-3">
                                    <i class="bi bi-person-plus-fill"></i>
                                </div>
                                <div>
                                    <div class="small fw-bold">New user registered</div>
                                    <div class="small text-muted">2 minutes ago</div>
                                </div>
                            </div>
                        </a>
                        <!-- More notification items... -->
                    </div>
                    <a href="#" class="dropdown-item text-center p-2 border-top small text-muted">View all notifications</a>
                </div>
            </div>

            <!-- Vertical Divider -->
            <div class="vr bg-white opacity-25 d-none d-md-block mx-2" style="height: 30px;"></div>

            <!-- Profile -->
            <div class="dropdown profile-dropdown">
                <a class="d-flex align-items-center text-decoration-none dropdown-toggle py-1 px-2 rounded-pill hover-bg-white-10 transition-all" 
                   href="#" data-bs-toggle="dropdown" aria-expanded="false">
                    <div class="avatar-container me-2">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=0DCAF0&color=fff&bold=true" 
                             alt="Admin" class="rounded-circle border border-2 border-info border-opacity-50" width="36" height="36">
                        <span class="status-indicator"></span>
                    </div>
                    <div class="d-none d-lg-block">
                        <div class="fw-semibold text-white small lh-1">Admin User</div>
                        <small class="text-info text-opacity-75" style="font-size: 0.7rem;">Super Admin</small>
                    </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 mt-2 p-2">
                    <li><h6 class="dropdown-header text-uppercase small fw-bold">Manage Account</h6></li>
                    <li><a class="dropdown-item rounded-2 py-2" href="#"><i class="bi bi-person-fill me-2 opacity-50"></i>My Profile</a></li>
                    <li><a class="dropdown-item rounded-2 py-2" href="#"><i class="bi bi-gear-fill me-2 opacity-50"></i>Settings</a></li>
                    <li><a class="dropdown-item rounded-2 py-2" href="#"><i class="bi bi-shield-lock-fill me-2 opacity-50"></i>Security</a></li>
                    <li><hr class="dropdown-divider mx-2"></li>
                    <li><a class="dropdown-item rounded-2 py-2 text-danger" href="logout"><i class="bi bi-box-arrow-right me-2 opacity-75"></i>Sign Out</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<style>
    :root {
        --admin-primary: #0f172a;
        --admin-secondary: #1e293b;
        --admin-accent: #0ea5e9;
        --admin-text-muted: #94a3b8;
        --navbar-height: 70px;
    }

    .admin-navbar {
        background-color: var(--admin-primary) !important;
        height: var(--navbar-height);
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        z-index: 1060;
    }

    .brand-icon {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, var(--admin-accent), #0284c7);
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        color: white;
        font-size: 1.4rem;
        box-shadow: 0 4px 12px rgba(14, 165, 233, 0.3);
    }

    .admin-badge {
        background-color: rgba(14, 165, 233, 0.1) !important;
        color: var(--admin-accent) !important;
        border: 1px solid rgba(14, 165, 233, 0.2);
        font-weight: 600;
        font-size: 0.65rem;
        letter-spacing: 0.5px;
        padding: 0.3em 0.8em;
    }

    .nav-icon-btn {
        width: 40px;
        height: 40px;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--admin-text-muted);
        border-radius: 10px;
        transition: all 0.2s;
        border: 1px solid transparent;
    }

    .nav-icon-btn:hover {
        color: white;
        background: rgba(255, 255, 255, 0.05);
        border-color: rgba(255, 255, 255, 0.1);
    }

    .nav-icon-btn i {
        font-size: 1.25rem;
    }

    .avatar-container {
        position: relative;
    }

    .status-indicator {
        position: absolute;
        bottom: 2px;
        right: 2px;
        width: 10px;
        height: 10px;
        background-color: #10b981;
        border: 2px solid var(--admin-primary);
        border-radius: 50%;
    }

    .profile-dropdown .dropdown-toggle::after {
        display: none;
    }

    .hover-bg-white-10:hover {
        background-color: rgba(255, 255, 255, 0.05);
    }

    .transition-all {
        transition: all 0.25s ease;
    }

    .icon-circle {
        width: 38px;
        height: 38px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
    }

    .dropdown-menu {
        animation: fadeInDown 0.2s ease-out;
    }

    @keyframes fadeInDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @media (max-width: 991.98px) {
        :root {
            --navbar-height: 60px;
        }
    }
</style>