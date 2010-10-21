set :application, "Staging - Production"

set :deploy_to, "/home/hosting_nosimoe/projects/staging"
set :branch, "master"
#role :scm, domain

# Rails environment. Used by application setup tasks and migrate tasks.
set :rails_env, "production"

