#!/bin/bash

################################################################################

source ../../common_openfoam.sh

################################################################################

function runCaseMomentX_DecreasedRes()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_Mx"_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    rm -f $DEST_DIR/system/blockMeshDict
    rm -f $DEST_DIR/system/forceCoeffs
    rm -f $DEST_DIR/system/snappyHexMeshDict
    cp case_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp case_full_dr/system/snappyHexMeshDict $DEST_DIR/system/snappyHexMeshDict
    cp case_full_x/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME"_Mx"_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

TIME_0=$(date +%s)
echo $(date +%Y-%m-%d\ %H:%M:%S) - Computations started

export EXEC_DIR=$(pwd)

################################################################################

# export MODEL_NAME=pw5_complete
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateAngleOfAttack
# runCaseAngleOfAttack -179
# runCaseAngleOfAttack -51
# runCaseAngleOfAttack -26
# runCaseAngleOfAttack 31
# runCaseAngleOfAttack 61
# runCaseAngleOfAttack 179

# cd $EXEC_DIR
# export MODEL_NAME=pw5_tail_off
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# # iterateAngleOfAttack
# runCaseAngleOfAttack -179
# runCaseAngleOfAttack -51
# runCaseAngleOfAttack -26
# runCaseAngleOfAttack 31
# runCaseAngleOfAttack 61
# runCaseAngleOfAttack 179

# cd $EXEC_DIR
# export MODEL_NAME=pw5_airbrakes
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# runCaseAngleOfAttack 1
# runCaseAngleOfAttack 5

# cd $EXEC_DIR
# export MODEL_NAME=pw5_elevator_20
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# runCaseAngleOfAttack 1
# runCaseAngleOfAttack 5

################################################################################

# cd $EXEC_DIR
# export MODEL_NAME=pw5_complete
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# iterateSideslipAngle

################################################################################

cd $EXEC_DIR
export MODEL_NAME=pw5_ailerons_19-5_9-75
export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
runCaseMomentX_DecreasedRes 1
runCaseMomentX_DecreasedRes 5

# cd $EXEC_DIR
# export MODEL_NAME=pw5_rudder_25
# export MODEL_FILE=$EXEC_DIR/models/stl/$MODEL_NAME.stl
# runCaseSideslipAngle -5
# runCaseSideslipAngle 5

################################################################################

TIME_1=$(date +%s)
TIME_T=$(expr $TIME_1 - $TIME_0 )
TIME_H=$(expr $TIME_T / 3600 )
TIME_M=$(expr $(expr $TIME_T - 3600 \* $TIME_H ) / 60 )
TIME_S=$(expr $TIME_T - 3600 \* $TIME_H - 60 \* $TIME_M )
TIME_F=`printf %02d ${TIME_H}`:`printf %02d ${TIME_M}`:`printf %02d ${TIME_S}`

echo "OpenFOAM computations finished in $TIME_F"
notify-send "OpenFOAM computations finished." "OpenFOAM computations finished in $TIME_F"
