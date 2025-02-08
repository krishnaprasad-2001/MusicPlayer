# lets the user to select a song with filemanager opiton 
select_music() {
	# provinding the   
  song=$(zenity --file-selection --title="Select a Song to Play" --file-filter="*.mp3")
  # If a song is selected, play it
  if [[ -f "$song" ]]; then
	  mpv "$song" &> MusicLog.txt &A
	  main
  else
    zenity --error --text="No song selected or file not found."
  fi
}
exit_player(){
	choice=$(zenity --question --text="Do you want to close the application")
	if [[ $? -eq 0 ]]
	then
		killall -9 mpv &> /var/log/MusicLog.txt
		exit 0;
	fi
}

search(){
	mkdir -p /var/krishna/findList &> /var/log/MusicLog.txt
	rm -rf /var/krishna/findList/* &> /var/log/MusicLog.txt
	searchTerm=$(zenity --entry --text="Enter your name:")
	ls -1 /root/Music > /var/musicList.txt
	grep -i $searchTerm /var/musicList.txt |head -n 30 > /var/log/tempList.txt
	rm -rf /var/krishna/findList/*
	while read value
	do
		# find /root/Music $value -exec rsync -ah --progress {} /var/krishna/findList/ \; &> /var/log/MusicLog.txt
		find /root/Music $value -exec cp {} /var/krishna/findList/  \; &> /var/log/MusicLog.txt
	done < /var/log/tempList.txt

	SearchSelection=$(zentiry --file-selection --directory --filename=/var/krishna/findList);
	mpv $searchSelection;
	main

}
scope(){
	zenity --info --text="This feature will be available in the next version. Please hold on "
	main
}
main() {
	option=$(zenity --list --title="Krishnas Music Player" --column="Version 1" "Select_a_music" "Favourites" "Exit" "Stop the songs" "Search for a song" )
	if [[ -z "$option" ]]; then
		echo "option not read"
	fi
	case "$option" in
		"Select_a_music")
			select_music
			;;
		"Exit")
			exit_player
			;;
		"Favourites")
			scope
			;;
		"Search for a song")
			search
			;;
		"Stop the songs")
			killall -9 mpv
			;;
		*)
			zenity --error --text="Invalid selection!"
			;;
	esac
}

main 
