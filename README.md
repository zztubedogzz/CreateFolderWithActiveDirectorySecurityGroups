# CreateFolderWithActiveDirectorySecurityGroups
This script creates AD groups in a specified OU one for read and one for modify

When you run this script it asks for a folder name. It will create 2 groups by default in the `example.local/MyGroups/MyFolders` OU (Organization Unit).
Using "Prefix-" as a prefix and "-suffix" ending with "_RO" for *read-only* and "RW" for *read and write (Modify)*.
Then it creates a folder by default in `X:\example\path` with the name you gave when you first ran the script.
Finaly the folder permissions updated with the 2 newly created groups according to their description.
Useful for repetative folder creation that uses read, and write groups.

If you want to modify the AD path for the users you must edit the variable `$groupPath`. 
If you wish to learn more about AD object paths follow [this link](https://docs.microsoft.com/en-us/powershell/module/activedirectory/get-adgroup?view=windowsserver2022-ps)

To change where the folder to be created, change the `$folderPath` variable. **UNC paths are not supported!** If you want to use a network location be sure that it is mounted first!

To add or remove custom prefixes and suffixes to the groups to be made, change the `$groupNameRO` and `$groupNameRW` variables to your liking. the "{0}" is important. It inserts the folder name in the middle of the string.


Keep in mind that I might update this project, plan accordingly.
You can modify this script to your liking and use it in your solution both commercially and for your own. 
