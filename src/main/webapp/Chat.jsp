<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>CampusKart | Chat</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
	rel="stylesheet">

<style>
:root {
    --primary-color: #14b8a6;
    --sidebar-bg: #ffffff;
    --chat-bg: #f1f5f9;
    --active-item: #f1f5f9;
}

body {
    background: #f8fafc;
    height: 100vh;
    overflow: hidden;
}

.main-container {
    height: calc(100vh - 70px);
    margin-top: 70px;
}

.chat-sidebar {
    background: var(--sidebar-bg);
    border-right: 1px solid #e5e7eb;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.chat-window {
    background: var(--chat-bg);
    height: 100%;
    display: flex;
    flex-direction: column;
}

.chat-header {
    background: white;
    padding: 12px 20px;
    border-bottom: 1px solid #e5e7eb;
    box-shadow: 0 2px 4px rgba(0,0,0,0.02);
    position: relative;
    z-index: 1000;
}

.product-img-small {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 8px;
}

.chat-messages {
    padding: 20px;
    overflow-y: auto;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.message {
    max-width: 75%;
    padding: 10px 16px;
    border-radius: 18px;
    font-size: 14.5px;
    position: relative;
    line-height: 1.5;
}

.sent {
    background: var(--primary-color);
    color: white;
    align-self: flex-end;
    border-bottom-right-radius: 4px;
}

.received {
    background: white;
    color: #1e293b;
    align-self: flex-start;
    border-bottom-left-radius: 4px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}

.time {
    font-size: 10px;
    margin-top: 4px;
    opacity: 0.8;
}

.chat-input-area {
    background: white;
    padding: 15px 25px;
    border-top: 1px solid #e5e7eb;
}

.input-group {
    background: #f8fafc;
    border-radius: 25px;
    padding: 5px 15px;
    border: 1px solid #e2e8f0;
}

.input-group input {
    border: none;
    background: transparent;
    box-shadow: none !important;
    padding: 8px 5px;
}

.send-btn {
    background: var(--primary-color);
    color: white;
    border: none;
    width: 38px;
    height: 38px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s;
}

.send-btn:hover {
    transform: scale(1.05);
    background: #0d9488;
}

.conversation-item {
    transition: background 0.2s;
    border-bottom: 1px solid #f1f5f9;
}

.conversation-item:hover {
    background: #f8fafc;
}

.conversation-item.active {
    background: var(--active-item);
    border-left: 4px solid var(--primary-color);
}

.status-badge {
    font-size: 10px;
    padding: 3px 8px;
    border-radius: 10px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
}

.badge-buying {
    background: #dcfce7;
    color: #166534;
}

.badge-selling {
    background: #fef9c3;
    color: #854d0e;
}

/* Custom Scrollbar */
::-webkit-scrollbar {
    width: 6px;
}
::-webkit-scrollbar-track {
    background: transparent;
}
::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 10px;
}
</style>
</head>

