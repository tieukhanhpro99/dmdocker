FROM ghcr.io/syncyomi/syncyomi:latest

# Thư mục cấu hình mặc định
ENV SYNCYOMI_CONFIG=/config

# Bản build lắng nghe mọi địa chỉ
ENV HOST=0.0.0.0

# Render gán PORT động, lấy biến và chuyển cho SyncYomi
ENV PORT ${PORT:-8282}
EXPOSE ${PORT}

# Chạy ứng dụng
ENTRYPOINT ["/syncyomi"]
CMD ["--host=0.0.0.0", "--port=${PORT}", "--config=/config"]
