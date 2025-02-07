# FROM - Base Image
#changed node version but then started getting error
FROM node:21-alpine3.18 AS build
#solution for that error
ENV NODE_OPTIONS="--openssl-legacy-provider"


# Install Angular CLI
# RUN - Directive for running commands
#RUN mkdir /ravi
RUN npm install -g @angular/cli

# ENV - Set Environment Variables
ENV APP_PATH /angular-calculator

RUN mkdir -p "$APP_PATH"

# WORKDIR - Set App Context { cd }
WORKDIR $APP_PATH

# COPY - Copy files to image
# COPY . .
COPY . /angular-calculator

# Fetch Dependencies
RUN npm install

# Build Application
RUN ng build

# Process for Deployment
FROM nginx
#FROM httpd

# Copy Build Files to Nginx
COPY --from=build /angular-calculator/dist/angularCalc  /usr/share/nginx/html
#COPY --from=build /angular-calculator/dist/angularCalc  /usr/local/apache3/htdocs
