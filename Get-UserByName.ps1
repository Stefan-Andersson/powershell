function Get-UserByName
 {
     [CmdletBinding()]
     param
     (
         [Parameter()]
         [string[]]$searchString = $null,
         [bool]$AccountEnabled = $True
     )
     if ($searchString -eq $null)
     {
        Write-Host "You must provide a searchstring for the search"
     }
     else 
     {
        Write-Host "Searching for students containing $StudenName"
        $finalSearchString = "*" + $searchString + "*"
        if ($AccountEnabled -eq $True) 
        {
            $users = Get-ADUser -Filter {Enabled -eq $AccountEnabled -and GivenName -like $finalSearchString -or SurName -like $finalSearchString} -Properties extensionAttribute1, extensionAttribute15, LastLogonDate, Created
        }
        Else
        {
            $users = Get-ADUser -Filter {GivenName -like $finalSearchString -or SurName -like $finalSearchString} -Properties extensionAttribute1, extensionAttribute15, LastLogonDate, Created
        }
        $users
     }

 }