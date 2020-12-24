#!/bin/bash
PRIVATE_REGISTRY="private-registry.example.com"
#------------------------
rm -rf auto_redhat_to_file.txt auto_file_to_private.txt

# Mirror Images from Red Hat registry to Local
cat origin.txt | sed "s/$PRIVATE_REGISTRY/file:\/\/offline/g" > auto_redhat_to_file.txt

# Mirror Images from Local to Private Registry
cp origin.txt auto_file_to_private.txt
while IFS= read -r line; do
   sed -i "s/$line/file:\/\/offline/g"  auto_file_to_private.txt
done < <( cat origin.txt  | sed 's/\(\/.*\)//g' | sort -u )
