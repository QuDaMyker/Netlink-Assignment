# --- Builder Stage ---
FROM node:20-slim AS builder
WORKDIR /app
COPY package.json yarn.lock* ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# --- Runtime Stage ---
FROM node:20-slim
RUN apt-get update && apt-get install -y wget gnupg lsb-release netcat-openbsd \
  && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get update && apt-get install -y postgresql-client-17 \
  && apt-get purge -y wget gnupg lsb-release \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY .env.production .env
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma

RUN yarn prisma generate
# RUN yarn prisma db push

COPY wait-for-postgres.sh /usr/local/bin/wait-for-postgres.sh
RUN chmod +x /usr/local/bin/wait-for-postgres.sh

EXPOSE 3000
CMD ["/usr/local/bin/wait-for-postgres.sh", "db", "5432", "yarn", "start:prod"]
