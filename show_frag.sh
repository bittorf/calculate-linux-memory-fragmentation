#!/bin/sh

get_free_pages()
{
	local line="$1"
	local minpos="${2:-0}"

	export FREE_PAGES=0

	local word i=1
	local pos=1

	for word in $line; do
		test $pos -ge "$minpos" && \
			FREE_PAGES=$(( FREE_PAGES + (word*i) ))
		i=$(( i * 2 ))
		pos=$(( pos + 1 ))
	done
}

calc()
{
	local file="${1:-/proc/buddyinfo}"
	local line zone all i
	local percent percent_all

	# user@box:~$ cat /proc/buddyinfo
	# Node 0, zone     DMA      0      1      1      0      2      1      1      0     1    1    2
	# Node 0, zone   DMA32     15    127    114    132     75     31      6      9     2    5  471
	# Node 0, zone  Normal  48382  33709  38569  29056  19644  48323  34662  18613  9036  322   11
	# Node 1, zone  Normal  26827  33986  27075  16485  33160  57045  26751  19753  9226  635   39

	while read -r line; do {
		set -- $line
		zone="$4" && shift 4

		get_free_pages "$*" && all="$FREE_PAGES"
		percent_all=0

		for i in 1 2 3 4 5 6 7 8 9 10 11; do {
			get_free_pages "$*" "$i"
			percent="$(( 100 - ( FREE_PAGES * 100 ) / all ))"
			percent_all=$(( percent_all + percent ))
		} done

		printf '%s\n' "$zone=$(( percent_all / 11 ))%"
	} done <"$file"
}

calc "$@"
