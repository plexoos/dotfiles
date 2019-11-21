#!/usr/bin/env bash

# Command line
PS1="[\u@\H:\w]\n$"

#bind "^[[3~" delete-char

# Do not echo ^C back to terminal
stty -ctlecho

export LS_COLORS='di=01;94:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35'
export EDITOR=vim
export VISUAL=vim
export PATH=.:~/usr/local/bin:$PATH


setup-root()
{
    local ROOT_VERSION=${1:-"5"}
    local BUILD_BIN_BITS=${2:-"32"}
    local BUILD_OPTS=${3:-"def"}
    local ROOT_OPTION="${ROOT_VERSION}_${BUILD_BIN_BITS}_${BUILD_OPTS}"

    case "${ROOT_OPTION}" in
    "5_32_afs")
       source /afs/rhic.bnl.gov/star/ROOT/5.34.30/.sl74_gcc485/rootdeb/bin/thisroot.sh
       ;;
    "5_32_def")
       source /scratch/smirnovd/root_v5-34-30_32/bin/thisroot.sh
       ;;
    "5_32_sse")
       source /scratch/smirnovd/root_v5-34-30_32_sse/bin/thisroot.sh
       ;;
    "5_64_afs")
       source /afs/rhic.bnl.gov/star/ROOT/5.34.30/.sl74_x8664_gcc485/rootdeb/bin/thisroot.sh
       ;;
    "5_64_def")
       source /scratch/smirnovd/root_v5-34-30_64/bin/thisroot.sh
       ;;
    "6_32_def")
       source /scratch/smirnovd/root_v6-13-04_32/bin/thisroot.sh
       ;;
    "6_64_def")
       source /scratch/smirnovd/root_v6-13-04_64/bin/thisroot.sh
       ;;
    *)
       echo -e "ERROR: Proper ROOT version must be selected [5|6] [32|64] [def|sse|afs]"
       ;;
    esac

    export ROOT_LEVEL=`root-config --version`
}


setup-gcc()
{
    local GCC_VERSION=${1:-"4"}

    case "${GCC_VERSION}" in
    "4")
       unset CC
       unset CXX
       local GCC_LD_LIBRARY_PATH_NEW=""
       local GCC_PATH_NEW=""
       ;;
    "5")
       export CC="/home/smirnovd/usr/local/gcc/5.5.0/bin/gcc"
       export CXX="/home/smirnovd/usr/local/gcc/5.5.0/bin/g++"
       local GCC_LD_LIBRARY_PATH_NEW="${HOME}/usr/local/gcc/5.5.0/lib64:"
       local GCC_PATH_NEW="/home/smirnovd/usr/local/gcc/5.5.0/bin:"
       ;;
    "7")
       export CC="/home/smirnovd/usr/local/gcc/7.3.0/bin/gcc"
       export CXX="/home/smirnovd/usr/local/gcc/7.3.0/bin/g++"
       local GCC_LD_LIBRARY_PATH_NEW="${HOME}/usr/local/gcc/7.3.0/lib64:"
       local GCC_PATH_NEW="/home/smirnovd/usr/local/gcc/7.3.0/bin:"
       ;;
    "8")
       export CC="/home/smirnovd/usr/local/gcc/8.1.0/bin/gcc"
       export CXX="/home/smirnovd/usr/local/gcc/8.1.0/bin/g++"
       local GCC_LD_LIBRARY_PATH_NEW="${HOME}/usr/local/gcc/8.1.0/lib64:"
       local GCC_PATH_NEW="/home/smirnovd/usr/local/gcc/8.1.0/bin:"
       ;;
    *)
       echo -e "ERROR: GCC version must be selected [4|5|7|8]"
       ;;
    esac

    # in case GCC_PATH is define remove it from LD_LIBRARY_PATH
    export LD_LIBRARY_PATH="${PATH/"$GCC_PATH"/}"
    export GCC_PATH="${GCC_PATH_NEW}"
    export PATH="${GCC_PATH}$PATH"

    # in case GCC_LD_LIBRARY_PATH is define remove it from LD_LIBRARY_PATH
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH/"$GCC_LD_LIBRARY_PATH"/}"
    export GCC_LD_LIBRARY_PATH="${GCC_LD_LIBRARY_PATH_NEW}"
    export LD_LIBRARY_PATH="${GCC_LD_LIBRARY_PATH}$LD_LIBRARY_PATH"
}

