#!/bin/bash

################################################################################

function runCaseAngleOfAttack()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME""_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME""_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

function runCaseSideslipAngle()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME""_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    rm -f $DEST_DIR/system/blockMeshDict
    rm -f $DEST_DIR/system/forceCoeffs
    cp case_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp case_full_x/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    surfaceTransformPoints -rollPitchYaw "( 0 0 $1 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME""_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

function runCaseMomentX()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_Mx"_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    rm -f $DEST_DIR/system/blockMeshDict
    rm -f $DEST_DIR/system/forceCoeffs
    cp case_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp case_full_x/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME"_Mx"_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

function runCaseMomentY()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_My"_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 0 $1 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME"_My"_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

function runCaseMomentZ()
{
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_Mz"_$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r case $DEST_DIR
    rm -f $DEST_DIR/system/blockMeshDict
    rm -f $DEST_DIR/system/forceCoeffs
    cp case_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp case_full_z/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    surfaceTransformPoints -rollPitchYaw "( 0 0 $1 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_$MODEL_NAME.dat
    tail -n 1 "$MODEL_NAME"_Mz"_$1"/postProcessing/forceCoeffs1/0/forceCoeffs.dat &>> forceCoeffs_$MODEL_NAME.dat
}

################################################################################

function iterateAngleOfAttack()
{
    for i in -180 -150 -120
    do
      runCaseAngleOfAttack $i
    done
    
    for i in {-90..-30..10}
    do
      runCaseAngleOfAttack $i
    done

    for i in -25 -20 -17 -14 -12
    do
      runCaseAngleOfAttack $i
    done

    for i in {-10..15..1}
    do
      runCaseAngleOfAttack $i
    done

    for i in 17 20 25
    do
      runCaseAngleOfAttack $i
    done

    for i in {30..90..10}
    do
      runCaseAngleOfAttack $i
    done
    
    for i in 120 150 180
    do
      runCaseAngleOfAttack $i
    done
}

################################################################################

function iterateAngleOfAttack_Short()
{
    for i in -89 -60 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 60 89
    do
      runCaseAngleOfAttack $i
    done
}

################################################################################

function iterateAngleOfAttack_Heli()
{
    for i in -180 -150 -120 -90 -60 -30 -20 -10 -5 0 5 10 20 30 60 90 120 150 180
    do
      runCaseAngleOfAttack $i
    done
}

################################################################################

function iterateSideslipAngle()
{
    for i in -90 -60 -30 -20 -10 -5  0  5  10  20  30  60  90
    do
      runCaseSideslipAngle $i
    done
}


################################################################################

function iterateSideslipAngleMomentZ()
{
    for i in -90 -60 -30 -20 -10 -5  0  5  10  20  30  60  90
    do
      runCaseMomentZ $i
    done
}
