###########################################
# BASE IMAGE
###########################################

FROM node:14 AS builder

WORKDIR /app

COPY . .

RUN npm install && npm run build

############################################
# HERE STARTS THE MAGIC OF MULTI STAGE BUILD
############################################

FROM nginx:alpine

# Copy the compiled binary from the build stage
COPY --from=builder /app/build /usr/share/nginx/html

# declar a non-root user
USER nginx

# rum CMD 
CMD ["nginx", "-g", "daemon off;"]


