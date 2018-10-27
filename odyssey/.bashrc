# .bashrc

#hostname -s  #avoid echo in bashrc
#echo $- > ~/temp/env/aaa.`date +%H%M%S`
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
[[ $- != *i* ]] && return
#limit coredumpsize 0
#limit stacksize unlimited
#limit filesize unlimited
#unset limits
#export MP_STACK_SIZE=64000000

#alias rm='rm -if'
#alias cp='cp -i'
#alias mv='mv -i'

alias path="echo \$PATH |sed 's/\:/\n/g'"
alias evince="evince -w"  # resolving some bugs
alias squeue="squeue -o \"%13i %.9P %.24j %.8u %.2t %.10M %.4C %.3D %R\""
alias sacct='sacct -S `date -d 1\ days\ ago +%m%d%y`'
alias saccnow="\sacct -S \`date +%H:%M\`"
export SACCT_FORMAT="JobID%-14,JobName,Partition,AllocCPUS%4,State,ExitCode%6,MaxRSS,Elapsed,NodeList" #ReqMem,NodeList
kuang_queues="huce_intel,huce_amd,huce_amd_bigmem,huce_bigmem,bigmem,test"
alias nodeinfo='squeue -p $kuang_queues -t PD |grep -v "(Dependency)$" |sort -rk 2,2; sinfo -p $kuang_queues -o "%10P %.4D %16C %N" -t idle,mix' # %6t %.3c %5a -e
alias xbash="srun -n 1 --pty --x11=first -p test -t 0-08:00 --mem=10000 /bin/bash"

export HISTSIZE=9999
export HISTCONTROL=ignoredups

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;36'
alias grep='grep -i'
alias less='less -I'
export LS_OPTIONS='--color=tty'
alias ls="ls --color=tty"
complete -r -DE  2>/dev/null
complete -r vim  2>/dev/null

#export TERM="xterm"
export PS1="[\u@\h \W]\$ "
#set prompt = "[%{\033[1;33m%}`whoami`%{\033[0m%}@%{\033[1;33m%}`hostname -s`%{\033[0m%}:%{\033[1;34m%}%~%{\033[0m%}]# "
export LC_ALL="en_US.UTF-8"
#export DISPLAY=":0.0"

export PATH=".:/usr/local/sbin:$PATH"

export NCARG_ROOT="/n/home05/pchan/sw/ncl-6.4.0"
export PATH="$NCARG_ROOT/bin:$PATH"
#export NCARG_LIB="$NCARG_ROOT/lib"
#export NCARG=$NCARG_ROOT
#export NCARG_NCARG="$NCARG/lib/ncarg"
#export NCL_COMMAND="$NCARG/bin/ncl"

mod18(){
module purge
module load matlab  #/R2017a-fasrc02
 # load matlab first: avoid "undefined reference to `ncdimdef'", only conflict with mod17
module load intel/17.0.4-fasrc01 impi/2017.2.174-fasrc01 netcdf/4.1.3-fasrc02
#module load libpng/1.6.25-fasrc01
#module load jasper/1.900.1-fasrc02
module load perl-modules/5.10.1-fasrc13

module load nco/4.7.4-fasrc01
#TODO module load ncview/2.1.7-fasrc01
#TODO module load ncl_ncarg/6.4.0-fasrc01
#TODO module load grads
alias matlab='matlab -softwareopengl -nosplash -nodesktop -singleCompThread'
 #alias matlab='matlab -softwareopengl -nosplash -nojvm -nodisplay -singleCompThread'
 #alias matlab='matlab -softwareopengl -nosplash -singleCompThread'
export expectMODULES=${LOADEDMODULES}
export LD_LIBRARY_save=${LD_LIBRARY_PATH}

# WRF
#export NETCDF=${NETCDF_HOME}
export NETCDF=${NETCDF_FORTRAN_HOME:-${NETCDF_HOME}}
export NETCDF4=0
export HDF5=${HDF5_HOME}
export JASPERLIB=${JASPER_LIB}
export JASPERINC=${JASPER_INCLUDE}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_NMM_CORE=0
export WRF_CHEM=0
export WRF_KPP=0
#unset MPI_LIB  #unset for WPS
}

