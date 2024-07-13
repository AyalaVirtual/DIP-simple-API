# The FROM instruction initializes a new build stage and sets the base image for subsequent instructions. This sets the base image as node:18, which is a Docker image that comes pre-installed with Node.js version 18. This base image is the foundation of your Docker image. All other instructions in the Dockerfile will build upon this base. 
FROM --platform=linux/amd64 node:18

# The WORKDIR instruction sets a specific directory in the Docker image as the working directory to be used for any subsequent instructions (i.e.  RUN, CMD, ENTRYPOINT, COPY and ADD). Any subsequent instructions will be run from this directory. 
WORKDIR /usr/src/app

# This is a wildcard that is used to ensure everything starting with "package" and ending with ".json (package.json AND package-lock.json) are copied into the working directory. 
COPY package*.json ./

# This installs the app dependencies
RUN npm install

# This copies the rest of the application code into the working directory
COPY . .

# This creates a "dist" folder and comppiles everything to JavaScript from TypeScript (the production build) 
RUN npm run build

# This exposes the port on which the app will run
EXPOSE 3001

# This starts the server using the production build
CMD ["npm", "run", "start:prod"]