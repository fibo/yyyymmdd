function yyyymmdd () {
    YYYYMM=$1
    if [ ${#YYYYMM} -ne 6 ]
    then
        echo "Param $YYYYMM is not valid" 1>&2
    else
        YYYY=${YYYYMM:0:4}
        MM=${YYYYMM:4:2}
        for d in $(cal $MM $YYYY | grep "^ *[0-9]")
        do
            DD=$(printf "%02d" $d)
            echo $YYYY$MM$DD
        done
    fi
}