mod17(){
source new-modules.sh
module purge
module load matlab  #/R2015b-fasrc01
 # load matlab first: avoid "undefined reference to `ncdimdef'", only conflict with mod17
#module try-load centos6/0.0.1-fasrc01
module load intel/15.0.0-fasrc01 impi/5.1.2.150-fasrc01 netcdf/4.1.3-fasrc09
#module load libpng/1.6.25-fasrc01
#module load jasper/1.900.1-fasrc02
module load perl-modules/5.22.0-fasrc03

module load nco/4.5.3-fasrc01
module load ncview/2.1.7-fasrc01
alias matlab='matlab -softwareopengl -nosplash -nodesktop -singleCompThread'
export expectMODULES=${LOADEDMODULES}

# WRF
export NETCDF=${NETCDF_HOME}
#export NETCDF=${NETCDF_FORTRAN_HOME:-${NETCDF_HOME}}
export NETCDF4=0
export HDF5=${HDF5_HOME}
export JASPERLIB=${JASPER_LIB}
export JASPERINC=${JASPER_INCLUDE}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_NMM_CORE=0
export WRF_CHEM=0
export WRF_KPP=0
#unset MPI_LIB  #unset for WPS
}

#if [ "$HOSTNAME" != "lfsdm05.rc.fas.harvard.edu" ] && [ "$LOADEDMODULES" != "matlab/R2017a-fasrc01:intel/15.0.0-fasrc01:impi/5.1.2.150-fasrc01:zlib/1.2.8-fasrc07:hdf5/1.8.12-fasrc12:netcdf/4.1.3-fasrc09:libpng/1.6.25-fasrc01:jpeg/6b-fasrc02:jasper/1.900.1-fasrc02:gsl/1.16-fasrc02:udunits/2.2.18-fasrc01:antlr/2.7.7-fasrc01:nco/4.5.3-fasrc01:ncview/2.1.7-fasrc01" ]; then

#if [[ "$-" == *"i"* ]] && [[ "$HOSTNAME" != *"nx"* ]] && [[ "$HOSTNAME" != *"datamover"* ]] && [[ "$HOSTNAME" != *"lfsdm"* ]] && [ "${LOADEDMODULES:-x}" != "$expectMODULES" ]; then
#  echo $LOADEDMODULES  #avoid echo in bashrc
#  echo mod17
#  mod17
#fi
alias matlab='matlab -softwareopengl -nosplash -nodesktop -singleCompThread'
#export PATH="/n/home07/ytian/bin:$PATH"
export PYTHONPATH="/n/home05/pchan/sw/ecmwfapi/ecmwfapi:$PYTHONPATH"

llsnap(){
    ls -ltrd --time-style=long-iso /n/home05/.snapshot/rc_homes_*/pchan/$1 |sort -u -k 6,7
}
ncdwrf(){
    ncdump -h $1 |grep -Ev 'FieldType|MemoryOrder|stagger|coordinates|sr_x|sr_y'
}
diffs(){
    diff $1 ~/script/*/${1##*/}
}
vimd(){
    vimdiff -R $1 $3
}

# OBSOLETE after this point

export myIP=`who -m| awk '{print $NF}'| tr -d '()'`
export mydesk="chenbaihua@${myIP}:~"
ssz(){
#    rsync -avzu $@ $mydesk/data_3T/temp/ssz/
    rsync -avzu $@ $mydesk/draw/blocking/
}


PATH="/n/home05/pchan/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/n/home05/pchan/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/n/home05/pchan/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/n/home05/pchan/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/n/home05/pchan/perl5"; export PERL_MM_OPT;
