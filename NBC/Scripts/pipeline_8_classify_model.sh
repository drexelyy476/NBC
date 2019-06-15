#!/bin/bash
#
### tell SGE to use bash for this script
#$ -S /bin/bash
### execute the job from the current working directory, i.e. the directory in which the qsub command is given
#$ -cwd
### join both stdout and stderr into the same file
#$ -j y
### set email address for sending job status
#$ -M rc887@drexel.edu
### project - basically, your research group name with "Grp" replaced by "Prj"
#$ -P rosenclassPrj
### select parallel environment, and number of job slots
#$ -pe shm 16
### request 15 min of wall clock time "h_rt" = "hard real time" (format is HH:MM:SS, or integer seconds)
#$ -l h_rt=48:00:00
### a hard limit 16 GB of memory per slot - if the job grows beyond this, the job is killed
#$ -l h_vmem=4G
### want nodes with at least 15 GB of free memory per slot
#$ -l m_mem_free=3G
### select the queue all.q, using hostgroup @intelhosts
#$ -q all.q
#$ -t 1-7:1

. /etc/profile.d/modules.sh

### These four modules must ALWAYS be loaded
module load shared
module load proteus
module load sge/univa
module load gcc
module load jellyfish/gcc/2.2.10
module load boost/openmpi/gcc/64/1.57.0

IDX=$(($SGE_TASK_ID))
TEST=real_sample/test_set/foler_$IDX
CODE=/lustre/scratch/yy476/Naive_Bayes/nb-classify.bash
start=`date +%s`
/lustre/scratch/yy476/Naive_Bayes/nb-classify.bash /lustre/scratch/yy476/Naive_Bayes/tools/save_model_15/ /lustre/scratch/yy476/Naive_Bayes/tools/strainmadness/raw/testing_7/foler_$IDX 1 15
end=`date +%s`
runtime=$((end-start))
echo "testing time is $runtime"
