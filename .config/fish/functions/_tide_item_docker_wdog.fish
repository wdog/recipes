function _tide_item_docker_wdog
    set current_dir (pwd)
    set runnig_containers (docker compose ls --format='json' | jq -r '.[].Name')
    _tide_print_item docker_wdog $tide_docker_icon ' ' $runnig_containers

end
