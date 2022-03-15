FROM alpine:3.10

LABEL org.opencontainers.image.source=https://github.com/jesteree/podsync-with-yt-dlp

WORKDIR /app/
RUN wget -O /usr/bin/youtube-dl https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp && \
    chmod +x /usr/bin/youtube-dl && \
    wget -q -O /app/podsync.tar.gz $(wget -q -O - https://api.github.com/repos/mxpv/podsync/releases/latest | awk -F\" '/browser_download_url.*Linux_x86_64.*/{print $(NF-1)}') && \
    cd /app && tar -xzf podsync.tar.gz && \
    chmod +x /app/podsync && \
    apk --no-cache add ca-certificates python3 ffmpeg tzdata
# Clean up
RUN rm -f /app/podsync.tar.gz

ENTRYPOINT ["/app/podsync"]
CMD ["--no-banner"]
