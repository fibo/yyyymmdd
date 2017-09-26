function yyyymmdd () {
    YYYYMM=$1
    if [ ${#YYYYMM} -ne 6 ]
    then
        echo "Param $YYYYMM is required in YYYYMM format" 1>&2
    else
        YYYY=${YYYYMM:0:4}
        MM=${YYYYMM:4:2}
    YYYYMMDD_MAX=99999999
    if [ ! -z "$UNTIL" ]
    then
        YYYYMMDD_MAX=$(date -d "$UNTIL" +%Y%m%d)
    fi
        for d in $(cal $MM $YYYY | perl -ple 's/[^[:print:]]_//g' | grep "^ *[0-9]")
        do
            DD=$(printf "%02d" $d)
            YYYYMMDD=$YYYY$MM$DD
            if [ $YYYYMMDD -le $YYYYMMDD_MAX ]
            then
                echo $YYYY$MM$DD
            fi
        done
    fi
}
