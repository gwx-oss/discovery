#!/usr/bin/env bash
# Functions to deploy the GSA PSHC discovery application development infrastructure.

#
# Deployment setup
#
cf_init_plugins() {
  local bin_dir="${1:-/usr/local/bin}"
  
  # In case we are running as a different user as the user who installed CF
  cf install-plugin -f "${bin_dir}/cf-autopilot"
  cf install-plugin -f "${bin_dir}/cf-service-connect"
}

cf_login() {
  local org="$1"
  local space="$2"
  local account="$3"
  local password="$4"
  
  cf login -a "$CF_LOGIN_URL" -u "$account" -p "$password" -o "$org" -s "$space"  
}


#
# Deployment execution
#
get_manifest_config() {
  local app="$1"
  local branch="$2"

  echo "cf/manifest-${branch}-${app}.yml"
}

deploy_app() {
  local branch="$1"
  local hostname="$2"
  local fail=0
  
  echo "________________________________________________________________________________"
  echo "deploying ${branch} app"
  # Background services
  echo "pushing ${branch}-scheduler"
  cf push discovery-scheduler -f "`get_manifest_config scheduler ${branch}`" &
  echo "pushing ${branch}-worker"
  cf push discovery-worker -f "`get_manifest_config worker ${branch}`" &
  
  # User focused display
  cf set-env discovery-web DISABLE_COLLECTSTATIC 1
  echo "host name is ${hostname}: "
  if [ "$hostname" ]
  then
    echo "________________________________________________________________________________"
    echo "cf push -n $hostname discovery-web -f get_manifest_config web ${branch}"
    cf push -n "$hostname" discovery-web -f "`get_manifest_config web ${branch}`" &
  else
    echo "________________________________________________________________________________"
    echo "cf zero-downtime-push discovery-web -f get_manifest_config web ${branch}"
    cf zero-downtime-push discovery-web -f "`get_manifest_config web ${branch}`" &
  fi
  
  echo "________________________________________________________________________________"
  echo "jobs running"
  jobs -l


  # Wait on everything to complete
  for job in `jobs -p`
  do
    wait $job || let "fail+=1"
    echo "________________________________________________________________________________"
    echo "current job: $job"
    echo "fail status: $fail"
  done
  
  echo "returning $fail"
  return "$fail"
}
