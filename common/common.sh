#!/bin/bash

################################################################################

function copyCaseFile()
{
    cp case/0.orig/include/initialConditions $1/0.orig/include
    cp case/system/snappyHexMeshDict $1/system
    cp case/system/surfaceFeatureExtractDict $1/system
    cp case/system/include/controlVolume $1/system/include
    cp case/system/include/referenceData $1/system/include
}

################################################################################

function runCaseAngleOfAttack_Full_All()
{
    export NAME_SUFFIX="AngleOfAttack_All"
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_"$NAME_SUFFIX"_"$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r ../common/case $DEST_DIR
    cp ../common/case_ctrl_vol_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp ../common/case_coeffs_full_all/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    copyCaseFile $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cz_Cmy.dat
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmx.dat
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmz.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cz_Cmy/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cz_Cmy.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cy_Cmx/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmx.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cy_Cmz/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmz.dat
}

################################################################################

function runCaseAngleOfAttack_Full_Cx_Cy_Cmx()
{
    export NAME_SUFFIX="AngleOfAttack_Full_Cx_Cy_Cmx"
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_"$NAME_SUFFIX"_"$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r ../common/case $DEST_DIR
    cp ../common/case_ctrl_vol_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp ../common/case_coeffs_full_Cx_Cy_Cmx/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    copyCaseFile $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cy_Cmx/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
}

################################################################################

function runCaseAngleOfAttack_Full_Cx_Cz_Cmy()
{
    export NAME_SUFFIX="AngleOfAttack_Full_Cx_Cz_Cmy"
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_"$NAME_SUFFIX"_"$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r ../common/case $DEST_DIR
    cp ../common/case_ctrl_vol_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp ../common/case_coeffs_full_Cx_Cz_Cmy/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    copyCaseFile $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cz_Cmy/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
}

################################################################################

function runCaseAngleOfAttack_Half_Cx_Cz_Cmy()
{
    export NAME_SUFFIX="AngleOfAttack_Half_Cx_Cz_Cmy"
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_"$NAME_SUFFIX"_"$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r ../common/case $DEST_DIR
    cp ../common/case_ctrl_vol_half/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp ../common/case_coeffs_half_Cx_Cz_Cmy/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    copyCaseFile $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 $1 0 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cz_Cmy/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX".dat
}

################################################################################

function runCaseSideslipAngle_Full_All()
{
    export NAME_SUFFIX="SideslipAngle_Full_All"
    export DEST_DIR="$FOAM_RUN/$MODEL_NAME"_"$NAME_SUFFIX"_"$1"

    cd $EXEC_DIR
    rm -rf $DEST_DIR
    cp -r ../common/case $DEST_DIR
    cp ../common/case_ctrl_vol_full/system/blockMeshDict $DEST_DIR/system/blockMeshDict
    cp ../common/case_coeffs_full_all/system/forceCoeffs $DEST_DIR/system/forceCoeffs
    copyCaseFile $DEST_DIR
    surfaceTransformPoints -rollPitchYaw "( 0 0 $1 )" $MODEL_FILE $DEST_DIR/constant/triSurface/model.stl
    cd $DEST_DIR
    ./run.sh
    cd $FOAM_RUN
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cz_Cmy.dat
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmx.dat
    printf "%d\t" $1 &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmz.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cz_Cmy/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cz_Cmy.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cy_Cmx/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmx.dat
    tail -n 1 "$MODEL_NAME"_"$NAME_SUFFIX"_"$1"/postProcessing/forceCoeffs_Cx_Cy_Cmz/0/forceCoeffs.dat &>> forceCoeffs_"$MODEL_NAME"_"$NAME_SUFFIX"_Cx_Cy_Cmz.dat
}

################################################################################
# Iterate Angle of Attack
################################################################################

function iterateAngleOfAttack_Half()
{
    for i in -180 -150 -120
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
    
    for i in {-90..-30..10}
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done

    for i in -25 -20 -17 -14 -12
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done

    for i in {-10..15..1}
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done

    for i in 17 20 25
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done

    for i in {30..90..10}
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
    
    for i in 120 150 180
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
}

################################################################################

function iterateAngleOfAttack_Half_Short_90()
{
    for i in -90 -60 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 60 90
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
}

################################################################################

function iterateAngleOfAttack_Half_Short_180()
{
    for i in -180 -150 -120
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
    
    iterateAngleOfAttack_Half_Short_90
    
    for i in 120 150 180
    do
      runCaseAngleOfAttack_Half_Cx_Cz_Cmy $i
    done
}

################################################################################
# Iterate Sideslip Angle 
################################################################################

function iterateSideslipAngle_Full()
{
    for i in -90 -60 -30 -20 -10 -5  0  5  10  20  30  60  90
    do
      runCaseSideslipAngle_Full_All $i
    done
}

################################################################################
