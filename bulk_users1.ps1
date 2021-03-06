# Import active directory module for running AD cmdlets
Import-Module activedirectory
  
#Store the data from ADUsers.csv in the $ADUsers variable
$ADUsers = Import-csv C:\Users\safwan.forde\Desktop\Bulk\bulk.csv

#Loop through each row containing user details in the CSV file 
foreach ($User in $ADUsers)
{
	#Read user data from each field in each row and assign the data to a variable as below
		
	$Username 	= $User.userprincipalname
	$Password 	= $User.password
	$Firstname 	= $User.firstname
	$Lastname 	= $User.lastname
	$OU 		= $User.path 
    $email      = $User.email
    $Displayname = $User.displayname
    $streetaddress = $User.streetaddress
    $city       = $User.city
    $zipcode    = $User.zipcode
    $state      = $User.state
    $country    = $User.country
    $office     = $User.office
    $jobtitle   = $User.title
    $company    = $User.company
    $descrip    = $USer.description
    $manager    = $user.manager
    $department = $User.department



	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $Username})
	{

		 #If user does exist, give a warning
		 Write-Warning "A user account with username $Username already exist in Active Directory."
	
}
	else
	{

		#User does not exist then proceed to create the new user account

        #Account will be created in the OU provided by the $OU variable read from the CSV file
		New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@ics.local" `
            -givenName "$Firstname" `
            -Surname "$Lastname" `
            -Enabled $True `
            -DisplayName $Displayname `
            -Name $Displayname `
            -Path $OU `
            -City $city `
            -Office $office `
            -Company $company `
            -State $state `
            -StreetAddress $streetaddress `
            -Description $descrip `
            -emailAddress $email `
            -Manager $manager `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $False
            
	}
}
