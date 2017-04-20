#!/bin/bash -e
# =====================================================================
# Build script running BIND in Docker environment
#
# Source: 
# Web: 
#
# =====================================================================

START_DELAY=5

BIND_DNS_HOME=/etc/bind
BIND_DNS_OG_CFG=named.conf.recursive
BIND_DNS_NEW_CFG=named.conf

# Error codes
E_ILLEGAL_ARGS=126

# Help function used in error messages and -h option
usage() {
  echo ""
  echo "Docker entry script for BIND service container"
  echo ""
  echo "-f: Start BIND in foreground with existing configuration."
  echo "-h: Show this help."
  
  echo "-s: Initialize environment like -i and start BIND in foreground." !!!!!
  echo ""
}


initConfig() {
  if [ ! "$(ls --ignore .keys --ignore .authoritative --ignore .recursive --ignore -A ${BIND_DNS_HOME})"  ]; then
    cp -r ${BIND_DNS_HOME}/${BIND_DNS_OG_CFG} ${BIND_DNS_HOME}/${BIND_DNS_NEW_CFG}
    sed -i "s,//forwarders {,forwarders {," ${BIND_DNS_HOME}/named.conf
    sed -i -e  "s,//[[:space:]]123.123.123.123;,${BIND_DNS_SERVER_2};," ${BIND_DNS_HOME}/named.conf
    sed -r -e "1,/(\b[8]\.){2}([4]\.){1}[4]/s/(\b[8]\.){2}([4]\.){1}[4]/${BIND_DNS_SERVER_1};/" ${BIND_DNS_HOME}/named.conf >${BIND_DNS_HOME}/named.tmp
    mv ${BIND_DNS_HOME}/named.tmp ${BIND_DNS_HOME}/named.conf
    sed -i "s,//};,};," ${BIND_DNS_HOME}/named.conf
    cat ${BIND_DNS_HOME}/named.conf 
  else
    echo "BIND configuration already initialized........."
  fi
}


start() {
  sleep ${START_DELAY}
  named -c /etc/bind/named.conf -g -u named
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts fhis flag; do
  case ${flag} in
    f)
      start
      exit
      ;;
    h)
      usage
      exit
      ;;
    s)
      initConfig
      start
      exit
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" > 0 ]]; then
  echo "Error: To many arguments: ${*}."
  usage
  exit ${E_ILLEGAL_ARGS}
fi