<body>

	<jsp:include page="components/Navbar.jsp" />

	<div class="container-fluid main-container p-0">
		<div class="row g-0 h-100">

			<!-- ================= LEFT SIDE: CONVERSATIONS ================= -->

			<div class="col-md-4 col-lg-3 chat-sidebar">

				<!-- SEARCH/FILTER -->
				<div class="p-3 border-bottom">
                    <h5 class="fw-bold mb-3">Messages</h5>
					<div class="d-flex gap-2">
                        <c:set var="currentFilter" value="${activeFilter.toLowerCase().trim()}" />
						<a href="chat?filter=all"
							class="btn btn-sm flex-grow-1 ${empty currentFilter or currentFilter == 'all' ? 'btn-dark' : 'btn-outline-secondary'}">
							All </a> 
                        <a href="chat?filter=buying"
							class="btn btn-sm flex-grow-1 ${currentFilter == 'buying' ? 'btn-dark' : 'btn-outline-secondary'}">
							Buying </a> 
                        <a href="chat?filter=selling"
							class="btn btn-sm flex-grow-1 ${currentFilter == 'selling' ? 'btn-dark' : 'btn-outline-secondary'}">
							Selling </a>
					</div>
				</div>

				<!-- LIST -->
				<div class="flex-grow-1 overflow-auto">

					<c:if test="${not empty conversations}">
                        <c:forEach var="c" items="${conversations}">
                            <c:set var="p" value="${productMap[c.id]}" />
                            <c:set var="other" value="${otherUserMap[c.id]}" />
                            <c:set var="isBuying" value="${c.buyerId == sessionScope.loggedUser.id}" />

                            <a href="chat?conversationId=${c.id}&filter=${activeFilter}"
                               class="text-decoration-none text-dark conversation-item d-block ${selectedConversation.id == c.id ? 'active' : ''}">

                                <div class="p-3">
                                    <div class="d-flex align-items-center">
                                        <!-- PRODUCT IMAGE -->
                                        <c:if test="${p != null}">
                                            <img src="/uploads/${p.image1}" class="product-img-small me-3">
                                        </c:if>

                                        <div class="flex-grow-1 min-width-0">
                                            <div class="d-flex justify-content-between align-items-center mb-1">
                                                <div class="fw-bold text-truncate" style="max-width: 150px;">
                                                    ${p.title}
                                                </div>
                                                <div class="text-success small fw-bold">
                                                    ₹${p.price}
                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="text-muted small text-truncate">
                                                    <c:choose>
                                                        <c:when test="${isBuying}">
                                                            Seller: ${other.name}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Buyer: ${other.name}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <span class="status-badge ${isBuying ? 'badge-buying' : 'badge-selling'}">
                                                    ${isBuying ? 'Buying' : 'Selling'}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
					</c:if>

					<c:if test="${empty conversations}">
						<div class="p-5 text-center text-muted">
                            <i class="bi bi-chat-dots fs-1 d-block mb-3 opacity-25"></i>
                            No conversations yet
                        </div>
					</c:if>

				</div>

			</div>

			<!-- ================= RIGHT SIDE: CHAT WINDOW ================= -->

			<div class="col-md-8 col-lg-9 chat-window">

				<c:if test="${selectedConversation != null}">

					<!-- HEADER -->
					<div class="chat-header d-flex align-items-center justify-content-between">
						<div class="d-flex align-items-center">
							<img src="/uploads/${product.image1}" class="product-img-small me-3">
							<div>
								<div class="fw-bold">${product.title}</div>
								<div class="small text-muted">
                                    <c:choose>
                                        <c:when test="${selectedConversation.buyerId == sessionScope.loggedUser.id}">
                                            Seller: <strong>${otherUser.name}</strong>
                                        </c:when>
                                        <c:otherwise>
                                            Buyer: <strong>${otherUser.name}</strong>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
							</div>
						</div>
                        <div class="d-flex align-items-center gap-2">
                            <div class="text-end me-2">
                                <div class="text-success fw-bold">₹ ${product.price}</div>
                                <a href="viewProduct?id=${product.id}" class="btn btn-sm btn-outline-primary py-0" style="font-size: 11px;">View Product</a>
                            </div>
                            
                            <!-- ACTION MENU -->
                            <div class="dropdown">
                                <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots-vertical"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0">
                                    <li>
                                        <c:choose>
                                            <c:when test="${isBlockedByMe}">
                                                <a class="dropdown-item text-primary" href="javascript:void(0)" onclick="handleBlockAction('unblock')">
                                                    <i class="bi bi-person-check me-2"></i> Unblock User
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="dropdown-item text-danger" href="javascript:void(0)" onclick="handleBlockAction('block')">
                                                    <i class="bi bi-person-x me-2"></i> Block User
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#reportModal">
                                            <i class="bi bi-flag me-2"></i> Report User
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
					</div>

					<!-- MESSAGES -->
					<div class="chat-messages" id="chatMessages">
                        
                        <c:if test="${isBlocked}">
                            <div class="alert alert-warning text-center py-2 mb-3" style="font-size: 13px;">
                                <c:choose>
                                    <c:when test="${isBlockedByMe}">
                                        You have blocked this user. <a href="javascript:void(0)" onclick="handleBlockAction('unblock')">Unblock</a> to send messages.
                                    </c:when>
                                    <c:otherwise>
                                        This conversation is read-only.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

						<c:if test="${not empty messages}">
							<c:forEach var="m" items="${messages}">
								<c:set var="isSent" value="${m.senderId == sessionScope.loggedUser.id}" />
                                <div class="message ${isSent ? 'sent' : 'received'}">
                                    ${m.message}
                                    <div class="time ${isSent ? 'text-end' : ''}">
                                        <small>${m.createdAt}</small>
                                    </div>
                                </div>
							</c:forEach>
						</c:if>

						<c:if test="${empty messages}">
							<div class="text-center text-muted mt-5" id="noMessages">
                                <div class="display-6 mb-2">👋</div>
                                <p>Start a conversation with ${otherUser.name}</p>
                            </div>
						</c:if>

					</div>

					<!-- INPUT AREA -->
					<div class="chat-input-area">
						<form id="chatForm">
							<div class="input-group">
								<input type="text" id="messageInput" class="form-control shadow-none"
									placeholder="${isBlocked ? 'You cannot send messages' : 'Type your message here...'}" 
                                    autocomplete="off" required ${isBlocked ? 'disabled' : ''}>
								<button type="submit" class="send-btn" ${isBlocked ? 'disabled' : ''}>
									<i class="bi bi-send-fill"></i>
								</button>
							</div>
						</form>
					</div>

				</c:if>

				<c:if test="${selectedConversation == null}">
					<div class="d-flex flex-column justify-content-center align-items-center h-100 text-muted opacity-50">
						<i class="bi bi-chat-right-quote display-1 mb-4"></i>
						<h4>Select a conversation to start chatting</h4>
					</div>
				</c:if>

			</div>

		</div>
	</div>

    <!-- REPORT MODAL -->
    <div class="modal fade" id="reportModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header border-bottom-0">
                    <h5 class="modal-title fw-bold">Report User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="reportForm">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Reason for reporting</label>
                            <select class="form-select shadow-none" id="reportReason" required>
                                <option value="">Select a reason</option>
                                <option value="SPAM">Spam</option>
                                <option value="HARASSMENT">Harassment</option>
                                <option value="INAPPROPRIATE_CONTENT">Inappropriate Content</option>
                                <option value="FRAUD">Fraud/Scam</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Details (Optional)</label>
                            <textarea class="form-control shadow-none" id="reportDetails" rows="3" placeholder="Provide more context..."></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-danger py-2 fw-bold">Submit Report</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

	<script>
		const chatMessages = document.getElementById("chatMessages");
        const chatForm = document.getElementById('chatForm');
        const messageInput = document.getElementById('messageInput');
		
        if (chatMessages) {
			chatMessages.scrollTop = chatMessages.scrollHeight;
		}

		let stompClient = null;
		const conversationId = "${selectedConversation.id}";
		const loggedUserId = "${sessionScope.loggedUser.id}";
        const otherUserId = "${otherUser.id}";

		function connect() {
			if (!conversationId || conversationId === "") return;

			const socket = new SockJS('/ws');
			stompClient = Stomp.over(socket);
			stompClient.debug = null; 

			stompClient.connect({}, function (frame) {
				stompClient.subscribe('/topic/messages/' + conversationId, function (messageOutput) {
					showMessage(JSON.parse(messageOutput.body));
				});
			});
		}

		function sendMessage(event) {
			event.preventDefault();
			const messageContent = messageInput.value.trim();

			if (messageContent && stompClient) {
				const chatMessage = {
					senderId: loggedUserId,
					message: messageContent,
					conversationId: conversationId
				};
				stompClient.send("/app/chat.sendMessage/" + conversationId, {}, JSON.stringify(chatMessage));
				messageInput.value = '';
			}
		}

		function showMessage(message) {
			const messageDiv = document.createElement('div');
			const isSent = message.senderId == loggedUserId;
			messageDiv.className = `message ${isSent ? 'sent' : 'received'}`;
			
			const now = new Date();
			const timeStr = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

			// Use textContent for message body to prevent XSS
			const textNode = document.createTextNode(message.message);
			messageDiv.appendChild(textNode);
			
			const timeDiv = document.createElement('div');
			timeDiv.className = `time \${isSent ? 'text-end' : ''}`;
			timeDiv.innerHTML = `<small>\${timeStr}</small>`;
			messageDiv.appendChild(timeDiv);

			chatMessages.appendChild(messageDiv);
			chatMessages.scrollTop = chatMessages.scrollHeight;
			
			const noMessages = document.getElementById('noMessages');
			if (noMessages) noMessages.remove();
		}

        async function handleBlockAction(action) {
            if (!confirm(`Are you sure you want to \${action} this user?`)) return;

            try {
                const response = await fetch(`/api/user/\${action}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ blockedId: otherUserId })
                });

                if (response.ok) {
                    location.reload();
                } else {
                    alert('Failed to perform action');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred');
            }
        }

        document.getElementById('reportForm')?.addEventListener('submit', async (e) => {
            e.preventDefault();
            const reason = document.getElementById('reportReason').value;
            const details = document.getElementById('reportDetails').value;

            try {
                const response = await fetch('/api/user/report', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        reportedId: otherUserId,
                        conversationId: conversationId,
                        reason: reason,
                        details: details
                    })
                });

                if (response.ok) {
                    alert('User reported successfully');
                    bootstrap.Modal.getInstance(document.getElementById('reportModal')).hide();
                } else {
                    alert('Failed to submit report');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred');
            }
        });

		document.addEventListener('DOMContentLoaded', function() {
			if (conversationId) {
                connect();
            }
			if (chatForm) {
				chatForm.addEventListener('submit', sendMessage);
			}
		});
	</script>

</body>
</html>
