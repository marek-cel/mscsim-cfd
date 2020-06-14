#!/bin/bash

################################################################################

source ../../common_openfoam.sh

################################################################################

TIME_0=$(date +%s)
echo $(date +%Y-%m-%d\ %H:%M:%S) - Computations started

export EXEC_DIR=$(pwd)

################################################################################

export MODEL_NAME=p51_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack

cd $EXEC_DIR
export MODEL_NAME=p51_tail_off_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack

cd $EXEC_DIR
export MODEL_NAME=p51_flaps_30_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack

cd $EXEC_DIR
export MODEL_NAME=p51_gear_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseAngleOfAttack -5
runCaseAngleOfAttack 0
runCaseAngleOfAttack 5

cd $EXEC_DIR
export MODEL_NAME=p51_elevator_10_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack

################################################################################

cd $EXEC_DIR
export MODEL_NAME=p51_full
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateSideslipAngle

################################################################################

TIME_1=$(date +%s)
TIME_T=$(expr $TIME_1 - $TIME_0 )
TIME_H=$(expr $TIME_T / 3600 )
TIME_M=$(expr $(expr $TIME_T - 3600 \* $TIME_H ) / 60 )
TIME_S=$(expr $TIME_T - 3600 \* $TIME_H - 60 \* $TIME_M )
TIME_F=`printf %02d ${TIME_H}`:`printf %02d ${TIME_M}`:`printf %02d ${TIME_S}`

echo "OpenFOAM computations finished in $TIME_F"
notify-send "OpenFOAM computations finished." "OpenFOAM computations finished in $TIME_F"
