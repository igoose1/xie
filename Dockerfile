# build static
FROM floryn90/hugo:0.165.0-ext AS builder

WORKDIR /xie
COPY . .
RUN hugo

# serve static
FROM caddy:2.11.4

COPY --from=builder /xie/public /srv
COPY Caddyfile /etc/caddy/Caddyfile
