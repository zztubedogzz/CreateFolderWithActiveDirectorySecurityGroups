#############
# Variables #
##########################
# Make your changes here!#
##########################
$folderName = Read-Host -Prompt 'FolderName';
$groupNameRO = 'Prefix-{0}-suffix_RO' -f $folderName
$groupNameRW = 'Prefix-{0}-suffix_RW' -f $folderName
$groupPath = "OU=MyFolders,OU=MyGroups,DC=example,DC=local"
$descStringRO = "Members of this group has read-only access to {0} folder on the FileServer." -f $folderName
$descStringRW = "Members of this group has readwrite access to {0} folder on the FileServer." -f $folderName
$newFolderPath = "x:\example\path"
$folderPath = "{0}{1}" -f $newFolderPath,$folderName
##########################

# Create read and modify groups
Write-Output "Creating $groupNameRO..."
New-ADGroup -Name $groupNameRO -SamAccountName $groupNameRO -GroupCategory Security -GroupScope Global -DisplayName $groupNameRO -Path $groupPath -Description $descStringRO
Write-Output "Creating $groupNameRW..."
New-ADGroup -Name $groupNameRW -SamAccountName $groupNameRW -GroupCategory Security -GroupScope Global -DisplayName $groupNameRW -Path $groupPath -Description $descStringRW

# Create folder
New-Item -Path $newFolderPath -Name $foldername -ItemType "directory"

# Add group permissions to the folder
$ACL = Get-ACL -Path $folderPath
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($groupNameRO,"Read", "ContainerInherit,ObjectInherit", "None","Allow")
$ACL.SetAccessRule($AccessRule)
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($groupNameRW,"Modify", "ContainerInherit,ObjectInherit", "None","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path $folderPath

# Output results in the console
(Get-ACL -Path $folderPath).Access | Format-Table IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -AutoSize