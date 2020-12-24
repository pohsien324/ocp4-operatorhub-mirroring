PRIVATE_REGISTRY="private-registry.example.com"
cat auto_file_to_private.txt | grep -P "($PRIVATE_REGISTRY\/).*" -o | sed 's/\// /g' | awk '{print $2}' | sort -u
