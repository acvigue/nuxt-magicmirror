ARG NODE_VERSION=20

FROM node:${NODE_VERSION}-slim as base

ARG PORT=3000

ENV NODE_ENV=production

WORKDIR /src

# Build
FROM base as build

COPY --link package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production=false

COPY --link . .

RUN yarn build
RUN npm prune

# Run
FROM node:${NODE_VERSION}-alpine

ENV PORT=$PORT

COPY --from=build /src/.output /src/.output
# Optional, only needed if you rely on unbundled dependencies
# COPY --from=build /src/node_modules /src/node_modules

CMD [ "node", ".output/server/index.mjs" ]