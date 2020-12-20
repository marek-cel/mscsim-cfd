#!/bin/bash

################################################################################

source ../../common_openfoam.sh

################################################################################

TIME_0=$(date +%s)
echo $(date +%Y-%m-%d\ %H:%M:%S) - Computations started

export EXEC_DIR=$(pwd)

################################################################################

# export MODEL_NAME=f35a_complete
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateAngleOfAttack
# runCaseAngleOfAttack 41

# cd $EXEC_DIR
# export MODEL_NAME=f35a_tail_off
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateAngleOfAttack
# runCaseAngleOfAttack -151
# runCaseAngleOfAttack -82
# runCaseAngleOfAttack 21
# runCaseAngleOfAttack 31
# runCaseAngleOfAttack 41

# cd $EXEC_DIR
# export MODEL_NAME=f35a_flaps_le_20
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateAngleOfAttack

# cd $EXEC_DIR
# export MODEL_NAME=f35a_flaps_te_30
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateAngleOfAttack

################################################################################

# cd $EXEC_DIR
# export MODEL_NAME=f35a_complete
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateSideslipAngle

# cd $EXEC_DIR
# export MODEL_NAME=f35a_rudder_20
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# runCaseSideslipAngle -5
# runCaseSideslipAngle 0
# runCaseSideslipAngle 5

################################################################################

cd $EXEC_DIR
export MODEL_NAME=f35a_ailerons_20
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseMomentX -5
runCaseMomentX 1
runCaseMomentX 5

################################################################################

TIME_1=$(date +%s)
TIME_T=$(expr $TIME_1 - $TIME_0 )
TIME_H=$(expr $TIME_T / 3600 )
TIME_M=$(expr $(expr $TIME_T - 3600 \* $TIME_H ) / 60 )
TIME_S=$(expr $TIME_T - 3600 \* $TIME_H - 60 \* $TIME_M )
TIME_F=`printf %02d ${TIME_H}`:`printf %02d ${TIME_M}`:`printf %02d ${TIME_S}`

echo "OpenFOAM computations finished in $TIME_F"
notify-send "OpenFOAM computations finished." "OpenFOAM computations finished in $TIME_F"
