# build static
FROM floryn90/hugo:0.123.7-ext AS builder

WORKDIR /xie
COPY . /xie/
RUN hugo --logLevel debug

# serve static
FROM caddy:2.10

COPY --from=builder /xie/public /srv
COPY Caddyfile /etc/caddy/Caddyfile
