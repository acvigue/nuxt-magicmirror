ARG NODE_VERSION=20

FROM node:${NODE_VERSION} as build

ARG PORT=3000

ENV NODE_ENV=production

WORKDIR /src

COPY --link package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production=false

COPY --link . .

RUN yarn build

# Run
FROM node:${NODE_VERSION}-alpine
WORKDIR /app
ENV PORT=$PORT

COPY --from=build /src/.output .
# Optional, only needed if you rely on unbundled dependencies
# COPY --from=build /src/node_modules /src/node_modules

CMD [ "node", "server/index.mjs" ]