# Set common environment variables for STAR software and ROOT. Usage:
#
#     setup-star [Release tag] [32 or 64 binaries]
#
# Examples:
#
#     setup-star
#     setup-star SL18d
#     setup-star DEV 64
#
setup-star()
{
    export STAR_VERSION=${1:-"DEV"}
    export STAR_LEVEL=${STAR_VERSION}
    local BUILD_BIN_BITS=${2:-"32"}
    local STAR_ROOT_DIR=${3:-"/afs/rhic.bnl.gov/star/packages/"}

    case "${BUILD_BIN_BITS}" in
    "64")
       BUILD_BIN_BITS="x8664_"
       ;;
    *)
       BUILD_BIN_BITS=""
       ;;
    esac

    export STAR_HOST_SYS="sl74_"${BUILD_BIN_BITS}"gcc485"
    export STAR="${STAR_ROOT_DIR}/${STAR_VERSION}"
    export OPTSTAR="/opt/star/${STAR_HOST_SYS}"

    # Defined just for shorthand
    local STAR_LIB="${STAR_ROOT_DIR}/${STAR_VERSION}/.${STAR_HOST_SYS}/lib"

    # in case STAR_LD_LIBRARY_PATH is define remove it from LD_LIBRARY_PATH
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH/"$STAR_LD_LIBRARY_PATH"/}"
    export STAR_LD_LIBRARY_PATH=".${STAR_HOST_SYS}/lib:${STAR_LIB}:${OPTSTAR}/lib:"
    export LD_LIBRARY_PATH="${STAR_LD_LIBRARY_PATH}$LD_LIBRARY_PATH"

    export CVSROOT="/afs/rhic.bnl.gov/star/packages/repository"

    #export DB_SERVER_LOCAL_CONFIG="/afs/rhic.bnl.gov/star/packages/conf/dbLoadBalancerLocalConfig_BNL.xml"
    export PATH=${PATH/"${STAR_BIN}"/}
    export STAR_BIN=":${STAR_ROOT_DIR}/${STAR_VERSION}/.${STAR_HOST_SYS}/bin"
    export PATH="$PATH${STAR_BIN}"
}

# Print some environment variables
my-env()
{
    echo -e "\t STAR_VERSION=           $STAR_VERSION"
    echo -e "\t STAR_HOST_SYS=          $STAR_HOST_SYS"
    echo -e "\t STAR=                   $STAR"
    echo -e "\t OPTSTAR=                $OPTSTAR"
    echo -e "\t STAR_LD_LIBRARY_PATH=   $STAR_LD_LIBRARY_PATH"
    echo -e "\t CVSROOT=                $CVSROOT"
    echo -e "\t ---"
    echo -e "\t ROOTSYS=                $ROOTSYS"
    echo -e "\t ROOT_LEVEL=             $ROOT_LEVEL"
    echo -e "\t ---"
    echo -e "\t CC=                     $CC"
    echo -e "\t CXX=                    $CXX"
    echo -e "\t GCC_LD_LIBRARY_PATH=    $GCC_LD_LIBRARY_PATH"
    echo -e "\t ---"
    echo -e "\t PATH=                   $PATH"
    echo -e "\t LD_LIBRARY_PATH=        $LD_LIBRARY_PATH"
}


command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists gls ; then
   export MYCMD_LS='gls --color=auto'
else
   export MYCMD_LS='ls --color=auto'
fi

alias ls="$MYCMD_LS"
alias lh="$MYCMD_LS -lh"
alias la="$MYCMD_LS -lah"
alias hgrep="history | grep"
alias mygitk="gitk --all&"
alias mytig="tig --all"
alias mycondor_q="condor_q smirnovd"
alias vimdiff="vimdiff -o"



function duf {
    du -h "$@" | sort -rn | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}"; break; fi; size=$((size/1024)); done; done
}

mkcdir() { mkdir -p -- "$1" && cd -P -- "$1"; }


# First argument is a wildcard to match file names, defaults to "*.orig"
# Second argument is a path to traverse, defaults to current dir "./"
rmrec()
{
    file_pattern=${1:-*.orig}
    file_list=(`find "${2:-./}" -name "${file_pattern}"`)

    if [ ${#file_list[@]} -eq 0 ]
    then
        echo "No \"${file_pattern}\" files found"
    else
        echo "Files to delete in ${2:-./}:"
        printf '%s\n' "${file_list[@]}"
        confirm && rm "${file_list[@]}"
    fi
}


# Call with a prompt string or use a default
confirm()
{
    read -r -p "${1:-Are you sure? [y/n]} " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        true
    else
        false
    fi
}


declare -x LANG="en_US"
shopt -s direxpand
# Silence terminal bell
xset -b
