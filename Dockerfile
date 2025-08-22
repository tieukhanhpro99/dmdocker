# Nhẹ, tự đóng gói binary để không lệ thuộc image có sẵn
FROM alpine:3.20

ARG SY_VERSION=v1.1.4
RUN apk add --no-cache ca-certificates tzdata curl tar \
 && curl -L -o /tmp/syncyomi.tar.gz \
   "https://github.com/SyncYomi/SyncYomi/releases/download/${SY_VERSION}/syncyomi_linux_x86_64.tar.gz" \
 && tar -xzf /tmp/syncyomi.tar.gz -C /usr/local/bin \
 && chmod +x /usr/local/bin/syncyomi \
 && rm -rf /tmp/*

# Thư mục lưu cấu hình/data (Render sẽ gắn disk vào đây)
VOLUME ["/config"]

# TZ cho tiện log
ENV TZ=Asia/Ho_Chi_Minh

# Render cấp biến PORT, ta bind 0.0.0.0 + PORT
# Nếu chưa có /config/config.toml thì tạo file tối thiểu cho đúng host/port
CMD ["/bin/sh","-lc","mkdir -p /config \
  && if [ ! -f /config/config.toml ]; then \
       printf 'host = \"0.0.0.0\"\\nport = %s\\n' \"${PORT:-10000}\" > /config/config.toml; \
     fi \
  && exec /usr/local/bin/syncyomi --config /config"]
