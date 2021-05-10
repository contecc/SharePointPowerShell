Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

#Toggle the Syncronozation settings to clean the DB.
$sa = Get-SPServiceApplication | ?{$_.DisplayName -eq 'User Profile Service Application'}
$sa.NoILMUsed = $true
$sa.Update()

$sa = Get-SPServiceApplication | ?{$_.DisplayName -eq 'User Profile Service Application'}
$sa.NoILMUsed = $false
$sa.Update()


#Configuration Variables
$SiteURL = "https://contoso.com"



#Get Objects
$ServiceContext  = Get-SPServiceContext -site $SiteURL
$UserProfileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($ServiceContext)

#Ger all User Profiles
$UserProfiles = $UserProfileManager.GetEnumerator()

# Loop through user profile
Foreach ($Profile in $UserProfiles ) 
{
    write-host Removing User Profile: $Profile["AccountName"] 
    #Remove User Profile
    $UserProfileManager.RemoveUserProfile($profile["AccountName"])
}
