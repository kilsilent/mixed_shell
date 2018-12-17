function show_doing_mark(){
    mark_list=(
        "-"
        "\\"
        "|"
        "/"
    )
    local pos=0
    local my_ppid=31535
    echo -e -n "\e[?25l"
    while ps -ef | grep ${my_ppid} | grep -v grep > /dev/null 2>&1
    do
        echo -e -n "\e[1;$[pos+32];$[pos+41]m${mark_list[${pos}]} \e[0m\e[2D"
        sleep 0.2
        if [ ${pos} -eq 3 ]; then
            pos=0
        else
            pos=$(($pos+1))
        fi
    done
    echo -e -n "\e[?25h"
}
show_doing_mark
