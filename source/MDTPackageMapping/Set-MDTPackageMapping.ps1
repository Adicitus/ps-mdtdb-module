function Set-MDTPackageMapping {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $ARPName,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $package = $null
    )
    
    Process
    {
        # Update the row
        $sql = "UPDATE PackageMapping SET Packages = '$package' WHERE ARPName = '$ARPName'"
        Write-Verbose "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
        Write-Host "Updated the package mapping record for $ARPName to install package $package."    
        
        # Write the updated record back to the pipeline
        Get-MDTPackageMapping -ARPName $ARPName
    }
}