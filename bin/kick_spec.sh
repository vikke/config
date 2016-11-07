cd ~/wo_docker/wo

wo a -env test rake spec:db:delete
echo 'start spec'
wo a spec ${@}
