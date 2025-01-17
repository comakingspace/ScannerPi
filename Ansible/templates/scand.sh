#!/bin/bash

datafolder="{{ datafolder }}"
mkdir -p $datafolder
cd $datafolder

/bin/systemd-notify --ready

poll_scanner(){
	echo "Papers, please!"

	/usr/bin/scanadf --source "ADF Duplex" -o $datafolder/$1_%d.png \
	--swdeskew=yes \
	--rollerdeskew=yes \
	--page-height 500 \
	--resolution=300 \
	--end-count 2
}

compress_files(){
	echo "Compressing files with $1"
	for f in $1*.png; do
			echo "Compressing $f"
			convert -strip -interlace Plane -sampling-factor 4:2:0 -colorspace Gray -quality 85% $f ${f%.*}.jpg
	done
}

make_pdf(){
	echo "Creating PDF $1"
	/usr/bin/img2pdf $1*.jpg -o $1.pdf
}

# shopt -s nullglob

while true; do
	name=$(date "+%F-%H-%M-%S")

	poll_scanner $name

	if ls $name*.png 1> /dev/null 2>&1; then
		echo "There was a scan! :D"
		(compress_files $name && make_pdf $name && rm -r $name*.png $name*.jpg) &
	fi

	# call watchdog
	/bin/systemd-notify WATCHDOG=1

done