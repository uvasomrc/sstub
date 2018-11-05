#!/bin/bash

# defaults for the settings
maxtime="12:00:00"

# function to write the script
write_script()
{
touch $jname.slurm

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
}

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

echo "What is the max time you'd like to allow for the job run? 
Enter in hh:mm:ss format."
read maxtime

echo "Would you like to load any modules? 
If so, enter their names separated by one space."
read modules

write_script

}

# Accept options 
while getopts “ij:A:P:N:m:t:z:” OPTION
do
        case $OPTION in 
                i)      interactive=1;;
				j)      jname=$OPTARG;;       
                A)      allocation=$OPTARG;;
                p)      partition=$OPTARG;;
                N)      nnodes=$OPTARG;;
                t)      maxtime=$OPTARG;;
                z)      modules=$OPTARG;;
        esac
done

if [ -z "$interactive" ] 
then
	write_script
else
    interview
fi