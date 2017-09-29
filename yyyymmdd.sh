function yyyymmdd () {
    YYYYMM=$1
    if [ ${#YYYYMM} -ne 6 ]
    then
        echo "Param $YYYYMM is required in YYYYMM format" 1>&2
    else
        YYYY=${YYYYMM:0:4}
        MM=${YYYYMM:4:2}
    CAL=$(which cal)
    case "$OSTYPE" in
        darwin*)
            DATE=$(which gdate)
        ;;
        linux*)
            DATE=$(which date)
            CAL="$CAL -h"
        ;;
    esac
    YYYYMMDD_MIN=0
    YYYYMMDD_MAX=99999999
    if [ ! -z "$FROM" ]
    then
        YYYYMMDD_MIN=`$DATE --date "$FROM" +%Y%m%d`
    fi
    if [ ! -z "$UNTIL" ]
    then
        YYYYMMDD_MAX=`$DATE --date "$UNTIL" +%Y%m%d`
    fi
    for DAY in $($CAL $MM $YYYY | grep '^ *[0-9]')
    do
        DD=$(printf "%02d" $DAY)
        YYYYMMDD=$YYYY$MM$DD
        if [ $YYYYMMDD -gt $YYYYMMDD_MIN -a $YYYYMMDD -le $YYYYMMDD_MAX ]
        then
            echo $YYYY$MM$DD
        fi
    done
    fi
}
