#!/bin/bash

# defaults for the settings
jname=$(date +%s)
maxtime="12:00:00"
queue="standard"
mem="1GB"
nnodes="1"
taskspercpu="1"

# usage
usage() {
    echo "usage: sstub"
    echo "  -j      job name to be prepended"
    echo "  -i      enter job info in interactive interview mode"
    echo "  -A      allocation for service unit recovery"
    echo "  -p      partition (queue) for the job"
    echo "  -N      number of nodes for job"
    echo "  -c      number of cores per CPU"
    echo "  -m      amount of memory per node (GB)"
    echo "  -t      maximum run time for the job in hh::mm::ss format"
    echo "  -z      modules to be used"
    echo "  -w      write file without opening in vim editor"
    echo "  -h      display help"
    exit 1
}

# function to write the script
write_script()
{
touch $jname.slurm

# logic for whether or not modules are set
if [ -z "$modules" ]
then
	module_load=""
else
	module_load="module load ${modules}"
fi

cat << EOT > $jname.slurm
#!/bin/bash
#SBATCH --job-name=$jname
#SBATCH --account=$allocation
#SBATCH --partition=$queue
#SBATCH --nodes=$nnodes
#SBATCH --ntasks-per-cpu=$taskspercpu
#SBATCH --mem=$mem
#SBATCH --time=$maxtime
#SBATCH --error=$jname.err

# Program to run
$module_load

EOT

dir="$(pwd)"

echo "================================"
echo "created $jname.slurm in $dir"
echo "================================"

# check to see if script should be opened in editor
# dne = 'do not edit' option
if [ -z "$dne" ]
then
	vim $jname.slurm
fi


}

# interview function for interactive evaluation
interview()
{

echo "What would you like to name the job?"
read jname

echo "What allocation would you like to use?"
read allocation

echo "To which partition (queue) would you like to add your job?"
read queue

echo "How many nodes do you need?"
read nnodes

echo "How many tasks per core (CPU) do you need to run?
If you aren't running a parallel program use 1."
read taskspercpu

echo "How much memory (in GB) does your run need?"
read mem

echo "What is the max time you'd like to allow for the job run? 
Enter in hh:mm:ss format."
read maxtime

echo "Would you like to load any modules? 
If so, enter the module name(s) separated by one space."
read modules

write_script

}

# Accept options 
while getopts “ij:A:P:N:m:t:z:w:h?” OPTION
do
        case $OPTION in 
                i)      interactive=1;;
				j)      jname=$OPTARG;;       
                A)      allocation=$OPTARG;;
                p)      partition=$OPTARG;;
                N)      nnodes=$OPTARG;;
                c)      taskspercpu=$OPTARG;;
                m)      mem=$OPTARG;;
                t)      maxtime=$OPTARG;;
                z)      modules=$OPTARG;;
                w)      dne=1;;
                h)      usage;;
                ?)      usage;;
                
        esac
done

# logic for whether or not the program is run interactively

if [ $# -eq 0 ]
then
	usage
elif [ -z "$interactive" ] 
then
	write_script
else
	interview
fi
