# `sstub`

---

## Overview

`sstub` is a **bash** program for writing templated [Slurm](https://slurm.schedmd.com/) scripts. Slurm is widely used tool for resource management on high-performance computing systems. There are a number of [existing tools](#Similar-projects) that provide web-based Slurm script generators. The goal of this project was to develop a tool for "stubbing" job specifications via the command line.

---

## Installation

The `sstub.sh` script is available to download from this repository. Once cloned, ensure  that the script is executable (`chmod +x sstub.sh`) and move to an appropriate `bin` in order to call the program directly by name.

```
git clone https://github.com/uvasomrc/sstub.git
```

Alternatively, users of the [University of Virginia high-performance computing system (Rivanna)](https://arcs.virginia.edu/rivanna) can install `sstub` by running the following command on the cluster:

```
bash <(curl -s https://raw.githubusercontent.com/uvasomrc/sstub/master/install.sh)
```

--- 

## Usage

Basic usage information is provided if the user runs the program with the `-h` flag:

```
sstub -h
```

```
usage: sstub
  -j      job name to be prepended
  -i      enter job info in interactive interview mode
  -A      allocation for service unit recovery
  -p      partition (queue) for the job
  -N      number of nodes for job
  -c      number of cores per CPU
  -m      amount of memory per node (GB)
  -t      maximum run time for the job in hh::mm::ss format
  -z      modules to be used
  -w      write file without opening in vim editor
  -h      display help
```

---

## Similar projects

- [Melbourne Bionformatics Job script generator for SLURM](https://www.melbournebioinformatics.org.au/jobscript-generator/)
- [Iowa State University High Performance Computing Slurm Job Script Generator for hpc-class](https://www.hpc.iastate.edu/guides/classroom-hpc-cluster/slurm-job-script-generator)
- [BYU Fulton Supercomputing Lab Job Script Generator](https://marylou.byu.edu/documentation/slurm/script-generator)