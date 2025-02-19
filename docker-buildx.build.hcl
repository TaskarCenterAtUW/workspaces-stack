group "default" {
    targets = [
        "osm-web",
        "pathways-editor",
        "rapid",
        "osm-cgimap",
        "frontend",
        "tasks-frontend",
        "tasks-backend",
        "osm-log-proxy",
        "osm-rails"
    ]
}

variable "WS_DOCKER_REGISTRY" {
      default = "opensidewalksdev.azurecr.io"
}

variable "ENV" {
      default = "dev"
}
    
variable "CODE_VERSION" {
      default = "0"
}
 
target "frontend" {
    context = "frontend"
    dockerfile = "Dockerfile"
    args = {
      CODE_VERSION = ""
      VITE_API_URL = "https://api.workspaces-${ENV}.sidewalks.washington.edu/api/v1/"
      VITE_OSM_URL = "https://osm.workspaces-${ENV}.sidewalks.washington.edu/"
      VITE_PATHWAYS_EDITOR_URL = "https://pathways.workspaces-${ENV}.sidewalks.washington.edu/"
      VITE_RAPID_URL = "https://rapid.workspaces-${ENV}.sidewalks.washington.edu/"
      VITE_TDEI_API_URL = "https://tdei-api-${ENV}.azurewebsites.net/api/v1/"
      VITE_TDEI_USER_API_URL = "https://tdei-usermanagement-be-${ENV}.azurewebsites.net/api/v1/"
    }  
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-frontend:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-frontend:${CODE_VERSION}"
    ]
}

target "osm-cgimap" {
    context = "osm-cgimap"
    dockerfile = "docker/ubuntu/Dockerfile2404"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-osm-cgimap:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-osm-cgimap:${CODE_VERSION}"
    ]
}

target "osm-log-proxy" {
    context = "osm-log-proxy"
    dockerfile = "Dockerfile"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-osm-log-proxy:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-osm-log-proxy:${CODE_VERSION}"
    ]
}

target "osm-rails" {
    context = "osm-rails"
    dockerfile = "Dockerfile.prod"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-osm-rails:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-osm-rails:${CODE_VERSION}"
    ]
}

target "osm-web" {
    context = "osm-web"
    dockerfile = "Dockerfile"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-osm-web:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-osm-web:${CODE_VERSION}"
    ]
}

target "pathways-editor" {
    context = "pathways-editor"
    dockerfile = "Dockerfile"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-pathways-editor:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-pathways-editor:${CODE_VERSION}"
    ]
}

target "rapid" {
    context = "rapid"
    dockerfile = "Dockerfile"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-rapid:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-rapid:${CODE_VERSION}"
    ]
}

target "tasks-backend" {
    context = "tasking-manager"
    dockerfile = "./scripts/docker/Dockerfile.backend"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-tasks-backend:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-tasks-backend:${CODE_VERSION}"
    ]
    target = "prod"
    args = {
      APP_UID = "1000"
    }
}

target "tasks-frontend" {
    context = "tasking-manager"
    dockerfile = "./scripts/docker/Dockerfile.frontend"
    tags = [
        "${WS_DOCKER_REGISTRY}/workspaces-tasks-frontend:${ENV}",
        "${WS_DOCKER_REGISTRY}/workspaces-tasks-frontend:${CODE_VERSION}"
    ]
    args = {
      TM_APP_API_URL = "https://tasks.workspaces-${ENV}.sidewalks.washington.edu/"
    }
}