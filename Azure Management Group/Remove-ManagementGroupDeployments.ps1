[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]  
    [string] $managementGroup,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]  
    [int] $skipCount
)

$LowerLimit = 100
$UpperLimit = 800

#Get the number of deployments for the specified resourcegroup
$Deployments = Get-AzManagementGroupDeployment -ManagementGroupId $managementGroup
[int]$count = $Deployments.Count
Write-Host "Count: $count" -ForegroundColor Yellow
If ($count -ge $LowerLimit -and $count -le $UpperLimit) {
    Write-Host "Removing deployments except for the most recent $skipCount ones" $count -ForegroundColor Yellow
    $Deployments | Select-Object -Skip $skipCount | Remove-AzManagementGroupDeployment
}
Else {
    Write-Host "Number of deployments is with the range of 300-801. No cleanup required" $count
}