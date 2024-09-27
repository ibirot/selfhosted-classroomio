FROM node:18-alpine

WORKDIR /app

RUN npm install -g pnpm

COPY ./package.json ./
COPY ./pnpm-lock.yaml ./

# Set environment variables
ENV IS_SELFHOSTED=true
ENV PUBLIC_SUPABASE_URL=$PUBLIC_SUPABASE_URL
ENV PUBLIC_SUPABASE_ANON_KEY=$PUBLIC_SUPABASE_ANON_KEY
ENV PRIVATE_SUPABASE_SERVICE_ROLE=$PRIVATE_SUPABASE_SERVICE_ROLE
ENV PRIVATE_APP_HOST=$PRIVATE_APP_HOST
ENV PRIVATE_APP_SUBDOMAINS=$PRIVATE_APP_SUBDOMAINS
ENV UNSPLASH_API_KEY=$UNSPLASH_API_KEY
ENV OPENAI_API_KEY=$OPENAI_API_KEY
ENV PUBLIC_SERVER_URL=$PUBLIC_SERVER_URL
ENV PUBLIC_IP_REGISTRY_KEY=$PUBLIC_IP_REGISTRY_KEY
ENV NODE_OPTIONS="--max-old-space-size=8192"

RUN pnpm i

COPY . .

WORKDIR /app/apps/dashboard

RUN pnpm i
RUN pnpm build
RUN pnpm prune --production

EXPOSE 5000

ENV NODE_ENV=production
CMD [ "node", "build" ]

# EXPOSE 5000

# CMD ["pnpm", "start"]
# CMD [ "sh", "-c", "ls -la && cd apps/dashboard && pnpm build && pnpm start" ]
