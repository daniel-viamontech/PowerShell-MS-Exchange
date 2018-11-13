#Import Distribution Groups from CSV files
#Gets a list of the csv files
$DistributionGroups = Get-ChildItem
#Makes a distribution list based on the name of each csv file
ForEach ($DistributionGroup in $DistributionGroups){
    $CurrentGroup = $DistributionGroup.Name.Split('.')[0]
    Write-Host -ForegroundColor Yellow "Creating $CurrentGroup distribution group"
    New-DistributionGroup -Name $CurrentGroup -DisplayName $CurrentGroup -Type "Distribution"

    #Reads into each csv file and adds all of the users in
    $GroupUsers = Import-Csv -Path "$DistributionGroup"
    ForEach ($GroupUser in $GroupUsers){
        $CurrentGroupUser = $GroupUser.PrimarySmtpAddress
        Write-Host -ForegroundColor Yellow "Adding $CurrentGroupUser to $CurrentGroup"
        Add-DistributionGroupMember -Identity $CurrentGroup -Member $CurrentGroupUser
    }
}
