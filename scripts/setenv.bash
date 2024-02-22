#!/bin/bash

# Load modules:

module purge
module load ohpc
module unload openmpi4
module load phdf5
module load netcdf
module load netcdf-fortran
module load mpich-4.0.2-gcc-9.4.0-gpof2pv
module load hwloc
module load phdf5
module list







# Set environment variables and importants directories


# MONAN-suite install root directory:
export DIRWORK=$(pwd)

# Others variables:
export OMP_NUM_THREADS=1
export OMPI_MCA_btl_openib_allow_ib=1
export OMPI_MCA_btl_openib_if_include="mlx5_0:1"
export PMIX_MCA_gds=hash
export MPI_PARAMS="-iface ib0 -bind-to core -map-by core"

# Libraries paths:
export NETCDF=/mnt/beegfs/monan/libs/netcdf
export PNETCDF=/mnt/beegfs/monan/libs/PnetCDF
export NETCDFDIR=${NETCDF}
export PNETCDFDIR=${PNETCDF}
export DIRDADOS=/mnt/beegfs/monan/dados/MONAN_v0.1.0
export OPERDIR=/oper/dados/ioper/tempo



# Submiting variables:
export STATIC_QUEUE=batch
export DEGRIB_QUEUE=batch
export INITATMOS_QUEUE=batch

# Colors:
export GREEN='\033[1;32m'  # Green
export RED='\033[1;31m'    # Red
export NC='\033[0m'        # No Color
export BLUE='\033[01;34m'  # Blue
