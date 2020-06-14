#!/bin/bash

################################################################################

source ../../common_openfoam.sh

################################################################################

TIME_0=$(date +%s)
echo $(date +%Y-%m-%d\ %H:%M:%S) - Computations started

export EXEC_DIR=$(pwd)

################################################################################

cd $EXEC_DIR
export MODEL_NAME=c130_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack

cd $EXEC_DIR
export MODEL_NAME=c130_tail_off_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack
runCaseAngleOfAttack -161
runCaseAngleOfAttack -91
runCaseAngleOfAttack -61
runCaseAngleOfAttack -16
runCaseAngleOfAttack 91
runCaseAngleOfAttack 131
runCaseAngleOfAttack 151

cd $EXEC_DIR
export MODEL_NAME=c130_flaps_18_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack
runCaseAngleOfAttack -121
runCaseAngleOfAttack -89
runCaseAngleOfAttack 61
runCaseAngleOfAttack 89

cd $EXEC_DIR
export MODEL_NAME=c130_flaps_35_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateAngleOfAttack
runCaseAngleOfAttack -89
runCaseAngleOfAttack 89

cd $EXEC_DIR
export MODEL_NAME=c130_gear
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseAngleOfAttack -5
runCaseAngleOfAttack 0
runCaseAngleOfAttack 5

cd $EXEC_DIR
export MODEL_NAME=c130_elevator_30_half
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseAngleOfAttack -5
runCaseAngleOfAttack 0
runCaseAngleOfAttack 5

################################################################################

cd $EXEC_DIR
export MODEL_NAME=c130_full
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
iterateSideslipAngle

################################################################################

cd $EXEC_DIR
export MODEL_NAME=c130_ailerons_max_full
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseMomentX -5
runCaseMomentX 0
runCaseMomentX 5

cd $EXEC_DIR
export MODEL_NAME=c130_rudder_30_full
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseSideslipAngle -5
runCaseSideslipAngle 0
runCaseSideslipAngle 5

################################################################################

TIME_1=$(date +%s)
TIME_T=$(expr $TIME_1 - $TIME_0 )
TIME_H=$(expr $TIME_T / 3600 )
TIME_M=$(expr $(expr $TIME_T - 3600 \* $TIME_H ) / 60 )
TIME_S=$(expr $TIME_T - 3600 \* $TIME_H - 60 \* $TIME_M )
TIME_F=`printf %02d ${TIME_H}`:`printf %02d ${TIME_M}`:`printf %02d ${TIME_S}`

echo "OpenFOAM computations finished in $TIME_F"
notify-send "OpenFOAM computations finished." "OpenFOAM computations finished in $TIME_F"
