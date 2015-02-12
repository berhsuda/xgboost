#!/bin/bash
if [[ $# -lt 1 ]]
then
    echo "Usage: nprocess"
    exit -1
fi

rm -rf mushroom.row* *.model
k=$1

# split the lib svm file into k subfiles
python splitrows.py ../data/agaricus.txt.train mushroom $k

# run xgboost mpi
../../tracker/rabit_demo.py -n $k linear.mock mushroom.row\%d "${*:2}" reg_L1=1 mock=0,1,1,0 mock=1,1,1,0  mock=0,2,1,1
