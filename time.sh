#!/bin/bash

PROJECT_DIR=${PROJECT_DIR:="./project"}

usage(){
    echo "Syntax : $0 [projet] "
    exit 1
}

function log() {
    levelname="$1"
    msg="$2"
    echo "[$levelname] : $msg "
}

function log.error()
{
    log "ERR" "$1"
}

function log.info()
{
    log "INFO" "$1"
}


#project list 
#project init PROJECTNAME
#project start PROJECTNAME

project_list(){
    ls $PROJECT_DIR
}

################################################################################
#    $1 : PROJECTNAME
################################################################################
project_init(){
    projectname="$1"
    if [[ -z "$projectname" ]] ; then
        log.error "$FUNCNAME - argument missing"
        return 1
    fi

    mkdir -p ${PROJECT_DIR}/${projectname}
    project_list
}

project_start(){
    projectname=$1
    datestart="$(date +%s)"
    log.info "PROJECT $projectname START $datestart"
    echo "Press CRTL + C for STOP PROJECT"
    while : ; do echo -n "*" ; sleep 60 ; done
}

project_stop(){
    projectname=$1
    datestop="$( date +%s )"
    log.info "PROJECT $projectname STOP $datestop"
    exit 1
}

trap project_stop INT

if [[ ! -d $PROJECT_DIR ]] ; then
    log.info "Create project directory"
    mkdir -p $PROJECT_DIR > /dev/null || {
        log.error "Fail to create $PROJECT_DIR"
        exit 1
    }
fi

case $1 in
    list)
        project_list
        ;;
    init)
        project_init $2 
        ;;
    start)
        project_start $2
        ;;
    *)
        usage
esac
