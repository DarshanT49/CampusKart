<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    :root {
        --primary: #0d9488;
        --primary-light: #2dd4bf;
        --primary-dark: #0f766e;
        --text-main: #1e293b;
        --navbar-bg: rgba(255, 255, 255, 0.9);
    }

    .navbar {
        background: var(--navbar-bg) !important;
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        padding: 15px 0;
        z-index: 1050; /* Ensure navbar is above other elements */
    }

    .navbar.scrolled {
        padding: 10px 0;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
        font-family: 'Poppins', sans-serif;
        font-weight: 700;
        color: var(--primary) !important;
        letter-spacing: -0.5px;
    }

    .nav-link {
        font-weight: 500;
        color: var(--text-main) !important;
        padding: 0.5rem 1rem !important;
        transition: color 0.2s ease;
    }

    .nav-link:hover {
        color: var(--primary) !important;
    }

    .nav-link.active {
        color: var(--primary) !important;
    }

    /* Sleek Search Bar */
    .search-container {
        position: relative;
        max-width: 400px;
        width: 100%;
    }

    .search-input {
        background: #f1f5f9 !important;
        border: 1px solid transparent !important;
        border-radius: 12px !important;
        padding: 10px 20px 10px 45px !important;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }

    .search-input:focus {
        background: white !important;
        border-color: var(--primary-light) !important;
        box-shadow: 0 0 0 4px rgba(45, 212, 191, 0.1) !important;
    }

    .search-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
        pointer-events: none;
    }

    /* Action Buttons */
    .btn-sell {
        background: var(--primary);
        color: white !important;
        border-radius: 12px;
        padding: 6px 28px !important;
        font-size: 0.85rem;
        font-weight: 600;
        margin-left: 12px;
        box-shadow: 0 6px 14px rgba(13, 148, 136, 0.25);
        transition: all 0.25s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
    }

    .btn-sell:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(13, 148, 136, 0.35);
    }

    .btn-login {
        color: var(--text-main);
        font-weight: 600;
        text-decoration: none;
        padding: 8px 16px;
        border-radius: 10px;
        transition: all 0.2s;
    }

    .btn-login:hover {
        background: #f1f5f9;
        color: var(--primary);
    }

    @media (max-width: 991px) {
        .search-container { max-width: 100%; margin: 15px 0; }
        .navbar-collapse {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-top: 15px;
            box-shadow: 0 20px 25px -5px rgba(0,0,0,0.1);
        }
    }
</style>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand fs-3 d-flex align-items-center" href="home">
            <i class="bi bi-lightning-charge-fill me-2"></i>CampusKart
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <!-- Search Bar -->
            <div class="mx-auto search-container d-none d-lg-block">
                <i class="bi bi-search search-icon"></i>
                <input type="text" id="topSearch" class="form-control search-input" placeholder="Search books, notes, labs...">
            </div>

            <!-- Navigation Links -->
            <ul class="navbar-nav align-items-center ms-auto">
                <li class="nav-item"><a class="nav-link px-3" href="home">Home</a></li>
                <li class="nav-item"><a class="nav-link px-3" href="browse">Browse</a></li>
                <li class="nav-item"><a class="nav-link px-3" href="chat">Chats</a></li>
                

                <!-- Auth Section -->
                <c:choose>
                    <c:when test="${empty sessionScope.loggedUser}">
                        <li class="nav-item ms-lg-3">
                            <a href="login" class="btn-login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a href="login" class="btn-sell">
                                <i class="bi bi-plus-lg me-1"></i> Sell
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item dropdown ms-lg-3">
                            <a class="nav-link dropdown-toggle d-flex align-items-center"
                               href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-2 fs-5"></i>
                                ${sessionScope.loggedUser.name}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                                <li><a class="dropdown-item py-2" href="profile.jsp"><i class="bi bi-person me-2"></i> Profile</a></li>
                                <li><a class="dropdown-item py-2" href="myProducts"><i class="bi bi-box me-2"></i> My Products</a></li>
                                <li><a class="dropdown-item py-2" href="wishlist"><i class="bi bi-heart me-2"></i> Wishlist</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item py-2 text-danger" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <c:choose>
                                <c:when test="${sessionScope.loggedUser.status == 'ACTIVE'}">
                                    <a href="sell" class="btn-sell">
                                        <i class="bi bi-plus-lg me-1"></i> Sell
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="#" class="btn-sell" onclick="alert('Your college is pending approval. You cannot sell yet.')">
                                        <i class="bi bi-plus-lg me-1"></i> Sell
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<script>
    // Scroll effect for navbar
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (navbar) {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        }
    });
</script>
