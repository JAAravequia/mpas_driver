#!/bin/bash

# Load modules:

export JEDI_ROOT=/mnt/beegfs/${USER}/jedi

## NOTE : Each executing job has to load the modules environment . 
#  Not needed to load here
#  For ungrib.exe job : 
#  source ${JEDI_ROOT}/intel_env_mpas_v8.2    # for Intel jedi-spack libraries


# Set environment variables and importants directories-------------------------------------------------- 


# MONAN-suite install root directories:
# Put your directories:
#                   Get the path 2 levels up from the calling script
#  here is in /mnt/beegfs/jose.aravequia/jedi/mpas_drive/scripts,  so DIR_SCRIPTS will be = /mnt/beegfs/jose.aravequia/jedi
export DIR_SCRIPTS=/mnt/beegfs/$USER/JEDI/run # $(dirname $(dirname $(pwd)))
export MONANDIR=$MONANDIR

# Submiting variables:

# PRE-Static phase:
export STATIC_QUEUE="PESQ1"
export STATIC_ncores=32
export STATIC_nnodes=1
export STATIC_ncpn=32
export STATIC_jobname="Pre.static"
export STATIC_walltime="02:00:00"

# PRE-Degrib phase:
export DEGRIB_QUEUE="PESQ1"
export DEGRIB_ncores=1
export DEGRIB_nnodes=1
export DEGRIB_ncpn=1
export DEGRIB_jobname="Pre.degrib"
export DEGRIB_walltime="00:05:00" not used yet - using STATIC_walltime

# PRE-Init Atmosphere phase:
export INITATMOS_QUEUE="PESQ1"
export INITATMOS_ncores=64
export INITATMOS_nnodes=1
### export INITATMOS_ncpn=1 not used yet  - using INITATMOS_ncores 
export INITATMOS_jobname="Pre.InitAtmos"
export INITATMOS_walltime="00:05:00" not used yet - using STATIC_walltime


# Model phase:
export MODEL_QUEUE="PESQ1"
export MODEL_ncores=128
export MODEL_nnodes=1
export MODEL_ncpn=128
export MODEL_jobname="Model.MONAN"
export MODEL_walltime="8:00:00"


# Post phase:
export POST_QUEUE="PESQ1"
### export POST_ncores=1 not used yet
export POST_nnodes=1
export POST_ncpn=32
export POST_jobname="Post.MONAN"
export POST_walltime="8:00:00"


# Products phase:
export PRODS_QUEUE="PESQ1"
export PRODS_ncores=1
export PRODS_nnodes=1
export PRODS_ncpn=1
export PRODS_jobname="Prods.MONAN"
export PRODS_walltime="8:00:00"


#-----------------------------------------------------------------------
# We discourage changing the variables below:

# Others variables:
# export OMP_NUM_THREADS=1
# export OMPI_MCA_btl_openib_allow_ib=1
# export OMPI_MCA_btl_openib_if_include="mlx5_0:1"
# export PMIX_MCA_gds=hash
# export MPI_PARAMS="-iface ib0 -bind-to core -map-by core"

# Libraries paths:
# export NETCDF=/mnt/beegfs/monan/libs/netcdf
# export PNETCDF=/mnt/beegfs/monan/libs/PnetCDF
# export NETCDFDIR=${NETCDF}
# export PNETCDFDIR=${PNETCDF}
export DIR_DADOS=/mnt/beegfs/$USER/JEDI/mpas8.2
export OPERDIR=/oper/dados/ioper/tempo
export GFSDATA=/mnt/beegfs/$USER/JEDI/GFS-CI
export GEFSDATA=/mnt/beegfs/$USER/JEDI/GEFS-CI
export WPS_EXEC=/mnt/beegfs/$USER/jedi/WPS-4.3.1

export EnsSize=80  ## Number of ensemble members. Used only by ensemble scripts 

# Colors:
export GREEN='\033[1;32m'  # Green
export RED='\033[1;31m'    # Red
export NC='\033[0m'        # No Color
export BLUE='\033[01;34m'  # Blue


# Functions: ======================================================================================================

how_many_nodes () { 
   nume=${1}   
   deno=${2}
   num=$(echo "${nume}/${deno}" | bc -l)  
   how_many_nodes_int=$(echo "${num}/1" | bc)
   dif=$(echo "scale=0; (${num}-${how_many_nodes_int})*100/1" | bc)
   rest=$(echo "scale=0; (((${num}-${how_many_nodes_int})*${deno})+0.5)/1" | bc -l)
   if [ ${dif} -eq 0 ]; then how_many_nodes_left=0; else how_many_nodes_left=1; fi
   if [ ${how_many_nodes_int} -eq 0 ]; then how_many_nodes_int=1; how_many_nodes_left=0; rest=0; fi
   
   echo "INT number of nodes needed: \${how_many_nodes_int}  = ${how_many_nodes_int}"
   echo "number of nodes left:       \${how_many_nodes_left} = ${how_many_nodes_left}"
   echo ""
}
#----------------------------------------------------------------------------------------------



clean_model_tmp_files () {

   echo "Removing all temporary files from last MODEL run trash."

   rm -f ${DIR_SCRIPTS}/run_dir/scripts/atmosphere_model
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/*TBL
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/*DBL
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/*DATA
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/x1.*.nc
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/x1.*.graph.info.part.*
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/Vtable.GFS
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/streams.atmosphere
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/stream_list.atmosphere.surface
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/stream_list.atmosphere.output
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/stream_list.atmosphere.diagnostics
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/namelist.atmosphere
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/MONAN_DIAG_*
   rm -f ${DIR_SCRIPTS}/run_dir/scripts/log.atmosphere.*
   echo ""
   
}
#----------------------------------------------------------------------------------------------

