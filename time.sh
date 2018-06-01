#!/bin/bash

PROJECT_DIR=${PROJECT_DIR:="./project"}
BIN_NAME=$0
DATE_START=""
DATE_STOP=""

usage(){
    echo "Syntax : $BIN_NAME [list|init|start] ARGS"
    exit 1
}

function log() {
    levelname="$1"
    msg="$2"
    echo " $(date ) [$levelname] : $msg "
}

function log.error()
{
    log "ERR" "$1"
}

function log.info()
{
    log "INFO" "$1"
}

project_list(){
    ls "$PROJECT_DIR"
}

################################################################################
#    $1 : PROJECTNAME
################################################################################
project_init(){
    projectname="$1"
    if [[ -z "$projectname" ]] ; then
        log.error "syntax : $BIN_NAME init PROJECTNAME"
        return 1
    fi

    mkdir -p ${PROJECT_DIR}/${projectname}
    project_list
}

project_start(){
    projectname="$1"
    if [[ -z "$projectname" ]] ; then
        log.error "syntax : $BIN_NAME start PROJECTNAME"
        return 1
    fi
    if ! ls ${PROJECT_DIR}/${projectname} > /dev/null 2> /dev/null ; then
        log.error "$projectname doesn't exist"
        return 1
    fi
    DATE_START="$(date +%s)"
    log.info "PROJECT $projectname START $datestart"
    echo "Press CRTL + C for STOP PROJECT"
    while : ; do echo -n "*" ; sleep 60 ; done
}

project_stop(){
    projectname="$1"
    DATE_STOP="$( date +%s )"
    log.info "PROJECT $projectname STOP $datestop"
    log.info "Writing duration."
    echo "$DATE_START;$DATE_STOP" >> ${PROJECT_DIR}/${projectname}/TIME.txt
    exit 1
}

project_count(){

}

PROJECTNAME="$2"

trap "project_stop $PROJECTNAME" INT

if [[ ! -d "$PROJECT_DIR" ]] ; then
    log.info "Create project directory"
    mkdir -p "$PROJECT_DIR" > /dev/null || {
        log.error "Fail to create $PROJECT_DIR"
        exit 1
    }
fi

case $1 in
    list)
        project_list
        ;;
    init)
        project_init $PROJECTNAME
        ;;
    start)
        project_start $PROJECTNAME
        ;;
    *)
        usage
esac
