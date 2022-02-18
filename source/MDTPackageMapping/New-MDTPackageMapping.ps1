function New-MDTPackageMapping {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $ARPName,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $package
    )

    Process
    {
        # Insert a new row
        $sql = "INSERT INTO PackageMapping (ARPName, Packages) VALUES ('$ARPName','$package')"
        Write-Debug "About to execute command: $sql"
        $identityCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $identityCmd.ExecuteScalar()
        Write-Debug "Added package mapping record for $ARPName"
    
        # Write the new record back to the pipeline
        Get-MDTPackageMapping -ARPName $ARPName
    }
}