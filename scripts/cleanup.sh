#!/bin/bash
MYHOME=$HOME
MYDESKTOP=$HOME/Desktop

echo "         _                              "
echo "        | |                             "
echo "    ___ | | ___  __ _ _ __  _   _ _ __  "
echo "   / __|| |/ _ \/ _  | '_ \| | | | '_ \ "
echo "  | (__ | |  __/ (_| | | | | |_| | |_) |"
echo "   \___||_|\___|\__,_|_| |_|\__,_| .__/ "
echo "                                | |    "
echo "                                |_|    v0.1 "
echo "  "

cd $MYDESKTOP
DIRS="Content Papers Code Images Music Videos Links Archives Webpages Progs"
for dir in $DIRS; do
	mkdir $dir
done

# make the final dest dir...
mkdir "desktop `date "+%Y-%m-%d"` "


for file in $MYDESKTOP/*; do
	#echo "found file $file ... "
	case $file in
	*.pdf | *.PDF | *.doc | *.docx | *.pages | *.ps | *.ppt | *.ods | *.rtf | *.xlsl | *.xsl ) 
		echo "Moving $file to Papers/"
		mv "$file" Papers/
	;;
	*.py | *.pyc | *.php | *.php4 | *.php5 | *.pl | *.java | *.c | *.js | *.m | *.csv | *.cpp | *.R | *.hs | *.ipynb) 
		echo "Moving $file to Code/"
		mv "$file" Code/
	;;
    *.tex | *.log | *.textClipping | *.epub )
        echo "Moving $file to Content/"
        mv "$file" Content/
    ;;
	*.gif | *.png | *.PNG | *.jpg | *.JPG | *.jpeg | *.tiff | *.bmp | *.gcx | *.svg | *.ico ) 
		echo "moving $file to to Images/"
		mv "$file" Images/
	;;
	*.aiff | *.sd2 | *.wav | *.mp3 | *.ogg | *.pls ) 
		echo "moving $file to to Music/"
		mv "$file" Music/
	;;
	*.wmv | *.mov | *.WMV | *.flv | *.avi | *.mp4 | *.mpg | *.m4v ) 
		echo "moving $file to to Videos/"
		mv "$file" Videos/
	;;
	*.exe | *.EXE) 
		echo "moving $file to to Progs/"
		mv "$file" Progs/
	;;
	*.webloc | *.lnk | *.desktop) 
		echo "Moving $file to Links..."
		mv "$file" Links/
	;;
	*.zip | *.gz | *.tgz | *.tar | *.dmg | *.iso | *.iso.md5sum | *.deb | *.pkg | *.bz2 | *.rar | *.mpkg | *.torrent ) 
		echo "Moving $file to Archives... "
		mv "$file" Archives/
	;;
	*.html | *.htm | *.webarchive) 
		echo "Moving $file to Webpages..."
		mv "$file" Webpages/
		mv "${file%.*} Files" Webpages/
		mv "${file%.*}_files" Webpages/
	;;
	*) echo "Sorry, I don't know what kind of file $file is!"
	esac
done

#delete empty dirs
for dir in $DIRS; do
	rmdir $dir      # will fail if files were put into it
done
