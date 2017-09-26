# yyyymmdd

> uses cal Unix program to print out the days in a month

[Installation](#installation) |
[Usage](#usage) |
[Annotated source](#annotated-source) |
[License](#license)

[![KLP](https://img.shields.io/badge/kiss-literate-orange.svg)](http://g14n.info/kiss-literate-programming)

<img src="https://rawgit.com/fibo/os-icons8/master/Apple-50.png" width="50" height="50" /> <img src="https://rawgit.com/fibo/os-icons8/master/Linux-50.png" width="50" height="50" />

## Installation

You can just copy and paste the [yyyymmdd.sh](https://github.com/fibo/yyyymmdd/blob/master/yyyymmdd.sh) function or do the following

```bash
mkdir -p ~/.bash
cd ~/.bash
git clone git://github.com/fibo/yyyymmdd.git
```

Edit your *~/.bash_profile* or *~/.profile* and add the following

```bash
source ~/.bash/yyyymmdd/yyyymmdd.sh
```

## Usage

Pass it year and month in *YYYYMM* format

```bash
$ yyyymmdd 201701
20170101
20170102
...
20170129
20170130
20170131
```

It is possible to provide an `UNTIL` option, which is passed to `date -d` command, for example

* `UNTIL=now yyyymmdd 201701`
* `UNTIL=yesterday yyyymmdd 201701`
* `UNTIL="2 hours ago" yyyymmdd 201701`

## Annotated source

Create a `yyyymmdd` bash function.

    function yyyymmdd () {

Then split input into year and month.

        YYYYMM=$1

        if [ ${#YYYYMM} -ne 6 ]
        then
            echo "Param $YYYYMM is required in YYYYMM format" 1>&2
        else
            YYYY=${YYYYMM:0:4}
            MM=${YYYYMM:4:2}

Handle `UNTIL` option

        YYYYMMDD_MAX=99999999

        if [ ! -z "$UNTIL" ]
        then
            YYYYMMDD_MAX=$(date -d "$UNTIL" +%Y%m%d)
        fi

Use [cal] to output days: on Linux it could highlight current day;
option `cal -h` turns it off but it is not supported on MacOS so a
regexp is used to get an alphanumeric output.

            for d in $(cal $MM $YYYY | perl -ple 's/[^[:print:]]_//g' | grep "^ *[0-9]")
            do
                DD=$(printf "%02d" $d)
                YYYYMMDD=$YYYY$MM$DD

                if [ $YYYYMMDD -le $YYYYMMDD_MAX ]
                then
                    echo $YYYY$MM$DD
                fi
            done

... and we are done!

        fi
    }

## License

[MIT](http://g14n.info/mit-license)

<sub>OS icons provided by <a href="https://icons8.com/">icons8</a>.</sub>

[cal]: https://en.wikipedia.org/wiki/Cal_(Unix) "cal"
