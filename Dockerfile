# build static
FROM floryn90/hugo:0.123.7 AS builder

WORKDIR /xie
COPY . /xie/
RUN hugo build

# serve static
FROM caddy:2.8

COPY --from=builder /xie/public /srv
COPY Caddyfile /etc/caddy/Caddyfile
