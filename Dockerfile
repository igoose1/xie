# build static
FROM klakegg/hugo:0.107.0 as builder

WORKDIR /xie
COPY . /xie/
RUN hugo build

# serve static
FROM caddy:2.6.4

COPY --from=builder /xie/public /srv
COPY Caddyfile /etc/caddy/Caddyfile
