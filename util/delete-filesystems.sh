# Get all of the filesystems to delete

aws efs describe-file-systems --query "FileSystems[?Name!=null]|[?starts_with(Name, 'factorio-')].FileSystemId" --output text | cat

# Array of file system IDs to delete

for fs_id in $(aws efs describe-file-systems --query "FileSystems[?Name!=null]|[?starts_with(Name, 'factorio-')].FileSystemId" --output text | cat)
do
    echo "Deleting file system: $fs_id"
    aws efs delete-file-system --file-system-id $fs_id
    if [ $? -eq 0 ]; then
        echo "Successfully deleted file system: $fs_id"
    else
        echo "Failed to delete file system: $fs_id"
    fi
done