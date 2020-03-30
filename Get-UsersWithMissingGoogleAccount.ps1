function Get-UsersWithMissingGoogleAccount
{
    $users = Get-ADUser -SearchBase "OU=KV,OU=04.ELEVER,OU=Användare,DC=UTBILDNING,DC=LOCAL" -Properties extensionattribute1,created,Lastlogondate -Filter {Enabled -eq $True} |Where extensionattribute1 -eq $null
    foreach ($user in $users)
    {
        # Collect information
        $SamAccountName = $user.SamAccountName
        $GivenName = $user.GivenName
        $SurName = $user.SurName
        $DisplayName = $SurName + ", " + $GivenName
        
        # Create new Powershell object for output
        $newObject = New-Object -TypeName psobject
        $newObject | Add-Member -MemberType NoteProperty -Name SamAccountName -Value $SamAccountName
        $newObject | Add-Member -MemberType NoteProperty -Name DisplayName -Value $DisplayName
        $newObject | Add-Member -MemberType NoteProperty -Name SurName -Value $SurName
        $newObject | Add-Member -MemberType NoteProperty -Name GivenName -Value $GivenName
        $newObject
    }
}